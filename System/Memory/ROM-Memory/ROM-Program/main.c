#include "functions.h"

int main() {
  PCIe_Bus_Enumeration();
  displaySearch();

  // Ya se puede usar biosWrite()
  biosWrite("Hola", 0);
  biosWrite("Mundo!!! \n\n", 0);
  biosWrite("A", 5);
  biosWrite("", 5);

  // Fin
  __asm__ volatile("HLT");
}