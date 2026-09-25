#include "functions.h"

// Estructura de función actual
typedef struct {
  void (*write)(char word[], int option, int length);
  volatile void *registers;
  uint32_t ecam_base; // Base ECAM del dispositivo de display activo
} DisplayDriver;

DisplayDriver current_display;

// Estructura registros TTY
typedef struct {
  volatile uint32_t comand;
  volatile uint32_t word_Addr;
  volatile uint32_t length;
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

  tty->cant = 0;
  tty->length = 0;
  tty->word_Addr = 0;

  switch (req->option) {
  case 1:
    // Escribir una letra
    tty->cant = req->length;
    tty->word_Addr = req->data[0];
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
    tty->length = req->length;
    tty->word_Addr = (uintptr_t)req->data;
    tty->comand = req->option;
    break;
  default:
    tty->comand = 0;
    break;
  }
}

// Handler del TTY
uint32_t tty_IRQHandler(uint32_t eflags, uint32_t epc) {

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

// Función principal que encola las peticiones (Llamada por biosWrite)
void ttyWrite(char word[], int option, int length) {

  if (system_panic) {
    // El sistema está abortando (excepción fatal): no podemos darnos el
    // lujo de esperar la cola ni la IRQ del TTY, porque esa IRQ podría
    // no volver a dispararse nunca (deadlock irrecuperable). Pisamos
    // cualquier operación en curso y escribimos directo al hardware.
    DisplayRequest panic_req = {
        .data = word, .option = option, .length = length};
    tty_execute_request(&panic_req);
    return;
  }

  // Esperamos a la IRQ del TTY
  while (display_queue.count >= QUEUE_SIZE) {
    __asm__ volatile("HLT");
  }

  // 1. Guardamos el estado real de SR8 antes de tocarlo.
  uint32_t flags_guardadas;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(flags_guardadas));

  irqOff(); // --- INICIO SECCIÓN CRÍTICA ---

  // Guardamos los datos en la cola
  display_queue.items[display_queue.tail].data = word;
  display_queue.items[display_queue.tail].option = option;
  display_queue.items[display_queue.tail].length = length;

  display_queue.tail = (display_queue.tail + 1) % QUEUE_SIZE;
  display_queue.count++;

  // Si el hardware estaba inactivo, lo activamos
  if (!hardware_busy) {
    hardware_busy = true;
    tty_execute_request(&display_queue.items[display_queue.head]);
  }

  // 3. Restauramos el valor exacto que guardamos
  __asm__ __volatile__("CYR %0, SR8" : : "r"(flags_guardadas));
  // --- FIN SECCIÓN CRÍTICA ---
}

// Inicializador del TTY
void initTty(uint32_t base) {
  // Inicializamos las variables de la cola
  display_queue.head = 0;
  display_queue.tail = 0;
  display_queue.count = 0;
  hardware_busy = false;

  ECAM_W(base, 0x04, 3); // Activa DMA y TTY

  // Leemos el BAR0
  uint32_t bar0 = ECAM_R(base, 0x10);
  current_display.registers = (volatile void *)(uintptr_t)bar0;

  base = base + ECAM_R(base, 0x24); // Base es igual a la direccion 0 del CP

  if ((ECAM_R(base, 0x0) & 0xFF) == 0x5) {

    // MSI suported
    int cantREQ = (ECAM_R(base, 0x0) >> 16) &
                  0x7; // Extraemos la cantidad de IRQ requeridas

    ECAM_W(base, 0x0,
           ECAM_R(base, 0x0) |
               (cantREQ << 24)); // Le damos las IRQ que nesesite

    ECAM_W(base, 0x4,
           LAPIC_BASE_ADDR +
               0x2C); // Le indicamos la direccion del registro MSI en LAPIC

    ECAM_W(base, 0x8, 127); // Indicamos el numero de vector

    ECAM_W(base, 0x0, ECAM_R(base, 0x0) | (0x1 << 19)); // Habilitamos las MSI

    // Asignamos vector
    registerIRQHandler(127, tty_IRQHandler);
  }
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

// Busqueda de TTY o GPU
void displaySearch() {

  if (false) {
    // Es GPU

    // initGpu(base);
    // current_display.write = gpuWrite;
    // current_display.ecam_base = base;

  } else {
    // Es TTY
    int offset = search(0x00070000); // Buscamos TTY por su Class Code
    if (offset < 0)
      return; // No reconocido
    uint32_t base = ECAM_BASE | ((uint32_t)mapa[offset].bus << 20) |
                    ((uint32_t)mapa[offset].dev << 15) |
                    ((uint32_t)mapa[offset].func << 12);

    initTty(base);
    current_display.ecam_base = base;
    current_display.write = ttyWrite;
  }
}

size_t strlen(const char *str) {
  const char *end = str;
  while (*end != '\0') {
    end++;
  }
  return (size_t)(end - str);
}

// Función principal
void biosWrite(char string[], int cant) {

  if (current_display.write != NULL) {
    if (string[0] == '\0' && cant >= 1) {
      // Borrar
      current_display.write("", 2, cant);

    } else if (string[0] == '\0' && cant == 0) {
      // Limpiar
      current_display.write("", 3, 0);
    } else if (string[1] == '\0') {
      // Escribir una letra
      if (cant == 0) {
        cant++; // Se le suma 1 para indicar que se debe escribir 1 vez
      }
      current_display.write(string, 1, cant);

    } else {
      // Escribir un texto en RAM
      cant = strlen(string);
      current_display.write(string, 4, cant);
    }
  }
}

// ================================================================================
// Conversión de entero a ASCII
// ================================================================================

// Creamos un "Pool" de buffers. Debe ser mayor o igual al QUEUE_SIZE.
#define ASCII_POOL_SIZE 8
#define ASCII_BUF_SIZE 32

static char ascii_pool[ASCII_POOL_SIZE][ASCII_BUF_SIZE];
static int current_pool_index = 0;

char *intToAscii(int num) {
  // --- INICIO SECCIÓN CRÍTICA ---
  // Guardamos el estado de las IRQs y las apagamos para que la rotación sea
  // 100% atómica
  uint32_t flags_guardadas;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(flags_guardadas));
  irqOff();

  char *ascii_buffer = ascii_pool[current_pool_index];
  current_pool_index = (current_pool_index + 1) % ASCII_POOL_SIZE;

  // Restauramos el estado original de las IRQs (por si ya estaban apagadas)
  __asm__ __volatile__("CYR %0, SR8" : : "r"(flags_guardadas));
  // --- FIN SECCIÓN CRÍTICA ---

  char *p = ascii_buffer + ASCII_BUF_SIZE - 1;
  *p = '\0'; // Fin de cadena

  uint32_t uval;
  int is_negative = 0;

  if (num < 0) {
    is_negative = 1;
    uval = -(uint32_t)num;
  } else {
    uval = (uint32_t)num;
  }

  // Extracción de dígitos de atrás hacia adelante
  if (uval == 0) {
    *--p = '0';
  } else {
    while (uval > 0) {
      *--p = '0' + (uval % 10);
      uval /= 10;
    }
  }

  if (is_negative) {
    *--p = '-';
  }

  return p; // Devuelve el puntero exacto dentro del búfer
}
