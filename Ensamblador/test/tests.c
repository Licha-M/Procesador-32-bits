#include "tests.h"

// =============================================================================
// Definición de las variables de resultado
// =============================================================================
volatile int32_t g_t01_add;
volatile int32_t g_t01_sub;
volatile uint32_t g_t01_and;
volatile uint32_t g_t01_or;
volatile uint32_t g_t01_xor;
volatile uint32_t g_t01_shl;
volatile uint32_t g_t01_shr_logical;

volatile int32_t g_t02_sar;
volatile uint32_t g_t02_shl_by2;
volatile uint32_t g_t02_shl_by34;
volatile uint32_t g_t02_shr_logical;

volatile uint32_t g_t03_full32;
volatile uint8_t g_t03_byte0;
volatile uint16_t g_t03_half0;
volatile uint32_t g_t03_word0;
static volatile uint8_t
    t03_buffer[4]; // buffer de trabajo, no hace falta inspeccionarlo aparte

volatile int32_t g_t04_cmp_signed;
volatile int32_t g_t04_cmp_unsigned;

volatile uint32_t g_t05_sum;
volatile uint32_t g_t06_sum;

volatile int32_t g_t07_array[T07_ARRAY_SIZE];
volatile uint32_t g_t07_count;

volatile int32_t g_t08_args[7];
volatile int32_t g_t09_args[8];

volatile uint32_t g_t10_fact5;
volatile uint32_t g_t10_fact10;

volatile int32_t g_t11_is_even_10;
volatile int32_t g_t11_is_odd_10;

volatile int32_t g_t12_sum;

volatile uint32_t g_t13_div_normal;
volatile uint32_t g_t13_mod_normal;
volatile uint32_t g_t13_div_by_zero;
volatile int32_t g_t13_sdiv_by_zero_neg;

volatile int32_t g_t14_initialized = 0x1234;

// =============================================================================
// T01 — ALU básica
// -----------------------------------------------------------------------------
// a = 240 (0xF0 = 1111 0000)
// b = 60  (0x3C = 0011 1100)
//
// Valores esperados (calculados a mano, no asumidos):
//   add          = 240 + 60  = 300            (0x0000012C)
//   sub          = 240 - 60  = 180             (0x000000B4)
//   and          = 0xF0 & 0x3C = 0x30 = 48      (1111 0000 & 0011 1100 = 0011
//   0000) or           = 0xF0 | 0x3C = 0xFC = 252     (1111 1100) xor = 0xF0 ^
//   0x3C = 0xCC = 204     (1100 1100) shl (a<<3)   = 240 * 8   = 1920
//   (0x00000780) shr_logical (a>>2, sin signo) = 240 / 4 = 60 (0x0000003C)
// =============================================================================
void t01_alu_basic(void) {
  int32_t a = 240;
  int32_t b = 60;
  g_t01_add = a + b;
  g_t01_sub = a - b;
  g_t01_and = (uint32_t)a & (uint32_t)b;
  g_t01_or = (uint32_t)a | (uint32_t)b;
  g_t01_xor = (uint32_t)a ^ (uint32_t)b;
  g_t01_shl = (uint32_t)a << 3;
  g_t01_shr_logical = (uint32_t)a >> 2;
}

// =============================================================================
// T02 — Shift aritmético vs lógico + enmascarado del shift amount
// -----------------------------------------------------------------------------
// x = -32  →  en bits: 0xFFFFFFE0
//
// sar (shift aritmético, preserva el signo):
//   -32 >> 2 (con signo)  = -8   (0xFFFFFFF8)
//
// shr_logical (shift lógico, NO preserva el signo — rellena con 0):
//   0xFFFFFFE0 >> 2 (sin signo) = 0x3FFFFFF8  (1073741816 decimal)
//
// shl_by2 (shift lógico izquierda por 2):
//   0xFFFFFFE0 << 2 = 0xFFFFFF80  (trunca a 32 bits)
//
// shl_by34: el PDF dice que el shift amount sólo toma los 5 bits inferiores
//   (shift_amount & 31). 34 & 31 = 2, así que shl_by34 DEBE dar exactamente
//   el mismo resultado que shl_by2 (0xFFFFFF80). Si no coincide, el backend
//   no está enmascarando el shift amount como debería.
// =============================================================================
void t02_shift_arith_and_mask(void) {
  int32_t x = -32;
  g_t02_sar = x >> 2;                   // shift aritmético (tipo con signo)
  g_t02_shr_logical = (uint32_t)x >> 2; // shift lógico (tipo sin signo)
  g_t02_shl_by2 = (uint32_t)x << 2;
  g_t02_shl_by34 = (uint32_t)x
                   << (34 & 31); // shift amount > 31: debe enmascararse
}

