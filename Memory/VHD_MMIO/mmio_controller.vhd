-- =============================================================================
-- Circuito 1: Controlador MMIO (Address Decoder / Memory Router)
-- =============================================================================
-- Proposito:
--   Interceptar toda transaccion de memoria que viene del pipeline del CPU,
--   decodificar la direccion fisica y decidir si el acceso va a RAM, ROM,
--   LAPIC, I/O-APIC o a un periferico (NVMe, etc.).
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
-- Mapas de Memoria fijos (constantes de diseno):
--   RAM    : 0x00000000 - 0x3FFFFFFF  (bits[31:30] = "00")
--   ROM    : 0xFFFF0000 - 0xFFFFFFFF  (bits[31:16] = 0xFFFF)
--   LAPIC  : 0xFEE00000 - 0xFEE00FFF (bits[31:12] = 0xFEE00)
--   IOAPIC : 0xFEC00000 - 0xFEC00FFF (bits[31:12] = 0xFEC00)
--   PERIF0 : 0xC0000000 - 0xC00FFFFF (bits[31:20] = 0xC00)
--   PERIF1 : 0xC0100000 - 0xC01FFFFF (bits[31:20] = 0xC01)
--
-- Restriccion de diseno:
--   No se usan bucles FOR ni GENERATE. Toda logica es combinacional
--   con senales explicitas, replicable en Logisim Evolution con
--   compuertas AND, OR, NOT, XOR y MUX.
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mmio_controller is
    port (
        -- ----------------------------------------------------------------
        -- Entradas desde el pipeline del CPU
        -- ----------------------------------------------------------------
        ADDR_BUS  : in  STD_LOGIC_VECTOR(31 downto 0);  -- Direccion fisica
        WDATA     : in  STD_LOGIC_VECTOR(31 downto 0);  -- Dato a escribir
        WEN       : in  STD_LOGIC;                       -- Write Enable
        REN       : in  STD_LOGIC;                       -- Read Enable
        BYTE_SEL  : in  STD_LOGIC_VECTOR(3 downto 0);   -- Strobe de bytes
        VALID_REQ : in  STD_LOGIC;                       -- Peticion valida

        -- ----------------------------------------------------------------
        -- Datos de retorno de cada esclavo (entradas externas)
        -- ----------------------------------------------------------------
        RDATA_RAM    : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_ROM    : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_LAPIC  : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_IOAPIC : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_PERIF0 : in  STD_LOGIC_VECTOR(31 downto 0);
        RDATA_PERIF1 : in  STD_LOGIC_VECTOR(31 downto 0);

        -- Handshake de cada esclavo
        READY_RAM    : in  STD_LOGIC;
        READY_ROM    : in  STD_LOGIC;
        READY_LAPIC  : in  STD_LOGIC;
        READY_IOAPIC : in  STD_LOGIC;
        READY_PERIF0 : in  STD_LOGIC;
        READY_PERIF1 : in  STD_LOGIC;

        -- ----------------------------------------------------------------
        -- Salidas Chip Select hacia cada esclavo
        -- ----------------------------------------------------------------
        CS_RAM    : out STD_LOGIC;
        CS_ROM    : out STD_LOGIC;
        CS_LAPIC  : out STD_LOGIC;
        CS_IOAPIC : out STD_LOGIC;
        CS_PERIF0 : out STD_LOGIC;
        CS_PERIF1 : out STD_LOGIC;

        -- Direccion local (offset dentro del esclavo seleccionado, 20 bits)
        LOCAL_ADDR : out STD_LOGIC_VECTOR(19 downto 0);

        -- Dato de escritura propagado al esclavo activo
        WDATA_OUT : out STD_LOGIC_VECTOR(31 downto 0);

        -- Señales de control redirigidas al esclavo activo
        WEN_OUT  : out STD_LOGIC;
        REN_OUT  : out STD_LOGIC;
        BSEL_OUT : out STD_LOGIC_VECTOR(3 downto 0);

        -- Dato de lectura devuelto al pipeline
        RDATA_OUT : out STD_LOGIC_VECTOR(31 downto 0);

        -- Handshake hacia el pipeline
        READY   : out STD_LOGIC;

        -- Flag de MMIO (suprime caching)
        IS_MMIO : out STD_LOGIC
    );
