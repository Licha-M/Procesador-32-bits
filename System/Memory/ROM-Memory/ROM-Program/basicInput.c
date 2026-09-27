#include "functions.h"
#include "inter_IRQs.h"

#define MAX_LINE 256

volatile char line_buffer[MAX_LINE];
volatile int line_index = 0;
volatile bool line_ready = false;

volatile bool KeyboardDetected;

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

// IRQ del keyboard.
uint32_t keyboard_IRQHandler(uint32_t eflags, uint32_t epc) {

  // 1. Leer el carácter de tu keyboard
  char key = kb_registers->data;

  // 2. Solo procesamos si el SO no está bloqueado procesando la línea anterior
  if (!line_ready) {
    if (key == '\n' || key == '\r') {
      // --- ENTER ---
      line_buffer[line_index] = '\0'; // Terminar el string al estilo C
      line_ready = true;              // Despertar a read()

      biosWrite("\r\n", 0);

    } else if (key == '\b') {
      // --- BACKSPACE (Borrar) ---
      if (line_index > 0) {
        line_index--; // Eliminar lógicamente del buffer

        biosWrite("\b", 1);
      }

    } else {
      // --- CARÁCTER NORMAL ---
      if (line_index < MAX_LINE - 1) {
        line_buffer[line_index] = key;
        line_index++;

        // Necesitamos pasarla como string nulo-terminado para biosWrite
        char str_key[2] = {key, '\0'};
        biosWrite(str_key, 0);
      }
    }
  }

  kb_registers->comand = 0x2; // Limpiamos la IRQ

  return epc;
}

// Inicialización del keyboard
void initKeyboard(uint32_t base) {

  ECAM_W(base, 0x04, 1); // Activamos Keyboard

  // Leemos el BAR0
  uint32_t bar0 = ECAM_R(base, 0x10);
  kb_registers = (volatile KeyboardRegisters *)(uintptr_t)bar0;

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
    registerIRQHandler(KEYBOARD_MSI_NUM, keyboard_IRQHandler);

    // Escribimos la configuracion final, pero solo los 16 bits superiores
    ECAM_W(base, 0x0, msi_reg >> 16);
  }

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

  uint32_t base = ECAM_BASE | ((uint32_t)mapa[offset].bus << 20) |
                  ((uint32_t)mapa[offset].dev << 15) |
                  ((uint32_t)mapa[offset].func << 12);

  initKeyboard(base);
  return KeyboardDetected = true;
}

// Función externa para leer
int read(char *out_buffer, int max_size) {

  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));

  if (eflags & EFLAGS_EN_INTS_MASK) {

    // 1. Reiniciar el estado para una nueva lectura
    irqOff();
    line_index = 0;
    line_ready = false;
    irqOn();

    // 2. Espera hastra una lectura valida
    while (!line_ready) {
      __asm__ volatile("HLT"); // La CPU descansa hasta la próxima IRQ
    }

    // 3. Copiar los datos de la memoria volátil al buffer del programa
    int bytes_copied = 0;

    // Protegemos la copia de memoria
    irqOff();
    while (bytes_copied < (max_size - 1) && line_buffer[bytes_copied] != '\0') {
      out_buffer[bytes_copied] = line_buffer[bytes_copied];
      bytes_copied++;
    }
    out_buffer[bytes_copied] = '\0'; // Asegurar finalización de string
    irqOn();

    // 4. Devolver la cantidad de caracteres leídos
    return bytes_copied;

  } else {
    biosWrite("\nIRQs deshabilitadas. Imposible leer datos.", 0);
    __asm__ volatile("HLT");
    return 0;
  }
}