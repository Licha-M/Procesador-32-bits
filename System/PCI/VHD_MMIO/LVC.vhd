-- ============================================================
--  Low Velocity Controller (LVC) — Hub de Periféricos
--  Arquitectura 32 bits  |  VHDL-93
--  Compatible con Logisim-Evolution 3.9 (VHDL Component)
-- ============================================================
--
--  PROPÓSITO:
--    Hub tipo PCIe-switch simplificado para 8 dispositivos lentos.
--    Implementa protocolo VALID/READY, bus de datos vectorial unificado,
--    y arbitraje Round-Robin con bloqueo por DMA.
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
--      Addr[3:2]   → registro: 00=DEVICE_ID
--
--  Los dispositivos envían su MSI directamente al LAPIC.
-- ============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LVC is
    port (
        -- ── Reloj y Reset ───────────────────────────────────
        CLK              : in  std_logic;
        RST              : in  std_logic;

        -- ── Bus de Periféricos (desde MMIO Controller) ───────
        SYS_Data_in      : in  std_logic_vector(31 downto 0);
        SYS_Data_out     : out std_logic_vector(31 downto 0);
        SYS_Addr         : in  std_logic_vector(31 downto 0);
        SYS_WE           : in  std_logic;
        LVC_SEL          : in  std_logic;
        SYS_VALID        : in  std_logic;
        SYS_READY        : out std_logic;

        -- ── Interfaz RAM para DMA (hacia el Memory Controller) ──
        MEM_BUS_REQ      : out std_logic;
        MEM_BUS_GNT      : in  std_logic;
        DMA_RAM_REQ      : out std_logic;
        DMA_RAM_WE       : out std_logic;
        DMA_RAM_Addr     : out std_logic_vector(31 downto 0);
        DMA_RAM_Wr_Data  : out std_logic_vector(31 downto 0);
        DMA_RAM_Rd_Data  : in  std_logic_vector(31 downto 0);
        DMA_RAM_ACK      : in  std_logic;

        -- ── Bus Unificado hacia Dispositivos Lentos (0 a 7) ───
        DEV_ID           : out std_logic_vector(2 downto 0);
        DEV_Data_out     : out std_logic_vector(31 downto 0);
        DEV_Data_in      : in  std_logic_vector(31 downto 0);
        DEV_Addr_out     : out std_logic_vector(31 downto 0);
        DEV_Addr_in      : in  std_logic_vector(31 downto 0);
        DEV_WE_out       : out std_logic;
        DEV_WE_in        : in  std_logic;

        DEV_VALID        : out std_logic;
        DEV_READY        : in  std_logic_vector(7 downto 0);
        
        -- ── Control de DMA de los dispositivos ────────────────
        DMA_REQ          : in  std_logic_vector(7 downto 0);
        DMA_ACK          : out std_logic_vector(7 downto 0);
        DEV_DMA_ACK_Word : out std_logic
    );
end entity LVC;

architecture RTL of LVC is

    -- Constantes DEVICE_ID (solo lectura en ECAM)
    type dev_id_t is array(0 to 7) of std_logic_vector(31 downto 0);
    constant DEVICE_ID_ARR : dev_id_t := (
        x"00000001", -- DEV0: UART
        x"00000002", -- DEV1: GPIO
        x"00000003", -- DEV2: Timer
        x"00000004", -- DEV3: USB
        x"00000005", -- DEV4: SATA
        x"00000006", -- DEV5: Audio
        x"00000007", -- DEV6: PS/2
        x"00000008"  -- DEV7: Expansión
    );

    -- Señales de decodificación LVC
    signal lvc_range_hit : std_logic;
    signal is_ecam       : std_logic;
    signal dev_idx_mmio  : integer range 0 to 7;
    signal dev_idx_ecam  : integer range 0 to 7;
    signal ecam_reg_idx  : integer range 0 to 3;
    
    -- Arbitraje DMA
    signal rr_ptr        : integer range 0 to 7;
    signal dma_locked    : std_logic;
    signal dma_owner     : integer range 0 to 7;
    signal wait_gnt      : std_logic;

