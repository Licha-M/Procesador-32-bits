#include "functions.h"
#include "inter_IRQs.h"

// ============================================================
// Auxiliary Functions
// ============================================================

// Apagar las IRQs
void irqOff() {
  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  uint32_t eflags_off = eflags & ~EFLAGS_EN_INTS_MASK;
  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_off));
}

void irqOn() {
  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  uint32_t eflags_on = eflags | EFLAGS_EN_INTS_MASK;
  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_on));
}

// ============================================================
// Excepciones
// ============================================================

// Error de paginas
uint32_t pageFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true; // Habilitamos la via de impresion sin IRQs
  biosWrite("\nFatal Error: Page Fault without MMU", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Error de alineamiento
uint32_t alignamentFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true; // Habilitamos la via de impresion sin IRQs
  biosWrite("\nFatal Error: Alignament Fault", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Error por instruccion sin privilegios
uint32_t generalProtectionFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true; // Habilitamos la via de impresion sin IRQs
  biosWrite("\nFatal Error: General Protection Fault", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Error por instrucciones desconocida
uint32_t invalidOpCode(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true; // Habilitamos la via de impresion sin IRQs
  biosWrite("\nFatal Error: Invalid OpCode", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Double Fault
uint32_t doubleFault(uint32_t eflags, uint32_t epc) {
  (void)eflags;
  irqOff();
  system_panic = true; // Habilitamos la via de impresion sin IRQs
  biosWrite("\nFatal Error: Double Fault", 0);
  __asm__ volatile("HLT");
  return epc;
}

// ============================================================
// IRQs
// ============================================================

uint32_t syscallsHandler(uint32_t eflags, uint32_t epc) { return epc + 4; }