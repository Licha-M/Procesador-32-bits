#include "functions.h"

int main() {
  int map_size = PCIe_Bus_Enumeration();
  __asm__ volatile("HLT");

  // Puntero al mapa de dispositivos PCIe
  volatile PCIe_Map *mapa = (volatile PCIe_Map *)(TABLE_Addr);

  // Bucle for para recorrer la cantidad de elementos dentro del mapa
  for (int i = 0; i < map_size; i++) {
    // Aquí puedes acceder a los elementos del mapa
    // Ejemplo: volatile uint32_t start = mapa[i].start_address;
  }
}