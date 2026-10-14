#include "nvm.h"
#include "../../hal/ecam.h"
#include "../../hal/lapic.h"
#include "../tty/tty.h"
#include <stdint.h>

#define NVM_HEAD_POS 0x08800000
#define NVM_TAIL_POS 0x08800800
#define NVM_QUEUES_SIZE 128

bool NvmDetected;
static volatile uint32_t head_index;
static volatile uint32_t tail_index;
static volatile bool hardware_busy;

typedef struct {
  volatile uint32_t comand;
  volatile uint32_t head;
  volatile uint32_t tail;
  volatile uint8_t doorbell;
} NvmRegisters;
static volatile NvmRegisters *nvm_registers;

typedef struct {
  volatile uint32_t opcode_ID;
  volatile uint32_t addr;
  volatile uint32_t SLBA;
  volatile uint32_t NLBA;
} NvmHeadRegisters;
static volatile NvmHeadRegisters *Head;

typedef struct {
  volatile uint32_t opcode_ID;
  uint32_t raw;
} NvmTailRegisters;
static volatile NvmTailRegisters *Tail;

static uint32_t nvm_IRQHandler(uint32_t eflags, uint32_t epc) {

  uint32_t offset = tail_index << 3;
  offset = NVM_TAIL_POS + offset;

  volatile NvmTailRegisters *currentTail =
      (volatile NvmTailRegisters *)(uintptr_t)offset;

  uint32_t completed_ID = currentTail->opcode_ID & 0x00FFFFFF;

  if (completed_ID == tail_index) {
    tail_index = (tail_index + 1) % NVM_QUEUES_SIZE;

    if (tail_index == head_index)
      hardware_busy = false;
    else
      nvm_registers->doorbell = 1;

  } else {
    hardware_busy = true;
    nvm_registers->doorbell = 1;
  }

  return epc;
}

static void initNvm(uint32_t base) {
  hardware_busy = false;
  ECAM_W(base, 0x04, 3);

  uint32_t bar0 = ECAM_R(base, 0x10);
  nvm_registers = (volatile NvmRegisters *)(uintptr_t)bar0;

  nvm_registers->comand = 1;
  nvm_registers->head = NVM_HEAD_POS;
  nvm_registers->tail = NVM_TAIL_POS;

  Head = (volatile NvmHeadRegisters *)(uintptr_t)NVM_HEAD_POS;
  Tail = (volatile NvmTailRegisters *)(uintptr_t)NVM_TAIL_POS;

  head_index = 0;
  tail_index = 0;

  initMSI(base, NVM_MSI_NUM, nvm_IRQHandler);
}

bool nvmSearch() {
  int offset = search(0x00010802);
  if (offset < 0)
    return NvmDetected = false;
  uint32_t base =
      ECAM_ADDR(mapa[offset].bus, mapa[offset].dev, mapa[offset].func);

  initNvm(base);

  return NvmDetected = true;
};

void accesNvm(uint32_t option, uint32_t *pointer, uint32_t SLBA,
              uint32_t Cant) {

  if (!(option == 0) && !(option == 1)) {
    biosWrite("\nComando de NVM no reconocido", 0);
    return;
  }

  volatile uint32_t next_head = (head_index + 1) % NVM_QUEUES_SIZE;
  while (next_head == tail_index) {
    irqOn();
    __asm__ volatile("HLT" : : : "memory");
  }

  uint32_t offset = head_index << 4;
  offset = NVM_HEAD_POS + offset;

  volatile NvmHeadRegisters *currentHead =
      (volatile NvmHeadRegisters *)(uintptr_t)offset;

  currentHead->addr = (uintptr_t)pointer;
  currentHead->NLBA = Cant;
  currentHead->SLBA = SLBA;
  currentHead->opcode_ID = ((option & 0xFF) << 24) | (head_index & 0xFFFFFF);

  head_index = next_head;

  if (!hardware_busy) {
    nvm_registers->doorbell = 1;
    hardware_busy = true;
  }
}