// =============================================================================
// T03 — Acceso a memoria de distintos tamaños y verificación de endianness
// -----------------------------------------------------------------------------
// Se escribe 0xAABBCCDD como INT (32 bits) en un buffer de 4 bytes.
// La arquitectura es Little-Endian (confirmado en el PDF, sección 1.1), así
// que en memoria el byte MENOS significativo (0xDD) queda en la dirección
// MÁS BAJA:
//
//   buffer[0] = 0xDD   (byte menos significativo)
//   buffer[1] = 0xCC
//   buffer[2] = 0xBB
//   buffer[3] = 0xAA   (byte más significativo)
//
// Por lo tanto, releyendo desde el inicio del buffer:
//   byte0 (CHAR LOD, 8 bits, zero-extend)  = 0xDD             (g_t03_byte0)
//   half0 (SHORT LOD, 16 bits, zero-extend) = 0xCCDD          (g_t03_half0)
//   word0 (INT LOD, 32 bits)                = 0xAABBCCDD       (g_t03_word0)
//
// El PDF confirma que CHAR/SHORT LOD rellenan con CERO los bits superiores
// (sección 3.2) — no hay signo. Si el resultado tuviera signo extendido
// (0xFFFFFFDD en vez de 0x000000DD para el byte), sería un bug de
// legalización de tipos en el backend.
// =============================================================================
void t03_mem_widths(void) {
  *(volatile uint32_t *)t03_buffer = 0xAABBCCDDu;
  g_t03_full32 = 0xAABBCCDDu;

  g_t03_byte0 = t03_buffer[0];
  g_t03_half0 = *(volatile uint16_t *)&t03_buffer[0];
  g_t03_word0 = *(volatile uint32_t *)&t03_buffer[0];
}

// =============================================================================
// T04 — Comparación con signo vs sin signo
// -----------------------------------------------------------------------------
// Mismo patrón de bits (0xFFFFFFFF) interpretado de dos formas distintas:
//
//   Con signo:   (int32_t)0xFFFFFFFF == -1.       -1 < 1  → VERDADERO (1)
//   Sin signo:   (uint32_t)0xFFFFFFFF == 4294967295. 4294967295 < 1 → FALSO (0)
//
// Este test verifica que el backend elige el flag correcto para el branch
// según el tipo: probablemente N (Negative) para comparación con signo, y
// C (Carry) para sin signo — el PDF no lo especifica explícitamente para
// LLVM, así que este test es justamente para DESCUBRIRLO empíricamente.
// Si ambos resultados dan igual, hay una confusión de signo/sin-signo en
// la selección de instrucciones (isel) para SETCC/BRCOND.
// =============================================================================
void t04_cmp_signed_vs_unsigned(void) {
  int32_t a_signed = -1;
  uint32_t a_unsigned = 0xFFFFFFFFu;
  int32_t b = 1;

  g_t04_cmp_signed = (a_signed < b) ? 1 : 0;               // esperado: 1
  g_t04_cmp_unsigned = (a_unsigned < (uint32_t)b) ? 1 : 0; // esperado: 0
}

// =============================================================================
// T05 — Loop chico de bound fijo (candidato a unroll en -O2)
// -----------------------------------------------------------------------------
// sum = 0*0 + 1*1 + 2*2 + 3*3 = 0 + 1 + 4 + 9 = 14
// =============================================================================
void t05_loop_small_fixed(void) {
  uint32_t sum = 0;
  for (uint32_t i = 0; i < 4; i++) {
    sum += i * i;
  }
  g_t05_sum = sum;
}

// =============================================================================
// T06 — Loop grande (no debería unrollearse; fuerza un loop real con BRH)
// -----------------------------------------------------------------------------
// sum = 0 + 1 + 2 + ... + 999 = 999*1000/2 = 499500
// =============================================================================
void t06_loop_large(void) {
  uint32_t sum = 0;
  for (uint32_t i = 0; i < 1000; i++) {
    sum += i;
  }
  g_t06_sum = sum;
}

