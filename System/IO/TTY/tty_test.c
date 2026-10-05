#include <stdint.h>

#define ECAM_R(base, off)                                                      \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)))
#define ECAM_W(base, off, val)                                                 \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)) =               \
       (uint32_t)(val))

#define ECAM_BASE 0xE0000000       // Base del espacio ECAM
#define MIN_BAR_POS 0xC0000000     // Base para la asignación de memoria BAR
#define LAPIC_BASE_ADDR 0xFEE00000 // Base del LAPIC

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
  ECAM_W(base, 0x04, 3);          // Escribimos el Comand

  // Configuración del dispositivo
  base = ECAM_BASE + ((1 << 20) | (0 << 15) | (0 << 12));
  ECAM_W(base, 0x10, MIN_BAR_POS); // Inicializamos BAR[0]
  ECAM_W(base, 0x04, 3);           // Activamos TTY

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

    // Escribimos la configuracion final, pero solo los 16 bits superiores
    ECAM_W(base, 0x0, msi_reg >> 16);

    ECAM_W(base, 0x4,
           LAPIC_BASE_ADDR +
               0x2C); // Le indicamos la direccion del registro MSI en LAPIC

    ECAM_W(base, 0x8, 126); // Indicamos el numero de vector
  }

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