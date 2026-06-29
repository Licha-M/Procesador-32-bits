-- =============================================================================
--  TLB_LRU.vhd
--  Translation Lookaside Buffer de 32 bits con reemplazo LRU
--  Optimizado para simulación en Logisim / GHDL
-- =============================================================================
--  ARQUITECTURA:
--    · Lookup COMBINACIONAL (asíncrono): responde sin esperar el clock,
--      ideal para simulación en Logisim.
--    · Escritura y actualización de edad LRU SÍNCRONA (flanco de subida).
--    · 64 entradas. Cada entrada guarda:
--        valid  (1 bit)
--        vpn    (20 bits, virt_addr[31:12])
--        pcid_k (8 bits,  pcid[7:0])
--        frame  (32 bits)
--        age    (6 bits, 0 = LRU, 63 = MRU)
--
--  POLÍTICA LRU (orden relativo siempre preservado):
--    · En HIT  → sea A = age[hit_idx] ANTES de promover.
--                age[hit_idx] = MAX
--                age[i]-- SOLO si age[i] > A   ← clave: no tocar entradas
--                                                  ya más viejas que hit
--    · En WRITE → sea A = age[víctima] ANTES de reemplazar.
--                 se inserta con age = MAX
--                 age[i]-- SOLO si valid[i] AND age[i] > A
--    · Prioridad: write_en > lookup hit (si ambas llegan al mismo ciclo)
--
--  ¿Por qué? Si decrementaras TODAS las entradas en cada hit, después de
--  suficientes hits en la misma entrada todas las demás llegarían a 0 y
--  perderías el orden relativo entre ellas (empate masivo en LRU).
-- =============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TLB_LRU is
    Generic (
        -- Parámetros: 64 entradas (puedes ajustar)
        NUM_ENTRIES   : integer := 64;  -- 64 entradas en la TLB

        -- Reducimos la comparación a VPN y PCID pequeño (más realista)
        VPN_HIGH      : integer := 31;
        VPN_LOW       : integer := 12;  -- página de 4 KB → 20 bits de VPN
        PCID_LOW_BITS : integer := 7    -- usamos 8 bits de PCID (bits 7..0)
    );
    Port (
        clk           : in  STD_LOGIC;
        reset         : in  STD_LOGIC;

        -- Búsqueda (ASÍNCRONA combinacional para simulación / Logisim)
        lookup_en     : in  STD_LOGIC;                      -- Habilitar búsqueda
        pcid          : in  STD_LOGIC_VECTOR(31 downto 0);  -- Process-Context ID
        virt_addr     : in  STD_LOGIC_VECTOR(31 downto 0);  -- Dirección virtual (32 bits)
        hit           : out STD_LOGIC;                      -- '1' si encontró
        phys_frame    : out STD_LOGIC_VECTOR(31 downto 0);  -- Marco físico (32 bits)

        -- Escritura (SÍNCRONA con reemplazo LRU automático)
        write_en      : in  STD_LOGIC;                      -- Habilitar escritura
        write_phys    : in  STD_LOGIC_VECTOR(31 downto 0)   -- Marco físico a insertar
    );
end TLB_LRU;

architecture Behavioral of TLB_LRU is

    -- -------------------------------------------------------------------------
    -- Constantes derivadas
    -- -------------------------------------------------------------------------
    constant VPN_BITS  : integer := VPN_HIGH - VPN_LOW + 1;  -- 20
    constant PCID_BITS : integer := PCID_LOW_BITS + 1;        -- 8  (bits 7..0)
    constant AGE_BITS  : integer := 6;                        -- log2(64) = 6
    constant MAX_AGE   : integer := NUM_ENTRIES - 1;          -- 63

    -- -------------------------------------------------------------------------
    -- Tipos de arrays para la tabla TLB
    -- -------------------------------------------------------------------------
    type t_vpn   is array(0 to NUM_ENTRIES-1) of std_logic_vector(VPN_BITS-1  downto 0);
    type t_pcid  is array(0 to NUM_ENTRIES-1) of std_logic_vector(PCID_BITS-1 downto 0);
    type t_frame is array(0 to NUM_ENTRIES-1) of std_logic_vector(31 downto 0);
    type t_age   is array(0 to NUM_ENTRIES-1) of unsigned(AGE_BITS-1 downto 0);
    type t_valid is array(0 to NUM_ENTRIES-1) of std_logic;

    -- -------------------------------------------------------------------------
    -- Registros de la TLB
    -- -------------------------------------------------------------------------
    signal tlb_valid : t_valid;
    signal tlb_vpn   : t_vpn;
    signal tlb_pcid  : t_pcid;
    signal tlb_frame : t_frame;
    signal tlb_age   : t_age;

    -- -------------------------------------------------------------------------
    -- Señales de resultado del bloque combinacional
    -- (leídas por el bloque síncrono para actualizar la edad en HIT)
    -- -------------------------------------------------------------------------
    signal s_hit_found : std_logic;
    signal s_hit_idx   : integer range 0 to NUM_ENTRIES-1;

