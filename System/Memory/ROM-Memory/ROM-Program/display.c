#include "functions.h"
#include "inter_IRQs.h"

// Estructura de función actual
typedef struct {
  void (*write)(char word[], int option, int length);
  volatile void *registers;
  uint32_t ecam_base; // Base ECAM del dispositivo de display activo
} DisplayDriver;

DisplayDriver current_display;

volatile bool DisplayDetected;

// Estructura registros TTY
typedef struct {
  volatile uint32_t comand;
  volatile uint32_t word_Addr;
  volatile uint32_t cant;
} TtyRegisters;

// Estructura registros GPU (No implementado)
// typedef struct {

// } GpuRegisters;

// Tamaño máximo de peticiones en espera
#define QUEUE_SIZE 4

// Estructura adaptada a tus necesidades
typedef struct {
  const char *data; // Puntero al texto/carácter
  char char_data;   // Copia del carácter para evitar dangling pointers
  int option;       // Comando (1, 2, 3, 4)
  int length;       // Longitud o cantidad
} DisplayRequest;

// Estructura de la cola (Buffer Circular)
typedef struct {
  DisplayRequest items[QUEUE_SIZE];
  volatile uint8_t head;  // Por donde leemos (IRQ)
  volatile uint8_t tail;  // Por donde escribimos (Programa)
  volatile uint8_t count; // Cantidad de elementos
} RequestQueue;

RequestQueue display_queue;
volatile bool hardware_busy = false;

// Bandera de pánico: ver declaración/comentario en functions.h.
volatile bool system_panic = false;

// ================================================================================
// Sección para TTY
// ================================================================================

// Función interna que realmente escribe en los registros del hardware
static void tty_execute_request(DisplayRequest *req) {
  volatile TtyRegisters *tty =
      (volatile TtyRegisters *)current_display.registers;

  switch (req->option) {
  case 1:
    // Escribir una letra
    tty->cant = req->length;
    tty->word_Addr = req->char_data; // Usamos la copia del carácter
    tty->comand = req->option;
    break;
  case 2:
    // Borrar
    tty->cant = req->length;
    tty->comand = req->option;
    break;
  case 3:
    // Limpiar TTY
    tty->comand = req->option;
    break;
  case 4:
    // Escribir cadena de texto
    tty->word_Addr = (uintptr_t)req->data;
    tty->comand = req->option;
    break;
  default:
    tty->comand = 0;
    break;
  }
}

// Handler del TTY
static uint32_t tty_IRQHandler(uint32_t eflags, uint32_t epc) {

  if (display_queue.count > 0) {
    // 1. Desencolamos la petición que acaba de terminar de imprimirse
    display_queue.head = (display_queue.head + 1) % QUEUE_SIZE;
    display_queue.count--;
  }

  if (display_queue.count > 0) {
    // 2. Si quedan peticiones, disparamos la siguiente
    tty_execute_request(&display_queue.items[display_queue.head]);
  } else {
    // 3. Si la cola quedó vacía, marcamos el hardware como libre
    hardware_busy = false;
  }

  return epc; // Retornamos a la instrucción interrumpida
}

// Determina si una petición requiere esperar IRQ de finalización del hardware.
static inline bool tty_requires_irq(int option, int length) {
  uint32_t opt = (uint32_t)option; // casteo a unsigned para operar sin signo
  uint32_t is_long_op =
      opt >> 2; // 1 si option >= 4, 0 si no (bit 2 en adelante)
  uint32_t is_op3 = (uint32_t)(opt == 3);    // 1 si option == 3, 0 si no
  uint32_t len_gt1 = (uint32_t)(length > 1); // 1 si length > 1, 0 si no
  return (bool)(is_long_op |
                ((1u - is_op3) & len_gt1)); // IRQ si: op>=4, o (op!=3 y len>1)
}

// Función principal que encola las peticiones (Llamada por biosWrite)
static void ttyWrite(char word[], int option, int length) {

  if (system_panic) {
    // El sistema está abortando no se inicia más.
    DisplayRequest panic_req = {
        .data = word, .char_data = word[0], .option = option, .length = length};
    tty_execute_request(&panic_req);
    return;
  }

  // Si la operación no genera IRQ
  if (!tty_requires_irq(option, length)) {
    // Si el hardware estaba ocupado procesando una cadena o ráfaga esperamos
    while (hardware_busy) {
      __asm__ volatile("HLT");
    }

    uint32_t flags_guardadas = enterCriticalSection();

    DisplayRequest direct_req = {
        .data = word, .char_data = word[0], .option = option, .length = length};
    tty_execute_request(&direct_req);

    exitCriticalSection(flags_guardadas);
    return;
  }

  // Esperamos a la IRQ del TTY si la cola está llena
  while (display_queue.count >= QUEUE_SIZE) {
    __asm__ volatile("HLT");
  }

  // --- INICIO SECCIÓN CRÍTICA ---
  uint32_t flags_guardadas = enterCriticalSection();

  // Guardamos los datos en la cola
  display_queue.items[display_queue.tail].data = word;
  display_queue.items[display_queue.tail].char_data = word[0]; // Copiamos valor
  display_queue.items[display_queue.tail].option = option;
  display_queue.items[display_queue.tail].length = length;

  display_queue.tail = (display_queue.tail + 1) % QUEUE_SIZE;
  display_queue.count++;

  // Si el hardware estaba inactivo, lo activamos
  if (!hardware_busy) {
    hardware_busy = true;
    tty_execute_request(&display_queue.items[display_queue.head]);
  }

  exitCriticalSection(flags_guardadas);
  // --- FIN SECCIÓN CRÍTICA ---
}

