#ifndef INTER_IRQS_H
#define INTER_IRQS_H

#include <stdbool.h>
#include <stdint.h>

// ============================================================
// Auxiliary Definitions
// ============================================================

void final();

// Estructura del registro Especial Flags (SR8)
typedef union {
  uint8_t eflags;
  struct {
    uint8_t Actual_KMode : 1;
    uint8_t Previous_KMode : 1;
    uint8_t Actual_INTs : 1;
    uint8_t Previous_INTs : 1;
    uint8_t resto : 4;
  } bits;
} ControlFlags;

// Máscaras de bits de EFlags (SR8). En_INTs: 1 = interrupciones habilitadas.
#define EFLAGS_KMODE_MASK (1u << 0)      // Actual_KMode
#define EFLAGS_PREV_KMODE_MASK (1u << 1) // Previous_KMode
#define EFLAGS_EN_INTS_MASK (1u << 2)    // Actual_INTs (En_INTs)
#define EFLAGS_PREV_INTS_MASK (1u << 3)  // Previous_INTs

// Bandera de pánico: se activa desde una excepción fatal
extern volatile bool system_panic;

// Apagar las IRQs
__attribute__((always_inline)) inline void irqOff() {
  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  uint32_t eflags_off = eflags & ~EFLAGS_EN_INTS_MASK;
  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_off));
}
// Encender las IRQs
__attribute__((always_inline)) inline void irqOn() {
  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  uint32_t eflags_on = eflags | EFLAGS_EN_INTS_MASK;
  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_on));
}

// Entrada a sección critica
__attribute__((always_inline)) inline uint32_t enterCriticalSection() {
  uint32_t flags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(flags));
  irqOff();
  return flags;
}

// Salida de sección critica
__attribute__((always_inline)) inline void exitCriticalSection(uint32_t flags) {
  __asm__ __volatile__("CYR %0, SR8" : : "r"(flags));
}

// ============================================================
// Excepciones
// ============================================================
// Cada excepción recibe las EFlags del error y el EPC de retorno

// Error de paginas
uint32_t pageFault(uint32_t eflags, uint32_t epc);

// Error de alineamiento
uint32_t alignamentFault(uint32_t eflags, uint32_t epc);

// Error por instruccion sin privilegios
uint32_t generalProtectionFault(uint32_t eflags, uint32_t epc);

// Error por instrucciones desconocida
uint32_t invalidOpCode(uint32_t eflags, uint32_t epc);

// Double Fault
uint32_t doubleFault(uint32_t eflags, uint32_t epc);

// ============================================================
// IRQs
// ============================================================

#define TTY_MSI_NUM 127      // Numero MSI para TTY
#define KEYBOARD_MSI_NUM 126 // Numero MSI para Keyboard

// Inicialización de MSI
void initMSI(uint32_t base, uint32_t irq_num,
             uint32_t (*handler)(uint32_t eflags, uint32_t epc));

#endif