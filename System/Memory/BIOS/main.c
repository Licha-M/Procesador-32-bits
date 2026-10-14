#include "bios_types.h"
#include "drivers/keyboard/keyboard.h"
#include "drivers/nvm/nvm.h"
#include "drivers/tty/tty.h"
#include "hal/ecam.h"
#include "hal/lapic.h"
#include "lib/format.h"
#include "shell/shell.h"

// Detiene el procesador de forma indefinida en un bucle con la instruccion HLT.
__attribute__((noreturn)) void final(void) {
  while (true) {
    __asm__ volatile("HLT");
  }
}

// Punto de entrada de la BIOS: inicializa interrupciones, PCIe, pantalla,
// teclado e inicia la shell.
int main(void) {
  initLAPIC();
  PCIe_Bus_Enumeration();

  if (!displaySearch())
    final();

  biosWrite("Enumeracion de buses finalizada.\n", 0);
  biosWrite("Hay ", 0);
  biosWrite(ToAscii(map_size, FMT_INT), 0);
  biosWrite(" dispositivos conectados.\n\n", 0);
  biosWrite("LAPIC e IRQs inicializadas.\n\n", 0);

  if (!nvmSearch()) {
    biosWrite("No se encontraron Memorias secundarias\n", 0);
    final();
  }

  if (!keyboardSearch()) {
    biosWrite("No hay teclado conectado\n", 0);
    final();
  }

  BiosShell();
}