// Inicializador del TTY
static void initTty(uint32_t base) {
  // Inicializamos las variables de la cola
  display_queue.head = 0;
  display_queue.tail = 0;
  display_queue.count = 0;
  hardware_busy = false;

  ECAM_W(base, 0x04, 3); // Activa DMA y TTY

  // Leemos el BAR0
  uint32_t bar0 = ECAM_R(base, 0x10);
  current_display.registers = (volatile void *)(uintptr_t)bar0;

  initMSI(base, TTY_MSI_NUM, tty_IRQHandler);
}

// ================================================================================
// Sección para GPU
// ================================================================================

void initGpu(uint32_t base) {
  ECAM_W(base, 0x04, 0); // No esta definido (Sin GPU)
}

void gpuWrite() {}

// ================================================================================
// Funciones principales
// ================================================================================

// Busqueda de TTY
bool displaySearch() {

  int offset = search(0x00070000); // Buscamos TTY por su Class Code
  if (offset < 0)
    return DisplayDetected = false; // No reconocido

  uint32_t base =
      ECAM_ADDR(mapa[offset].bus, mapa[offset].dev, mapa[offset].func);

  initTty(base);
  current_display.ecam_base = base;
  current_display.write = ttyWrite;
  return DisplayDetected = true;
}

// Función de limpieza
inline void biosClear(void) { // cls() llama a esta
  current_display.write(0, 3, 0);
}

// Función principal
void biosWrite(char string[], int cant) {
  uint32_t c0 = (uint8_t)string[0];
  uint32_t c1 = (uint8_t)string[1];

  uint32_t is_long = (c1 | (0u - c1)) >> 31; // 1 si tiene 2+ caracteres
  uint32_t m = 0u - is_long;                 // máscara de "larga"

  uint32_t x = c0 ^ 8u;                   // '\b' == 8
  uint32_t not_bs = (x | (0u - x)) >> 31; // 1 si c0 != '\b'
  uint32_t opt =
      (4u & m) | ((2u - not_bs) & ~m); // 4, 1 (letra) o 2 (backspace)

  uint32_t u = (uint32_t)cant;
  uint32_t nz = (u | (0u - u)) >> 31; // 1 si cant != 0
  u += (1u - nz) & ~m;                // cant 0 -> 1, solo en carácter único

  current_display.write(string, (int)opt, (int)u);
}

// ================================================================================
// Trabajo con sitrings
// ================================================================================

// Creamos un "Pool" de buffers. Debe ser mayor o igual al QUEUE_SIZE.
#define ASCII_POOL_SIZE 8
#define ASCII_BUF_SIZE 32

static char ascii_pool[ASCII_POOL_SIZE][ASCII_BUF_SIZE];
static int current_pool_index = 0;

// Paso de int a ASCII
char *intToAscii(int num) {

  // --- INICIO SECCIÓN CRÍTICA ---
  uint32_t flags_guardadas = enterCriticalSection();

  char *ascii_buffer = ascii_pool[current_pool_index];
  current_pool_index = (current_pool_index + 1) % ASCII_POOL_SIZE;

  exitCriticalSection(flags_guardadas);
  // --- FIN SECCIÓN CRÍTICA ---

  // Apuntamos al final del buffer asignado
  char *p = ascii_buffer + ASCII_BUF_SIZE - 1;
  *p = '\0';

  // Optimización branchless del signo (compatible con logical shift):
  //   Logical shift: (uint32_t)num >> 31 extrae el bit de signo → 1 o 0.
  //   Negación unsigned: 0u - 1 = 0xFFFFFFFF, 0u - 0 = 0x00000000.
  //   mask = 0xFFFFFFFF si num < 0, mask = 0x00000000 si num >= 0.
  uint32_t is_neg = (uint32_t)num >> 31; // bit de signo: 1 o 0
  uint32_t mask = 0u - is_neg;           // expande a 0xFFFFFFFF o 0x00000000
  // abs(num) sin branch: (num XOR mask) - mask == abs(num), seguro para INT_MIN
  uint32_t uval = ((uint32_t)num ^ mask) - mask;

  // Extracción de dígitos optimizada mediante multiplicación por recíproco
  if (__builtin_expect(uval == 0, 0)) {
    *--p = '0';
  } else {
    while (uval > 0) {

      // Al multiplicar por uval, los 32 bits superiores del resultado de 64
      // bits contienen el cociente exacto tras desplazarlo.
      uint64_t prod = (uint64_t)uval * 0xCCCCCCCDULL;
      uint32_t q = (uint32_t)(prod >> 35); // q = uval / 10

      // Calculamos el residuo: r = uval - (q * 10)
      // Como 10 = (q * 8) + (q * 2), usamos desplazamientos rápidos: (q << 3) +
      // (q << 1)
      uint32_t r = uval - ((q << 3) + (q << 1));

      *--p = '0' + (char)r; // Conversión directa a ASCII
      uval = q;             // Avanzamos al siguiente dígito
    }
  }

  // Branchless: escribe '-' solo si mask != 0 (num era negativo)
  if (mask)
    *--p = '-';

  return p;
}

// Reemplazo de strcmp de string.h
int strcmp(const char *s1, const char *s2) {
  // Bucle con un único salto condicional por iteración
  while (*s1 && (*s1 == *s2)) {
    s1++;
    s2++;
  }
  // Se realiza la resta final convirtiendo a unsigned char
  // para cumplir estrictamente con el estándar ANSI C
  return *(const unsigned char *)s1 - *(const unsigned char *)s2;
}
