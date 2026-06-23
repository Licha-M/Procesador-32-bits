-- ============================================================
--  Low Velocity Controller (LVC) — Hub de Periféricos
--  Arquitectura 32 bits  |  VHDL-93
--  Compatible con Logisim-Evolution 3.9 (VHDL Component)
-- ============================================================
--
--  PROPÓSITO:
--    Hub tipo PCIe-switch simplificado para 8 dispositivos lentos.
--    Centraliza:
--      1. Decodificación de direcciones (ningún dispositivo decodifica)
--      2. Arbitraje DMA round-robin
--      3. Generación del bitmap MSI de 128 bits
--
--  MAPA DE SUB-RANGOS (dentro de 0xD0000000–0xD00FFFFF):
--    Addr[19]=0  → MMIO de dispositivo (0xD0000000–0xD007FFFF)
--      Addr[18:12]=0x00 → DEV0: UART   (0xD0000xxx)
--      Addr[18:12]=0x01 → DEV1: GPIO   (0xD0001xxx)
--      Addr[18:12]=0x02 → DEV2: Timer  (0xD0002xxx)
--      Addr[18:12]=0x03 → DEV3: USB    (0xD0003xxx)
--      Addr[18:12]=0x04 → DEV4: SATA   (0xD0004xxx)
--      Addr[18:12]=0x05 → DEV5: Audio  (0xD0005xxx)
--      Addr[18:12]=0x06 → DEV6: PS/2   (0xD0006xxx)
--      Addr[18:12]=0x07 → DEV7: Expan. (0xD0007xxx)
--    Addr[19]=1  → LVC-ECAM (0xD0080000–0xD00FFFFF)
--      Addr[10:8]  → dispositivo a configurar (0-7)
--      Addr[3:2]   → registro: 00=DEVICE_ID 01=MSI_CTRL
--                               10=MSI_VEC   11=DMA_MSI_VEC
--
--  INTERFAZ MSI:
--    Entrada: DEVn_MSI_REQ (1 bit por dispositivo)
--    Salida:  MSI_OUT[127:0] — bitmap de vectores activos
--    El vector de cada dispositivo se configura en LVC-ECAM.
--
--  INTERFAZ DMA:
--    Cada dispositivo expone: REQ, WE, Addr[31:0], Cant[15:0]
--    Bus compartido de datos: DMA_Wr_Data (dev→RAM) /
--                             DMA_Rd_Data (RAM→dev)
--    El árbitro round-robin otorga GNT a un dispositivo a la vez.
--    Al completar: pulsa DEVn_DMA_DONE y genera MSI si está habilitado.
--
--  DEVICE_ID por dispositivo (registro ECAM 0x000):
--    DEV0=0x00000001  DEV1=0x00000002  DEV2=0x00000003
--    DEV3=0x00000004  DEV4=0x00000005  DEV5=0x00000006
--    DEV6=0x00000007  DEV7=0x00000008
-- ============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ------------------------------------------------------------
entity LVC is
    port (
        -- ── Reloj y Reset ───────────────────────────────────
        CLK              : in  std_logic;
        RST              : in  std_logic;   -- activo en alto

        -- ── Bus de Periféricos (desde MMIO Controller) ───────
        BUS_CS           : in  std_logic;
        BUS_WE           : in  std_logic;
        BUS_Addr         : in  std_logic_vector(31 downto 0);
        BUS_Data_out     : in  std_logic_vector(31 downto 0);
        BUS_Byte_En      : in  std_logic_vector(3  downto 0);

        -- ── Respuesta del LVC al bus ─────────────────────────
        LVC_Data_in      : out std_logic_vector(31 downto 0);
        LVC_ACK          : out std_logic;

        -- ── Chip Selects hacia dispositivos ──────────────────
        CS_DEV0          : out std_logic;
        CS_DEV1          : out std_logic;
        CS_DEV2          : out std_logic;
        CS_DEV3          : out std_logic;
        CS_DEV4          : out std_logic;
        CS_DEV5          : out std_logic;
        CS_DEV6          : out std_logic;
        CS_DEV7          : out std_logic;

        -- ── Bus interno compartido hacia dispositivos ─────────
        SUB_WE           : out std_logic;
        SUB_Addr         : out std_logic_vector(11 downto 0);
        SUB_Data_out     : out std_logic_vector(31 downto 0);
        SUB_Byte_En      : out std_logic_vector(3  downto 0);

        -- ── Datos de retorno desde cada dispositivo ───────────
        DEV0_Data_in     : in  std_logic_vector(31 downto 0);
        DEV1_Data_in     : in  std_logic_vector(31 downto 0);
        DEV2_Data_in     : in  std_logic_vector(31 downto 0);
        DEV3_Data_in     : in  std_logic_vector(31 downto 0);
        DEV4_Data_in     : in  std_logic_vector(31 downto 0);
        DEV5_Data_in     : in  std_logic_vector(31 downto 0);
        DEV6_Data_in     : in  std_logic_vector(31 downto 0);
        DEV7_Data_in     : in  std_logic_vector(31 downto 0);

        -- ── MSI requests desde cada dispositivo ──────────────
        --    1 bit por dispositivo; el LVC mapea al vector ECAM
        DEV0_MSI_REQ     : in  std_logic;
        DEV1_MSI_REQ     : in  std_logic;
        DEV2_MSI_REQ     : in  std_logic;
        DEV3_MSI_REQ     : in  std_logic;
        DEV4_MSI_REQ     : in  std_logic;
        DEV5_MSI_REQ     : in  std_logic;
        DEV6_MSI_REQ     : in  std_logic;
        DEV7_MSI_REQ     : in  std_logic;

        -- ── DMA request por dispositivo ───────────────────────
        DEV0_DMA_REQ     : in  std_logic;
        DEV1_DMA_REQ     : in  std_logic;
        DEV2_DMA_REQ     : in  std_logic;
        DEV3_DMA_REQ     : in  std_logic;
        DEV4_DMA_REQ     : in  std_logic;
        DEV5_DMA_REQ     : in  std_logic;
        DEV6_DMA_REQ     : in  std_logic;
        DEV7_DMA_REQ     : in  std_logic;

        DEV0_DMA_WE      : in  std_logic;   -- 1=escribe a RAM
        DEV1_DMA_WE      : in  std_logic;
        DEV2_DMA_WE      : in  std_logic;
        DEV3_DMA_WE      : in  std_logic;
        DEV4_DMA_WE      : in  std_logic;
        DEV5_DMA_WE      : in  std_logic;
        DEV6_DMA_WE      : in  std_logic;
        DEV7_DMA_WE      : in  std_logic;

        DEV0_DMA_Addr    : in  std_logic_vector(31 downto 0);
        DEV1_DMA_Addr    : in  std_logic_vector(31 downto 0);
        DEV2_DMA_Addr    : in  std_logic_vector(31 downto 0);
        DEV3_DMA_Addr    : in  std_logic_vector(31 downto 0);
        DEV4_DMA_Addr    : in  std_logic_vector(31 downto 0);
        DEV5_DMA_Addr    : in  std_logic_vector(31 downto 0);
        DEV6_DMA_Addr    : in  std_logic_vector(31 downto 0);
        DEV7_DMA_Addr    : in  std_logic_vector(31 downto 0);

        DEV0_DMA_Cant    : in  std_logic_vector(15 downto 0);  -- palabras a transferir
        DEV1_DMA_Cant    : in  std_logic_vector(15 downto 0);
        DEV2_DMA_Cant    : in  std_logic_vector(15 downto 0);
        DEV3_DMA_Cant    : in  std_logic_vector(15 downto 0);
        DEV4_DMA_Cant    : in  std_logic_vector(15 downto 0);
        DEV5_DMA_Cant    : in  std_logic_vector(15 downto 0);
        DEV6_DMA_Cant    : in  std_logic_vector(15 downto 0);
        DEV7_DMA_Cant    : in  std_logic_vector(15 downto 0);

        -- ── DMA grant y done hacia dispositivos ───────────────
        DEV0_DMA_GNT     : out std_logic;
        DEV1_DMA_GNT     : out std_logic;
        DEV2_DMA_GNT     : out std_logic;
        DEV3_DMA_GNT     : out std_logic;
        DEV4_DMA_GNT     : out std_logic;
        DEV5_DMA_GNT     : out std_logic;
        DEV6_DMA_GNT     : out std_logic;
        DEV7_DMA_GNT     : out std_logic;

        DEV0_DMA_DONE    : out std_logic;
        DEV1_DMA_DONE    : out std_logic;
        DEV2_DMA_DONE    : out std_logic;
        DEV3_DMA_DONE    : out std_logic;
        DEV4_DMA_DONE    : out std_logic;
        DEV5_DMA_DONE    : out std_logic;
        DEV6_DMA_DONE    : out std_logic;
        DEV7_DMA_DONE    : out std_logic;

        -- ── Bus compartido DMA de datos ───────────────────────
        --    Solo el dispositivo con GNT activo usa este bus.
        DMA_Wr_Data      : in  std_logic_vector(31 downto 0);  -- dev→RAM
        DMA_Rd_Data      : out std_logic_vector(31 downto 0);  -- RAM→dev
        DMA_Word_ACK     : out std_logic;                      -- 1 palabra transferida

        -- ── Interfaz RAM para DMA ─────────────────────────────
        DMA_RAM_REQ      : out std_logic;
        DMA_RAM_WE       : out std_logic;
        DMA_RAM_Addr     : out std_logic_vector(31 downto 0);
        DMA_RAM_Wr_Data  : out std_logic_vector(31 downto 0);
        DMA_RAM_Rd_Data  : in  std_logic_vector(31 downto 0);
        DMA_RAM_ACK      : in  std_logic;

        -- ── MSI output (128-bit bitmap de vectores) ───────────
        --    Conectar directamente al registro IRR del LAPIC.
        --    No se necesita compuerta OR externa.
        MSI_OUT          : out std_logic_vector(127 downto 0)
    );
