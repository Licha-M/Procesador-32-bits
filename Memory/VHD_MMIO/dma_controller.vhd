-- =============================================================================
-- Circuito 2: Controlador y Sistema DMA (Bus Master)
-- =============================================================================
-- Proposito:
--   Permitir que un periferico (NVMe, GPU, tarjeta de red) lea y escriba
--   datos directamente en la RAM sin intervencion del CPU.
--   El DMA actua como un segundo maestro de bus.
--
-- Interfaz con el Pipeline:
--   Entradas desde pipeline:
--     Data_out  : 32 bits  -> DMA_DATA_IN (cuando DMA_DIR='0', periferico->RAM)
--     Addr      : 32 bits  -> DMA_ADDR (configuracion)
--     RoW(1)    : 1 bit    -> indica acceso valido (CPU_REQ)
--     RAM_Ready : 1 bit    -> RAM_READY (handshake de la DRAM)
--     Stall     : 1 bit    -> stall externo (no usado por DMA, lo produce)
--   Salidas hacia pipeline:
--     Data_in(31:0) -> DMA_DATA_OUT (datos leidos de RAM al periferico)
--     Stall         -> CPU_STALL   (congela el pipeline mientras DMA usa el bus)
--
-- FSM del canal DMA (4 estados, sin bucles):
--   IDLE -> WAIT_GRANT -> ACTIVE_TRANSFER -> DONE -> IDLE
--
-- Restriccion de diseno:
--   No se usan bucles FOR ni GENERATE. Toda logica usa señales explicitas
--   y una FSM secuencial con señales de control combinacionales.
--   Compatible con Logisim Evolution (compuertas basicas + registros).
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dma_controller is
    port (
        -- ----------------------------------------------------------------
        -- Reloj y reset
        -- ----------------------------------------------------------------
        CLK   : in STD_LOGIC;
        RESET : in STD_LOGIC;  -- Reset sincrono activo alto

        -- ----------------------------------------------------------------
        -- Entradas de configuracion del canal (escritas por CPU via MMIO)
        -- ----------------------------------------------------------------
        DMA_REQ     : in STD_LOGIC;                      -- Periferico pide DMA
        DMA_ADDR    : in STD_LOGIC_VECTOR(31 downto 0);  -- Direccion base en RAM
        DMA_LEN     : in STD_LOGIC_VECTOR(19 downto 0);  -- Numero de beats (x4 bytes)
        DMA_DIR     : in STD_LOGIC;                      -- '0'=Periferico->RAM  '1'=RAM->Periferico
        DMA_DATA_IN : in STD_LOGIC_VECTOR(31 downto 0);  -- Dato del periferico hacia RAM

        -- ----------------------------------------------------------------
        -- Interfaz con el arbitro del bus (NoC)
        -- ----------------------------------------------------------------
        BUS_GRANT : in STD_LOGIC;  -- Arbitro concede el bus al DMA

        -- ----------------------------------------------------------------
        -- Interfaz con la DRAM
        -- ----------------------------------------------------------------
        RAM_READY    : in STD_LOGIC;                      -- DRAM completo la operacion
        RAM_RDATA    : in STD_LOGIC_VECTOR(31 downto 0);  -- Dato leido de RAM

        -- ----------------------------------------------------------------
        -- Señal del CPU hacia el arbitro
        -- ----------------------------------------------------------------
        CPU_REQ : in STD_LOGIC;  -- Pipeline del CPU necesita el bus

        -- ================================================================
        -- SALIDAS
        -- ================================================================

        -- ----------------------------------------------------------------
        -- Hacia el periferico
        -- ----------------------------------------------------------------
        DMA_ACK      : out STD_LOGIC;                      -- Solicitud aceptada
        DMA_DATA_OUT : out STD_LOGIC_VECTOR(31 downto 0);  -- Dato de RAM al periferico
        DMA_DONE     : out STD_LOGIC;                      -- Transferencia completa

        -- ----------------------------------------------------------------
        -- Hacia el arbitro del bus (NoC)
        -- ----------------------------------------------------------------
        BUS_REQ : out STD_LOGIC;  -- DMA pide el bus

        -- ----------------------------------------------------------------
        -- Hacia la DRAM (via NoC)
        -- ----------------------------------------------------------------
        RAM_ADDR  : out STD_LOGIC_VECTOR(31 downto 0);  -- Direccion en RAM
        RAM_WDATA : out STD_LOGIC_VECTOR(31 downto 0);  -- Dato a escribir
        RAM_WEN   : out STD_LOGIC;                       -- Write Enable hacia DRAM

        -- ----------------------------------------------------------------
        -- Hacia el pipeline del CPU
        -- ----------------------------------------------------------------
        CPU_STALL : out STD_LOGIC;  -- Congela el pipeline

        -- ----------------------------------------------------------------
        -- Hacia el controlador de cache L1-D / L2
        -- ----------------------------------------------------------------
        CACHE_INVALIDATE_ADDR : out STD_LOGIC_VECTOR(31 downto 0);
        CACHE_INVALIDATE_EN   : out STD_LOGIC;  -- '1' cuando hay invalidacion valida

        -- ----------------------------------------------------------------
        -- Estado observable (para debug / integracion)
        -- ----------------------------------------------------------------
        STATE_OUT : out STD_LOGIC_VECTOR(1 downto 0)
        -- "00" = IDLE  "01" = WAIT_GRANT  "10" = ACTIVE  "11" = DONE
    );
