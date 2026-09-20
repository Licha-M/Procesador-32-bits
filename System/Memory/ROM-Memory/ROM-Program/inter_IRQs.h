#ifndef INTER_IRQS_H
#define INTER_IRQS_H

#include <stdbool.h>
#include <stdint.h>


// ============================================================
// Auxiliary Definitions
// ============================================================

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

void irqOff();
void irqOn();

// ============================================================
// Excepciones
// ============================================================
// Cada excepción recibe las EFlags vigentes al momento del error (para
// saber si ocurrió en user o kernel mode) y el EPC de retorno, y devuelve
// el EPC ya corregido.

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

#endif