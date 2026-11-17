#ifndef HAL_RAM_H
#define HAL_RAM_H

#include "../bios_types.h"
#include "../lib/uefiCalls.h"
#include "ecam.h"
#include <stdbool.h>
#include <stdint.h>

extern uint32_t *CantRamMB;

inline int initRAM() {
  uint32_t *CantRamMB = NULL;

  if (ECAM_R(ECAM_ADDR(0, 0, 0), 0x0) != 0xFFFFFFFF) {
    if (allocatePool(PERSISTENT_DATA, sizeof(uint32_t), (void **)&CantRamMB) ==
        -1) {
      return -1;
    }
    *CantRamMB = ECAM_R(ECAM_ADDR(0, 0, 0), 0x4);
    return 0;

  } else {
    // No hay RAM
    final();
  }

  return -1;
}

#endif