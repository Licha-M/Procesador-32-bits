#ifndef HAL_ECAM_H
#define HAL_ECAM_H

#include <stdint.h>
#include "../bios_types.h"

#define ECAM_BASE 0xE0000000
#define ECAM_ADDR(bus, dev, func) \
  (ECAM_BASE | ((uint32_t)(bus) << 20) | ((uint32_t)(dev) << 15) | ((uint32_t)(func) << 12))
#define TABLE_Addr 0x08000000
#define MAX_PCIE_DEVICES 64

#define ECAM_R(base, off) (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)))
#define ECAM_W(base, off, val) (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)) = (uint32_t)(val))

extern volatile PCIe_Map *mapa;
extern int map_size;

void PCIe_Bus_Enumeration(void);
int search(uint32_t tipo);

#endif