end mmio_controller;

architecture Combinacional of mmio_controller is

    -- =========================================================================
    -- Señales internas de decodificacion de rango
    -- Cada una es '1' si ADDR_BUS cae dentro del rango correspondiente
    -- =========================================================================

    -- RAM: bits[31:30] = "00"
    --   Equivale a NOT(ADDR_BUS(31)) AND NOT(ADDR_BUS(30))
    signal HIT_RAM : STD_LOGIC;

    -- ROM: bits[31:16] = 0xFFFF
    --   Todos los bits del 31 al 16 deben ser '1'
    signal HIT_ROM : STD_LOGIC;

    -- LAPIC: bits[31:12] = 0xFEE00
    --   0xFEE00 = 1111_1110_1110_0000_0000
    --   ADDR_BUS[31:12] debe ser igual a "11111110111000000000"
    signal HIT_LAPIC : STD_LOGIC;

    -- IOAPIC: bits[31:12] = 0xFEC00
    --   0xFEC00 = 1111_1110_1100_0000_0000
    --   ADDR_BUS[31:12] debe ser igual a "11111110110000000000"
    signal HIT_IOAPIC : STD_LOGIC;

    -- PERIF0: bits[31:20] = 0xC00
    --   0xC00 = 1100_0000_0000
    --   ADDR_BUS[31:20] = "110000000000"
    signal HIT_PERIF0 : STD_LOGIC;

    -- PERIF1: bits[31:20] = 0xC01
    --   0xC01 = 1100_0000_0001
    --   ADDR_BUS[31:20] = "110000000001"
    signal HIT_PERIF1 : STD_LOGIC;

    -- Señales internas con VALID_REQ aplicado
    signal SEL_RAM    : STD_LOGIC;
    signal SEL_ROM    : STD_LOGIC;
    signal SEL_LAPIC  : STD_LOGIC;
    signal SEL_IOAPIC : STD_LOGIC;
    signal SEL_PERIF0 : STD_LOGIC;
    signal SEL_PERIF1 : STD_LOGIC;

    -- =========================================================================
    -- Señales de direccion local (offset = bits bajos de ADDR_BUS)
    -- =========================================================================

    -- Para RAM y perifericos grandes usamos bits[19:0] directamente
    signal OFFSET_LOW20  : STD_LOGIC_VECTOR(19 downto 0);

    -- Para LAPIC/IOAPIC usamos bits[11:0] (4KB de espacio)
    signal OFFSET_LOW12  : STD_LOGIC_VECTOR(11 downto 0);

    -- =========================================================================
    -- MUX de retorno de datos (RDATA) - seleccion por los CS
    -- =========================================================================
    signal RDATA_MUX : STD_LOGIC_VECTOR(31 downto 0);

    -- MUX de READY
    signal READY_MUX : STD_LOGIC;

    -- MUX de LOCAL_ADDR
    signal LADDR_MUX : STD_LOGIC_VECTOR(19 downto 0);

