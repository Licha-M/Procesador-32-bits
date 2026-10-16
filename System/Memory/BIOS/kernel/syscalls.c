#include "syscalls.h"

// Manejador de llamadas al sistema (syscalls): retorna el EPC incrementado en 4 para saltar la instruccion de llamada.
uint32_t syscallsHandler(uint32_t *regs, uint32_t eflags, uint32_t epc) {
  (void)regs;
  (void)eflags;
  return epc + 4;
}