begin

    -- =========================================================================
    -- BLOQUE 1: Lookup combinacional (asíncrono)
    -- =========================================================================
    -- Responde en el mismo ciclo de simulación sin esperar un flanco de clock.
    -- Recorre todas las entradas en paralelo (síntesis) o en delta-cycles
    -- (simulación) y devuelve hit + phys_frame.
    -- También actualiza las señales internas s_hit_found / s_hit_idx que
    -- serán leídas por el bloque síncrono para el aging LRU en hit.
    -- =========================================================================
    comb_lookup : process(lookup_en, virt_addr, pcid,
                          tlb_valid, tlb_vpn, tlb_pcid, tlb_frame)
        variable v_vpn   : std_logic_vector(VPN_BITS-1  downto 0);
        variable v_pcid  : std_logic_vector(PCID_BITS-1 downto 0);
        variable v_found : std_logic;
        variable v_frame : std_logic_vector(31 downto 0);
        variable v_idx   : integer range 0 to NUM_ENTRIES-1;
    begin
        -- Extraer campos de comparación
        v_vpn  := virt_addr(VPN_HIGH downto VPN_LOW);
        v_pcid := pcid(PCID_LOW_BITS downto 0);

        -- Valores por defecto (miss)
        v_found := '0';
        v_frame := (others => '0');
        v_idx   := 0;

        -- Recorrido de las 64 entradas (en síntesis: lógica paralela)
        if lookup_en = '1' then
            for i in 0 to NUM_ENTRIES-1 loop
                if tlb_valid(i) = '1'
                   and tlb_vpn(i)  = v_vpn
                   and (tlb_pcid(i) = v_pcid or tlb_frame(i)(3) = '1')
                then
                    v_found := '1';
                    v_frame := tlb_frame(i);
                    v_idx   := i;
                    -- No hay break en VHDL; si hubiera dos hits (no debería)
                    -- el último índice gana. En una TLB correcta no hay duplicados.
                end if;
            end loop;
        end if;

        -- Salidas principales
        hit        <= v_found;
        phys_frame <= v_frame;

        -- Señales internas para el bloque síncrono
        s_hit_found <= v_found;
        s_hit_idx   <= v_idx;
    end process comb_lookup;


    -- =========================================================================
    -- BLOQUE 2: Actualización síncrona de la TLB y política LRU
    -- =========================================================================
    -- En cada flanco de subida de clk:
    --   · reset  → invalida todo
    --   · write_en = '1' → inserta nueva entrada con LRU replacement
    --   · write_en = '0' y hit = '1' → promueve la entrada a MRU
    -- Prioridad: write_en > hit (si llegan juntos, se procesa la escritura).
    -- =========================================================================
    sync_tlb : process(clk)
        variable v_vpn        : std_logic_vector(VPN_BITS-1  downto 0);
        variable v_pcid_w     : std_logic_vector(PCID_BITS-1 downto 0);
        variable v_target     : integer range 0 to NUM_ENTRIES-1;
        variable v_lru_idx    : integer range 0 to NUM_ENTRIES-1;
        variable v_min_age    : unsigned(AGE_BITS-1 downto 0);
        variable v_free_found : boolean;
        variable v_free_idx   : integer range 0 to NUM_ENTRIES-1;
        -- Captura la edad de la víctima/hit ANTES de sobreescribirla,
        -- necesaria para el decremento selectivo correcto.
        variable v_victim_age : unsigned(AGE_BITS-1 downto 0);
    begin
        if rising_edge(clk) then

            -- -----------------------------------------------------------------
            -- Reset: invalida toda la tabla y pone las edades a 0
            -- -----------------------------------------------------------------
            if reset = '1' then
                for i in 0 to NUM_ENTRIES-1 loop
                    tlb_valid(i) <= '0';
                    tlb_age(i)   <= (others => '0');
                end loop;

            -- -----------------------------------------------------------------
            -- Escritura con reemplazo LRU
            -- -----------------------------------------------------------------
            elsif write_en = '1' then
                v_vpn    := virt_addr(VPN_HIGH downto VPN_LOW);
                v_pcid_w := pcid(PCID_LOW_BITS downto 0);

                -- Paso 1: Buscar entrada libre (inválida) o la de menor edad
                v_free_found := false;
                v_free_idx   := 0;
                v_min_age    := (others => '1');  -- inicializar al máximo
                v_lru_idx    := 0;

                for i in 0 to NUM_ENTRIES-1 loop
                    -- Primera entrada inválida encontrada = candidata gratis
                    if tlb_valid(i) = '0' and not v_free_found then
                        v_free_found := true;
                        v_free_idx   := i;
                    end if;
                    -- Mínima edad (LRU real)
                    if tlb_age(i) < v_min_age then
                        v_min_age := tlb_age(i);
                        v_lru_idx := i;
                    end if;
                end loop;

                -- Paso 2: Elegir víctima y capturar su edad actual
                if v_free_found then
                    v_target     := v_free_idx;
                    v_victim_age := tlb_age(v_free_idx); -- 0 si era inválida
                else
                    v_target     := v_lru_idx;
                    v_victim_age := v_min_age;            -- edad LRU real
                end if;

                -- Paso 3: Insertar la nueva entrada como MRU
                tlb_vpn(v_target)   <= v_vpn;
                tlb_pcid(v_target)  <= v_pcid_w;
                tlb_frame(v_target) <= write_phys;
                tlb_valid(v_target) <= '1';
                tlb_age(v_target)   <= to_unsigned(MAX_AGE, AGE_BITS);

                -- Paso 4: Decrementar SOLO las entradas más recientes que la víctima.
                --   Invariante: si age[i] <= v_victim_age, esas entradas ya eran
                --   más viejas que la víctima y no deben cambiar su posición relativa.
                for i in 0 to NUM_ENTRIES-1 loop
                    if i /= v_target then
                        if tlb_valid(i) = '1' and tlb_age(i) > v_victim_age then
                            tlb_age(i) <= tlb_age(i) - 1;
                        end if;
                    end if;
                end loop;

            -- -----------------------------------------------------------------
            -- Hit: promover la entrada encontrada a MRU.
            -- CORRECCIÓN LRU: solo decrementan las entradas cuya edad sea
            -- MAYOR que la edad actual de la entrada en hit.  Las entradas
            -- que ya eran más viejas que hit conservan su posición relativa.
            -- -----------------------------------------------------------------
            elsif lookup_en = '1' and s_hit_found = '1' then
                -- Capturar la edad actual del hit (antes de promoverla)
                v_victim_age := tlb_age(s_hit_idx);

                for i in 0 to NUM_ENTRIES-1 loop
                    if i = s_hit_idx then
                        -- Entrada accedida → MRU
                        tlb_age(i) <= to_unsigned(MAX_AGE, AGE_BITS);
                    elsif tlb_valid(i) = '1' and tlb_age(i) > v_victim_age then
                        -- Solo las entradas más recientes que hit pierden un puesto
                        tlb_age(i) <= tlb_age(i) - 1;
                        -- Las entradas con age <= v_victim_age ya eran más viejas
                        -- que hit: su orden relativo entre sí no debe cambiar.
                    end if;
                end loop;
            end if;

        end if;
    end process sync_tlb;