// =============================================================================
// T07 — Loop anidado con "break" condicional en el loop interno
// -----------------------------------------------------------------------------
// Este test reproduce EXACTAMENTE la estructura que tenía el bug sospechado
// en bus_Enumeration: un for externo (dev), un for interno (func), y un
// "break" condicional que corta el loop interno antes de tiempo en una
// iteración específica del externo.
//
//   for (dev = 0; dev < 4; dev++) {
//     for (func = 0; func < 8; func++) {
//       if (dev == 2 && func == 3) break;   // corta SOLO cuando dev==2
//       array[count++] = dev*8 + func;
//     }
//   }
//
// Recorrido esperado, mano a mano:
//   dev=0: func 0..7 (8 iteraciones, nada corta)   → escribe  0, 1, 2, 3, 4, 5,
//   6, 7 dev=1: func 0..7 (8 iteraciones, nada corta)   → escribe  8,
//   9,10,11,12,13,14,15 dev=2: func 0,1,2 (corta en func==3)           →
//   escribe 16,17,18 dev=3: func 0..7 (8 iteraciones, nada corta)   → escribe
//   24,25,26,27,28,29,30,31
//
// Total de elementos escritos: 8 + 8 + 3 + 8 = 27  → g_t07_count debe ser 27
//
// Contenido esperado de g_t07_array (índices 0 a 26):
//   [0..7]   =  0, 1, 2, 3, 4, 5, 6, 7
//   [8..15]  =  8, 9,10,11,12,13,14,15
//   [16..18] = 16,17,18
//   [19..26] = 24,25,26,27,28,29,30,31
//
// Si el "break" del dev==2 no corta bien (el bug que sospechábamos en el
// backend real), vas a ver MÁS de 27 elementos escritos, o vas a ver que
// el valor en el índice 19 no es 24 sino 19 o 20 (señal de que el break
// no cortó y seguyó escribiendo func=3..7 también en dev==2).
// =============================================================================
void t07_nested_loop_with_break(void) {
  uint32_t count = 0;
  for (int32_t dev = 0; dev < 4; dev++) {
    for (int32_t func = 0; func < 8; func++) {
      if (dev == 2 && func == 3) {
        break;
      }
      g_t07_array[count] = dev * 8 + func;
      count++;
    }
  }
  g_t07_count = count;
}

// =============================================================================
// T08 — Llamada con exactamente 7 argumentos (todos entran en R1-R7)
// -----------------------------------------------------------------------------
// Se llama a una función con 7 argumentos escalares distintos. Como la
// convención confirmada es R1..R7 en orden para los primeros 7 argumentos,
// esta llamada NO debería necesitar tocar la pila para pasar argumentos.
//
// Valores pasados: 11, 22, 33, 44, 55, 66, 77 (todos distintos y fáciles
// de identificar si alguno queda mal ubicado).
//
// Esperado: g_t08_args[0..6] = {11, 22, 33, 44, 55, 66, 77}
// =============================================================================
static void t08_callee(int32_t a1, int32_t a2, int32_t a3, int32_t a4,
                       int32_t a5, int32_t a6, int32_t a7) {
  g_t08_args[0] = a1;
  g_t08_args[1] = a2;
  g_t08_args[2] = a3;
  g_t08_args[3] = a4;
  g_t08_args[4] = a5;
  g_t08_args[5] = a6;
  g_t08_args[6] = a7;
}

void t08_call_7args(void) { t08_callee(11, 22, 33, 44, 55, 66, 77); }

// =============================================================================
// T09 — Llamada con 8 argumentos (el 8vo va forzosamente por pila)
// -----------------------------------------------------------------------------
// Con 8 argumentos, los primeros 7 van por R1-R7 y el 8vo tiene que pasarse
// por la pila (según el PDF, sección 5.1: "si una función recibe más
// parámetros que los registros disponibles, los argumentos restantes se
// colocarán en la pila"). Este test verifica específicamente ESE mecanismo.
//
// Valores pasados: 101, 103, 107, 109, 113, 127, 131, 137 (primos, fáciles
// de distinguir de basura o de un valor de otro test).
//
// Esperado: g_t09_args[0..7] = {101, 103, 107, 109, 113, 127, 131, 137}
// Prestale especial atención a g_t09_args[7] (137): si el mecanismo de
// paso por pila está mal, ese es el valor que más probablemente salga mal
// (leído desde el offset equivocado, o pisado por el propio prólogo del
// callee).
// =============================================================================
static void t09_callee(int32_t a1, int32_t a2, int32_t a3, int32_t a4,
                       int32_t a5, int32_t a6, int32_t a7, int32_t a8) {
  g_t09_args[0] = a1;
  g_t09_args[1] = a2;
  g_t09_args[2] = a3;
  g_t09_args[3] = a4;
  g_t09_args[4] = a5;
  g_t09_args[5] = a6;
  g_t09_args[6] = a7;
  g_t09_args[7] = a8;
}

