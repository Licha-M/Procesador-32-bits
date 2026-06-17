-- =============================================================================
-- Circuito 4: Puente de Periféricos Lentos (Peripheral Bridge)
-- =============================================================================
-- Propósito:
--   Recibe un único Chip Select (CS_BRIDGE) desde el Controlador MMIO principal
--   y realiza una sub-decodificación para controlar múltiples periféricos de
--   baja velocidad (UART, Timer, GPIO, etc.) sin sobrecargar de puertos al
--   árbitro central. Actúa como un sub-árbitro o embudo.
--
-- Interfaz:
--   Entradas desde el MMIO:
--     CS_BRIDGE  : 1 bit (habilita todo el puente)
--     LOCAL_ADDR : 20 bits (Bits [19:16] para sub-decodificar, [15:0] como sub-offset)
--     WDATA_IN   : 32 bits (Dato a escribir)
--     WEN, REN   : 1 bit c/u (Señales de control)
--
--   Salidas hacia sub-periféricos:
--     CS_UART, CS_TIMER, CS_GPIO, CS_I2C : 1 bit c/u (Sólo uno activo a la vez)
--     SUB_ADDR   : 16 bits (Offset propagado a los esclavos)
--     WDATA_OUT  : 32 bits (Dato a escribir propagado)
--     WEN, REN   : Propagados a los esclavos
--
--   Retornos hacia el MMIO:
--     RDATA_BRIDGE : 32 bits (Seleccionado del esclavo activo)
--     READY_BRIDGE : 1 bit (Seleccionado del esclavo activo)
--
-- Restricción de diseño:
--   No se usan bucles FOR ni GENERATE. Toda la lógica es puramente combinacional
--   y compatible con Logisim Evolution (puertas lógicas básicas y MUX).
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity slow_connection_system is
    port (
        -- ----------------------------------------------------------------
        -- Entradas desde el Controlador MMIO Principal
        -- ----------------------------------------------------------------
        CS_BRIDGE  : in  STD_LOGIC;                      -- Chip Select del puente
        LOCAL_ADDR : in  STD_LOGIC_VECTOR(19 downto 0);  -- Offset enviado por el MMIO
        WDATA_IN   : in  STD_LOGIC_VECTOR(31 downto 0);  -- Dato a escribir
        WEN        : in  STD_LOGIC;                      -- Write Enable
        REN        : in  STD_LOGIC;                      -- Read Enable

        -- ----------------------------------------------------------------
        -- Entradas desde los sub-periféricos locales
        -- ----------------------------------------------------------------
        RDATA_UART  : in  STD_LOGIC_VECTOR(31 downto 0);
        READY_UART  : in  STD_LOGIC;

        RDATA_TIMER : in  STD_LOGIC_VECTOR(31 downto 0);
        READY_TIMER : in  STD_LOGIC;

        RDATA_GPIO  : in  STD_LOGIC_VECTOR(31 downto 0);
        READY_GPIO  : in  STD_LOGIC;

        RDATA_I2C   : in  STD_LOGIC_VECTOR(31 downto 0);
        READY_I2C   : in  STD_LOGIC;

        -- ----------------------------------------------------------------
        -- Salidas hacia los sub-periféricos locales
        -- ----------------------------------------------------------------
        CS_UART   : out STD_LOGIC;
        CS_TIMER  : out STD_LOGIC;
        CS_GPIO   : out STD_LOGIC;
        CS_I2C    : out STD_LOGIC;

        SUB_ADDR  : out STD_LOGIC_VECTOR(15 downto 0);
        WDATA_OUT : out STD_LOGIC_VECTOR(31 downto 0);
        WEN_OUT   : out STD_LOGIC;
        REN_OUT   : out STD_LOGIC;

        -- ----------------------------------------------------------------
        -- Retornos hacia el Controlador MMIO Principal
        -- ----------------------------------------------------------------
        RDATA_BRIDGE : out STD_LOGIC_VECTOR(31 downto 0);
        READY_BRIDGE : out STD_LOGIC
    );
end slow_connection_system;

