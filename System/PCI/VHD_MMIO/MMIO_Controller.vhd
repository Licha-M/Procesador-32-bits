-- ============================================================
--  MMIO Controller — Filtro Principal RAM / ROM / E/S
--  Arquitectura 32 bits  |  VHDL-93
--  Compatible con Logisim-Evolution 3.9 (VHDL Component)
-- ============================================================
--
--  MAPA DE MEMORIA FÍSICO:
--    0x00000000 – 0x7FFFFFFF  →  RAM  (bit 31 = 0)
--    0xFF000000 – 0xFFFFFFFF  →  ROM  (bits 31..24 = 0xFF)
--    (todo lo demás)          →  Bus de Periféricos
--
--  INTERFAZ PIPELINE:
--    Entradas desde el pipeline:
--      Data_out  [31:0]  — Dato a escribir
--      RoW       [1:0]   — [1]=Usa RAM  [0]=1=Write/0=Read
--      Addr      [31:0]  — Dirección física
--      Tipo      [2:0]   — 000=8bits  001=32bits  (resto reservado)
--
--    Salidas hacia el pipeline:
--      Data_in   [63:0]  — 64 bits de dato entregados por la RAM.
--                          La RAM devuelve dos palabras de 32 bits
--                          consecutivas para llenar la cola FIFO del
--                          pipeline. Para ROM/periféricos (32 bits)
--                          se entrega el dato en [31:0] y ceros en [63:32].
--      Stall     [0]     — 1 = pipeline detenido (espera RAM)
--      RAM_Ready [0]     — reflejo de la señal de RAM (info al pipeline)
--
--  INTERFAZ RAM (sincrona, externa):
--    RAM_Data_in  [63:0]  — 64 bits devueltos por la RAM (bus ancho)
--    RAM_Ready_in [0]     — la RAM completó la operación
--    RAM_CS       [0]     — habilita la RAM
--    RAM_WE       [0]     — 1=escritura  0=lectura
--    RAM_Addr     [31:0]  — dirección hacia la RAM
--    RAM_Data_out [31:0]  — dato hacia la RAM
--    RAM_Byte_En  [3:0]   — habilitación de byte (Tipo)
--
--  INTERFAZ ROM (combinacional, externa):
--    ROM_Data_in  [31:0]  — dato devuelto por la ROM (combinacional)
--    ROM_CS       [0]     — habilita la ROM
--    ROM_Addr     [31:0]  — dirección hacia la ROM
--
--  INTERFAZ BUS PERIFÉRICOS (expone todo al bus externo):
--    PERIPH_CS       [0]     — hay transacción de periférico activa
--    PERIPH_WE       [0]     — 1=escritura  0=lectura
--    PERIPH_Addr     [31:0]  — dirección en el bus
--    PERIPH_Data_out [31:0]  — dato hacia el periférico
--    PERIPH_Data_in  [31:0]  — dato devuelto por el periférico
--    PERIPH_Byte_En  [3:0]   — ancho de la transferencia
-- ============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ------------------------------------------------------------
entity MMIO_Controller is
    port (
        -- ── Reloj y Reset ───────────────────────────────────
        CLK             : in  std_logic;
        RST             : in  std_logic;    -- activo en alto

        -- ── Interfaz Pipeline (entrada) ──────────────────────
        PL_Addr         : in  std_logic_vector(31 downto 0);
        PL_Data_out     : in  std_logic_vector(31 downto 0);
        PL_RoW          : in  std_logic_vector(1 downto 0);
        PL_Tipo         : in  std_logic_vector(2 downto 0);

        -- ── Interfaz Pipeline (salida) ───────────────────────
        PL_Data_in      : out std_logic_vector(63 downto 0);
        PL_Stall        : out std_logic;
        PL_RAM_Ready    : out std_logic;

        -- ── Interfaz RAM ─────────────────────────────────────
        RAM_Data_in     : in  std_logic_vector(63 downto 0);   -- Bus RAM de 64 bits
        RAM_Ready_in    : in  std_logic;

        RAM_CS          : out std_logic;
        RAM_WE          : out std_logic;
        RAM_Addr        : out std_logic_vector(31 downto 0);
        RAM_Data_out    : out std_logic_vector(31 downto 0);
        RAM_Byte_En     : out std_logic_vector(3 downto 0);

        -- ── Interfaz ROM (combinacional) ─────────────────────
        ROM_Data_in     : in  std_logic_vector(31 downto 0);

        ROM_CS          : out std_logic;
        ROM_Addr        : out std_logic_vector(31 downto 0);

        -- ── Bus de Periféricos ───────────────────────────────
        PERIPH_Data_in  : in  std_logic_vector(31 downto 0);

        PERIPH_CS       : out std_logic;
        PERIPH_WE       : out std_logic;
        PERIPH_Addr     : out std_logic_vector(31 downto 0);
        PERIPH_Data_out : out std_logic_vector(31 downto 0);
        PERIPH_Byte_En  : out std_logic_vector(3 downto 0)
    );
end entity MMIO_Controller;

-- ------------------------------------------------------------
architecture RTL of MMIO_Controller is

    -- ── Señales internas de decodificación ───────────────────
    signal sel_ram    : std_logic;
    signal sel_rom    : std_logic;
    signal sel_periph : std_logic;

    -- ── Byte enable según Tipo ───────────────────────────────
    signal byte_en_s  : std_logic_vector(3 downto 0);

    -- ── Dato leído multiplexado (64 bits hacia el pipeline) ────
    --    RAM  → 64 bits reales (dos palabras para la FIFO)
    --    ROM  → 32 bits en [31:0], ceros en [63:32]
    --    PERIPH → 32 bits en [31:0], ceros en [63:32]
    signal read_data  : std_logic_vector(63 downto 0);

    -- ── Stall interno ────────────────────────────────────────
    signal stall_s    : std_logic;

