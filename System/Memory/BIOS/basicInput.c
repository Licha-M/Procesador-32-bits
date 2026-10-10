#include "functions.h"
#include "inter_IRQs.h"

#define MAX_LINE 256

volatile char line_buffer[MAX_LINE];
volatile int line_index = 0;
volatile bool line_ready = false;

volatile bool KeyboardDetected;

#define KEYQ_SIZE 64 // potencia de 2
#define KEYQ_MASK (KEYQ_SIZE - 1)

static volatile char key_queue[KEYQ_SIZE];
static volatile uint8_t kq_head = 0; // escribe solo la IRQ
static volatile uint8_t kq_tail = 0; // escribe solo read()

// ============================================================
// Structs definitions
// ============================================================

typedef struct {
  volatile uint32_t comand;
  volatile uint32_t data;
} KeyboardRegisters;

volatile KeyboardRegisters *kb_registers;

// ============================================================
// Intern functions
// ============================================================

// IRQ del keyboard: solo encola, no escribe en pantalla ni espera nada.
uint32_t keyboard_IRQHandler(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  char key = kb_registers->data;
  kb_registers->comand = 0x2; // Limpiamos la IRQ del teclado

  uint8_t next = (kq_head + 1) & KEYQ_MASK;
  if (next != kq_tail) { // si está llena, se descarta la tecla
    key_queue[kq_head] = key;
    kq_head = next;
  }
  return epc;
}

static inline void waitForKey(void) {
  __asm__ volatile("HLT"); // TODO: hacerlo atómico según la ISA
}

// Inicialización del keyboard
void initKeyboard(uint32_t base) {

  ECAM_W(base, 0x04, 1); // Activamos Keyboard

  // Leemos el BAR0
  uint32_t bar0 = ECAM_R(base, 0x10);
  kb_registers = (volatile KeyboardRegisters *)(uintptr_t)bar0;

  initMSI(base, KEYBOARD_MSI_NUM, keyboard_IRQHandler);

  kb_registers->comand = 1; // Limpiamos el teclado por si acaso
}

// ============================================================
// Extern functions
// ============================================================

// Busqueda de keyboard
bool keyboardSearch() {
  int offset = search(0x00090000); // Buscamos Keyboard por su Class Code
  if (offset < 0)
    return KeyboardDetected = false; // No reconocido

  uint32_t base =
      ECAM_ADDR(mapa[offset].bus, mapa[offset].dev, mapa[offset].func);

  initKeyboard(base);
  return KeyboardDetected = true;
}

// Función externa para leer
int read(char *out_buffer, int max_size) {
  if (out_buffer == NULL || max_size <= 0)
    return -1;
  out_buffer[0] = '\0'; // Punto 3: nunca devolvemos basura

  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  if (!(eflags & EFLAGS_EN_INTS_MASK)) {
    biosWrite("\nIRQs deshabilitadas. Imposible leer datos.\n", 0);
    return -1;
  }

  int n = 0;
  int echoed_n = 0; // Caracteres de out_buffer ya mostrados en pantalla
  bool done = false;

  while (!done) {
    // Esperamos a que haya al menos un carácter disponible
    while (kq_tail == kq_head)
      waitForKey();

    // Drenamos todo lo disponible actualmente en la cola
    while (!done && kq_tail != kq_head) {
      char key = key_queue[kq_tail];
      kq_tail = (kq_tail + 1) & KEYQ_MASK;

      if (key == '\n' || key == '\r') {
        if (key == '\r' && kq_tail != kq_head && key_queue[kq_tail] == '\n') {
          kq_tail = (kq_tail + 1) & KEYQ_MASK;
        }
        done = true;
        break;
      } else if (key == '\b' || key == 127) {
        if (n > 0) {
          n--;
          // Si el carácter borrado ya había sido mostrado en pantalla, lo borramos visualmente
          if (echoed_n > n) {
            echoed_n = n;
            biosWrite("\b", 1);
          }
        }
      } else if ((unsigned char)key >= 32 && (unsigned char)key < 127) {
        if (n < max_size - 1) {
          out_buffer[n++] = key;
        }
      }
    }

    // Volcado de caracteres acumulados a pantalla:
    // - Si el usuario escribió tecla por tecla (esperando el HLT), habrá 1 carácter y se refleja de inmediato.
    // - Si el usuario escribió de golpe / ráfaga, se procesan todos en memoria y se muestran juntos en una sola llamada.
    if (n > echoed_n) {
      out_buffer[n] = '\0';
      biosWrite(&out_buffer[echoed_n], 0);
      echoed_n = n;
    }
  }

  out_buffer[n] = '\0';
  biosWrite("\n", 0);
  return n;
}