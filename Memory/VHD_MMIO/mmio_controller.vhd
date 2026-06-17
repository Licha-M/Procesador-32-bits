-- =============================================================================
-- Circuito 1: Controlador MMIO (Address Decoder / Memory Router)
-- =============================================================================
-- Proposito:
--   Interceptar toda transaccion de memoria que viene del pipeline del CPU,
--   decodificar la direccion fisica y decidir si el acceso va a RAM, ROM,
--   LAPIC o al Controlador General de PCIe.
--
-- Interfaz con el Pipeline:
--   Entradas desde pipeline:
--     ADDR_BUS  : 32 bits  (Addr del pipeline)
--     WDATA     : 32 bits  (Data_out del pipeline)
--     WEN       : 1 bit    (RoW(0): '1' = escritura)
--     REN       : 1 bit    (RoW(1) invertido: '1' = lectura)
--     BYTE_SEL  : 4 bits   (Tipo -> strobe de bytes)
--     VALID_REQ : 1 bit    (RoW(1): '1' cuando hay peticion real)
--   Salidas hacia pipeline:
--     RDATA_OUT : 32 bits  (Data_in(31:0))
--     READY     : 1 bit    (RAM_Ready del pipeline)
--     IS_MMIO   : 1 bit    (flag de cache)
--
-- Mapas de Memoria fijos:
--   RAM        : 0x00000000 - 0x3FFFFFFF  (bits[31:30] = "00")
--   ROM        : 0xFFFF0000 - 0xFFFFFFFF  (bits[31:16] = 0xFFFF)
--   LAPIC      : 0xFEE00000 - 0xFEE00FFF  (bits[31:12] = 0xFEE00)
--   PCIE_CTRL  : 0xC0000000 - 0xC00FFFFF  (bits[31:20] = 0xC00)
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mmio_controller is
    port (
        -- Entradas desde el pipeline del CPU
        ADDR_BUS  : in  STD_LOGIC_VECTOR(31 downto 0);
        WDATA     : in  STD_LOGIC_VECTOR(31 downto 0);
        WEN       : in  STD_LOGIC;
        REN       : in  STD_LOGIC;
        BYTE_SEL  : in  STD_LOGIC_VECTOR(3 downto 0);
        VALID_REQ : in  STD_LOGIC;

        -- Datos de retorno de cada esclavo
        RDATA_RAM        : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_ROM        : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_LAPIC      : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_PCIE_CTRL  : in  STD_LOGIC_VECTOR(31 downto 0);

        -- Handshake de cada esclavo
        READY_RAM        : in  STD_LOGIC;
        READY_ROM        : in  STD_LOGIC;
        READY_LAPIC      : in  STD_LOGIC;
        READY_PCIE_CTRL  : in  STD_LOGIC;

        -- Salidas Chip Select hacia cada esclavo
        CS_RAM        : out STD_LOGIC;
        CS_ROM        : out STD_LOGIC;
        CS_LAPIC      : out STD_LOGIC;
        CS_PCIE_CTRL  : out STD_LOGIC;

        -- Direccion local (offset dentro del esclavo)
        LOCAL_ADDR : out STD_LOGIC_VECTOR(19 downto 0);

        -- Propagacion
        WDATA_OUT : out STD_LOGIC_VECTOR(31 downto 0);
        WEN_OUT   : out STD_LOGIC;
        REN_OUT   : out STD_LOGIC;
        BSEL_OUT  : out STD_LOGIC_VECTOR(3 downto 0);

        -- Retorno al pipeline
        RDATA_OUT : out STD_LOGIC_VECTOR(31 downto 0);
        READY     : out STD_LOGIC;
        IS_MMIO   : out STD_LOGIC
    );
end mmio_controller;

architecture Combinacional of mmio_controller is
    signal HIT_RAM        : STD_LOGIC;
    signal HIT_ROM        : STD_LOGIC;
    signal HIT_LAPIC      : STD_LOGIC;
    signal HIT_PCIE_CTRL  : STD_LOGIC;

    signal SEL_RAM        : STD_LOGIC;
    signal SEL_ROM        : STD_LOGIC;
    signal SEL_LAPIC      : STD_LOGIC;
    signal SEL_PCIE_CTRL  : STD_LOGIC;

    signal OFFSET_LOW20   : STD_LOGIC_VECTOR(19 downto 0);
    signal OFFSET_LOW12   : STD_LOGIC_VECTOR(11 downto 0);

    signal RDATA_MUX      : STD_LOGIC_VECTOR(31 downto 0);
    signal READY_MUX      : STD_LOGIC;
    signal LADDR_MUX      : STD_LOGIC_VECTOR(19 downto 0);