end dma_controller;

architecture FSM_DMA of dma_controller is

    -- =========================================================================
    -- Definicion de estados de la FSM
    -- =========================================================================
    -- Se codifica con 2 bits para facilitar la implementacion en Logisim
    -- con un registro de 2 bits y logica combinacional de siguiente estado.
    --   ST_IDLE        = "00"
    --   ST_WAIT_GRANT  = "01"
    --   ST_ACTIVE      = "10"
    --   ST_DONE        = "11"

    constant ST_IDLE       : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant ST_WAIT_GRANT : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant ST_ACTIVE     : STD_LOGIC_VECTOR(1 downto 0) := "10";
    constant ST_DONE       : STD_LOGIC_VECTOR(1 downto 0) := "11";

    -- =========================================================================
    -- Registros internos del canal DMA
    -- =========================================================================

    -- Registro de estado actual de la FSM
    signal CURRENT_STATE : STD_LOGIC_VECTOR(1 downto 0);

    -- Registro de direccion actual (avanza +4 en cada beat)
    signal CURRENT_ADDR : STD_LOGIC_VECTOR(31 downto 0);

    -- Contador de beats restantes (cuenta regresiva hasta cero)
    signal BEAT_COUNT : STD_LOGIC_VECTOR(19 downto 0);

    -- Registro de DMA_DIR capturado al inicio de la transferencia
    signal DIR_LATCH : STD_LOGIC;

    -- =========================================================================
    -- Señales combinacionales de siguiente estado y control
    -- =========================================================================

    signal NEXT_STATE : STD_LOGIC_VECTOR(1 downto 0);

    -- Condiciones de transicion (combinacionales)
    signal COND_START      : STD_LOGIC;  -- IDLE -> WAIT_GRANT
    signal COND_GRANTED    : STD_LOGIC;  -- WAIT_GRANT -> ACTIVE
    signal COND_BEAT_DONE  : STD_LOGIC;  -- en ACTIVE: beat completado (RAM_READY)
    signal COND_ALL_DONE   : STD_LOGIC;  -- ACTIVE -> DONE (BEAT_COUNT llega a 0)
    signal COND_DONE_BACK  : STD_LOGIC;  -- DONE -> IDLE (siempre en 1 ciclo)

    -- Señal de beat completado: ACTIVE Y RAM_READY
    signal BEAT_COMPLETE : STD_LOGIC;

    -- Direccion incrementada (CURRENT_ADDR + 4, sin carry de 32 bits)
    signal ADDR_PLUS_4 : STD_LOGIC_VECTOR(31 downto 0);

    -- Beat count decrementado (BEAT_COUNT - 1)
    signal BEAT_MINUS_1 : STD_LOGIC_VECTOR(19 downto 0);

    -- Indicador de BEAT_COUNT = 0 (fin de transferencia)
    -- Se implementa como NOR de todos los bits del contador
    signal BEAT_IS_ZERO : STD_LOGIC;

    -- Indicador de BEAT_COUNT = 1 (proximo beat sera el ultimo)
    -- BEAT_COUNT[19:1] = todos cero Y BEAT_COUNT[0] = '1'
    signal BEAT_IS_ONE : STD_LOGIC;

    -- =========================================================================
    -- Señales de estado actual decodificadas (para logica combinacional)
    -- =========================================================================
    signal IS_IDLE       : STD_LOGIC;
    signal IS_WAIT_GRANT : STD_LOGIC;
    signal IS_ACTIVE     : STD_LOGIC;
    signal IS_DONE       : STD_LOGIC;

    -- =========================================================================
    -- Señales de control del arbitro
    -- =========================================================================
    signal BURST_IN_PROGRESS : STD_LOGIC;  -- '1' mientras FSM esta en ACTIVE

