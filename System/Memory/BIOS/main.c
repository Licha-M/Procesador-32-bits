#include "functions.h"

__attribute__((noreturn)) void final() {
  while (true) {
    // Fin dentro de un bucle para que termine por mas que alla IRQs
    __asm__ volatile("HLT");
  }
}

// Definimos el mapa de dispositivos
volatile PCIe_Map *mapa = (volatile PCIe_Map *)(TABLE_Addr);
int map_size = 0;

int main() {

  // Inicializamos LAPIC y excepciones
  initLAPIC();

  // Enumeramos los buses PCIe
  PCIe_Bus_Enumeration();

  // Buscamos una pantalla
  if (!displaySearch())
    final();

  // Ya se puede usar biosWrite()
  biosWrite("Enumeracion de buses finalizada.\n", 0);
  biosWrite("Hay ", 0);
  biosWrite(ToAscii(map_size, FMT_INT), 0);
  biosWrite(" dispositivos conectados.\n\n", 0);
  biosWrite("LAPIC e IRQs inicializadas.\n\n", 0);

  if (!keyboardSearch()) {
    biosWrite("No hay teclado conectado\n", 0);
    final();
  }

  BiosShell();
}