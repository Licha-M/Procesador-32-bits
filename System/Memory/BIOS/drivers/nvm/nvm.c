#include "nvm.h"
#include "../../hal/ecam.h"
#include "../../hal/lapic.h"
#include "../tty/tty.h"
#include <stdint.h>

#define NVM_CLASS_CODE 0x00010802
#define NVM_HEAD_POS 0x08800000  // colas de comandos (una por dispositivo)
#define NVM_TAIL_POS 0x08840800  // colas de finalizaciones
#define NVM_FOUND_POS 0x08400800 // tabla de dispositivos
#define NVM_MAX_DEVS 32
#define NVM_QUEUE_LEN 128 // debe ser potencia de 2
#define NVM_ID_MASK 0x00FFFFFF
#define NVM_ENTRY_EMPTY                                                        \
  0xFFFFFFFF // marca de "sin finalización" en la cola tail

#define NEXT(i) (((i) + 1) & (NVM_QUEUE_LEN - 1))

bool NvmDetected;

typedef struct {
  volatile uint32_t command;
  volatile uint32_t head;
  volatile uint32_t tail;
  volatile uint8_t doorbell;
} NvmRegisters;

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

typedef struct {
  NvmRegisters *regs;
  volatile bool busy;           // hay un comando en curso en el dispositivo
  volatile uint32_t head_index; // próximo slot libre para encolar
  volatile uint32_t tail_index; // próximo slot a completar
} NvmDev;

_Static_assert(sizeof(NvmHeadEntry) * NVM_QUEUE_LEN == 2048, "head queue size");
_Static_assert(sizeof(NvmTailEntry) * NVM_QUEUE_LEN == 1024, "tail queue size");

#define HEAD_Q ((NvmHeadEntry(*)[NVM_QUEUE_LEN])NVM_HEAD_POS)
#define TAIL_Q ((NvmTailEntry(*)[NVM_QUEUE_LEN])NVM_TAIL_POS)

static NvmDev *const nvmDevs = (NvmDev *)NVM_FOUND_POS;
static uint32_t nvmCount;

// IRQ MSI: consume la finalización del dispositivo que interrumpió y lanza el
// próximo comando si hay.
static uint32_t nvm_IRQHandler(uint32_t eflags, uint32_t epc, uint32_t cause) {
  (void)eflags;
  uint32_t id = NVM_MSI_NUM - cause; // inverso de la IRQ asignada en initNvm
  if (id >= nvmCount)
    return epc;

  NvmDev *dev = &nvmDevs[id];
  uint32_t flags = enterCriticalSection();

  NvmTailEntry *done = &TAIL_Q[id][dev->tail_index];
  if ((done->opcode_ID & NVM_ID_MASK) == dev->tail_index) {
    done->opcode_ID = NVM_ENTRY_EMPTY;
    dev->tail_index = NEXT(dev->tail_index);

    if (dev->tail_index == dev->head_index)
      dev->busy = false;
    else
      dev->regs->doorbell = 1;
  }

  exitCriticalSection(flags);
  return epc;
}

// Inicializa una NVM: habilita PCIe, prepara las colas, registra la MSI y
// arranca el dispositivo.
static void initNvm(uint32_t base, uint32_t num) {

  NvmDev *dev = &nvmDevs[num];
  dev->busy = false;
  dev->head_index = 0;
  dev->tail_index = 0;

  for (uint32_t i = 0; i < NVM_QUEUE_LEN; i++)
    TAIL_Q[num][i].opcode_ID = NVM_ENTRY_EMPTY;

  ECAM_W(base, 0x04, 3); // memory space + bus master
  dev->regs = (NvmRegisters *)(uintptr_t)ECAM_R(base, 0x10); // BAR0
  dev->regs->head = (uint32_t)(uintptr_t)HEAD_Q[num];
  dev->regs->tail = (uint32_t)(uintptr_t)TAIL_Q[num];

  initMSI(base, NVM_MSI_NUM - num, nvm_IRQHandler);
  dev->regs->command = 1; // habilitar al final, con todo ya configurado
}

// Busca las NVM en el bus PCIe y las inicializa; devuelve true si encontró al
// menos una.
bool nvmSearch(void) {
  uint32_t found[NVM_MAX_DEVS];
  int cant = search(NVM_CLASS_CODE, found);

  nvmCount = (uint32_t)
      cant; // antes de initNvm: así el handler ya reconoce los dispositivos
  for (int i = 0; i < cant; i++)
    initNvm(found[i], i);

  return NvmDetected = (cant > 0);
}

// Encola una lectura (0) o escritura (1) y toca el doorbell si el dispositivo
// estaba libre.
void NvmAccess(uint32_t option, uint32_t disp, uint32_t *pointer, uint32_t SLBA,
               uint32_t Cant) {
  if (option > NVM_WRITE) {
    biosWrite("\nComando de NVM no reconocido", 0);
    return;
  }
  if (disp >= nvmCount) {
    biosWrite("\nDispositivo NVM inexistente", 0);
    return;
  }

  NvmDev *dev = &nvmDevs[disp];
  uint32_t flags = enterCriticalSection();

  // Cola llena: dormir hasta que llegue una IRQ (la finalización libera un
  // lugar) y re-chequear
  while (NEXT(dev->head_index) == dev->tail_index) {
    irqOn();
    __asm__ volatile("HLT" : : : "memory");
    irqOff();
  }

  uint32_t idx = dev->head_index;
  NvmHeadEntry *cmd = &HEAD_Q[disp][idx];

  cmd->addr = (uint32_t)(uintptr_t)pointer;
  cmd->SLBA = SLBA;
  cmd->NLBA = Cant;
  cmd->opcode_ID =
      (option << 24) | idx; // se escribe al final: valida la entrada
  dev->head_index = NEXT(idx);

  if (!dev->busy) {
    dev->busy = true;
    dev->regs->doorbell = 1;
  }

  exitCriticalSection(flags);
}