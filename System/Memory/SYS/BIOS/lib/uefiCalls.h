#ifndef LIB_UEFICALLS_H
#define LIB_UEFICALLS_H

#include "../bios_types.h"
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// Tipos de datos para pool
#define BOOT_ONLY_DATA 0
#define PERSISTENT_DATA 1
#define IRQ_TABLE_DATA 2

int allocatePages();
int allocatePool(uint32_t type, uint32_t size, void **buffer);

#endif