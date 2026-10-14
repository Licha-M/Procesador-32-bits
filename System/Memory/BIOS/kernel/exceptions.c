#include "exceptions.h"
#include "../hal/lapic.h"
#include "../drivers/tty/tty.h"
#include "../bios_types.h"

// Manejador de la excepcion Page Fault (fallo de pagina): imprime error fatal y detiene la CPU.
uint32_t pageFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true;
  biosWrite("\nFatal Error: Page Fault without MMU", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Manejador de la excepcion Alignment Fault (acceso desalineado): imprime error fatal y detiene la CPU.
uint32_t alignamentFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true;
  biosWrite("\nFatal Error: Alignament Fault", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Manejador de la excepcion General Protection Fault: imprime error fatal y detiene la CPU.
uint32_t generalProtectionFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true;
  biosWrite("\nFatal Error: General Protection Fault", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Manejador de la excepcion Invalid OpCode (instruccion no valida): imprime error fatal y detiene la CPU.
uint32_t invalidOpCode(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true;
  biosWrite("\nFatal Error: Invalid OpCode", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Manejador de la excepcion Double Fault (doble fallo): imprime error fatal y detiene la CPU.
uint32_t doubleFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true;
  biosWrite("\nFatal Error: Double Fault", 0);
  __asm__ volatile("HLT");
  return epc;
}
