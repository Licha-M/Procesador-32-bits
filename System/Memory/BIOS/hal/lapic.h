#ifndef HAL_LAPIC_H
#define HAL_LAPIC_H

#include "../bios_types.h"
#include <stdbool.h>
#include <stdint.h>


#define EFLAGS_KMODE_MASK (1u << 0)
#define EFLAGS_PREV_KMODE_MASK (1u << 1)
#define EFLAGS_EN_INTS_MASK (1u << 2)
#define EFLAGS_PREV_INTS_MASK (1u << 3)

#define LAPIC_BASE_ADDR 0xFEE00000

__attribute__((always_inline)) static inline void irqOff(void) {
  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  uint32_t eflags_off = eflags & ~EFLAGS_EN_INTS_MASK;
  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_off));
}

__attribute__((always_inline)) static inline void irqOn(void) {
  uint32_t eflags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  uint32_t eflags_on = eflags | EFLAGS_EN_INTS_MASK;
  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_on));
}

__attribute__((always_inline)) static inline uint32_t
enterCriticalSection(void) {
  uint32_t flags;
  __asm__ __volatile__("CYE SR8, %0" : "=r"(flags));
  irqOff();
  return flags;
}

__attribute__((always_inline)) static inline void
exitCriticalSection(uint32_t flags) {
  __asm__ __volatile__("CYR %0, SR8" : : "r"(flags));
}

void initLAPIC(void);
void initMSI(uint32_t base, uint32_t irq_num, IRQHandler handler);

#endif
