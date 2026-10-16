#include "lapic.h"
#include "../drivers/tty/tty.h"
#include "../kernel/exceptions.h"
#include "../kernel/syscalls.h"
#include "ecam.h"
#include <stddef.h>

#define MAX_IRQS 128

typedef struct {
  IRQHandler handlers[MAX_IRQS];
} IRQTable;

static IRQTable irq_table;

typedef struct {
  volatile uint32_t BaseAddr;
  volatile uint32_t ID;
  volatile uint32_t LAPIC_Config;
  volatile uint32_t TPR;
  volatile uint32_t EOI;
  volatile uint32_t Timmer_Config;
  volatile uint32_t Timmer_Limit;
  volatile uint32_t IRR[4];
  volatile uint32_t MSI;
} LAPIC_Registers;

volatile LAPIC_Registers *Registros =
    (volatile LAPIC_Registers *)(LAPIC_BASE_ADDR);

static uint32_t defaultIRQHandler(uint32_t eflags, uint32_t epc,
                                  uint32_t cause) {
  (void)eflags;
  irqOff();
  if (cause < MAX_IRQS)
    biosWrite("Fatal Error: Unhandled IRQ", 0);
  else
    biosWrite("Fatal Error: Over Limit IRQ", 0);
  __asm__ volatile("HLT");
  return epc;
}

void mainHandler(uint32_t *regs) {
  uint32_t epc, eflags, flags, carry, cause;
  __asm__ __volatile__("CYE SR1, %0" : "=r"(epc));
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  __asm__ __volatile__("CYE SR9, %0" : "=r"(flags));
  __asm__ __volatile__("CYE SR10, %0" : "=r"(carry));
  __asm__ __volatile__("CYE SR7, %0" : "=r"(cause));

  uint32_t eflags_off = eflags & ~EFLAGS_EN_INTS_MASK;
  if (eflags & EFLAGS_PREV_INTS_MASK) {
    uint32_t eflags_on = eflags_off | EFLAGS_EN_INTS_MASK;
    __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_on));
  }

  if (cause != 0) {
    if (cause < MAX_IRQS && irq_table.handlers[cause] != NULL) {
      epc = irq_table.handlers[cause](eflags, epc, cause);
    } else {
      epc = defaultIRQHandler(eflags, epc, cause);
    }
  } else {
    epc = syscallsHandler(regs, eflags, epc);
  }

  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_off));
  __asm__ __volatile__("CYR %0, SR1" : : "r"(epc));
  __asm__ __volatile__("CYR %0, SR9" : : "r"(flags));
  __asm__ __volatile__("CYR %0, SR10" : : "r"(carry));

  if (cause >= 16) {
    Registros->EOI = 1;
  }
}

__attribute__((naked)) void entryHandler(void) {
  __asm__ volatile("SLT ADI R14, 56 \n"
                   "INT STR R14, R1, -56 \n"
                   "INT STR R14, R2, -52 \n"
                   "INT STR R14, R3, -48 \n"
                   "INT STR R14, R4, -44 \n"
                   "INT STR R14, R5, -40 \n"
                   "INT STR R14, R6, -36 \n"
                   "INT STR R14, R7, -32 \n"
                   "INT STR R14, R8, -28 \n"
                   "INT STR R14, R9, -24 \n"
                   "INT STR R14, R10, -20 \n"
                   "INT STR R14, R11, -16 \n"
                   "INT STR R14, R12, -12 \n"
                   "INT STR R14, R13, -8 \n"
                   "INT STR R14, R15, -4 \n"
                   "SLT ADD R14, R0, R1 \n"
                   "SLT ADI R1, -56 \n"
                   "H LDI R15, %hi(mainHandler) \n"
                   "SLT ADI R15, %lo(mainHandler) \n"
                   "CAL R15 \n"
                   "INT LOD R14, R1, -56 \n"
                   "INT LOD R14, R2, -52 \n"
                   "INT LOD R14, R3, -48 \n"
                   "INT LOD R14, R4, -44 \n"
                   "INT LOD R14, R5, -40 \n"
                   "INT LOD R14, R6, -36 \n"
                   "INT LOD R14, R7, -32 \n"
                   "INT LOD R14, R8, -28 \n"
                   "INT LOD R14, R9, -24 \n"
                   "INT LOD R14, R10, -20 \n"
                   "INT LOD R14, R11, -16 \n"
                   "INT LOD R14, R12, -12 \n"
                   "INT LOD R14, R13, -8 \n"
                   "INT LOD R14, R15, -4 \n"
                   "SLT ADI R14, -56 \n"
                   "SRT \n");
}

// Setea el nivel aceptado de IRQ. 0 = todas las IRQs
static inline void setTPR(uint32_t level) { Registros->TPR = level; }

void initMSI(uint32_t base, uint32_t irq_num, IRQHandler handler) {
  base = base + ECAM_R(base, 0x24);
  if ((ECAM_R(base, 0x0) & 0xFF) == 0x5) {
    uint32_t msi_reg = ECAM_R(base, 0x0);
    int cantREQ = (msi_reg >> 17) & 0x7;
    msi_reg &= 0x0000FFFF;
    msi_reg |= (cantREQ << 20);
    msi_reg |= (0x1 << 16);
    ECAM_W(base, 0x4, LAPIC_BASE_ADDR + 0x2C);
    ECAM_W(base, 0x8, irq_num);
    if (irq_num < MAX_IRQS && handler != NULL) {
      irq_table.handlers[irq_num] = handler;
    }
    ECAM_W(base, 0x0, msi_reg >> 16);
  }
}

void initLAPIC(void) {
  irq_table.handlers[1] = &pageFault;
  irq_table.handlers[2] = &alignamentFault;
  irq_table.handlers[3] = &generalProtectionFault;
  irq_table.handlers[4] = &invalidOpCode;
  irq_table.handlers[5] = &doubleFault;

  __asm__ __volatile__("CYR %0, SR12" : : "r"(&entryHandler));

  Registros->BaseAddr = LAPIC_BASE_ADDR;
  Registros->ID = 0;
  setTPR(0);
  Registros->LAPIC_Config = 3;
  irqOn();
}