end entity LVC;

-- ------------------------------------------------------------
architecture RTL of LVC is

    -- ── Tipos internos (arrays para operar sobre 8 dispositivos)
    type slv32_8  is array(0 to 7) of std_logic_vector(31 downto 0);
    type slv16_8  is array(0 to 7) of std_logic_vector(15 downto 0);
    type slv7_8   is array(0 to 7) of std_logic_vector(6  downto 0);
    type slv2_8   is array(0 to 7) of std_logic_vector(1  downto 0);
    type slv32_8r is array(0 to 7) of std_logic_vector(31 downto 0);

    -- ── Empaquetado de señales individuales en arrays ────────
    signal dev_msi_req   : std_logic_vector(7 downto 0);
    signal dev_dma_req   : std_logic_vector(7 downto 0);
    signal dev_dma_we    : std_logic_vector(7 downto 0);
    signal dev_dma_addr  : slv32_8;
    signal dev_dma_cant  : slv16_8;
    signal dev_data_in   : slv32_8;
    signal dev_dma_gnt   : std_logic_vector(7 downto 0);
    signal dev_dma_done  : std_logic_vector(7 downto 0);
    signal cs_dev        : std_logic_vector(7 downto 0);

    -- ── Registros ECAM (banco de configuración por dispositivo)
    --    Escritos por el OS a través del bus en 0xD008xxxx
    --    MSI_CTRL[1:0]: [0]=MSI_EN  [1]=DMA_MSI_EN
    signal ecam_msi_ctrl    : slv2_8;   -- habilitaciones
    signal ecam_msi_vec     : slv7_8;   -- vector MSI del dispositivo
    signal ecam_dma_msi_vec : slv7_8;   -- vector MSI de finalización DMA

    -- ── Señales de decodificación de dirección ───────────────
    signal lvc_range_hit : std_logic;   -- la addr cae en 0xD00xxxxx
    signal is_ecam       : std_logic;   -- Addr[19]='1' → LVC-ECAM
    signal dev_idx_mmio  : integer range 0 to 7;  -- dispositivo MMIO
    signal dev_idx_ecam  : integer range 0 to 7;  -- dispositivo ECAM
    signal ecam_reg_idx  : integer range 0 to 3;  -- registro ECAM

    -- ── Dato leído desde dispositivo (mux) ───────────────────
    signal mmio_read_data  : std_logic_vector(31 downto 0);
    signal ecam_read_data  : std_logic_vector(31 downto 0);

    -- ── FSM árbitro DMA ──────────────────────────────────────
    type dma_state_t is (DMA_IDLE, DMA_BURST, DMA_DONE);
    signal dma_state     : dma_state_t;
    signal dma_grant_idx : integer range 0 to 7;  -- dispositivo con grant
    signal dma_arb_ptr   : integer range 0 to 7;  -- puntero round-robin
    signal dma_addr_ptr  : std_logic_vector(31 downto 0);  -- addr actual en RAM
    signal dma_cnt_r     : std_logic_vector(15 downto 0);  -- palabras restantes
    signal dma_we_r      : std_logic;             -- dirección capturada
    signal dma_word_ack  : std_logic;             -- pulso: 1 palabra lista
    signal dma_active    : std_logic;             -- hay transferencia activa

    -- ── Constantes de DEVICE_ID (solo lectura) ───────────────
    type dev_id_t is array(0 to 7) of std_logic_vector(31 downto 0);
    constant DEVICE_ID : dev_id_t := (
        x"00000001",  -- DEV0: UART
        x"00000002",  -- DEV1: GPIO
        x"00000003",  -- DEV2: Timer
        x"00000004",  -- DEV3: USB
        x"00000005",  -- DEV4: SATA
        x"00000006",  -- DEV5: Audio
        x"00000007",  -- DEV6: PS/2
        x"00000008"   -- DEV7: Expansión
    );