begin

    -- ============================================================
    --  1. DECODIFICACIÓN DE DIRECCIONES SYS_Addr
    -- ============================================================
    lvc_range_hit <= '1' when (LVC_SEL = '1' and SYS_Addr(31 downto 20) = x"D00") else '0';
    
    is_ecam       <= SYS_Addr(19);
    dev_idx_mmio  <= to_integer(unsigned(SYS_Addr(14 downto 12)));
    dev_idx_ecam  <= to_integer(unsigned(SYS_Addr(10 downto 8)));
    ecam_reg_idx  <= to_integer(unsigned(SYS_Addr(3 downto 2)));

    -- ============================================================
    --  2. ÁRBITRO ROUND-ROBIN Y MÁQUINA DE ESTADOS DMA
    -- ============================================================
    process(CLK)
        variable v_next : integer range 0 to 7;
        variable v_found : std_logic;
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                rr_ptr     <= 0;
                dma_locked <= '0';
                dma_owner  <= 0;
                wait_gnt   <= '0';
                MEM_BUS_REQ <= '0';
                DMA_ACK    <= (others => '0');
            else
                if dma_locked = '0' and wait_gnt = '0' then
                    -- Búsqueda de petición DMA en Round-Robin
                    v_found := '0';
                    for pass in 0 to 7 loop
                        if v_found = '0' then
                            v_next := (rr_ptr + 1 + pass) mod 8;
                            if DMA_REQ(v_next) = '1' then
                                wait_gnt    <= '1';
                                dma_owner   <= v_next;
                                MEM_BUS_REQ <= '1';
                                v_found     := '1';
                            end if;
                        end if;
                    end loop;
                    if v_found = '0' then
                        -- Sin DMA, el puntero se mantiene
                    end if;
                elsif wait_gnt = '1' then
                    -- Esperar a que el Memory Controller nos dé el bus
                    if MEM_BUS_GNT = '1' then
                        wait_gnt <= '0';
                        dma_locked <= '1';
                        DMA_ACK(dma_owner) <= '1';
                        rr_ptr <= dma_owner; -- Actualizar RR pointer
                    end if;
                elsif dma_locked = '1' then
                    -- Modo Bloqueo DMA
                    -- Esperamos a que el dispositivo baje DMA_REQ
                    if DMA_REQ(dma_owner) = '0' then
                        dma_locked <= '0';
                        DMA_ACK(dma_owner) <= '0';
                        MEM_BUS_REQ <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- ============================================================
    --  3. ENRUTAMIENTO DE SEÑALES SEGÚN EL MODO (NORMAL vs DMA)
    -- ============================================================
    
    -- A) Hacia el dispositivo (DEV_...)
    process(dma_locked, lvc_range_hit, is_ecam, dev_idx_mmio, SYS_VALID, SYS_Addr, SYS_Data_in, SYS_WE, DMA_RAM_Rd_Data, dma_owner)
    begin
        if dma_locked = '1' then
            -- Durante DMA, los datos hacia el dispositivo vienen de la RAM
            DEV_ID       <= std_logic_vector(to_unsigned(dma_owner, 3));
            DEV_Data_out <= DMA_RAM_Rd_Data;
            DEV_Addr_out <= (others => '0'); -- No aplica en DMA
            DEV_WE_out   <= '0';
            DEV_VALID    <= '0'; -- El dispositivo lidera
        else
            -- Modo Normal (Lectura/Escritura MMIO)
            if lvc_range_hit = '1' and is_ecam = '0' then
                DEV_ID       <= std_logic_vector(to_unsigned(dev_idx_mmio, 3));
                DEV_Data_out <= SYS_Data_in;
                DEV_Addr_out <= SYS_Addr;
                DEV_WE_out   <= SYS_WE;
                DEV_VALID    <= SYS_VALID;
            else
                DEV_ID       <= (others => '0');
                DEV_Data_out <= (others => '0');
                DEV_Addr_out <= (others => '0');
                DEV_WE_out   <= '0';
                DEV_VALID    <= '0';
            end if;
        end if;
    end process;

    -- B) Hacia el sistema MMIO (SYS_...)
    process(lvc_range_hit, is_ecam, SYS_VALID, dev_idx_ecam, ecam_reg_idx, dev_idx_mmio, DEV_READY, DEV_Data_in, dma_locked)
    begin
        SYS_Data_out <= (others => '0');
        SYS_READY    <= '0';

        if dma_locked = '0' and lvc_range_hit = '1' and SYS_VALID = '1' then
            if is_ecam = '1' then
                -- Respuesta del LVC-ECAM (interna)
                SYS_READY <= '1';
                if ecam_reg_idx = 0 then
                    SYS_Data_out <= DEVICE_ID_ARR(dev_idx_ecam);
                else
                    SYS_Data_out <= (others => '0');
                end if;
            else
                -- Respuesta del dispositivo MMIO
                SYS_Data_out <= DEV_Data_in;
                SYS_READY    <= DEV_READY(dev_idx_mmio);
            end if;
        end if;
    end process;

    -- C) Hacia el Memory Controller (DMA_RAM_...)
    process(dma_locked, DEV_Addr_in, DEV_Data_in, DEV_WE_in)
    begin
        if dma_locked = '1' then
            DMA_RAM_Addr    <= DEV_Addr_in;
            DMA_RAM_Wr_Data <= DEV_Data_in;
            DMA_RAM_WE      <= DEV_WE_in;
        else
            DMA_RAM_Addr    <= (others => '0');
            DMA_RAM_Wr_Data <= (others => '0');
            DMA_RAM_WE      <= '0';
        end if;
    end process;
    
    -- Mantiene la ráfaga activa hacia la RAM mientras dure el bloqueo DMA
    DMA_RAM_REQ <= '1' when dma_locked = '1' else '0';

    -- El ACK de la RAM se pasa al dispositivo
    DEV_DMA_ACK_Word <= DMA_RAM_ACK when dma_locked = '1' else '0';

end architecture RTL;