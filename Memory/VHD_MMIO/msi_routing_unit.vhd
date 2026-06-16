-- =============================================================================
-- Circuito 3: Sistema de Conexion para Mensajes MSI (IRU)
--             MSI Translation / Interrupt Routing Unit
-- =============================================================================
-- Proposito:
--   Interceptar escrituras de memoria que son tecnicamente MSI
--   (Message Signaled Interrupts) y redirigirlas al controlador de
--   interrupciones correcto (LAPIC del nucleo destino).
--
--   Una MSI es una escritura de 32 bits hacia 0xFEE00000-0xFEEFFFFF.
--   Este circuito distingue esa escritura de una escritura RAM normal.
--
-- Interfaz con el Pipeline:
--   Entradas:
--     Data_out  : 32 bits -> MSI_WRITE_DATA (vector de interrupcion)
--     Addr      : 32 bits -> MSI_WRITE_ADDR (direccion objetivo)
--     RoW(1)    : 1 bit   -> MSI_WRITE_VALID (peticion valida)
--     RoW(0)    : 1 bit   -> WEN (escritura activa)
--   Salidas:
--     Data_in(7:0) -> LAPIC_VECTOR
--     Stall        -> (indirecto, via MSI_CAPTURE al NoC)
--
-- Tabla MSI interna:
--   Soporta hasta 4 dispositivos (DEVICE_ID de 2 bits).
--   Cada entrada tiene: TARGET_LAPIC_ID(3:0), VECTOR(7:0),
--                       DELIVERY_MODE(2:0), MASKED(1 bit), VALID(1 bit)
--   La tabla se carga en boot via escrituras MMIO (puerto de configuracion).
--
-- FSM de despacho (3 estados):
--   IDLE -> LOOKUP -> DISPATCH -> IDLE
--
-- Restriccion de diseno:
--   Sin bucles FOR/GENERATE. Tabla de 4 entradas implementada con
--   4 conjuntos de registros y un MUX 4:1. Compatible con Logisim Evolution.
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity msi_routing_unit is
    port (
        -- ----------------------------------------------------------------
        -- Reloj y reset
        -- ----------------------------------------------------------------
        CLK   : in STD_LOGIC;
        RESET : in STD_LOGIC;  -- Reset sincrono activo alto

        -- ================================================================
        -- ENTRADAS de monitoreo del bus
        -- ================================================================
        MSI_WRITE_ADDR  : in STD_LOGIC_VECTOR(31 downto 0);  -- Direccion de escritura en bus
        MSI_WRITE_DATA  : in STD_LOGIC_VECTOR(31 downto 0);  -- Dato de escritura (vector MSI)
        MSI_WRITE_VALID : in STD_LOGIC;                       -- Transaccion valida en el bus
        DEVICE_ID       : in STD_LOGIC_VECTOR(1 downto 0);   -- Identificador del dispositivo (2 bits = 4 devs)

        -- ----------------------------------------------------------------
        -- Puerto de configuracion de la tabla MSI
        -- (el CPU escribe aqui en tiempo de boot via MMIO)
        -- ----------------------------------------------------------------
        CFG_WEN      : in STD_LOGIC;                       -- '1' = escribir en la tabla
        CFG_ENTRY    : in STD_LOGIC_VECTOR(1 downto 0);   -- Indice de la entrada (0-3)
        CFG_LAPIC_ID : in STD_LOGIC_VECTOR(3 downto 0);   -- LAPIC destino
        CFG_VECTOR   : in STD_LOGIC_VECTOR(7 downto 0);   -- Numero de vector (0-255)
        CFG_DELIVERY : in STD_LOGIC_VECTOR(2 downto 0);   -- Modo de entrega
        CFG_MASKED   : in STD_LOGIC;                       -- '1' = interrupcion enmascarada
        CFG_VALID    : in STD_LOGIC;                       -- '1' = entrada valida en tabla

        -- ----------------------------------------------------------------
        -- Handshake del LAPIC destino
        -- ----------------------------------------------------------------
        LAPIC_ACK : in STD_LOGIC;  -- LAPIC confirmo recepcion de la interrupcion

        -- ================================================================
        -- SALIDAS
        -- ================================================================

        -- ----------------------------------------------------------------
        -- Hacia el arbitro/NoC central
        -- ----------------------------------------------------------------
        MSI_CAPTURE : out STD_LOGIC;  -- '1' = NoC NO debe rutar esta escritura a RAM

        -- ----------------------------------------------------------------
        -- Hacia el LAPIC del nucleo destino
        -- ----------------------------------------------------------------
        LAPIC_INT_REQ      : out STD_LOGIC;                      -- Solicitud de interrupcion
        LAPIC_VECTOR       : out STD_LOGIC_VECTOR(7 downto 0);   -- Numero de vector
        LAPIC_DELIVERY_MODE: out STD_LOGIC_VECTOR(2 downto 0);   -- Modo de entrega
        LAPIC_TARGET_ID    : out STD_LOGIC_VECTOR(3 downto 0);   -- ID del LAPIC destino

        -- ----------------------------------------------------------------
        -- Hacia el periferico que genero la MSI
        -- ----------------------------------------------------------------
        MSI_ACK : out STD_LOGIC;  -- Pulso: MSI recibida y procesada

        -- ----------------------------------------------------------------
        -- Hacia el registro de estado del sistema
        -- ----------------------------------------------------------------
        MSI_ERROR : out STD_LOGIC;  -- Error de seguridad o entrada invalida

        -- ----------------------------------------------------------------
        -- Estado observable (debug)
        -- ----------------------------------------------------------------
        STATE_OUT : out STD_LOGIC_VECTOR(1 downto 0)
        -- "00"=IDLE  "01"=LOOKUP  "10"=DISPATCH  "11"=unused
    );
