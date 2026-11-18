#ifndef BIOS_TYPES_H
#define BIOS_TYPES_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

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

typedef struct {
  uint32_t map_size;
  volatile bool system_panic;
  uint32_t nvm_selected;
  uint32_t nvmCount;
  uint32_t CantRamMB;
} globalVars;

extern globalVars *Globals;

__attribute__((noreturn)) void final(void);

#endif
