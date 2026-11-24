#include "shell.h"
#include "../bios_types.h"
#include "../boot/boot.h"
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

// 'const' asegura que quede en .rodata y no ocupe RAM en .data
static const Comando tabla_comandos[] = {
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
  const int page_size = 5;
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

// Reinicia el sistema llamando de nuevo a la funcion main().
void reset(void) {
  // Ponemos el SP en 4KB y saltamos a main
  asm volatile("H LDI R14, 0\n"
               "SLT ADI R14, 4096\n"
               "H LDI R15, %hi(main) \n"
               "SLT ADI R15, %lo(main) \n"
               "JMP R15");
}

// Convierte una cadena de dígitos decimales en un entero. false si está vacía,
// tiene otros caracteres o es demasiado larga.
static bool parseUInt(const char *s, uint32_t *out) {
  uint32_t v = 0;
  int digits = 0;
  for (; *s; s++, digits++) {
    if (*s < '0' || *s > '9' || digits >= 9)
      return false;
    v = v * 10 + (uint32_t)(*s - '0');
  }
  *out = v;
  return digits > 0;
}

// Carga el bootloader elegido con setboot y le entrega el control.
void initSO(void) {
  if (bootSelected < 0) {
    biosWrite("Primero seleccione un bootloader con 'setboot'\n", 0);
    return;
  }
  const BootEntry *e = &bootEntries[bootSelected];
  biosWrite("Cargando ", 0);
  biosWrite((char *)e->folder, 0);
  biosWrite("/", 0);
  biosWrite((char *)e->file, 0);
  biosWrite("...\n", 0);

  switch (bootRun((uint32_t)bootSelected)) {
  case BOOT_OK:
    biosWrite("El bootloader devolvio el control a la BIOS\n", 0);
    break;
  case BOOT_ERR_FS:
    biosWrite("Error: no se pudo montar la particion EFI\n", 0);
    break;
  case BOOT_ERR_FILE:
    biosWrite("Error: no se pudo leer el bootloader\n", 0);
    break;
  case BOOT_ERR_MEM:
    biosWrite("Error: no hay memoria para cargar el bootloader\n", 0);
    break;
  default:
    biosWrite("Error: bootloader inexistente\n", 0);
    break;
  }
}

// Muestra en una tabla paginada los dispositivos PCIe enumerados con su Class
// Code y direccion ECAM.
void enumdisp(void) {
  const int page_size = 3;
  biosWrite("Hay ", 0);
  biosWrite(ToAscii(Globals->map_size, FMT_INT), 0);
  biosWrite(" dispositivos conectados\n", 0);
  biosWrite("Class Code   ECAM Address\n", 0);
  biosWrite("------------ ------------\n", 0);
  for (int i = 0; i < Globals->map_size; i++) {
    writePadded(ToAscii(mapa[i].ClassCode, FMT_HEX_FULL), 13);
    biosWrite(ToAscii(ECAM_ADDR(mapa[i].bus, mapa[i].dev, mapa[i].func),
                      FMT_HEX_FULL),
              0);
    biosWrite("\n", 0);
    if ((i + 1) < Globals->map_size && (i + 1) % page_size == 0) {
      if (!paginate())
        return;
      biosWrite("Class Code   ECAM Address\n", 0);
      biosWrite("------------ ------------\n", 0);
    }
  }
}

// Lista los bootloaders (.bin) de las particiones EFI de todas las NVM.
void lsboot(void) {
  const int page_size = 3;

  if (bootCount == 0) {
    biosWrite("No hay bootloaders en las particiones EFI\n", 0);
    return;
  }
  biosWrite("Hay ", 0);
  biosWrite(ToAscii(bootCount, FMT_INT), 0);
  biosWrite(" bootloaders\n", 0);
  biosWrite("ID    Carpeta         Bootloader\n", 0);
  biosWrite("--    -------         ----------\n", 0);

  for (uint32_t i = 0; i < bootCount; i++) {
    writePadded(ToAscii(i, FMT_INT), 6);
    writePadded(bootEntries[i].folder, 16);
    biosWrite(bootEntries[i].file, 0);
    biosWrite("\n", 0);

    if ((i + 1) < bootCount && (i + 1) % page_size == 0) {
      if (!paginate())
        return;
      biosWrite("ID    Carpeta         Bootloader\n", 0);
      biosWrite("--    -------         ----------\n", 0);
    }
  }
}

// Pide un ID de lsboot y lo deja elegido para initSO.
void setboot(void) {
  if (bootCount == 0) {
    biosWrite("No hay bootloaders para elegir\n", 0);
    return;
  }
  char resp[8];
  uint32_t id;
  biosWrite("ID del bootloader (Enter para cancelar): ", 0);
  readInput(resp, sizeof(resp));
  if (resp[0] == '\0') {
    biosWrite("Cancelado\n", 0);
    return;
  }
  if (!parseUInt(resp, &id) || id >= bootCount) {
    biosWrite("ID invalido. Use 'lsboot' para ver los IDs\n", 0);
    return;
  }
  bootSelected = (int32_t)id;
  biosWrite("Seleccionado: ", 0);
  biosWrite(bootEntries[id].folder, 0);
  biosWrite("/", 0);
  biosWrite(bootEntries[id].file, 0);
  biosWrite("\n", 0);
}

// Limpia la pantalla de la terminal.
void cls(void) { biosClear(); }

// Bucle principal de la consola interactiva: lee comandos del usuario y ejecuta
// la funcion asociada.
__attribute__((noreturn)) void BiosShell(void) {
  char input[32]; // Ya vive en el stack
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