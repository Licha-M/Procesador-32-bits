#ifndef TESTS_H
#define TESTS_H
#include <stdint.h>

// =============================================================================
// Banco de pruebas para el backend ISA32_LM
// =============================================================================
// Cada test es una función que no toma valores de entrada variables (todos los
// datos de prueba están hardcodeados adentro) y que deja su resultado en
// variables globales `volatile` — así podés inspeccionarlas con el debugger/
// simulador después de llamar a la función, sin depender de en qué registro
// physical terminó quedando cada valor (eso lo decide el register allocator y
// puede cambiar entre compilaciones).
//
// El único valor que SÍ es estable entre compilaciones es la convención de
// retorno: un resultado escalar de 32 bits siempre vuelve en R1 (confirmado
// en el PDF, sección 5.1). Cuando un test además tiene sentido devolver algo
// por R1, se documenta explícitamente.
//
// Todos los valores esperados están calculados a mano en los comentarios de
// tests.c, junto a cada función. Compará contra eso.
// =============================================================================

// ---- Variables de resultado (una por test, para poder inspeccionarlas todas
//      juntas al final sin tener que parar en cada return) ------------------

// T01 — ALU básica (AND/OR/XOR/ADD/SUB/SHL/SHR lógico)
extern volatile int32_t g_t01_add;
extern volatile int32_t g_t01_sub;
extern volatile uint32_t g_t01_and;
extern volatile uint32_t g_t01_or;
extern volatile uint32_t g_t01_xor;
extern volatile uint32_t g_t01_shl;
extern volatile uint32_t g_t01_shr_logical;

// T02 — Shift aritmético vs lógico, y enmascarado del shift amount (&31)
extern volatile int32_t g_t02_sar;      // shift aritmético (signo preservado)
extern volatile uint32_t g_t02_shl_by2; // shift lógico por 2
extern volatile uint32_t
    g_t02_shl_by34; // shift lógico por 34 (debe == shl_by2, 34&31=2)
extern volatile uint32_t g_t02_shr_logical; // shift lógico (sin signo)

// T03 — Acceso a memoria de distintos tamaños (CHAR/SHORT/INT) y endianness
extern volatile uint32_t g_t03_full32; // el valor completo escrito
extern volatile uint8_t g_t03_byte0;   // primer byte leído (LSB)
extern volatile uint16_t g_t03_half0;  // primer half-word leído
extern volatile uint32_t g_t03_word0;  // el word completo releído

// T04 — Comparación con signo vs sin signo (mismo bit pattern, resultado
// distinto)
extern volatile int32_t g_t04_cmp_signed; // (-1 < 1) con signo   → esperado 1
extern volatile int32_t
    g_t04_cmp_unsigned; // (0xFFFFFFFF < 1) sin signo → esperado 0

// T05 — Loop chico de bound fijo (candidato a unroll)
extern volatile uint32_t g_t05_sum; // suma de i*i para i=0..3

// T06 — Loop grande (no debería unrollearse)
extern volatile uint32_t g_t06_sum; // suma de i para i=0..999

// T07 — Loop anidado con "break" condicional en el loop interno
//       (mímica directa del patrón dev/func de bus_Enumeration)
#define T07_ARRAY_SIZE 32
extern volatile int32_t g_t07_array[T07_ARRAY_SIZE];
extern volatile uint32_t
    g_t07_count; // cuántos elementos se llegaron a escribir

// T08 — Llamada con exactamente 7 argumentos (todos entran en R1-R7)
extern volatile int32_t g_t08_args[7];

// T09 — Llamada con 8 argumentos (el 8vo va forzosamente por pila)
extern volatile int32_t g_t09_args[8];

// T10 — Recursión simple (factorial)
extern volatile uint32_t g_t10_fact5;  // factorial(5)  → esperado 120
extern volatile uint32_t g_t10_fact10; // factorial(10) → esperado 3628800

// T11 — Recursión mutua entre dos funciones distintas (is_even/is_odd)
extern volatile int32_t g_t11_is_even_10; // is_even(10) → esperado 1
extern volatile int32_t g_t11_is_odd_10;  // is_odd(10)  → esperado 0

// T12 — Dirección de una variable local que "escapa" (se pasa a otra función)
extern volatile int32_t
    g_t12_sum; // suma de un array local llenado por otra función

// T13 — División sin signo, incluyendo x/0 (regla confirmada: x/0 = x)
extern volatile uint32_t g_t13_div_normal; // 17 / 5   → esperado 3
extern volatile uint32_t g_t13_mod_normal; // 17 % 5   → esperado 2
extern volatile uint32_t
    g_t13_div_by_zero; // 42 / 0   → esperado 42 (regla especial)
extern volatile int32_t
    g_t13_sdiv_by_zero_neg; // (-8)/0 con signo → esperado -8

// T14 — Variable global inicializada con valor no cero (para probar sección .data)
extern volatile int32_t g_t14_initialized;

// ---- Funciones de test -------------------------------------------------

void t01_alu_basic(void);
void t02_shift_arith_and_mask(void);
void t03_mem_widths(void);
void t04_cmp_signed_vs_unsigned(void);
void t05_loop_small_fixed(void);
void t06_loop_large(void);
void t07_nested_loop_with_break(void);
void t08_call_7args(void);
void t09_call_8args(void);
void t10_recursion_factorial(void);
void t11_mutual_recursion(void);
void t12_escaping_local_array(void);
// void t13_division(void);

#endif // TESTS_H
