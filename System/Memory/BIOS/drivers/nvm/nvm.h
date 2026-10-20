#ifndef DRIVERS_NVM_H
#define DRIVERS_NVM_H

#include <stdbool.h>
#include <stdint.h>

#define NVM_MSI_NUM 125
#define NVM_OK 0
#define NVM_INVALID_OPTION 1
#define NVM_DEVICE_NOT_RECOGNIZED 2

#define HARDWARE_PAGE_SIZE 4096

extern bool NvmDetected;
extern uint32_t nvmCount;

// Busca e inicializa las NVM del bus PCIe; devuelve true si hay al menos una.
bool nvmSearch(void);

// Lee count sectores desde lba al buffer; retorna cuando terminó de cargarse.
int nvm_read_sectors(uint32_t disp, uint32_t lba, uint32_t count,
                     uint32_t *buffer);

// Escribe count sectores del buffer desde lba; retorna cuando terminó de
// guardarse.
int nvm_write_sectors(uint32_t disp, uint32_t lba, uint32_t count,
                      uint32_t *buffer);

#endif