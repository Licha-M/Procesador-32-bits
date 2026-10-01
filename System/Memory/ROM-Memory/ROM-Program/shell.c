#include "functions.h"
#include "inter_IRQs.h"

// ================================================================================
// Auxiliary Definitions
// ================================================================================

// Tabla de comandos
typedef struct {
  const char *nombre;
  void (*funcion)(void);
} Comando;

// Prototipos de las funciones para que puedan asignarse en la tabla abajo.
void help(void);
void cls(void);
void sysOff(void);
void initSO(void);
void enumDisp(void);

// Declaramos la tabla
Comando tabla_comandos[] = {{"help", help},
                            {"cls", cls},
                            {"sysOff", sysOff},
                            {"initSO", initSO},
                            {"enumDisp", enumDisp}};

#define NUM_COMANDOS (sizeof(tabla_comandos) / sizeof(Comando))

// ================================================================================
// Intern Functions
// ================================================================================

// Función de ayuda
void help() {
  biosWrite("El sistema permite estos comandos: \n", 0);

  for (size_t i = 0; i < NUM_COMANDOS; i++) {
    biosWrite((char *)tabla_comandos[i].nombre, 0);
    biosWrite("\n", 0);
  }
}

// Función de borrado
void cls() { biosClear(); }

// Función de apagado
void sysOff() {
  biosWrite("Apagando sistema...", 0);
  final();
}

// Función que inicia el SO
void initSO() { return; }

// Enumeración de dispositivos
void enumDisp() {
  biosWrite("Class Code\t", 0);
  biosWrite("ECAM Addres\n", 0);
  for (int i = 0; i < map_size; i++) {
    biosWrite(intToAscii(mapa[i].ClassCode), 0);
    biosWrite("\t", 0);
    biosWrite(intToAscii(ECAM_ADDR(mapa[i].bus, mapa[i].dev, mapa[i].func)), 0);
    biosWrite("\n", 0);
  }
  biosWrite("Hay ", 0);
  biosWrite(intToAscii(map_size), 0);
  biosWrite(" dispositivos conectados\n", 0);
}

// ================================================================================
// Extern functions
// ================================================================================

// Inicializa la shell (verdadero programa principal)
__attribute__((noreturn)) void BiosShell() {
  char input[32];

  while (true) {
    bool comando = false;
    irqOn(); // La shell siempre debería correr con IRQs habilitadas

    biosWrite(">", 0);
    read(input, sizeof(input));

    for (size_t i = 0; i < NUM_COMANDOS; i++) {
      if (strcmp(input, tabla_comandos[i].nombre) == 0) {
        tabla_comandos[i].funcion(); // Llama a la función directamente
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