begin

    -- ============================================================
    --  0. EMPAQUETADO: señales individuales → arrays internos
    -- ============================================================
    dev_msi_req  <= DEV7_MSI_REQ & DEV6_MSI_REQ & DEV5_MSI_REQ & DEV4_MSI_REQ &
                    DEV3_MSI_REQ & DEV2_MSI_REQ & DEV1_MSI_REQ & DEV0_MSI_REQ;

    dev_dma_req  <= DEV7_DMA_REQ & DEV6_DMA_REQ & DEV5_DMA_REQ & DEV4_DMA_REQ &
                    DEV3_DMA_REQ & DEV2_DMA_REQ & DEV1_DMA_REQ & DEV0_DMA_REQ;

    dev_dma_we   <= DEV7_DMA_WE  & DEV6_DMA_WE  & DEV5_DMA_WE  & DEV4_DMA_WE  &
                    DEV3_DMA_WE  & DEV2_DMA_WE  & DEV1_DMA_WE  & DEV0_DMA_WE;

    dev_dma_addr(0) <= DEV0_DMA_Addr;  dev_dma_addr(1) <= DEV1_DMA_Addr;
    dev_dma_addr(2) <= DEV2_DMA_Addr;  dev_dma_addr(3) <= DEV3_DMA_Addr;
    dev_dma_addr(4) <= DEV4_DMA_Addr;  dev_dma_addr(5) <= DEV5_DMA_Addr;
    dev_dma_addr(6) <= DEV6_DMA_Addr;  dev_dma_addr(7) <= DEV7_DMA_Addr;

    dev_dma_cant(0) <= DEV0_DMA_Cant;  dev_dma_cant(1) <= DEV1_DMA_Cant;
    dev_dma_cant(2) <= DEV2_DMA_Cant;  dev_dma_cant(3) <= DEV3_DMA_Cant;
    dev_dma_cant(4) <= DEV4_DMA_Cant;  dev_dma_cant(5) <= DEV5_DMA_Cant;
    dev_dma_cant(6) <= DEV6_DMA_Cant;  dev_dma_cant(7) <= DEV7_DMA_Cant;

    dev_data_in(0) <= DEV0_Data_in;  dev_data_in(1) <= DEV1_Data_in;
    dev_data_in(2) <= DEV2_Data_in;  dev_data_in(3) <= DEV3_Data_in;
    dev_data_in(4) <= DEV4_Data_in;  dev_data_in(5) <= DEV5_Data_in;
    dev_data_in(6) <= DEV6_Data_in;  dev_data_in(7) <= DEV7_Data_in;

    -- ── Desempaquetado de arrays a salidas individuales ──────
    CS_DEV0 <= cs_dev(0);  CS_DEV1 <= cs_dev(1);
    CS_DEV2 <= cs_dev(2);  CS_DEV3 <= cs_dev(3);
    CS_DEV4 <= cs_dev(4);  CS_DEV5 <= cs_dev(5);
    CS_DEV6 <= cs_dev(6);  CS_DEV7 <= cs_dev(7);

    DEV0_DMA_GNT <= dev_dma_gnt(0);  DEV1_DMA_GNT <= dev_dma_gnt(1);
    DEV2_DMA_GNT <= dev_dma_gnt(2);  DEV3_DMA_GNT <= dev_dma_gnt(3);
    DEV4_DMA_GNT <= dev_dma_gnt(4);  DEV5_DMA_GNT <= dev_dma_gnt(5);
    DEV6_DMA_GNT <= dev_dma_gnt(6);  DEV7_DMA_GNT <= dev_dma_gnt(7);

    DEV0_DMA_DONE <= dev_dma_done(0);  DEV1_DMA_DONE <= dev_dma_done(1);
    DEV2_DMA_DONE <= dev_dma_done(2);  DEV3_DMA_DONE <= dev_dma_done(3);
    DEV4_DMA_DONE <= dev_dma_done(4);  DEV5_DMA_DONE <= dev_dma_done(5);
    DEV6_DMA_DONE <= dev_dma_done(6);  DEV7_DMA_DONE <= dev_dma_done(7);

    DMA_Word_ACK <= dma_word_ack;

    -- ============================================================
    --  1. COMPARADOR DE RANGO PRINCIPAL
    --     Addr[31:20] = 0xD00  →  esta transacción es del LVC
    -- ============================================================
    lvc_range_hit <= '1' when (BUS_CS = '1' and
                                BUS_Addr(31 downto 20) = x"D00")
                    else '0';

    -- Bit [19] distingue MMIO de dispositivo vs LVC-ECAM
    is_ecam <= BUS_Addr(19);

    -- Índice de dispositivo para MMIO: Addr[18:12]  (0-7)
    dev_idx_mmio <= to_integer(unsigned(BUS_Addr(14 downto 12)));

    -- Índice de dispositivo para ECAM: Addr[10:8]   (0-7)
    dev_idx_ecam <= to_integer(unsigned(BUS_Addr(10 downto 8)));

    -- Índice de registro ECAM: Addr[3:2]
    --   0=DEVICE_ID  1=MSI_CTRL  2=MSI_VEC  3=DMA_MSI_VEC
    ecam_reg_idx <= to_integer(unsigned(BUS_Addr(3 downto 2)));

    -- El LVC reclama la transacción
    LVC_ACK <= lvc_range_hit;

    -- ============================================================
    --  2. GENERACIÓN DE CHIP SELECTS (solo para MMIO, no ECAM)
    --     CS activo solo cuando la addr es MMIO (no ECAM) y
    --     el índice coincide con el dispositivo.
    -- ============================================================
    cs_gen : process(lvc_range_hit, is_ecam, dev_idx_mmio)
    begin
        cs_dev <= (others => '0');   -- todos desactivados por defecto
        if lvc_range_hit = '1' and is_ecam = '0' then
            cs_dev(dev_idx_mmio) <= '1';
        end if;
    end process cs_gen;

    -- ============================================================
    --  3. BUS INTERNO HACIA DISPOSITIVOS (compartido)
    --     SUB_Addr = offset de 12 bits dentro del bloque 4 KB
    -- ============================================================
    SUB_WE       <= BUS_WE;
    SUB_Addr     <= BUS_Addr(11 downto 0);
    SUB_Data_out <= BUS_Data_out;
    SUB_Byte_En  <= BUS_Byte_En;

    -- ============================================================
    --  4. MULTIPLEXOR DE DATO DE LECTURA MMIO
    --     El dispositivo con CS activo pone su dato aquí.
    -- ============================================================
    mux_mmio_rd : process(lvc_range_hit, is_ecam, dev_idx_mmio, dev_data_in)
    begin
        mmio_read_data <= (others => '0');
        if lvc_range_hit = '1' and is_ecam = '0' then
            mmio_read_data <= dev_data_in(dev_idx_mmio);
        end if;
    end process mux_mmio_rd;

    -- ============================================================
    --  5. MULTIPLEXOR DE DATO DE LECTURA ECAM
    --     Lee registros internos del banco ECAM del LVC.
    --     Registros: 0=DEVICE_ID  1=MSI_CTRL  2=MSI_VEC  3=DMA_MSI_VEC
    -- ============================================================
    mux_ecam_rd : process(lvc_range_hit, is_ecam, dev_idx_ecam, ecam_reg_idx,
                          ecam_msi_ctrl, ecam_msi_vec, ecam_dma_msi_vec,
                          dma_state, dma_grant_idx)
        variable v_dev  : integer range 0 to 7;
        variable v_reg  : integer range 0 to 3;
        variable v_stat : std_logic_vector(31 downto 0);
    begin
        ecam_read_data <= (others => '0');
        if lvc_range_hit = '1' and is_ecam = '1' then
            v_dev := dev_idx_ecam;
            v_reg := ecam_reg_idx;
            case v_reg is
                when 0 =>   -- DEVICE_ID (solo lectura)
                    ecam_read_data <= DEVICE_ID(v_dev);
                when 1 =>   -- MSI_CTRL
                    ecam_read_data(1 downto 0) <= ecam_msi_ctrl(v_dev);
                    ecam_read_data(31 downto 2) <= (others => '0');
                when 2 =>   -- MSI_VEC
                    ecam_read_data(6 downto 0) <= ecam_msi_vec(v_dev);
                    ecam_read_data(31 downto 7) <= (others => '0');
                when 3 =>   -- DMA_MSI_VEC
                    ecam_read_data(6 downto 0) <= ecam_dma_msi_vec(v_dev);
                    ecam_read_data(31 downto 7) <= (others => '0');
                when others =>
                    ecam_read_data <= (others => '0');
            end case;
        end if;
    end process mux_ecam_rd;

    -- Salida final al bus (MMIO o ECAM según is_ecam)
    LVC_Data_in <= ecam_read_data when (lvc_range_hit = '1' and is_ecam = '1')
                   else mmio_read_data;

    -- ============================================================
    --  6. BANCO DE REGISTROS ECAM (escritura síncrona)
    --     Reg 0 (DEVICE_ID) es solo lectura; escrituras ignoradas.
    --     Reg 1 = MSI_CTRL, Reg 2 = MSI_VEC, Reg 3 = DMA_MSI_VEC
    -- ============================================================
    ecam_write : process(CLK)
        variable v_dev : integer range 0 to 7;
        variable v_reg : integer range 0 to 3;
    begin
        if CLK'event and CLK = '1' then
            if RST = '1' then
                -- Valores por defecto: MSI deshabilitado, vector 0
                for i in 0 to 7 loop
                    ecam_msi_ctrl(i)    <= "00";
                    ecam_msi_vec(i)     <= std_logic_vector(to_unsigned(i, 7));
                    ecam_dma_msi_vec(i) <= std_logic_vector(to_unsigned(i + 8, 7));
                end loop;
            elsif lvc_range_hit = '1' and is_ecam = '1' and BUS_WE = '1' then
                v_dev := dev_idx_ecam;
                v_reg := ecam_reg_idx;
                case v_reg is
                    when 0 =>   -- DEVICE_ID: solo lectura, ignorar escritura
                        null;
                    when 1 =>   -- MSI_CTRL
                        ecam_msi_ctrl(v_dev) <= BUS_Data_out(1 downto 0);
                    when 2 =>   -- MSI_VEC
                        ecam_msi_vec(v_dev) <= BUS_Data_out(6 downto 0);
                    when 3 =>   -- DMA_MSI_VEC
                        ecam_dma_msi_vec(v_dev) <= BUS_Data_out(6 downto 0);
                    when others => null;
                end case;
            end if;
        end if;
    end process ecam_write;

    -- ============================================================
    --  7. ÁRBITRO DMA ROUND-ROBIN + FSM DE TRANSFERENCIA
    --
    --     Estados:
    --       DMA_IDLE  → escanea dispositivos buscando REQ activo
    --       DMA_BURST → transfiere una palabra por ciclo de ACK
    --       DMA_DONE  → pulsa DONE y MSI, vuelve a IDLE
    --
    --     El árbitro avanza el puntero (dma_arb_ptr) desde el
    --     último dispositivo servido (round-robin justo).
    -- ============================================================
    dma_fsm : process(CLK)
        variable v_next     : integer range 0 to 7;
        variable v_found    : std_logic;
        variable v_cnt_next : std_logic_vector(15 downto 0);
    begin
        if CLK'event and CLK = '1' then
            if RST = '1' then
                dma_state     <= DMA_IDLE;
                dma_grant_idx <= 0;
                dma_arb_ptr   <= 0;
                dma_addr_ptr  <= (others => '0');
                dma_cnt_r     <= (others => '0');
                dma_we_r      <= '0';
                dev_dma_gnt   <= (others => '0');
                dev_dma_done  <= (others => '0');
                dma_word_ack  <= '0';
                dma_active    <= '0';
                DMA_RAM_REQ   <= '0';
                DMA_RAM_WE    <= '0';
                DMA_RAM_Addr  <= (others => '0');
                DMA_RAM_Wr_Data <= (others => '0');
                DMA_Rd_Data   <= (others => '0');
            else
                -- Pulsos de 1 ciclo: limpiar antes de actualizar
                dev_dma_done <= (others => '0');
                dma_word_ack <= '0';

                case dma_state is

                    -- ── IDLE: arbitraje round-robin ───────────
                    when DMA_IDLE =>
                        dma_active    <= '0';
                        DMA_RAM_REQ   <= '0';
                        dev_dma_gnt   <= (others => '0');

                        v_found := '0';
                        for pass in 0 to 7 loop
                            if v_found = '0' then
                                v_next := (dma_arb_ptr + 1 + pass) mod 8;
                                if dev_dma_req(v_next) = '1' then
                                    -- Dispositivo encontrado: capturar parámetros
                                    dma_grant_idx          <= v_next;
                                    dma_addr_ptr           <= dev_dma_addr(v_next);
                                    dma_cnt_r              <= dev_dma_cant(v_next);
                                    dma_we_r               <= dev_dma_we(v_next);
                                    dev_dma_gnt(v_next)    <= '1';
                                    dma_active             <= '1';
                                    dma_arb_ptr            <= v_next;
                                    v_found                := '1';
                                    dma_state              <= DMA_BURST;
                                end if;
                            end if;
                        end loop;

                    -- ── BURST: transferencia de palabras ──────
                    when DMA_BURST =>
                        DMA_RAM_REQ     <= '1';
                        DMA_RAM_WE      <= dma_we_r;
                        DMA_RAM_Addr    <= dma_addr_ptr;
                        DMA_RAM_Wr_Data <= DMA_Wr_Data;  -- dato del dispositivo

                        if DMA_RAM_ACK = '1' then
                            -- Una palabra transferida
                            dma_word_ack <= '1';

                            if dma_we_r = '0' then
                                -- Lectura: retransmitir dato de RAM al dispositivo
                                DMA_Rd_Data <= DMA_RAM_Rd_Data;
                            end if;

                            -- Avanzar puntero de dirección (+4 bytes)
                            dma_addr_ptr <= std_logic_vector(
                                unsigned(dma_addr_ptr) + 4);

                            -- Decrementar contador de palabras
                            v_cnt_next := std_logic_vector(
                                unsigned(dma_cnt_r) - 1);
                            dma_cnt_r <= v_cnt_next;

                            if v_cnt_next = x"0000" then
                                -- Última palabra: ir a DONE
                                DMA_RAM_REQ <= '0';
                                dma_state   <= DMA_DONE;
                            end if;
                        end if;

                    -- ── DONE: señalizar finalización ─────────
                    when DMA_DONE =>
                        DMA_RAM_REQ  <= '0';
                        dma_active   <= '0';
                        dev_dma_gnt  <= (others => '0');
                        -- Pulso de DONE al dispositivo que fue servido
                        dev_dma_done(dma_grant_idx) <= '1';
                        dma_state <= DMA_IDLE;

                    when others =>
                        dma_state <= DMA_IDLE;

                end case;
            end if;
        end if;
    end process dma_fsm;

    -- ============================================================
    --  8. GENERADOR DE BITMAP MSI DE 128 BITS
    --
    --     Para cada dispositivo n:
    --       Si DEVn_MSI_REQ='1' y MSI_EN='1' (ecam_msi_ctrl(n)(0))
     --        → bit MSI_VEC(n) del bitmap se pone a '1'
    --
    --     Para cada canal DMA completado:
    --       Si dev_dma_done(n)='1' y DMA_MSI_EN='1' (ecam_msi_ctrl(n)(1))
    --        → bit DMA_MSI_VEC(n) del bitmap se pone a '1'
    --
    --     El bitmap resultante se OR-ea de todos los dispositivos.
    --     Se usa una variable local para acumular sin conflictos.
    -- ============================================================
    msi_bitmap_gen : process(dev_msi_req, dev_dma_done,
                              ecam_msi_ctrl, ecam_msi_vec, ecam_dma_msi_vec)
        variable v_bmap  : std_logic_vector(127 downto 0);
        variable v_vidx  : integer range 0 to 127;
    begin
        v_bmap := (others => '0');

        for i in 0 to 7 loop
            -- MSI de dispositivo
            if dev_msi_req(i) = '1' and ecam_msi_ctrl(i)(0) = '1' then
                v_vidx := to_integer(unsigned(ecam_msi_vec(i)));
                v_bmap(v_vidx) := '1';
            end if;

            -- MSI de finalización DMA
            if dev_dma_done(i) = '1' and ecam_msi_ctrl(i)(1) = '1' then
                v_vidx := to_integer(unsigned(ecam_dma_msi_vec(i)));
                v_bmap(v_vidx) := '1';
            end if;
        end loop;

        MSI_OUT <= v_bmap;
    end process msi_bitmap_gen;

end architecture RTL;
