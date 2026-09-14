#include "functions.h"

int main() {
  int map_size = PCIe_Bus_Enumeration();

  ECAM_Addr resultados[MAX_PCIE_DEVICES];
  int encontrados = search(0x070000, map_size, resultados, MAX_PCIE_DEVICES);

  __asm__ volatile("HLT");
}