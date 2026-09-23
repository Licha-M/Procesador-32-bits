#include "functions.h"

// Definimos el mapa de dispositivos
volatile PCIe_Map *mapa = (volatile PCIe_Map *)(TABLE_Addr);
int map_size = 0;

int main() {

  // Inicializamos interrupcines
  initIRQs();

  // Inicializamos LAPIC y excepciones
  initLAPIC();

  // Enumeramos los buses PCIe
  // PCIe_Bus_Enumeration();

  // Buscamos una pantalla
  displaySearch();

  // Ya se puede usar biosWrite()
  biosWrite("Enumeración de buses finalizada.\n", 0);
  biosWrite("Hay ", 0);
  biosWrite(intToAscii(map_size), 0);
  biosWrite("dispositivos conectados.\n\n", 0);
  biosWrite("LAPIC e IRQs inicializadas.\n\n", 0);

  while (true) {
    // Fin dentro de un bucle para que termine por mas que alla IRQs
    __asm__ volatile("HLT");
  }
}