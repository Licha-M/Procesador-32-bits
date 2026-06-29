-- =============================================================================
-- Priority Decoder - Decodificador de Prioridad
-- =============================================================================
-- Descripcion:
--   Es el inverso del Pri_Encoder. Recibe un codigo de 7 bits (INDEX) que
--   representa una posicion de bit entre 0 y 127, y genera un vector de 128
--   bits "one-hot" (un solo bit activo) particionado en dos salidas de 64 bits.
--
--   La salida sigue el mismo convenio que Pri_Encoder:
--     A   cubre los bits  [63:  0]  (posiciones  0 ..  63)
--     B   cubre los bits [127: 64]  (posiciones 64 .. 127)
--
--   Si VALID = '0' ambas salidas son todo ceros, independientemente de INDEX.
--
-- Entradas:
--   INDEX  : std_logic_vector(6 downto 0)  -- Posicion del bit a activar (0-127)
--   VALID  : std_logic                     -- '1' habilita la decodificacion
--
-- Salidas:
--   A      : std_logic_vector(63 downto 0) -- bits [63:0]   del resultado
--   B      : std_logic_vector(63 downto 0) -- bits [127:64] del resultado
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- -----------------------------------------------------------------------------
-- Entity
-- -----------------------------------------------------------------------------
entity Pri_Decoder is
    port (
        -- Entrada codificada
        INDEX  : in  std_logic_vector(6 downto 0);   -- posicion del bit activo
        VALID  : in  std_logic;                       -- habilita la decodificacion

        -- Salidas one-hot (64 bits cada una)
        A      : out std_logic_vector(63 downto 0);   -- bits [63:0]
        B      : out std_logic_vector(63 downto 0)    -- bits [127:64]
    );
end entity Pri_Decoder;

-- -----------------------------------------------------------------------------
-- Architecture - Combinacional / Asincrona
-- -----------------------------------------------------------------------------
architecture rtl of Pri_Decoder is

    -- Vector interno de 128 bits (one-hot)
    signal combined : std_logic_vector(127 downto 0);

begin

    -- -------------------------------------------------------------------------
    -- Proceso combinacional - Priority Decoder
    -- Activa solo el bit cuya posicion coincide con INDEX.
    -- Si VALID = '0', el resultado es todo ceros.
    -- -------------------------------------------------------------------------
    PRIORITY_DEC : process(INDEX, VALID)
        variable pos : integer range 0 to 127;
    begin
        combined <= (others => '0');          -- default: todo apagado

        if VALID = '1' then
            pos := to_integer(unsigned(INDEX));
            combined(pos) <= '1';             -- activa el bit indicado
        end if;

    end process PRIORITY_DEC;

    -- -------------------------------------------------------------------------
    -- Separacion del vector en dos salidas de 64 bits
    -- B <-- combined[127:64]   (posiciones 64 .. 127)
    -- A <-- combined[ 63: 0]   (posiciones  0 ..  63)
    -- -------------------------------------------------------------------------
    A <= combined(63  downto  0);
    B <= combined(127 downto 64);

end architecture rtl;