begin

    -- ============================================================
    --  1. DECODIFICACIÓN COMBINACIONAL DE RANGO
    --     Solo se examina la dirección; ningún registro intermedio.
    -- ============================================================
    decode_range : process(PL_Addr)
    begin
        -- Valores por defecto (safe defaults)
        sel_ram    <= '0';
        sel_rom    <= '0';
        sel_periph <= '0';

        if PL_Addr(31) = '0' then
            -- 0x00000000 – 0x7FFFFFFF  →  RAM
            sel_ram    <= '1';

        elsif PL_Addr(31 downto 24) = x"FF" then
            -- 0xFF000000 – 0xFFFFFFFF  →  ROM
            sel_rom    <= '1';

        else
            -- Todo lo demás              →  Bus periféricos
            sel_periph <= '1';
        end if;
    end process decode_range;

    -- ============================================================
    --  2. GENERACIÓN DE BYTE ENABLE SEGÚN PL_Tipo
    --     000 = acceso de 8 bits  → 0001 (byte bajo)
    --     001 = acceso de 32 bits → 1111 (palabra completa)
    --     otros = reservado        → 0000
    --  Nota: en un diseño real el offset dentro de la palabra
    --  rotatría el byte enable; aquí se asume alineación.
    -- ============================================================
    byte_enable : process(PL_Tipo)
    begin
        case PL_Tipo is
            when "000"  => byte_en_s <= "0001";   -- 8 bits
            when "001"  => byte_en_s <= "1111";   -- 32 bits
            when others => byte_en_s <= "0000";   -- reservado
        end case;
    end process byte_enable;

    -- ============================================================
    --  3. GENERACIÓN DE STALL
    --     El pipeline se detiene si:
    --       - La dirección apunta a RAM (sel_ram='1')
    --       - Y la RAM aún no ha terminado (RAM_Ready_in='0')
    --     La ROM es combinacional: nunca genera Stall.
    --     Los periféricos no generan Stall en este nivel
    --     (su latencia es gestionada externamente).
    -- ============================================================
    stall_s  <= sel_ram and (not RAM_Ready_in);
    PL_Stall <= stall_s;

    -- ============================================================
    --  4. MULTIPLEXADO DE DATO DE LECTURA HACIA EL PIPELINE
    --     Priority: RAM > ROM > Periféricos
    --
    --     RAM    → 64 bits reales del bus ancho de la RAM.
    --              Los bits [63:32] contienen la segunda palabra de
    --              32 bits (dirección+4), usada para llenar la FIFO
    --              de instrucciones del pipeline en un solo ciclo.
    --
    --     ROM    → 32 bits en [31:0]; [63:32] = 0x00000000
    --     PERIPH → 32 bits en [31:0]; [63:32] = 0x00000000
    -- ============================================================
    mux_read : process(sel_ram, sel_rom, sel_periph,
                       RAM_Data_in, ROM_Data_in, PERIPH_Data_in)
    begin
        read_data <= (others => '0');   -- default (safe)

        if sel_ram = '1' then
            -- Pasar los 64 bits completos de la RAM al pipeline
            read_data <= RAM_Data_in;
        elsif sel_rom = '1' then
            -- ROM entrega 32 bits; zero-extend a 64
            read_data(31 downto  0) <= ROM_Data_in;
            read_data(63 downto 32) <= (others => '0');
        elsif sel_periph = '1' then
            -- Periférico entrega 32 bits; zero-extend a 64
            read_data(31 downto  0) <= PERIPH_Data_in;
            read_data(63 downto 32) <= (others => '0');
        end if;
    end process mux_read;

    -- Los 64 bits van directamente al pipeline
    PL_Data_in <= read_data;

    -- ============================================================
    --  5. SALIDAS RAM
    -- ============================================================
    RAM_CS       <= sel_ram;
    RAM_WE       <= PL_RoW(0) when sel_ram = '1' else '0';
    RAM_Addr     <= PL_Addr;
    RAM_Data_out <= PL_Data_out;
    RAM_Byte_En  <= byte_en_s;

    -- ============================================================
    --  6. SALIDAS ROM (combinacional, solo lectura)
    -- ============================================================
    ROM_CS   <= sel_rom;
    ROM_Addr <= PL_Addr;

    -- ============================================================
    --  7. SALIDAS BUS PERIFÉRICOS
    --     PERIPH_CS se activa cuando la dirección no es RAM ni ROM.
    --     Los dispositivos (PCIe, LVC) inspeccionan el bus y
    --     responden solo si reconocen la dirección (BAR/decodif.).
    -- ============================================================
    PERIPH_CS       <= sel_periph;
    PERIPH_WE       <= PL_RoW(0) when sel_periph = '1' else '0';
    PERIPH_Addr     <= PL_Addr;
    PERIPH_Data_out <= PL_Data_out;
    PERIPH_Byte_En  <= byte_en_s;

    -- ============================================================
    --  8. REFLEJO DE RAM_READY AL PIPELINE
    -- ============================================================
    PL_RAM_Ready <= RAM_Ready_in;

end architecture RTL;
