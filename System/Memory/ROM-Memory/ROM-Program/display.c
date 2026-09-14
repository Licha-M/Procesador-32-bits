#include "functions.h"

// Estructura de función actual
typedef struct {
  void (*write)(char word[], int option, int length);
  volatile void *registers;
} DisplayDriver;

DisplayDriver current_display;
TtyRegisters tty_ram;
GpuRegisters gpu_ram;

void initTty() {
  volatile PCIe_Map *mapa = (volatile PCIe_Map *)(TABLE_Addr);
  int offset = search(0x00700000);
  uint32_t base =
      ECAM_BASE + ((mapa[offset].bus << 20) | (mapa[offset].dev << 15) |
                   (mapa[offset].func << 12));
  ECAM_W(base, 0x04, 3); // Escribimos 0b0011 en comand. Activa DMA y TTY
}

void ttyWrite(char word[], int option, int length) {
  volatile TtyRegisters *tty =
      (volatile TtyRegisters *)current_display.registers;
  switch (option) {
  case 1:
    break;
  case 2:
    break;
  case 3:
    // Limpiar TTY
    tty->word_Addr = 0;
    tty->length = 0;
    tty->cant = 0;
    tty->comand = 3;
    break;
  case 4:
    break;
  default:
    break;
  }
}

void displaySearch() {

  if (search(0xFFFFFFFF) >= 1) {
    // Es GPU

    // initGpu(&gpu_ram);
    // current_display.write = gpuWrite;
    // current_display.registers = &gpu_ram;

  } else if (search(0x00700000) >= 1) {
    // Es TTY

    initTty();
    current_display.write = ttyWrite;
    current_display.registers = &tty_ram;

  } else // No reconocido
    return;
}

void biosWrite() {
  if (current_display.write != NULL) {
    // current_display.write();
  } else {
    displaySearch();
  }
}