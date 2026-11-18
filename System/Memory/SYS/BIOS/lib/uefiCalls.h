#ifndef LIB_UEFICALLS_H
#define LIB_UEFICALLS_H

#include <stdbool.h>
#include <stdint.h>

#define BOOT_ONLY_DATA 0  // Se libera (free) apenas arranca el SO
#define PERSISTENT_DATA 1 // No se libera nunca
#define IRQ_TABLE_DATA 2  // El SO decide si la mantiene o la actualiza
#define DEVICE_TABLE 3    // El SO la libera cuando ya no la usa
#define DEVICE_DATA 4     // Datos de dispositivos: decide el SO
#define DEVICE_QUEUES 5   // Colas de dispositivos: el SO decide si las mantiene

// Aloja porciones pequeñas de RAM, medidas en Bytes
int allocatePool(uint32_t type, uint32_t size, void **buffer);

#define ANY_MEMORY 0xFFFFFFFF // Si no se requiere una pagina en especifico

// Aloja paginas enteras de RAM
int allocatePages(uint32_t address, uint32_t type, uint32_t cant,
                  void **buffer);

#endif