#include "functions.h"

void final() {
  while (true) {
    // Fin dentro de un bucle para que termine por mas que alla IRQs
    __asm__ volatile("HLT");
  }
}

// Definimos el mapa de dispositivos
volatile PCIe_Map *mapa = (volatile PCIe_Map *)(TABLE_Addr);
int map_size = 0;

int main() {

  // Inicializamos interrupcines
  initIRQs();

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
  biosWrite(intToAscii(map_size), 0);
  biosWrite(" dispositivos conectados.\n\n", 0);
  biosWrite("LAPIC e IRQs inicializadas.\n\n", 0);

  if (!keyboardSearch()) {
    biosWrite("No hay teclado conectado", 0);
    final();
  }

  char text[10];

  while (true) {
    biosWrite("Escriba ", 0);
    read(text, 10);
    biosWrite(text, 0);
    biosWrite("\n", 0);
  }

  final();
}