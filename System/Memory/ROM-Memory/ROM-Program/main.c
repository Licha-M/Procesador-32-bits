#include "functions.h"

int main() {
  PCIe_Bus_Enumeration();

  __asm__ volatile("HLT");
}