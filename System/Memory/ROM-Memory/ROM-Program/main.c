#include "functions.h"

int main() {
  PCIe_Bus_Enumeration();
  displaySearch();

  // Ya se puede usar biosWrite()
  biosWrite("Enumeración de buses finalizada.\n", 0);
  biosWrite("Hay ", 0);
  biosWrite(intToAscii(map_size), 0);
  biosWrite("dispositivos conectados.\n", 0);

  // Fin
  __asm__ volatile("HLT");
}