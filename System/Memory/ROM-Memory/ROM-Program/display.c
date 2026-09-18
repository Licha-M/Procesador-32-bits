#include "functions.h"

// Estructura de función actual
typedef struct {
  void (*write)(char word[], int option, int length);
  volatile void *registers;
  uint32_t ecam_base; // Base ECAM del dispositivo de display activo
} DisplayDriver;

DisplayDriver current_display;
// GpuRegisters gpu_ram;

// ================================================================================
// Sección para TTY
// ================================================================================

void initTty(uint32_t base) {
  ECAM_W(base, 0x04, 3); // Escribimos 0b0011 en comand. Activa DMA y TTY

  // Leemos el BAR0 (offset 0x10)
  uint32_t bar0 = ECAM_R(base, 0x10);
  current_display.registers = (volatile void *)(uintptr_t)bar0;
}

void ttyWrite(char word[], int option, int length) {
  volatile TtyRegisters *tty =
      (volatile TtyRegisters *)current_display.registers;
  uint32_t cmd_status = ECAM_R(current_display.ecam_base, 0x04);

  if (((cmd_status & 0xFFFF0000) >> 16) == 0) {
    tty->cant = 0;
    tty->length = 0;
    tty->word_Addr = 0;

    switch (option) {
    case 1:
      // Escribir una letra
      tty->cant = length;
      tty->word_Addr = word[0];
      tty->comand = option;
      return;
    case 2:
      // Borrar
      tty->cant = length;
      tty->comand = option;
      return;
    case 3:
      // Limpiar TTY
      tty->comand = option;
      return;
    case 4:
      tty->length = length;
      tty->word_Addr = (uintptr_t)word;
      tty->comand = option;
      return;
    default:
      tty->comand = 0;
      return;
    }
  }
  return;
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

    volatile PCIe_Map *mapa = (volatile PCIe_Map *)(TABLE_Addr);
    uint32_t base = ECAM_BASE | ((uint32_t)mapa[offset].bus << 20) |
                    ((uint32_t)mapa[offset].dev << 15) |
                    ((uint32_t)mapa[offset].func << 12);

    initTty(base);
    current_display.ecam_base = base;
    current_display.write = ttyWrite;
  }
}

size_t strlen(const char *str) {
  size_t longitud = 0;

  // Recorremos hasta encontrar '\0'
  while (str[longitud] != '\0') {
    longitud++;
  }

  return longitud;
}

void biosWrite(char string[], int cant) {

  if (string[0] == '\0' && cant >= 1) {
    // Borrar
    current_display.write("", 2, cant);

  } else if (string[0] == '\0' && cant == 0) {
    // Limpiar
    current_display.write("", 3, 0);
  } else if (string[1] == '\0') {
    // Escribir una letra
    current_display.write(string, 1, cant);
  } else {
    // Escribir un texto en RAM
    cant = strlen(string);
    current_display.write(string, 4, cant);
  }
  return;
}