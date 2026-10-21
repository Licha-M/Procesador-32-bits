#include "nvm.h"
#include "../../fs/fat/fat_types.h"
#include "../../hal/ecam.h"
#include "../../hal/lapic.h"
#include "../tty/tty.h"
#include <stdbool.h>
#include <stdint.h>

#define NVM_CLASS_CODE 0x00010802
#define NVM_HEAD_POS 0x08800000 // colas de comandos (una por dispositivo)
#define NVM_TAIL_POS 0x08840800 // colas de finalizaciones
#define NVM_MAX_DEVS 32
#define NVM_QUEUE_LEN 128 // debe ser potencia de 2
#define NVM_ID_MASK 0x00FFFFFF
#define NVM_ENTRY_EMPTY                                                        \
  0xFFFFFFFF // marca de "sin finalización" en la cola tail
#define NVM_READ 0
#define NVM_WRITE 1

#define NEXT(i) (((i) + 1) & (NVM_QUEUE_LEN - 1))

bool NvmDetected;
uint32_t nvmCount;
NvmDev *const nvmDevs = (NvmDev *)NVM_FOUND_POS;

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

#define HEAD_Q ((NvmHeadEntry(*)[NVM_QUEUE_LEN])NVM_HEAD_POS)
#define TAIL_Q ((NvmTailEntry(*)[NVM_QUEUE_LEN])NVM_TAIL_POS)

// IRQ MSI: si el dispositivo que interrumpió completó su comando, avisa a
// NvmAccess.
static uint32_t nvm_IRQHandler(uint32_t eflags, uint32_t epc, uint32_t cause) {
  (void)eflags;
  uint32_t id = NVM_MSI_NUM - cause; // inverso de la IRQ asignada en initNvm
  if (id >= nvmCount)
    return epc;

  NvmDev *dev = &nvmDevs[id];
  if ((TAIL_Q[id][dev->index].opcode_ID & NVM_ID_MASK) == dev->index)
    dev->done = true;

  return epc;
}

// Inicializa una NVM: habilita PCIe, carga las colas, registra la MSI y arranca
// el dispositivo.
static void initNvm(uint32_t base, uint32_t num) {
  NvmDev *dev = &nvmDevs[num];
  dev->ID = num;
  dev->done = false;
  dev->index = 0;

  ECAM_W(base, 0x04, 3); // memory space + bus master
  dev->regs = (NvmRegisters *)(uintptr_t)ECAM_R(base, 0x10); // BAR0
  dev->regs->head = (uint32_t)(uintptr_t)HEAD_Q[num];
  dev->regs->tail = (uint32_t)(uintptr_t)TAIL_Q[num];

  initMSI(base, NVM_MSI_NUM - num, nvm_IRQHandler);
  dev->regs->command = 1; // habilitar al final, con todo ya configurado

  // Revisamos que la unidad sea booteable
  dev->booteable = (fat_mount(dev) != -1);

  if (NvmDetected == false)
    NvmDetected = dev->booteable;
}

// Busca las NVM en el bus PCIe y las inicializa; devuelve true si encontró al
// menos una booteable
bool nvmSearch(void) {
  uint32_t found[NVM_MAX_DEVS];
  nvmCount = search(NVM_CLASS_CODE, found);

  for (int i = 0; i < nvmCount; i++) {
    nvm_selected = i;
    initNvm(found[i], i);
  }

  return NvmDetected;
}

// Envía un comando (lectura o escritura) y no retorna hasta que el dispositivo
// lo completa.
static int NvmAccess(uint32_t option, uint32_t disp, uint32_t *pointer,
                     uint32_t SLBA, uint32_t Cant) {
  if (option > NVM_WRITE) {
    biosWrite("\nComando de NVM no reconocido", 0);
    return NVM_INVALID_OPTION;
  }
  if (disp >= nvmCount) {
    biosWrite("\nDispositivo NVM inexistente", 0);
    return NVM_DEVICE_NOT_RECOGNIZED;
  }

  NvmDev *dev = &nvmDevs[disp];
  uint32_t idx = dev->index;
  uint32_t flags = enterCriticalSection();

  TAIL_Q[disp][idx].opcode_ID =
      NVM_ENTRY_EMPTY; // descarta cualquier finalización vieja
  dev->done = false;

  NvmHeadEntry *cmd = &HEAD_Q[disp][idx];
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