#include "keyboard.h"
#include "../../hal/ecam.h"
#include "../../hal/lapic.h"
#include "../tty/tty.h"
#include <stddef.h>

#define MAX_LINE 256
volatile char line_buffer[MAX_LINE];
volatile int line_index = 0;
volatile bool line_ready = false;
volatile bool KeyboardDetected;

#define KEYQ_SIZE 64
#define KEYQ_MASK (KEYQ_SIZE - 1)
static volatile char key_queue[KEYQ_SIZE];
static volatile uint8_t kq_head = 0;
static volatile uint8_t kq_tail = 0;

typedef struct {
  volatile uint32_t comand;
  volatile uint32_t data;
} KeyboardRegisters;
static volatile KeyboardRegisters *kb_registers;

// Manejador de la interrupcion (IRQ) del teclado: lee el caracter recibido y lo
// encola.
uint32_t keyboard_IRQHandler(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  char key = kb_registers->data;
  // Envia comando 0x2 para limpiar/confirmar la interrupcion en el controlador
  // de teclado.
  kb_registers->comand = 0x2;
  // Calcula la siguiente posicion en la cola circular usando mascara de bits
  // (modulo rapido).
  uint8_t next = (kq_head + 1) & KEYQ_MASK;
  if (next != kq_tail) {
    key_queue[kq_head] = key;
    kq_head = next;
  }
  return epc;
}

// Detiene la CPU temporalmente con HLT a la espera de una interrupcion de
// teclado.
static inline void waitForKey(void) { __asm__ volatile("HLT"); }

// Configura el dispositivo de teclado PCIe: mapea sus registros MMIO y activa
// MSI.
static void initKeyboard(uint32_t base) {
  ECAM_W(base, 0x04, 1);
  // Lee la direccion base fisica (BAR0) asignada al teclado en la configuracion
  // PCIe.
  uint32_t bar0 = ECAM_R(base, 0x10);
  // Mapea la estructura de registros a la direccion obtenida de BAR0.
  kb_registers = (volatile KeyboardRegisters *)(uintptr_t)bar0;
  initMSI(base, KEYBOARD_MSI_NUM, keyboard_IRQHandler);
  kb_registers->comand = 1;
}

// Busca el dispositivo de teclado en el arbol PCIe por su Class Code y lo
// inicializa.
bool keyboardSearch(void) {
  int offset = search(0x00090000);
  if (offset < 0)
    return KeyboardDetected = false;
  uint32_t base =
      ECAM_ADDR(mapa[offset].bus, mapa[offset].dev, mapa[offset].func);
  initKeyboard(base);
  return KeyboardDetected = true;
}

// Lee una linea de texto desde el teclado hasta presionar Enter, gestionando
// eco y backspace.
int readInput(char *out_buffer, int max_size) {
  if (out_buffer == NULL || max_size <= 0)
    return -1;
  out_buffer[0] = '\0';
  uint32_t eflags;
  // Lee el registro de estado SR8 (eflags) del procesador.
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  // Verifica si el bit de interrupciones habilitadas esta activo; si no, no se
  // pueden recibir teclas.
  if (!(eflags & EFLAGS_EN_INTS_MASK)) {
    biosWrite("\nIRQs deshabilitadas. Imposible leer datos.\n", 0);
    return -1;
  }
  int n = 0;
  int echoed_n = 0;
  bool done = false;
  while (!done) {
    // Si la cola circular esta vacia, suspende la CPU hasta que ocurra una IRQ.
    while (kq_tail == kq_head)
      waitForKey();
    while (!done && kq_tail != kq_head) {
      char key = key_queue[kq_tail];
      // Avanza el indice de lectura de la cola circular.
      kq_tail = (kq_tail + 1) & KEYQ_MASK;
      if (key == '\n' || key == '\r') {
        // Si viene una secuencia CRLF (\r\n), descarta el '\n' siguiente para
        // evitar saltos dobles.
        if (key == '\r' && kq_tail != kq_head && key_queue[kq_tail] == '\n') {
          kq_tail = (kq_tail + 1) & KEYQ_MASK;
        }
        done = true;
        break;
      } else if (key == '\b' || key == 127) {
        if (n > 0) {
          n--;
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
