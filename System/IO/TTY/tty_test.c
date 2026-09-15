#include <stdint.h>

#define ECAM_R(base, off)                                                      \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)))
#define ECAM_W(base, off, val)                                                 \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)) =               \
       (uint32_t)(val))

#define ECAM_BASE 0xE0000000   // Base del espacio ECAM
#define MIN_BAR_POS 0xC0000000 // Base para la asignación de memoria BAR

// Estructura registros TTY
typedef struct {
  volatile uint32_t comand;
  volatile uint32_t word_Addr;
  volatile uint32_t length;
  volatile uint32_t cant;
} TtyRegisters;

int main() {

  // Configuración del puerto
  uintptr_t base = ECAM_BASE + ((0 << 20) | (1 << 15) | (0 << 12));
  ECAM_W(base, 0x18, 0xC000C000); // Escribimos Limit y Base
  ECAM_W(base, 0x10, 0x00010100); // Escribimos PSS
  ECAM_W(base, 0x04, 1);          // Escribimos el Comand

  // Configuración del dispositivo
  base = ECAM_BASE + ((1 << 20) | (0 << 15) | (0 << 12));
  ECAM_W(base, 0x10, MIN_BAR_POS); // Inicializamos BAR[0]
  ECAM_W(base, 0x04, 3);           // Activamos TTY
  volatile TtyRegisters *tty = (volatile TtyRegisters *)MIN_BAR_POS;

  // Escritura

  tty->word_Addr = 72;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 111;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 108;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 97;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 32;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 77;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 117;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 110;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 100;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 111;
  tty->cant = 1;
  tty->comand = 1;
  __asm__ volatile("NOP");
  __asm__ volatile("NOP");
  tty->word_Addr = 33;
  tty->cant = 3;
  tty->comand = 1;

  // Fin
  __asm__ volatile("HLT");
}