begin

    -- =========================================================================
    -- PASO 1: Decodificacion de rangos (puramente combinacional)
    --         Comparadores de rango implementados bit a bit con AND/NOT
    -- =========================================================================

    -- -------------------------------------------------------------------------
    -- RAM: 0x00000000 - 0x3FFFFFFF
    --   Condicion: ADDR_BUS[31] = '0' AND ADDR_BUS[30] = '0'
    -- -------------------------------------------------------------------------
    HIT_RAM <= (NOT ADDR_BUS(31)) AND (NOT ADDR_BUS(30));

    -- -------------------------------------------------------------------------
    -- ROM: 0xFFFF0000 - 0xFFFFFFFF
    --   Condicion: ADDR_BUS[31:16] = "1111111111111111"
    --   Se implementa con un AND de 16 entradas (arbol de AND de 2 entradas)
    -- -------------------------------------------------------------------------
    HIT_ROM <=  ADDR_BUS(31) AND ADDR_BUS(30) AND ADDR_BUS(29) AND ADDR_BUS(28) AND
                ADDR_BUS(27) AND ADDR_BUS(26) AND ADDR_BUS(25) AND ADDR_BUS(24) AND
                ADDR_BUS(23) AND ADDR_BUS(22) AND ADDR_BUS(21) AND ADDR_BUS(20) AND
                ADDR_BUS(19) AND ADDR_BUS(18) AND ADDR_BUS(17) AND ADDR_BUS(16);

    -- -------------------------------------------------------------------------
    -- LAPIC: 0xFEE00000 - 0xFEE00FFF
    --   ADDR_BUS[31:12] = 0xFEE00
    --   0xFEE00 en binario (20 bits): 1111_1110_1110_0000_0000
    --   Bit 31=1, 30=1, 29=1, 28=1, 27=1, 26=1, 25=1, 24=0
    --   Bit 23=1, 22=1, 21=1, 20=0, 19=0, 18=0, 17=0, 16=0
    --   Bit 15=0, 14=0, 13=0, 12=0
    -- -------------------------------------------------------------------------
    HIT_LAPIC <=
            ADDR_BUS(31) AND ADDR_BUS(30) AND ADDR_BUS(29) AND ADDR_BUS(28) AND
            ADDR_BUS(27) AND ADDR_BUS(26) AND ADDR_BUS(25) AND (NOT ADDR_BUS(24)) AND
            ADDR_BUS(23) AND ADDR_BUS(22) AND ADDR_BUS(21) AND (NOT ADDR_BUS(20)) AND
            (NOT ADDR_BUS(19)) AND (NOT ADDR_BUS(18)) AND (NOT ADDR_BUS(17)) AND (NOT ADDR_BUS(16)) AND
            (NOT ADDR_BUS(15)) AND (NOT ADDR_BUS(14)) AND (NOT ADDR_BUS(13)) AND (NOT ADDR_BUS(12));

    -- -------------------------------------------------------------------------
    -- IOAPIC: 0xFEC00000 - 0xFEC00FFF
    --   ADDR_BUS[31:12] = 0xFEC00
    --   0xFEC00 en binario (20 bits): 1111_1110_1100_0000_0000
    --   Bit 31=1, 30=1, 29=1, 28=1, 27=1, 26=1, 25=1, 24=0
    --   Bit 23=1, 22=1, 21=0, 20=0, 19=0, 18=0, 17=0, 16=0
    --   Bit 15=0, 14=0, 13=0, 12=0
    -- -------------------------------------------------------------------------
    HIT_IOAPIC <=
            ADDR_BUS(31) AND ADDR_BUS(30) AND ADDR_BUS(29) AND ADDR_BUS(28) AND
            ADDR_BUS(27) AND ADDR_BUS(26) AND ADDR_BUS(25) AND (NOT ADDR_BUS(24)) AND
            ADDR_BUS(23) AND ADDR_BUS(22) AND (NOT ADDR_BUS(21)) AND (NOT ADDR_BUS(20)) AND
            (NOT ADDR_BUS(19)) AND (NOT ADDR_BUS(18)) AND (NOT ADDR_BUS(17)) AND (NOT ADDR_BUS(16)) AND
            (NOT ADDR_BUS(15)) AND (NOT ADDR_BUS(14)) AND (NOT ADDR_BUS(13)) AND (NOT ADDR_BUS(12));

    -- -------------------------------------------------------------------------
    -- PERIF0: 0xC0000000 - 0xC00FFFFF
    --   ADDR_BUS[31:20] = 0xC00 = "110000000000"
    --   Bit 31=1, 30=1, 29=0, 28=0, 27=0, 26=0, 25=0, 24=0
    --   Bit 23=0, 22=0, 21=0, 20=0
    -- -------------------------------------------------------------------------
    HIT_PERIF0 <=
            ADDR_BUS(31) AND ADDR_BUS(30) AND
            (NOT ADDR_BUS(29)) AND (NOT ADDR_BUS(28)) AND
            (NOT ADDR_BUS(27)) AND (NOT ADDR_BUS(26)) AND
            (NOT ADDR_BUS(25)) AND (NOT ADDR_BUS(24)) AND
            (NOT ADDR_BUS(23)) AND (NOT ADDR_BUS(22)) AND
            (NOT ADDR_BUS(21)) AND (NOT ADDR_BUS(20));

    -- -------------------------------------------------------------------------
    -- PERIF1: 0xC0100000 - 0xC01FFFFF
    --   ADDR_BUS[31:20] = 0xC01 = "110000000001"
    --   Bit 31=1, 30=1, 29=0, 28=0, 27=0, 26=0, 25=0, 24=0
    --   Bit 23=0, 22=0, 21=0, 20=1
    -- -------------------------------------------------------------------------
    HIT_PERIF1 <=
            ADDR_BUS(31) AND ADDR_BUS(30) AND
            (NOT ADDR_BUS(29)) AND (NOT ADDR_BUS(28)) AND
            (NOT ADDR_BUS(27)) AND (NOT ADDR_BUS(26)) AND
            (NOT ADDR_BUS(25)) AND (NOT ADDR_BUS(24)) AND
            (NOT ADDR_BUS(23)) AND (NOT ADDR_BUS(22)) AND
            (NOT ADDR_BUS(21)) AND ADDR_BUS(20);

    -- =========================================================================
    -- Aplicar VALID_REQ: solo activar CS cuando hay peticion real
    -- Prioridad de exclusion mutua: ROM > LAPIC > IOAPIC > PERIF1 > PERIF0 > RAM
    -- (ROM y LAPIC tienen precedencia sobre RAM porque sus bits superiores
    --  son mas restrictivos y no solapan, pero se explicita para seguridad)
    -- =========================================================================

    -- RAM activa solo si ninguno de los rangos MMIO coincide
    SEL_RAM    <= HIT_RAM    AND (NOT HIT_ROM) AND (NOT HIT_LAPIC) AND
                  (NOT HIT_IOAPIC) AND (NOT HIT_PERIF0) AND (NOT HIT_PERIF1)
                  AND VALID_REQ;

    -- El resto se activan directamente (sus rangos no solapan con RAM
    -- pero mantenemos la mascara de exclusion para robustez)
    SEL_ROM    <= HIT_ROM    AND VALID_REQ;
    SEL_LAPIC  <= HIT_LAPIC  AND (NOT HIT_ROM) AND VALID_REQ;
    SEL_IOAPIC <= HIT_IOAPIC AND (NOT HIT_ROM) AND (NOT HIT_LAPIC) AND VALID_REQ;
    SEL_PERIF0 <= HIT_PERIF0 AND VALID_REQ;
    SEL_PERIF1 <= HIT_PERIF1 AND VALID_REQ;

    -- Conectar a las salidas CS
    CS_RAM    <= SEL_RAM;
    CS_ROM    <= SEL_ROM;
    CS_LAPIC  <= SEL_LAPIC;
    CS_IOAPIC <= SEL_IOAPIC;
    CS_PERIF0 <= SEL_PERIF0;
    CS_PERIF1 <= SEL_PERIF1;

    -- =========================================================================
    -- PASO 2: Calculo de Direccion Local
    --   LOCAL_ADDR = bits bajos de ADDR_BUS (offset dentro del esclavo)
    --   Para RAM/PERIF: bits[19:0]
    --   Para LAPIC/IOAPIC: bits[11:0] extendidos con ceros
    -- =========================================================================

    OFFSET_LOW20 <= ADDR_BUS(19 downto 0);
    OFFSET_LOW12 <= ADDR_BUS(11 downto 0);

    -- MUX de LOCAL_ADDR segun el esclavo seleccionado
    -- Implementado como OR de terminos enmascarados (cada termino vale
    -- solo cuando su CS esta activo; como son mutuamente excluyentes,
    -- el OR es seguro)
    LADDR_MUX <=
        -- RAM: bits[19:0] directamente
        (OFFSET_LOW20                                 ) when SEL_RAM    = '1' else
        -- ROM: bits[19:0] (offset en los 64KB del vector de reset)
        (OFFSET_LOW20                                 ) when SEL_ROM    = '1' else
        -- LAPIC/IOAPIC: extender 12 bits bajos con ceros arriba
        ("00000000" & OFFSET_LOW12                    ) when SEL_LAPIC  = '1' else
        ("00000000" & OFFSET_LOW12                    ) when SEL_IOAPIC = '1' else
        -- PERIF0/PERIF1: bits[19:0] directamente
        (OFFSET_LOW20                                 ) when SEL_PERIF0 = '1' else
        (OFFSET_LOW20                                 ) when SEL_PERIF1 = '1' else
        (others => '0');

    LOCAL_ADDR <= LADDR_MUX;

    -- =========================================================================
    -- PASO 3: Arbol de Multiplexores para Escritura y Lectura
    -- =========================================================================

    -- ----- Escritura: propagar WDATA y señales de control al esclavo activo --
    -- WDATA_OUT es el mismo dato para todos (cada esclavo lo recibe solo
    -- cuando su CS esta activo, lo filtra con WEN_OUT)
    WDATA_OUT <= WDATA;
    WEN_OUT   <= WEN;
    REN_OUT   <= REN;
    BSEL_OUT  <= BYTE_SEL;

    -- ----- Lectura: MUX de RDATA segun esclavo activo -----------------------
    RDATA_MUX <=
        RDATA_RAM    when SEL_RAM    = '1' else
        RDATA_ROM    when SEL_ROM    = '1' else
        RDATA_LAPIC  when SEL_LAPIC  = '1' else
        RDATA_IOAPIC when SEL_IOAPIC = '1' else
        RDATA_PERIF0 when SEL_PERIF0 = '1' else
        RDATA_PERIF1 when SEL_PERIF1 = '1' else
        (others => '0');

    RDATA_OUT <= RDATA_MUX;

    -- =========================================================================
    -- PASO 4: Handshake READY
    --   Cada esclavo tiene su propia señal READY. El MUX selecciona la
    --   del esclavo activo y la propaga al pipeline.
    --   ROM y esclavos simples pueden tener READY='1' fijo (1 ciclo).
    --   DRAM/PCIe pueden tardar varios ciclos.
    -- =========================================================================

    READY_MUX <=
        READY_RAM    when SEL_RAM    = '1' else
        READY_ROM    when SEL_ROM    = '1' else
        READY_LAPIC  when SEL_LAPIC  = '1' else
        READY_IOAPIC when SEL_IOAPIC = '1' else
        READY_PERIF0 when SEL_PERIF0 = '1' else
        READY_PERIF1 when SEL_PERIF1 = '1' else
        '0';  -- Sin esclavo activo -> stall (READY='0')

    READY <= READY_MUX;

    -- =========================================================================
    -- PASO 5: Flag IS_MMIO
    --   IS_MMIO = NOT(CS_RAM OR CS_ROM)
    --   Indica que el acceso es a un periferico MMIO: la cache NO debe
    --   cachear este dato.
    -- =========================================================================

    IS_MMIO <= NOT (SEL_RAM OR SEL_ROM);

end Combinacional;
