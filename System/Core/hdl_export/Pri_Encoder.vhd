-- =============================================================================
-- Priority Encoder - Codificador de Prioridad
-- =============================================================================
-- Descripcion:
--   Recibe dos operandos de 64 bits (A y B). Los concatena en un vector de
--   128 bits donde B ocupa los bits [127:64] y A los bits [63:0].
--   Devuelve de forma ASINCRONA (combinacional puro) un codigo de 7 bits que
--   representa la posicion del bit '1' mas significativo (MSB activo).
--
--   Si ningun bit esta activo, la salida es "0000000" y la senal VALID = '0'.
--
-- Entradas:
--   A       : std_logic_vector(63 downto 0)  -- Operando bajo  [63:0]
--   B       : std_logic_vector(63 downto 0)  -- Operando alto [127:64]
--
-- Salidas:
--   INDEX   : std_logic_vector(6 downto 0)   -- Posicion del bit mas alto activo
--   VALID   : std_logic                      -- '1' si al menos un bit esta activo
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- -----------------------------------------------------------------------------
-- Entity
-- -----------------------------------------------------------------------------
entity Pri_Encoder is
    port (
        -- Operandos de entrada (64 bits cada uno)
        A     : in  std_logic_vector(63 downto 0);   -- bits [63:0]
        B     : in  std_logic_vector(63 downto 0);   -- bits [127:64]

        -- Resultado combinacional
        INDEX : out std_logic_vector(6 downto 0);    -- posicion del MSB activo
        VALID : out std_logic                         -- indica al menos un bit activo
    );
end entity Pri_Encoder;

-- -----------------------------------------------------------------------------
-- Architecture - Combinacional / Asincrona
-- -----------------------------------------------------------------------------
architecture rtl of Pri_Encoder is

    -- Vector interno de 128 bits: B en la mitad alta, A en la baja
    signal combined : std_logic_vector(127 downto 0);

begin

    -- -------------------------------------------------------------------------
    -- Concatenacion: B es mas significativo que A
    -- combined[127:64] = B
    -- combined[ 63: 0] = A
    -- -------------------------------------------------------------------------
    combined <= B & A;

    -- -------------------------------------------------------------------------
    -- Proceso combinacional - Priority Encoder
    -- Recorre el vector desde el bit mas alto (127) hacia el mas bajo (0).
    -- En cuanto encuentra el primer '1', codifica su posicion en INDEX y
    -- activa VALID. Si no hay ningun '1', INDEX = 0 y VALID = '0'.
    -- -------------------------------------------------------------------------
    PRIORITY_ENC : process(combined)
        variable found : boolean;
    begin
        INDEX <= (others => '0');
        VALID <= '0';
        found := false;

        for i in 127 downto 0 loop
            if (combined(i) = '1') and (not found) then
                INDEX <= std_logic_vector(to_unsigned(i, 7));
                VALID <= '1';
                found := true;
            end if;
        end loop;

    end process PRIORITY_ENC;

end architecture rtl;