end Behavioral;

-- =============================================================================
-- NOTAS DE USO
-- =============================================================================
--
--  1. LOOKUP (asíncrono):
--       · Pon lookup_en = '1', virt_addr y pcid en los pines.
--       · hit y phys_frame responden sin esperar el clock.
--       · La actualización LRU del hit se efectúa en el siguiente flanco.
--
--  2. ESCRITURA (síncrona):
--       · Pon write_en = '1', virt_addr, pcid y write_phys en los pines.
--       · La inserción y el reemplazo LRU ocurren en el flanco de subida.
--       · write_en tiene prioridad sobre lookup_en si llegan juntos.
--
--  3. RESET:
--       · reset = '1' (síncrono) invalida todas las entradas en el
--         siguiente flanco de subida.
--
--  4. AJUSTE DE TAMAÑO:
--       · Para una TLB más pequeña (y más rápida en Logisim) baja
--         NUM_ENTRIES a 16 o 32.
--       · Ajusta AGE_BITS = ceil(log2(NUM_ENTRIES)):
--           16 entradas → AGE_BITS = 4
--           32 entradas → AGE_BITS = 5
--           64 entradas → AGE_BITS = 6  (valor actual)
--
--  5. LOGISIM:
--       · Compila con GHDL y exporta el netlist.
--       · El loop de 64 entradas genera lógica paralela; si el simulador
--         va lento, reduce NUM_ENTRIES a 16 y ajusta AGE_BITS.
-- =============================================================================
