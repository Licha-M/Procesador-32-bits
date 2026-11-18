#ifndef DRIVERS_NVM_H
#define DRIVERS_NVM_H

#include <stdbool.h>
#include <stdint.h>

#define NVM_MSI_NUM 125
#define NVM_OK 0
#define NVM_INVALID_OPTION 1
#define NVM_DEVICE_NOT_RECOGNIZED 2

#define HARDWARE_PAGE_SIZE 4096
#define NVM_QUEUE_LEN 128 // Movido aquí para definir el tamaño en NvmDev

typedef struct {
  volatile uint32_t
      opcode_ID; // [31:24] opcode, [23:0] ID (= índice en la cola)
  volatile uint32_t addr;
  volatile uint32_t SLBA;
  volatile uint32_t NLBA;
} NvmHeadEntry;

typedef struct {
  volatile uint32_t opcode_ID; // [23:0] ID del comando completado
  volatile uint32_t raw;
} NvmTailEntry;

_Static_assert(sizeof(NvmHeadEntry) * NVM_QUEUE_LEN == 2048, "head queue size");
_Static_assert(sizeof(NvmTailEntry) * NVM_QUEUE_LEN == 1024, "tail queue size");

typedef struct {
  volatile uint32_t command;
  volatile uint32_t head;
  volatile uint32_t tail;
  volatile uint8_t doorbell;
} NvmRegisters;

typedef struct {
  NvmRegisters *regs;
  NvmHeadEntry *head; // Cola de comandos asignada por allocatePages
  NvmTailEntry *tail; // Cola de finalizaciones asignada por allocatePages
  volatile bool done; // el comando en curso terminó
  uint32_t index;     // slot (comando y finalización) del próximo comando
  bool booteable;
  uint32_t ID;
  char name[12];
} NvmDev;

extern NvmDev *nvmDevs;

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
