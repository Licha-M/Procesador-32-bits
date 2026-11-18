#include "bios_types.h"
#include "drivers/keyboard/keyboard.h"
#include "drivers/nvm/nvm.h"
#include "drivers/tty/tty.h"
#include "hal/ecam.h"
#include "hal/lapic.h"
#include "lib/uefiCalls.h"
#include "shell/shell.h"

// Detiene el procesador de forma indefinida en un bucle con la instruccion HLT.
__attribute__((noreturn)) void final(void) {
  while (true) {
    __asm__ volatile("HLT");
  }
}

globalVars *Globals = NULL;

// Inicializador de variables en RAM
void initGlobalVars() {
  uint32_t *pointer = (uint32_t *)0xFFFFFFFF;
  if (allocatePages(0x00000000, BOOT_ONLY_DATA, 1, (void **)&pointer) != 0 ||
      pointer != 0x00000000)
    final();
  // Alojamos las variables globales
  if (allocatePool(BOOT_ONLY_DATA, sizeof(*Globals), (void **)&Globals) != 0)
    final();
  Globals->CantRamMB = ECAM_R(ECAM_ADDR(0, 0, 0), 0x4);
}

// Punto de entrada de la BIOS: inicializa interrupciones, PCIe, pantalla,
// teclado e inicia la shell.
int main(void) {

  // Testeamos la RAM e inicializamos variables
  if (ECAM_R(ECAM_ADDR(0, 0, 0), 0x0) == 0xFFFFFFFF)
    final();
  else
    initGlobalVars();

  initLAPIC();

  PCIe_Bus_Enumeration();

  if (!displaySearch())
    final();

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