void t09_call_8args(void) {
  t09_callee(101, 103, 107, 109, 113, 127, 131, 137);
}

// =============================================================================
// T10 — Recursión simple (factorial)
// -----------------------------------------------------------------------------
// factorial(5)  = 5*4*3*2*1           = 120
// factorial(10) = 10*9*8*7*6*5*4*3*2*1 = 3628800
//
// factorial(10) en particular fuerza 10 niveles de recursión — suficiente
// para detectar corrupción de pila si cada nivel no reserva/libera su
// marco correctamente (el mismo mecanismo que usa bus_Enumeration, pero
// aislado sin nada de ECAM/structs de por medio).
// =============================================================================
static uint32_t t10_factorial(uint32_t n) {
  if (n <= 1) {
    return 1;
  }
  return n * t10_factorial(n - 1);
}

void t10_recursion_factorial(void) {
  g_t10_fact5 = t10_factorial(5);
  g_t10_fact10 = t10_factorial(10);
}

// =============================================================================
// T11 — Recursión mutua entre dos funciones distintas
// -----------------------------------------------------------------------------
// is_even(n) llama a is_odd(n-1), que a su vez llama a is_even(n-2), etc.
// A diferencia de T10 (una función que se llama a sí misma), acá cada
// llamada es a una función DISTINTA — esto estresa la preservación de
// registros callee-saved entre DOS cuerpos de código diferentes, no el
// mismo (que es más fácil de "acertar por casualidad" si el compilador
// reutiliza la misma asignación de registros en cada nivel).
//
// is_even(10): 10 es par → esperado 1
// is_odd(10):  10 no es impar → esperado 0
// =============================================================================
static int32_t t11_is_odd(uint32_t n);

static int32_t t11_is_even(uint32_t n) {
  if (n == 0) {
    return 1;
  }
  return t11_is_odd(n - 1);
}

static int32_t t11_is_odd(uint32_t n) {
  if (n == 0) {
    return 0;
  }
  return t11_is_even(n - 1);
}

void t11_mutual_recursion(void) {
  g_t11_is_even_10 = t11_is_even(10);
  g_t11_is_odd_10 = t11_is_odd(10);
}

// =============================================================================
// T12 — Dirección de una variable local que "escapa" a otra función
// -----------------------------------------------------------------------------
// Reproduce el patrón de PCIe_Bus_Enumeration: variables locales cuya
// DIRECCIÓN se pasa a otra función (que las llena por puntero), en vez de
// pasarse por valor. Esto obliga al backend a darles una dirección de pila
// real (no puede mantenerlas sólo en un registro).
//
// t12_helper llena local[0..2] = {1, 2, 3}
// g_t12_sum = 1 + 2 + 3 = 6
// =============================================================================
static void t12_helper(int32_t *arr) {
  arr[0] = 1;
  arr[1] = 2;
  arr[2] = 3;
}

void t12_escaping_local_array(void) {
  int32_t local[3];
  t12_helper(local);
  g_t12_sum = local[0] + local[1] + local[2];
}

// =============================================================================
// T13 — División y módulo sin signo, incluyendo división por cero
// -----------------------------------------------------------------------------
// División normal:
//   17 / 5 = 3   (17 = 3*5 + 2)
//   17 % 5 = 2
//
// División por cero — regla confirmada para esta arquitectura: x/0 = x
// (incluyendo 0/0 = 0), en vez del comportamiento típico de otras ISAs
// (excepción, o 0xFFFFFFFF):
//   42 / 0        = 42            (unsigned)
//   (-8) / 0      = -8            (con signo — la división con signo se
//                    arma por software sobre la unsigned de hardware según
//                    el PDF sección 4.1, así que este caso además verifica
//                    que esa capa de software respeta la regla especial
//                    de x/0 al propagar el signo correctamente)
// =============================================================================
// void t13_division(void) {
//   uint32_t a = 17, b = 5;
//   g_t13_div_normal = a / b;
//   g_t13_mod_normal = a % b;

//   uint32_t c = 42, zero_u = 0;
//   g_t13_div_by_zero = c / zero_u;

//   int32_t d = -8, zero_s = 0;
//   g_t13_sdiv_by_zero_neg = d / zero_s;
// }