architecture Combinacional of slow_connection_system is

    -- =========================================================================
    -- Señales internas de decodificación de sub-rango
    -- =========================================================================
    signal SEL_UART  : STD_LOGIC;
    signal SEL_TIMER : STD_LOGIC;
    signal SEL_GPIO  : STD_LOGIC;
    signal SEL_I2C   : STD_LOGIC;

    -- Señales con el Chip Select principal (CS_BRIDGE) aplicado
    signal EN_UART  : STD_LOGIC;
    signal EN_TIMER : STD_LOGIC;
    signal EN_GPIO  : STD_LOGIC;
    signal EN_I2C   : STD_LOGIC;

begin

    -- =========================================================================
    -- PASO 1: Sub-decodificación Combinacional
    -- Se inspeccionan los bits [19:16] de la dirección local.
    -- Implementado puramente con compuertas AND/NOT para compatibilidad con Logisim.
    -- =========================================================================

    -- Si LOCAL_ADDR[19:16] == "0000" -> UART
    SEL_UART  <= (NOT LOCAL_ADDR(19)) AND (NOT LOCAL_ADDR(18)) AND
                 (NOT LOCAL_ADDR(17)) AND (NOT LOCAL_ADDR(16));

    -- Si LOCAL_ADDR[19:16] == "0001" -> TIMER
    SEL_TIMER <= (NOT LOCAL_ADDR(19)) AND (NOT LOCAL_ADDR(18)) AND
                 (NOT LOCAL_ADDR(17)) AND      LOCAL_ADDR(16);

    -- Si LOCAL_ADDR[19:16] == "0010" -> GPIO
    SEL_GPIO  <= (NOT LOCAL_ADDR(19)) AND (NOT LOCAL_ADDR(18)) AND
                      LOCAL_ADDR(17)  AND (NOT LOCAL_ADDR(16));

    -- Si LOCAL_ADDR[19:16] == "0011" -> I2C
    SEL_I2C   <= (NOT LOCAL_ADDR(19)) AND (NOT LOCAL_ADDR(18)) AND
                      LOCAL_ADDR(17)  AND      LOCAL_ADDR(16);


    -- Activar los Chip Selects locales SÓLO si el puente completo está activo (CS_BRIDGE = '1')
    EN_UART  <= SEL_UART  AND CS_BRIDGE;
    EN_TIMER <= SEL_TIMER AND CS_BRIDGE;
    EN_GPIO  <= SEL_GPIO  AND CS_BRIDGE;
    EN_I2C   <= SEL_I2C   AND CS_BRIDGE;

    -- Asignación a las salidas físicas
    CS_UART  <= EN_UART;
    CS_TIMER <= EN_TIMER;
    CS_GPIO  <= EN_GPIO;
    CS_I2C   <= EN_I2C;


    -- =========================================================================
    -- PASO 2: Propagación de Dirección y Control
    -- =========================================================================

    -- El offset enviado a los sub-periféricos son los 16 bits más bajos
    SUB_ADDR <= LOCAL_ADDR(15 downto 0);

    -- El dato a escribir y las señales de control se propagan a todos en paralelo
    -- (Los periféricos ignorarán esto si su respectivo CS está inactivo)
    WDATA_OUT <= WDATA_IN;
    WEN_OUT   <= WEN;
    REN_OUT   <= REN;


    -- =========================================================================
    -- PASO 3: Árbol MUX Secundario para Retornos (Lectura y Handshake)
    -- =========================================================================

    -- RDATA_BRIDGE: MUX que selecciona la respuesta del periférico activo
    RDATA_BRIDGE <=
        RDATA_UART  when EN_UART  = '1' else
        RDATA_TIMER when EN_TIMER = '1' else
        RDATA_GPIO  when EN_GPIO  = '1' else
        RDATA_I2C   when EN_I2C   = '1' else
        (others => '0'); -- Retorna 0 si ningún sub-periférico fue seleccionado

    -- READY_BRIDGE: MUX que selecciona la señal de finalización del periférico activo
    READY_BRIDGE <=
        READY_UART  when EN_UART  = '1' else
        READY_TIMER when EN_TIMER = '1' else
        READY_GPIO  when EN_GPIO  = '1' else
        READY_I2C   when EN_I2C   = '1' else
        '0'; -- Stall por defecto si no hay esclavo o si nadie responde

end Combinacional;
