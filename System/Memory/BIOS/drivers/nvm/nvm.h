#ifndef DRIVERS_NVM_H
#define DRIVERS_NVM_H

#include <stdbool.h>
#include <stdint.h>

#define NVM_MSI_NUM 125
#define NVM_READ 0
#define NVM_WRITE 1

extern bool NvmDetected;

// Busca e inicializa las NVM del bus PCIe; devuelve true si hay al menos una.
bool nvmSearch(void);

// Encola una lectura/escritura de Cant bloques desde SLBA hacia/desde pointer.
void accesNvm(uint32_t option, uint32_t disp, uint32_t *pointer, uint32_t SLBA,
              uint32_t Cant);

#endif