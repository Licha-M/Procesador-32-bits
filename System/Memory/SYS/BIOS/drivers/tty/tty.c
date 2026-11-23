#include "tty.h"
#include "../../bios_types.h"
#include "../../hal/ecam.h"
#include "../../hal/lapic.h"
#include "../../lib/uefiCalls.h"

// Primera direccion de la ROM en el mapa fisico (la ROM ocupa desde aqui hasta
// el final del espacio de 32 bits; la RAM va de 0x00000000 a ROM_BASE).
#ifndef ROM_BASE
#define ROM_BASE 0xFFF00000u
#endif

// Tamano de cada buffer de rebote (incluye el '\0'). Las cadenas en ROM mas
// largas se envian en varios trozos. El string mas largo actual mide 69 B.
#define BOUNCE_SIZE 128

typedef struct {
  void (*write)(char word[], int option, int length);
  volatile void *registers;
  uint32_t ecam_base;
  volatile bool hardware_busy;
} DisplayDriver;

static DisplayDriver *current_display;

typedef struct {
  volatile uint32_t comand;
  volatile uint32_t word_Addr;
  volatile uint32_t cant;
} TtyRegisters;

#define QUEUE_SIZE 4

typedef struct {
  const char *data;
  char char_data;
  int option;
  int length;
} DisplayRequest;

typedef struct {
  DisplayRequest items[QUEUE_SIZE];
  volatile uint8_t head, tail, count;
  char bounce[QUEUE_SIZE][BOUNCE_SIZE] __attribute__((aligned(64)));
  char panic_bounce[BOUNCE_SIZE] __attribute__((aligned(64)));
} RequestQueue;

static RequestQueue *display_queue;

// Indica si un puntero apunta a ROM (inaccesible para el periferico).
static inline bool in_rom(const char *p) { return (uintptr_t)p >= ROM_BASE; }

#define HAS_ZERO(w) ((((w) - 0x01010101U) & ~(w) & 0x80808080U) != 0)

// Copia palabras desde *srcp (alineado a 4). Devuelve true si el string
// termino (la palabra con el '\0' ya esta copiada); si no, avanza *srcp.
static bool copy_to_bounce(char *dst, const char **srcp) {
  const uint32_t *s = (const uint32_t *)*srcp;
  uint32_t *d = (uint32_t *)dst;
  const uint32_t n = BOUNCE_SIZE / 4 - 1; // deja 1 palabra para el cero
  for (uint32_t i = 0; i < n; i++) {
    uint32_t w = s[i];
    d[i] = w;
    if (HAS_ZERO(w)) {
      d[i + 1] = 0; // por si el TTY corta en palabra cero
      return true;
    }
  }
  d[n] = 0;
  *srcp += n * 4;
  return false;
}

// Envia una solicitud de comando y parametros a los registros MMIO del
// controlador de pantalla.
static void tty_execute_request(DisplayRequest *req) {
  volatile TtyRegisters *tty =
      (volatile TtyRegisters *)current_display->registers;
  switch (req->option) {
  case 1:
    tty->cant = req->length;
    tty->word_Addr = req->char_data;
    tty->comand = req->option;
    break;
  case 2:
    tty->cant = req->length;
    tty->comand = req->option;
    break;
  case 3:
    tty->comand = req->option;
    break;
  case 4:
    tty->word_Addr = (uintptr_t)req->data;
    tty->comand = req->option;
    break;
  default:
    tty->comand = 0;
    break;
  }
}

// Manejador de interrupcion del TTY: se invoca al finalizar una operacion y
// despacha la siguiente si la cola no esta vacia.
static uint32_t tty_IRQHandler(uint32_t eflags, uint32_t epc, uint32_t cause) {
  display_queue->head = (display_queue->head + 1) % QUEUE_SIZE;
  display_queue->count--;
  if (__builtin_expect(display_queue->count > 0, 0)) {
    tty_execute_request(&display_queue->items[display_queue->head]);
  } else {
    current_display->hardware_busy = false;
  }
  return epc;
}

// Evalua de forma branchless si la operacion requiere esperar interrupciones
// hardware.
static inline bool tty_requires_irq(int option, int length) {
  uint32_t opt = (uint32_t)option;
  // Comprueba si es opcion >= 4 (escritura de bloque o cadena larga).
  uint32_t is_long_op = opt >> 2;
  // Comprueba si es opcion 3 (limpiar pantalla, no requiere IRQ prolongada por
  // longitud).
  uint32_t is_op3 = (uint32_t)(opt == 3);
  // Determina si la longitud a escribir es mayor a un caracter.
  uint32_t len_gt1 = (uint32_t)(length > 1);
  // Requiere IRQ si es operacion larga, o si no es comando 3 y la longitud
  // supera 1.
  return (bool)(is_long_op | ((1u - is_op3) & len_gt1));
}