end msi_routing_unit;

architecture FSM_MSI of msi_routing_unit is

    -- =========================================================================
    -- Estados de la FSM
    -- =========================================================================
    constant ST_IDLE     : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant ST_LOOKUP   : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant ST_DISPATCH : STD_LOGIC_VECTOR(1 downto 0) := "10";

    signal CURRENT_STATE : STD_LOGIC_VECTOR(1 downto 0);
    signal NEXT_STATE    : STD_LOGIC_VECTOR(1 downto 0);

    -- =========================================================================
    -- Tabla MSI interna: 4 entradas, cada una con sus registros
    -- Entrada 0
    -- =========================================================================
    signal T0_LAPIC_ID : STD_LOGIC_VECTOR(3 downto 0);
    signal T0_VECTOR   : STD_LOGIC_VECTOR(7 downto 0);
    signal T0_DELIVERY : STD_LOGIC_VECTOR(2 downto 0);
    signal T0_MASKED   : STD_LOGIC;
    signal T0_VALID    : STD_LOGIC;

    -- Entrada 1
    signal T1_LAPIC_ID : STD_LOGIC_VECTOR(3 downto 0);
    signal T1_VECTOR   : STD_LOGIC_VECTOR(7 downto 0);
    signal T1_DELIVERY : STD_LOGIC_VECTOR(2 downto 0);
    signal T1_MASKED   : STD_LOGIC;
    signal T1_VALID    : STD_LOGIC;

    -- Entrada 2
    signal T2_LAPIC_ID : STD_LOGIC_VECTOR(3 downto 0);
    signal T2_VECTOR   : STD_LOGIC_VECTOR(7 downto 0);
    signal T2_DELIVERY : STD_LOGIC_VECTOR(2 downto 0);
    signal T2_MASKED   : STD_LOGIC;
    signal T2_VALID    : STD_LOGIC;

    -- Entrada 3
    signal T3_LAPIC_ID : STD_LOGIC_VECTOR(3 downto 0);
    signal T3_VECTOR   : STD_LOGIC_VECTOR(7 downto 0);
    signal T3_DELIVERY : STD_LOGIC_VECTOR(2 downto 0);
    signal T3_MASKED   : STD_LOGIC;
    signal T3_VALID    : STD_LOGIC;

    -- =========================================================================
    -- Registros de captura de la transaccion MSI en curso
    -- =========================================================================
    signal LATCH_DEVICE_ID  : STD_LOGIC_VECTOR(1 downto 0);
    signal LATCH_WRITE_DATA : STD_LOGIC_VECTOR(31 downto 0);

    -- =========================================================================
    -- Salidas del MUX de lookup de tabla (combinacionales)
    -- =========================================================================
    signal MUX_LAPIC_ID : STD_LOGIC_VECTOR(3 downto 0);
    signal MUX_VECTOR   : STD_LOGIC_VECTOR(7 downto 0);
    signal MUX_DELIVERY : STD_LOGIC_VECTOR(2 downto 0);
    signal MUX_MASKED   : STD_LOGIC;
    signal MUX_VALID    : STD_LOGIC;

    -- =========================================================================
    -- Señales de deteccion combinacionales
    -- =========================================================================

    -- PASO 1: Vigilancia del bus (snoop combinacional)
    --   El rango MSI en x86: ADDR_BUS[31:20] = 0xFEE = "111111101110"
    --   Bit 31=1,30=1,29=1,28=1, 27=1,26=1,25=1,24=0, 23=1,22=1,21=1,20=0
    signal ADDR_IS_MSI_RANGE : STD_LOGIC;

    -- Captura combinacional de MSI valida
    signal MSI_SNOOP_HIT : STD_LOGIC;

    -- PASO 3: Validacion de seguridad
    -- Vector en la escritura coincide con el vector en la tabla
    --   MSI_WRITE_DATA[7:0] es el numero de vector (bits bajos del dato)
    signal VECTOR_MATCH  : STD_LOGIC;
    signal ENTRY_OK      : STD_LOGIC;  -- Valid AND NOT MASKED AND VECTOR_MATCH

    -- Señal de error (entrada invalida o vector no coincide)
    signal SECURITY_ERROR : STD_LOGIC;

    -- =========================================================================
    -- Decodificacion de estado actual
    -- =========================================================================
    signal IS_IDLE     : STD_LOGIC;
    signal IS_LOOKUP   : STD_LOGIC;
    signal IS_DISPATCH : STD_LOGIC;

    -- Condiciones de transicion
    signal COND_CAPTURE  : STD_LOGIC;  -- IDLE -> LOOKUP
    signal COND_OK       : STD_LOGIC;  -- LOOKUP -> DISPATCH (todo correcto)
    signal COND_ERROR    : STD_LOGIC;  -- LOOKUP -> IDLE con error
    signal COND_ACKED    : STD_LOGIC;  -- DISPATCH -> IDLE cuando LAPIC_ACK

    -- Señal interna de pending (interrupcion enmascarada, guardada para despues)
    signal PENDING_IRQ : STD_LOGIC;

