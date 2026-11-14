#ifndef BIOS_TYPES_H
#define BIOS_TYPES_H

#include <stdbool.h>
#include <stdint.h>


extern volatile bool system_panic;

typedef uint32_t (*IRQHandler)(uint32_t eflags, uint32_t epc, uint32_t cause);

typedef struct {
  volatile uint32_t start_address;
  volatile uint32_t end_address;
  volatile uint32_t size;
  volatile uint32_t ClassCode;
  volatile uint8_t bus;
  volatile uint8_t dev;
  volatile uint8_t func;
} PCIe_Map;

__attribute__((noreturn)) void final(void);

#endif
