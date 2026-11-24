#include "nvm.h"
#include "../../boot/boot.h"
#include "../../hal/ecam.h"
#include "../../hal/lapic.h"
#include "../../lib/uefiCalls.h"
#include "../tty/tty.h"
#include <stdbool.h>
#include <stdint.h>


#define NVM_CLASS_CODE 0x00010802
#define NVM_MAX_DEVS 32
#define NVM_ID_MASK 0x00FFFFFF
#define NVM_ENTRY_EMPTY                                                        \
  0xFFFFFFFF // marca de "sin finalización" en la cola tail
#define NVM_READ 0
#define NVM_WRITE 1

#define NEXT(i) (((i) + 1) & (NVM_QUEUE_LEN - 1))
NvmDev *nvmDevs = NULL;

// IRQ MSI: si el dispositivo que interrumpió completó su comando, avisa a
// NvmAccess.
static uint32_t nvm_IRQHandler(uint32_t eflags, uint32_t epc, uint32_t cause) {
  (void)eflags;
  uint32_t id = NVM_MSI_NUM - cause; // inverso de la IRQ asignada en initNvm
  if (id >= Globals->nvmCount || nvmDevs == NULL)
    return epc;

  NvmDev *dev = &nvmDevs[id];
  if ((dev->tail[dev->index].opcode_ID & NVM_ID_MASK) == dev->index)
    dev->done = true;

  return epc;
}

// Inicializa una NVM: aloja colas, habilita PCIe, registra MSI y arranca
// el dispositivo.
static void initNvm(uint32_t base, uint32_t num, bool *detected) {
  NvmDev *dev = &nvmDevs[num];
  dev->ID = num;
  dev->done = false;
  dev->index = 0;
  dev->booteable = false; // la memoria del pool no viene en cero

  void *queuePage = NULL;

  if (allocatePages(ANY_MEMORY, DEVICE_QUEUES, 1, &queuePage) != 0 ||
      queuePage == NULL) {
    biosWrite("\nError alojando paginas DMA para NVM", 0);
    dev->booteable = false;
    return;
  }

  dev->head = (NvmHeadEntry *)queuePage;
  dev->tail = (NvmTailEntry *)((uintptr_t)queuePage + 2048);

  ECAM_W(base, 0x04, 3); // memory space + bus master
  dev->regs = (NvmRegisters *)(uintptr_t)ECAM_R(base, 0x10); // BAR0
  dev->regs->head = (uint32_t)(uintptr_t)dev->head;
  dev->regs->tail = (uint32_t)(uintptr_t)dev->tail;

  initMSI(base, NVM_MSI_NUM - num, nvm_IRQHandler);
  dev->regs->command = 1; // habilitar al final, con todo ya configurado

  // Revisamos que la unidad sea booteable (ya se pueden hacer lecturas)
  dev->booteable = (bootScanDisk(num) > 0); // anota sus bootloaders en la tabla

  if (*detected == false)
    *detected = dev->booteable;
}

// Busca las NVM en el bus PCIe y las inicializa; devuelve true si encontró al
// menos una booteable
bool nvmSearch(void) {
  uint32_t found[NVM_MAX_DEVS];
  bool detected = false;
  Globals->nvmCount = search(NVM_CLASS_CODE, found);

  if (Globals->nvmCount == 0) {
    return false;
  }

  if (allocatePool(DEVICE_DATA, sizeof(NvmDev) * (Globals->nvmCount),
                   (void **)&nvmDevs) != 0 ||
      nvmDevs == NULL) {
    biosWrite("\nError alojando memoria para tabla NVM", 0);
    Globals->nvmCount = 0;
    return false;
  }

  if (bootInit() != 0)
    biosWrite("\nError alojando tabla de bootloaders", 0);

  for (uint32_t i = 0; i < Globals->nvmCount; i++) {
    Globals->nvm_selected = i;
    initNvm(found[i], i, &detected);
  }

  return detected;
}

// Envía un comando (lectura o escritura) y no retorna hasta que el dispositivo
// lo completa.
static int NvmAccess(uint32_t option, uint32_t disp, uint32_t *pointer,
                     uint32_t SLBA, uint32_t Cant) {
  if (option > NVM_WRITE) {
    biosWrite("\nComando de NVM no reconocido", 0);
    return NVM_INVALID_OPTION;
  }
  if (disp >= Globals->nvmCount || nvmDevs == NULL) {
    biosWrite("\nDispositivo NVM inexistente", 0);
    return NVM_DEVICE_NOT_RECOGNIZED;
  }

  NvmDev *dev = &nvmDevs[disp];
  uint32_t idx = dev->index;
  uint32_t flags = enterCriticalSection();

  dev->tail[idx].opcode_ID =
      NVM_ENTRY_EMPTY; // descarta cualquier finalización vieja
  dev->done = false;

  NvmHeadEntry *cmd = &dev->head[idx];
  cmd->addr = (uint32_t)(uintptr_t)pointer;
  cmd->SLBA = SLBA;
  cmd->NLBA = Cant;
  cmd->opcode_ID = (option << 24) | idx; // al final: valida la entrada
  dev->regs->doorbell = 1;

  // Dormir hasta que el handler marque done
  while (!dev->done) {
    irqOn();
    __asm__ volatile("HLT" : : : "memory");
    irqOff();
  }

  dev->index = NEXT(idx);
  exitCriticalSection(flags);
  return NVM_OK;
}

// Lee count sectores desde lba al buffer y retorna cuando terminó de cargarse.
int nvm_read_sectors(uint32_t disp, uint32_t lba, uint32_t count,
                     uint32_t *buffer) {
  return NvmAccess(NVM_READ, disp, buffer, lba, count);
}

// Escribe count sectores del buffer desde lba y retorna cuando terminó de
// guardarse.
int nvm_write_sectors(uint32_t disp, uint32_t lba, uint32_t count,
                      uint32_t *buffer) {
  return NvmAccess(NVM_WRITE, disp, buffer, lba, count);
}