begin

    -- =========================================================================
    -- Decodificacion de estado
    -- =========================================================================
    IS_IDLE     <= '1' when CURRENT_STATE = ST_IDLE     else '0';
    IS_LOOKUP   <= '1' when CURRENT_STATE = ST_LOOKUP   else '0';
    IS_DISPATCH <= '1' when CURRENT_STATE = ST_DISPATCH else '0';
    STATE_OUT   <= CURRENT_STATE;

    -- =========================================================================
    -- PASO 1: Vigilancia del bus (snoop combinacional)
    --   Detectar si ADDR_BUS[31:20] = 0xFEE
    --   0xFEE = 1111_1110_1110
    --   Bit 31=1,30=1,29=1,28=1, 27=1,26=1,25=1,24=0, 23=1,22=1,21=1,20=0
    -- =========================================================================
    ADDR_IS_MSI_RANGE <=
        MSI_WRITE_ADDR(31) AND MSI_WRITE_ADDR(30) AND
        MSI_WRITE_ADDR(29) AND MSI_WRITE_ADDR(28) AND
        MSI_WRITE_ADDR(27) AND MSI_WRITE_ADDR(26) AND
        MSI_WRITE_ADDR(25) AND (NOT MSI_WRITE_ADDR(24)) AND
        MSI_WRITE_ADDR(23) AND MSI_WRITE_ADDR(22) AND
        MSI_WRITE_ADDR(21) AND (NOT MSI_WRITE_ADDR(20));

    -- Hit de snoop: direccion en rango MSI Y transaccion valida
    MSI_SNOOP_HIT <= ADDR_IS_MSI_RANGE AND MSI_WRITE_VALID;

    -- MSI_CAPTURE: salida combinacional inmediata
    -- Activa en IDLE cuando detectamos el hit (antes de pasar a LOOKUP)
    -- Y tambien durante LOOKUP y DISPATCH mientras procesamos
    MSI_CAPTURE <= MSI_SNOOP_HIT OR IS_LOOKUP OR IS_DISPATCH;

    -- =========================================================================
    -- PASO 2: MUX de lookup en la tabla MSI
    --   Usando LATCH_DEVICE_ID como indice (capturado al inicio)
    --   MUX 4:1 implementado con when/else (equivale a 4 AND + OR en Logisim)
    -- =========================================================================
    MUX_LAPIC_ID <=
        T0_LAPIC_ID when LATCH_DEVICE_ID = "00" else
        T1_LAPIC_ID when LATCH_DEVICE_ID = "01" else
        T2_LAPIC_ID when LATCH_DEVICE_ID = "10" else
        T3_LAPIC_ID;

    MUX_VECTOR <=
        T0_VECTOR when LATCH_DEVICE_ID = "00" else
        T1_VECTOR when LATCH_DEVICE_ID = "01" else
        T2_VECTOR when LATCH_DEVICE_ID = "10" else
        T3_VECTOR;

    MUX_DELIVERY <=
        T0_DELIVERY when LATCH_DEVICE_ID = "00" else
        T1_DELIVERY when LATCH_DEVICE_ID = "01" else
        T2_DELIVERY when LATCH_DEVICE_ID = "10" else
        T3_DELIVERY;

    MUX_MASKED <=
        T0_MASKED when LATCH_DEVICE_ID = "00" else
        T1_MASKED when LATCH_DEVICE_ID = "01" else
        T2_MASKED when LATCH_DEVICE_ID = "10" else
        T3_MASKED;

    MUX_VALID <=
        T0_VALID when LATCH_DEVICE_ID = "00" else
        T1_VALID when LATCH_DEVICE_ID = "01" else
        T2_VALID when LATCH_DEVICE_ID = "10" else
        T3_VALID;

    -- =========================================================================
    -- PASO 3: Validacion de seguridad
    --   Verificar que el vector en la escritura coincide con el de la tabla
    --   MSI_WRITE_DATA[7:0] = numero de vector (convencion x86)
    -- =========================================================================

    -- Comparador de 8 bits bit a bit (XNOR + AND en Logisim)
    -- VECTOR_MATCH = '1' si los 8 bits coinciden
    VECTOR_MATCH <=
        NOT (MUX_VECTOR(7) XOR LATCH_WRITE_DATA(7)) AND
        NOT (MUX_VECTOR(6) XOR LATCH_WRITE_DATA(6)) AND
        NOT (MUX_VECTOR(5) XOR LATCH_WRITE_DATA(5)) AND
        NOT (MUX_VECTOR(4) XOR LATCH_WRITE_DATA(4)) AND
        NOT (MUX_VECTOR(3) XOR LATCH_WRITE_DATA(3)) AND
        NOT (MUX_VECTOR(2) XOR LATCH_WRITE_DATA(2)) AND
        NOT (MUX_VECTOR(1) XOR LATCH_WRITE_DATA(1)) AND
        NOT (MUX_VECTOR(0) XOR LATCH_WRITE_DATA(0));

    -- Entrada valida: existe en tabla, no enmascarada, y vector coincide
    ENTRY_OK <= MUX_VALID AND (NOT MUX_MASKED) AND VECTOR_MATCH;

    -- Error de seguridad: no valido O vector no coincide
    SECURITY_ERROR <= NOT MUX_VALID OR NOT VECTOR_MATCH;

    -- =========================================================================
    -- Condiciones de transicion de la FSM
    -- =========================================================================
    COND_CAPTURE <= MSI_SNOOP_HIT AND IS_IDLE;
    COND_OK      <= IS_LOOKUP AND ENTRY_OK;
    COND_ERROR   <= IS_LOOKUP AND SECURITY_ERROR;
    COND_ACKED   <= IS_DISPATCH AND LAPIC_ACK;

    -- Siguiente estado
    NEXT_STATE <=
        ST_LOOKUP   when COND_CAPTURE = '1' else
        ST_DISPATCH when COND_OK      = '1' else
        ST_IDLE     when COND_ERROR   = '1' else
        ST_IDLE     when COND_ACKED   = '1' else
        CURRENT_STATE;

    -- =========================================================================
    -- Proceso secuencial: registros de la FSM y la tabla MSI
    -- =========================================================================
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                CURRENT_STATE    <= ST_IDLE;
                LATCH_DEVICE_ID  <= (others => '0');
                LATCH_WRITE_DATA <= (others => '0');
                PENDING_IRQ      <= '0';

                -- Reset de la tabla MSI
                T0_LAPIC_ID <= (others => '0'); T0_VECTOR <= (others => '0');
                T0_DELIVERY <= (others => '0'); T0_MASKED <= '0'; T0_VALID <= '0';
                T1_LAPIC_ID <= (others => '0'); T1_VECTOR <= (others => '0');
                T1_DELIVERY <= (others => '0'); T1_MASKED <= '0'; T1_VALID <= '0';
                T2_LAPIC_ID <= (others => '0'); T2_VECTOR <= (others => '0');
                T2_DELIVERY <= (others => '0'); T2_MASKED <= '0'; T2_VALID <= '0';
                T3_LAPIC_ID <= (others => '0'); T3_VECTOR <= (others => '0');
                T3_DELIVERY <= (others => '0'); T3_MASKED <= '0'; T3_VALID <= '0';

            else
                -- Actualizar estado de la FSM
                CURRENT_STATE <= NEXT_STATE;

                -- -----------------------------------------------------------
                -- Escritura en la tabla MSI desde el puerto de configuracion
                -- El CPU escribe usando CFG_WEN y CFG_ENTRY
                -- Implementado como 4 registros con enable individual
                -- -----------------------------------------------------------
                if CFG_WEN = '1' then
                    if CFG_ENTRY = "00" then
                        T0_LAPIC_ID <= CFG_LAPIC_ID;
                        T0_VECTOR   <= CFG_VECTOR;
                        T0_DELIVERY <= CFG_DELIVERY;
                        T0_MASKED   <= CFG_MASKED;
                        T0_VALID    <= CFG_VALID;
                    end if;
                    if CFG_ENTRY = "01" then
                        T1_LAPIC_ID <= CFG_LAPIC_ID;
                        T1_VECTOR   <= CFG_VECTOR;
                        T1_DELIVERY <= CFG_DELIVERY;
                        T1_MASKED   <= CFG_MASKED;
                        T1_VALID    <= CFG_VALID;
                    end if;
                    if CFG_ENTRY = "10" then
                        T2_LAPIC_ID <= CFG_LAPIC_ID;
                        T2_VECTOR   <= CFG_VECTOR;
                        T2_DELIVERY <= CFG_DELIVERY;
                        T2_MASKED   <= CFG_MASKED;
                        T2_VALID    <= CFG_VALID;
                    end if;
                    if CFG_ENTRY = "11" then
                        T3_LAPIC_ID <= CFG_LAPIC_ID;
                        T3_VECTOR   <= CFG_VECTOR;
                        T3_DELIVERY <= CFG_DELIVERY;
                        T3_MASKED   <= CFG_MASKED;
                        T3_VALID    <= CFG_VALID;
                    end if;
                end if;

                -- -----------------------------------------------------------
                -- Captura de la transaccion MSI al entrar a LOOKUP
                -- -----------------------------------------------------------
                if COND_CAPTURE = '1' then
                    LATCH_DEVICE_ID  <= DEVICE_ID;
                    LATCH_WRITE_DATA <= MSI_WRITE_DATA;
                end if;

                -- -----------------------------------------------------------
                -- Guardar interrupcion como PENDING si estaba enmascarada
                -- (se procesara cuando se desenmascare)
                -- -----------------------------------------------------------
                if IS_LOOKUP = '1' and MUX_VALID = '1' and MUX_MASKED = '1' then
                    PENDING_IRQ <= '1';
                end if;

                -- Limpiar PENDING_IRQ al despachar
                if COND_ACKED = '1' then
                    PENDING_IRQ <= '0';
                end if;

            end if;
        end if;
    end process;

    -- =========================================================================
    -- PASO 4: Salidas de despacho al LAPIC (combinacionales)
    -- =========================================================================

    -- LAPIC_INT_REQ: activo en estado DISPATCH (el LAPIC recibe la solicitud)
    LAPIC_INT_REQ <= IS_DISPATCH;

    -- Vector y modo de entrega provienen del MUX de la tabla
    LAPIC_VECTOR        <= MUX_VECTOR;
    LAPIC_DELIVERY_MODE <= MUX_DELIVERY;
    LAPIC_TARGET_ID     <= MUX_LAPIC_ID;

    -- =========================================================================
    -- PASO 5: Handshake de completado
    -- =========================================================================

    -- MSI_ACK: pulso de 1 ciclo cuando el LAPIC confirma la recepcion
    -- (equivalente a IS_DISPATCH AND LAPIC_ACK)
    MSI_ACK <= COND_ACKED;

    -- =========================================================================
    -- Señal de error de seguridad
    -- =========================================================================
    MSI_ERROR <= COND_ERROR;

end FSM_MSI;
