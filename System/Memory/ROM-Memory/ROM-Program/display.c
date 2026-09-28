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

  tty->cant = 0;
  tty->length = 0;
  tty->word_Addr = 0;

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
    // El sistema está abortando no se inicia más.
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
    uint32_t msi_reg = ECAM_R(base, 0x0);

    int cantREQ = (msi_reg >> 17) &
                  0x7; // Extraemos la cantidad de IRQ requeridas (Bits 17-19)

    // Limpiamos los bits superiores (16-31) para quitar valores residuales
    msi_reg &= 0x0000FFFF;

    // Le damos las IRQ que necesite en la "Cantidad dada" (Bits 20-22)
    msi_reg |= (cantREQ << 20);

    // Habilitamos las MSI (Bit 16)
    msi_reg |= (0x1 << 16);

    ECAM_W(base, 0x4,
           LAPIC_BASE_ADDR +
               0x2C); // Le indicamos la direccion del registro MSI en LAPIC

    ECAM_W(base, 0x8, TTY_MSI_NUM); // Indicamos el numero de vector

    // Asignamos vector
    registerIRQHandler(TTY_MSI_NUM, tty_IRQHandler);

    // Escribimos la configuracion final, pero solo los 16 bits superiores
    ECAM_W(base, 0x0, msi_reg >> 16);
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
bool displaySearch() {

  if (false) {
    // Es GPU

    // initGpu(base);
    // current_display.write = gpuWrite;
    // current_display.ecam_base = base;

  } else {
    // Es TTY
    int offset = search(0x00070000); // Buscamos TTY por su Class Code
    if (offset < 0)
      return DisplayDetected = false; // No reconocido

    uint32_t base = ECAM_BASE | ((uint32_t)mapa[offset].bus << 20) |
                    ((uint32_t)mapa[offset].dev << 15) |
                    ((uint32_t)mapa[offset].func << 12);

    initTty(base);
    current_display.ecam_base = base;
    current_display.write = ttyWrite;
    return DisplayDetected = true;
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

  if (string[0] == '\b') {
    // Borrar
    if (cant == 0) {
      cant++;
    }
    current_display.write(string, 2, cant);

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
  uint32_t flags_guardadas;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(flags_guardadas));
  irqOff();

  char *ascii_buffer = ascii_pool[current_pool_index];
  current_pool_index = (current_pool_index + 1) % ASCII_POOL_SIZE;

  __asm__ __volatile__("CYR %0, SR8" : : "r"(flags_guardadas));
  // --- FIN SECCIÓN CRÍTICA ---

  // Apuntamos al final del buffer asignado
  char *p = ascii_buffer + ASCII_BUF_SIZE - 1;
  *p = '\0';

  uint32_t uval;
  int is_negative = 0;

  if (num < 0) {
    is_negative = 1;
    uval = -(uint32_t)num; // Seguro para INT_MIN
  } else {
    uval = (uint32_t)num;
  }

  // Extracción de dígitos optimizada mediante multiplicación por recíproco
  if (uval == 0) {
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

  if (is_negative) {
    *--p = '-';
  }

  return p;
}