begin

    -- =========================================================================
    -- Decodificacion de estado actual
    -- (equivalente a un decodificador 2:4 en Logisim)
    -- =========================================================================
    IS_IDLE       <= '1' when CURRENT_STATE = ST_IDLE       else '0';
    IS_WAIT_GRANT <= '1' when CURRENT_STATE = ST_WAIT_GRANT else '0';
    IS_ACTIVE     <= '1' when CURRENT_STATE = ST_ACTIVE     else '0';
    IS_DONE       <= '1' when CURRENT_STATE = ST_DONE       else '0';

    BURST_IN_PROGRESS <= IS_ACTIVE;
    STATE_OUT         <= CURRENT_STATE;

    -- =========================================================================
    -- BLOQUE A: Arbitro de Prioridad (combinacional)
    --   El DMA tiene prioridad alta cuando esta en medio de una rafaga.
    --   Fuera de rafaga, el CPU tiene prioridad normal.
    -- =========================================================================

    -- BUS_REQ: el DMA pide el bus cuando esta en WAIT_GRANT o ACTIVE
    BUS_REQ <= IS_WAIT_GRANT OR IS_ACTIVE;

    -- CPU_STALL: el pipeline se congela cuando el DMA tiene el bus
    --   (el arbitro externo gestiona BUS_GRANT; aqui solo indicamos
    --    que el DMA esta activo y el CPU debe esperar)
    CPU_STALL <= (IS_ACTIVE OR IS_WAIT_GRANT) AND (NOT BUS_GRANT OR CPU_REQ);
    -- Nota: en una implementacion real CPU_STALL lo genera el arbitro
    -- externo; aqui lo aproximamos para que el pipeline vea la señal.

    -- =========================================================================
    -- BLOQUE B: Logica combinacional de siguiente estado
    -- =========================================================================

    -- Condiciones de transicion
    COND_START   <= DMA_REQ  AND IS_IDLE;
    COND_GRANTED <= BUS_GRANT AND IS_WAIT_GRANT;

    -- BEAT_COUNT = 0 se detecta con un NOR de 20 bits
    -- (arbol de OR de 2 entradas en Logisim)
    BEAT_IS_ZERO <=
        (NOT BEAT_COUNT(19)) AND (NOT BEAT_COUNT(18)) AND
        (NOT BEAT_COUNT(17)) AND (NOT BEAT_COUNT(16)) AND
        (NOT BEAT_COUNT(15)) AND (NOT BEAT_COUNT(14)) AND
        (NOT BEAT_COUNT(13)) AND (NOT BEAT_COUNT(12)) AND
        (NOT BEAT_COUNT(11)) AND (NOT BEAT_COUNT(10)) AND
        (NOT BEAT_COUNT(9))  AND (NOT BEAT_COUNT(8))  AND
        (NOT BEAT_COUNT(7))  AND (NOT BEAT_COUNT(6))  AND
        (NOT BEAT_COUNT(5))  AND (NOT BEAT_COUNT(4))  AND
        (NOT BEAT_COUNT(3))  AND (NOT BEAT_COUNT(2))  AND
        (NOT BEAT_COUNT(1))  AND (NOT BEAT_COUNT(0));

    -- BEAT_COUNT = 1: todos los bits salvo el 0 son cero, y bit 0 = '1'
    BEAT_IS_ONE <=
        (NOT BEAT_COUNT(19)) AND (NOT BEAT_COUNT(18)) AND
        (NOT BEAT_COUNT(17)) AND (NOT BEAT_COUNT(16)) AND
        (NOT BEAT_COUNT(15)) AND (NOT BEAT_COUNT(14)) AND
        (NOT BEAT_COUNT(13)) AND (NOT BEAT_COUNT(12)) AND
        (NOT BEAT_COUNT(11)) AND (NOT BEAT_COUNT(10)) AND
        (NOT BEAT_COUNT(9))  AND (NOT BEAT_COUNT(8))  AND
        (NOT BEAT_COUNT(7))  AND (NOT BEAT_COUNT(6))  AND
        (NOT BEAT_COUNT(5))  AND (NOT BEAT_COUNT(4))  AND
        (NOT BEAT_COUNT(3))  AND (NOT BEAT_COUNT(2))  AND
        (NOT BEAT_COUNT(1))  AND BEAT_COUNT(0);

    BEAT_COMPLETE <= IS_ACTIVE AND RAM_READY;

    -- Transicion ACTIVE -> DONE cuando el ultimo beat se completa
    -- (BEAT_COUNT era 1 y ahora baja a 0, o ya era 0)
    COND_ALL_DONE <= BEAT_COMPLETE AND (BEAT_IS_ONE OR BEAT_IS_ZERO);

    -- Transicion DONE -> IDLE es automatica (1 ciclo en DONE)
    COND_DONE_BACK <= IS_DONE;

    -- Logica de siguiente estado (MUX de 4 entradas)
    NEXT_STATE <=
        ST_WAIT_GRANT when COND_START    = '1' else
        ST_ACTIVE     when COND_GRANTED  = '1' else
        ST_DONE       when COND_ALL_DONE = '1' else
        ST_IDLE       when COND_DONE_BACK= '1' else
        CURRENT_STATE;  -- Permanecer en estado actual

    -- =========================================================================
    -- BLOQUE C: Calculo de valores para registros internos
    --   ADDR_PLUS_4   = CURRENT_ADDR + 4
    --   BEAT_MINUS_1  = BEAT_COUNT - 1
    -- Estas sumas se implementan con un sumador de 32/20 bits en Logisim
    -- =========================================================================

    -- Suma CURRENT_ADDR + 4 (equivalente a: bit[2] toggle con carry)
    -- En VHDL usamos suma directa; en Logisim usar un Adder de 32 bits
    ADDR_PLUS_4 <= CURRENT_ADDR + "00000000000000000000000000000100";

    -- Resta BEAT_COUNT - 1
    -- En Logisim usar un Adder de 20 bits con entrada B = "11111111111111111111" (complemento -1)
    BEAT_MINUS_1 <= BEAT_COUNT - "00000000000000000001";

    -- =========================================================================
    -- Proceso secuencial: registros de la FSM
    -- (equivale a flip-flops D con enable en Logisim)
    -- =========================================================================
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                -- Reset sincrono: volver al estado IDLE
                CURRENT_STATE <= ST_IDLE;
                CURRENT_ADDR  <= (others => '0');
                BEAT_COUNT    <= (others => '0');
                DIR_LATCH     <= '0';
            else
                -- Actualizar estado
                CURRENT_STATE <= NEXT_STATE;

                -- -------------------------------------------------------
                -- Al entrar a WAIT_GRANT: capturar configuracion del canal
                -- (solo cuando COND_START es verdadero)
                -- -------------------------------------------------------
                if COND_START = '1' then
                    CURRENT_ADDR <= DMA_ADDR;
                    BEAT_COUNT   <= DMA_LEN;
                    DIR_LATCH    <= DMA_DIR;
                end if;

                -- -------------------------------------------------------
                -- Durante ACTIVE: avanzar en cada beat completado
                -- (solo cuando BEAT_COMPLETE es verdadero)
                -- -------------------------------------------------------
                if BEAT_COMPLETE = '1' then
                    CURRENT_ADDR <= ADDR_PLUS_4;
                    BEAT_COUNT   <= BEAT_MINUS_1;
                end if;
            end if;
        end if;
    end process;

    -- =========================================================================
    -- Salidas combinacionales de la FSM
    -- =========================================================================

    -- DMA_ACK: se activa cuando pasamos a ACTIVE_TRANSFER
    -- (el periferico recibe confirmacion al obtener el bus)
    DMA_ACK <= IS_ACTIVE;

    -- RAM_ADDR: siempre apunta a la direccion actual del DMA
    RAM_ADDR <= CURRENT_ADDR;

    -- RAM_WDATA: dato del periferico hacia la RAM
    RAM_WDATA <= DMA_DATA_IN;

    -- RAM_WEN: activo cuando DMA esta transfiriendo Y direccion es escritura
    --   DIR_LATCH='0' significa Periferico->RAM (escritura en RAM)
    RAM_WEN <= IS_ACTIVE AND (NOT DIR_LATCH);

    -- DMA_DATA_OUT: dato leido de RAM hacia el periferico
    --   Solo valido cuando DIR_LATCH='1' (RAM->Periferico)
    DMA_DATA_OUT <= RAM_RDATA;

    -- DMA_DONE: pulso de 1 ciclo cuando se entra al estado DONE
    DMA_DONE <= IS_DONE;

    -- CACHE_INVALIDATE: cuando DMA escribe en RAM, notificar a la cache
    --   Se activa en cada beat de escritura completado
    CACHE_INVALIDATE_EN   <= BEAT_COMPLETE AND (NOT DIR_LATCH);
    CACHE_INVALIDATE_ADDR <= CURRENT_ADDR;

end FSM_DMA;
