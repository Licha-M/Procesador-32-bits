#include "shell.h"
#include "../bios_types.h"
#include "../drivers/keyboard/keyboard.h"
#include "../drivers/nvm/nvm.h"
#include "../drivers/tty/tty.h"
#include "../hal/ecam.h"
#include "../hal/lapic.h"
#include "../lib/format.h"

void help(void);
void sysOff(void);
void reset(void);
void initSO(void);
void enumdisp(void);
void lsboot(void);
void setboot(void);
void cls(void);

typedef struct {
  const char *nombre;
  void (*funcion)(void);
} Comando;

Comando tabla_comandos[] = {
    {"help", help},       {"sysOff", sysOff},     {"reset", reset},
    {"initSO", initSO},   {"enumdisp", enumdisp}, {"lsboot", lsboot},
    {"setboot", setboot}, {"cls", cls},
};

#define NUM_COMANDOS (sizeof(tabla_comandos) / sizeof(Comando))

// Imprime una cadena en pantalla rellenando con espacios hasta completar el
// ancho indicado.
static void writePadded(char *string, int width) {
  biosWrite(string, 0);
  const char *p = string;
  while (*p)
    p++;
  int len = (int)(p - string);
  char sp[2] = {' ', '\0'};
  for (int i = len; i < width; i++)
    biosWrite(sp, 0);
}

int page_size;

// Pausa la salida para paginacion y espera confirmacion del usuario para
// continuar o salir.
static bool paginate(void) {
  char resp[8];
  biosWrite("Continuar? (c/Enter, q para salir): ", 0);
  readInput(resp, sizeof(resp));
  if (resp[0] == 'q' || resp[0] == 'Q') {
    return false;
  }
  biosClear();
  return true;
}

// Muestra en pantalla los comandos disponibles en la consola con paginacion.
void help(void) {
  page_size = 5;
  biosWrite("El sistema permite estos comandos: \n", 0);
  for (size_t i = 0; i < NUM_COMANDOS; i++) {
    biosWrite("- ", 0);
    biosWrite((char *)tabla_comandos[i].nombre, 0);
    biosWrite("\n", 0);
    if ((i + 1) < NUM_COMANDOS && (i + 1) % page_size == 0) {
      if (!paginate())
        return;
      biosWrite("El sistema permite estos comandos: \n", 0);
    }
  }
}

// Apaga el sistema mostrando un mensaje y llamando a final().
void sysOff(void) {
  biosWrite("Apagando sistema...", 0);
  final();
}

extern int main(void);
// Reinicia el sistema llamando de nuevo a la funcion main().
void reset(void) { main(); }

// Inicia el sistema operativo (reserva para futura implementacion).
void initSO(void) { return; }

// Muestra en una tabla paginada los dispositivos PCIe enumerados con su Class
// Code y direccion ECAM.
void enumdisp(void) {
  page_size = 3;
  biosWrite("Hay ", 0);
  biosWrite(ToAscii(map_size, FMT_INT), 0);
  biosWrite(" dispositivos conectados\n", 0);
  biosWrite("Class Code   ECAM Address\n", 0);
  biosWrite("------------ ------------\n", 0);
  for (int i = 0; i < map_size; i++) {
    writePadded(ToAscii(mapa[i].ClassCode, FMT_HEX_FULL), 13);
    biosWrite(ToAscii(ECAM_ADDR(mapa[i].bus, mapa[i].dev, mapa[i].func),
                      FMT_HEX_FULL),
              0);
    biosWrite("\n", 0);
    if ((i + 1) < map_size && (i + 1) % page_size == 0) {
      if (!paginate())
        return;
      biosWrite("Class Code   ECAM Address\n", 0);
      biosWrite("------------ ------------\n", 0);
    }
  }
}

// Lista los dispositivos de arranque disponibles
void lsboot(void) {
  page_size = 3;

  biosWrite("Hay ", 0);
  biosWrite(ToAscii(nvmCount, FMT_INT), 0);
  biosWrite(" NVMs conectados\n", 0);
  biosWrite("ID    Nombre\n", 0);
  biosWrite("--    -----------\n", 0);

  int printed_count = 0;

  for (int i = 0; i < nvmCount; i++) {
    NvmDev *dev = &nvmDevs[i];

    if (dev->booteable == true) {
      writePadded(ToAscii(i, FMT_INT), 6);
      biosWrite(dev->name, 0);
      biosWrite("\n", 0);
      printed_count++;

      // Paginación basada estrictamente en elementos impresos
      if (printed_count < nvmCount && printed_count % page_size == 0) {
        if (!paginate())
          return;
        biosWrite("ID    Nombre\n", 0);
        biosWrite("--    -----------\n", 0);
      }
    }
  }
}

// Configura el dispositivo de arranque preferido (reserva para futura
// implementacion).
void setboot(void) { return; }

// Limpia la pantalla de la terminal.
void cls(void) { biosClear(); }

// Bucle principal de la consola interactiva: lee comandos del usuario y ejecuta
// la funcion asociada.
__attribute__((noreturn)) void BiosShell(void) {
  char input[32];
  while (true) {
    bool comando = false;
    irqOn();
    biosWrite(">", 0);
    readInput(input, sizeof(input));
    for (size_t i = 0; i < NUM_COMANDOS; i++) {
      if (strcmp(input, tabla_comandos[i].nombre) == 0) {
        tabla_comandos[i].funcion();
        comando = true;
        break;
      }
    }
    if (!comando && input[0] != '\0') {
      biosWrite("Comando no reconocido. Use 'help' para ver los comandos "
                "reconocidos\n",
                0);
    }
  }
}
