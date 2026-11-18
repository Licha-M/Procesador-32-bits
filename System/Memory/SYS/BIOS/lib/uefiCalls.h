#ifndef LIB_UEFICALLS_H
#define LIB_UEFICALLS_H

#include "../bios_types.h"
#include "../hal/lapic.h"
#include <stdbool.h>
#include <stdint.h>

// Tipos de asinación
#define BOOT_ONLY_DATA 0  // Se libera (free) apenas arranca el SO
#define PERSISTENT_DATA 1 // No se libera nunca
#define IRQ_TABLE_DATA 2  // El SO decide si la mantiene o la actualiza
#define DEVICE_TABLE 3    // El SO la libera cuando ya no la usa
#define DEVICE_DATA 4     // Datos de dispositivos: decide el SO
#define DEVICE_QUEUES 5   // Colas de dispositivos: el SO decide si las mantiene
#define BAR_SECTION 6     // Regiones de memoria IO

// Aloja porciones pequeñas de RAM, medidas en Bytes
int allocatePool(uint32_t type, uint32_t size, void **buffer);

// Libera las porciones que ya no se utilizan
void freePool(void **pointer);

#define ANY_MEMORY 0xFFFFFFFF // Si no se requiere una pagina en especifico

// Aloja paginas enteras de RAM
int allocatePages(uint32_t address, uint32_t type, uint32_t cant,
                  void **buffer);

// Libera las paginas que ya no se utilizan
void freePages(uint32_t cant, void **pointer);

// Asigna memoria IO
int allocateIOMemory(uint32_t min, uint32_t max);

// Entrega un puntero al mapa de memoria
uint32_t getVarMap();

#endif