#ifndef KERNEL_SYSCALLS_H
#define KERNEL_SYSCALLS_H

#include <stdint.h>

uint32_t syscallsHandler(uint32_t *regs, uint32_t eflags, uint32_t epc);

#endif