// Envia peticiones de impresion/control al TTY, usando envio directo o
// encolamiento con IRQ segun corresponda. Las cadenas (opcion 4) que viven en
// ROM se copian antes a un buffer de RAM, porque el periferico no puede leer
// la ROM.
static void ttyWrite(char word[], int option, int length) {
  // En caso de panico del sistema, procesa de forma directa e inmediata para
  // asegurar el volcado del mensaje. No usa el asignador ni la cola; los
  // mensajes de panico en ROM se truncan a BOUNCE_SIZE-4 bytes.
  if (__builtin_expect(Globals->system_panic, 0)) {
    const char *src = word;
    if (option == 4 && in_rom(word)) {
      const char *p = word;
      copy_to_bounce(display_queue->panic_bounce, &p);
      src = display_queue->panic_bounce;
    }
    DisplayRequest panic_req = {
        .data = src, .char_data = word[0], .option = option, .length = length};
    tty_execute_request(&panic_req);
    return;
  }
  // Las opciones < 4 no pasan punteros al periferico (solo char_data), por lo
  // que nunca necesitan buffer de rebote.
  if (!tty_requires_irq(option, length)) {
    while (current_display->hardware_busy) {
      __asm__ volatile("HLT");
    }
    // Protege la seccion critica deshabilitando IRQs durante la emision directa
    // del comando.
    uint32_t flags_guardadas = enterCriticalSection();
    DisplayRequest direct_req = {
        .data = word, .char_data = word[0], .option = option, .length = length};
    tty_execute_request(&direct_req);
    exitCriticalSection(flags_guardadas);
    return;
  }

  bool rom_str = (option == 4) && in_rom(word);
  const char *rom_src = word; // cursor de lectura en ROM (alineado a 4)
  bool more = false;          // true si quedan trozos de la cadena por enviar
  // Si la cadena esta en ROM se envia en trozos de hasta BOUNCE_SIZE-4 bytes;
  // si esta en RAM se envia entera, una sola vez.
  do {
    while (display_queue->count >= QUEUE_SIZE) {
      __asm__ volatile("HLT");
    }
    // Protege la manipulacion concurrente de la cola circular de peticiones
    // frente al IRQ handler.
    uint32_t flags_guardadas = enterCriticalSection();
    uint8_t slot = display_queue->tail;
    const char *src = word;
    if (rom_str) {
      // copy_to_bounce devuelve true cuando copio la palabra con el '\0'.
      more = !copy_to_bounce(display_queue->bounce[slot], &rom_src);
      src = display_queue->bounce[slot];
    }
    display_queue->items[slot].data = src;
    display_queue->items[slot].char_data = src[0];
    display_queue->items[slot].option = option;
    display_queue->items[slot].length = length;
    display_queue->tail = (slot + 1) % QUEUE_SIZE;
    display_queue->count++;
    if (!current_display->hardware_busy) {
      current_display->hardware_busy = true;
      tty_execute_request(&display_queue->items[display_queue->head]);
    }
    exitCriticalSection(flags_guardadas);
  } while (more);
}

// Configura el hardware de pantalla: resetea la cola, mapea BAR0 y registra el
// vector MSI del TTY.
static void initTty(uint32_t base) {
  void *raw;
  if (allocatePool(DEVICE_QUEUES, sizeof(RequestQueue) + 63, &raw) != 0)
    final();
  display_queue = (RequestQueue *)(((uintptr_t)raw + 63) & ~(uintptr_t)63);

  display_queue->head = 0;
  display_queue->tail = 0;
  display_queue->count = 0;
  current_display->hardware_busy = false;
  ECAM_W(base, 0x04, 3);
  uint32_t bar0 = ECAM_R(base, 0x10);
  current_display->registers = (volatile void *)(uintptr_t)bar0;
  initMSI(base, TTY_MSI_NUM, tty_IRQHandler);
}

// Busca el dispositivo de pantalla en el arbol PCIe por su Class Code y vincula
// su funcion de escritura.
bool displaySearch(void) {
  bool DisplayDetected;

  int offset = searchFirst(0x00070000);
  if (offset < 0)
    return DisplayDetected = false;
  uint32_t base =
      ECAM_ADDR(mapa[offset].bus, mapa[offset].dev, mapa[offset].func);

  if (allocatePool(DEVICE_DATA, sizeof(*current_display),
                   (void **)&current_display) != 0)
    final();

  initTty(base);

  current_display->ecam_base = base;
  current_display->write = ttyWrite;
  return DisplayDetected = true;
}

// Limpia la pantalla completa de la terminal enviando el comando 3.
void biosClear(void) { current_display->write(0, 3, 0); }

// Escribe texto en la pantalla determinando de forma branchless el comando y
// longitud adecuados.
void biosWrite(char string[], int cant) {
  uint32_t c0 = (uint8_t)string[0];
  uint32_t c1 = (uint8_t)string[1];
  // Determina si la cadena tiene 2 o mas caracteres: (x | -x) >> 31 es 1 si x
  // != 0, 0 si x == 0.
  uint32_t is_long = (c1 | (0u - c1)) >> 31;
  // Genera mascara de bits: 0xFFFFFFFF si es cadena larga, 0x0 si es un solo
  // caracter.
  uint32_t m = 0u - is_long;
  // Comprueba si el primer caracter es backspace ('\b', ASCII 8).
  uint32_t x = c0 ^ 8u;
  // not_bs vale 1 si NO es backspace, y 0 si ES backspace.
  uint32_t not_bs = (x | (0u - x)) >> 31;
  // Calcula la opcion sin saltos condicionales: opcion 4 si es cadena, 1 si es
  // caracter normal, o 2 si es backspace.
  uint32_t opt = (4u & m) | ((2u - not_bs) & ~m);
  uint32_t u = (uint32_t)cant;
  // Comprueba si la cantidad pasada es distinta de cero.
  uint32_t nz = (u | (0u - u)) >> 31;
  // Si la cantidad era 0 y no es cadena larga, asigna cantidad 1 por defecto.
  u += (1u - nz) & ~m;
  current_display->write(string, (int)opt, (int)u);
}