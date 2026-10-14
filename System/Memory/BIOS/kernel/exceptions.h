#ifndef KERNEL_EXCEPTIONS_H
#define KERNEL_EXCEPTIONS_H

#include <stdint.h>

uint32_t pageFault(uint32_t eflags, uint32_t epc);
uint32_t alignamentFault(uint32_t eflags, uint32_t epc);
uint32_t generalProtectionFault(uint32_t eflags, uint32_t epc);
uint32_t invalidOpCode(uint32_t eflags, uint32_t epc);
uint32_t doubleFault(uint32_t eflags, uint32_t epc);

#endif