begin
    -- Decodificacion
    HIT_RAM <= (NOT ADDR_BUS(31)) AND (NOT ADDR_BUS(30));
    HIT_ROM <=  ADDR_BUS(31) AND ADDR_BUS(30) AND ADDR_BUS(29) AND ADDR_BUS(28) AND
                ADDR_BUS(27) AND ADDR_BUS(26) AND ADDR_BUS(25) AND ADDR_BUS(24) AND
                ADDR_BUS(23) AND ADDR_BUS(22) AND ADDR_BUS(21) AND ADDR_BUS(20) AND
                ADDR_BUS(19) AND ADDR_BUS(18) AND ADDR_BUS(17) AND ADDR_BUS(16);
    HIT_LAPIC <=
            ADDR_BUS(31) AND ADDR_BUS(30) AND ADDR_BUS(29) AND ADDR_BUS(28) AND
            ADDR_BUS(27) AND ADDR_BUS(26) AND ADDR_BUS(25) AND (NOT ADDR_BUS(24)) AND
            ADDR_BUS(23) AND ADDR_BUS(22) AND ADDR_BUS(21) AND (NOT ADDR_BUS(20)) AND
            (NOT ADDR_BUS(19)) AND (NOT ADDR_BUS(18)) AND (NOT ADDR_BUS(17)) AND (NOT ADDR_BUS(16)) AND
            (NOT ADDR_BUS(15)) AND (NOT ADDR_BUS(14)) AND (NOT ADDR_BUS(13)) AND (NOT ADDR_BUS(12));
    HIT_PCIE_CTRL <=
            ADDR_BUS(31) AND ADDR_BUS(30) AND
            (NOT ADDR_BUS(29)) AND (NOT ADDR_BUS(28)) AND
            (NOT ADDR_BUS(27)) AND (NOT ADDR_BUS(26)) AND
            (NOT ADDR_BUS(25)) AND (NOT ADDR_BUS(24)) AND
            (NOT ADDR_BUS(23)) AND (NOT ADDR_BUS(22)) AND
            (NOT ADDR_BUS(21)) AND (NOT ADDR_BUS(20));

    SEL_RAM    <= HIT_RAM    AND (NOT HIT_ROM) AND (NOT HIT_LAPIC) AND (NOT HIT_PCIE_CTRL) AND VALID_REQ;
    SEL_ROM    <= HIT_ROM    AND VALID_REQ;
    SEL_LAPIC  <= HIT_LAPIC  AND (NOT HIT_ROM) AND VALID_REQ;
    SEL_PCIE_CTRL <= HIT_PCIE_CTRL AND VALID_REQ;

    CS_RAM        <= SEL_RAM;
    CS_ROM        <= SEL_ROM;
    CS_LAPIC      <= SEL_LAPIC;
    CS_PCIE_CTRL  <= SEL_PCIE_CTRL;

    OFFSET_LOW20 <= ADDR_BUS(19 downto 0);
    OFFSET_LOW12 <= ADDR_BUS(11 downto 0);

    LADDR_MUX <=
        (OFFSET_LOW20                                 ) when SEL_RAM    = '1' else
        (OFFSET_LOW20                                 ) when SEL_ROM    = '1' else
        ("00000000" & OFFSET_LOW12                    ) when SEL_LAPIC  = '1' else
        (OFFSET_LOW20                                 ) when SEL_PCIE_CTRL = '1' else
        (others => '0');

    LOCAL_ADDR <= LADDR_MUX;

    WDATA_OUT <= WDATA;
    WEN_OUT   <= WEN;
    REN_OUT   <= REN;
    BSEL_OUT  <= BYTE_SEL;

    RDATA_MUX <=
        RDATA_RAM        when SEL_RAM    = '1' else
        RDATA_ROM        when SEL_ROM    = '1' else
        RDATA_LAPIC      when SEL_LAPIC  = '1' else
        RDATA_PCIE_CTRL  when SEL_PCIE_CTRL = '1' else
        (others => '0');

    RDATA_OUT <= RDATA_MUX;

    READY_MUX <=
        READY_RAM        when SEL_RAM    = '1' else
        READY_ROM        when SEL_ROM    = '1' else
        READY_LAPIC      when SEL_LAPIC  = '1' else
        READY_PCIE_CTRL  when SEL_PCIE_CTRL = '1' else
        '0';

    READY <= READY_MUX;
    IS_MMIO <= NOT (SEL_RAM OR SEL_ROM);

end Combinacional;
