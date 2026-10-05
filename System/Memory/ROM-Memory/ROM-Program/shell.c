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

// Control
void help(void);   // Listado de funciones
void sysOff(void); // Apagado de sistema
void reset(void);  // Reinicio del sistema
void initSO(void); // Inicio del SO desde el SSD seleccionado

// Exploración de hardware
void enumdisp(void); // Listado de dispositivos
void lsboot(void);   // Listado de SSD con sectores de arranque

// Configuración en Memoria
void setboot(void); // Setea el dispositivo de arranque

// Interfaz
void cls(void); // Limpiar pantalla

// Declaramos la tabla
Comando tabla_comandos[] = {
    {"help", help},       {"sysOff", sysOff},     {"reset", reset},
    {"initSO", initSO},   {"enumdisp", enumdisp}, {"lsboot", lsboot},
    {"setboot", setboot}, {"cls", cls},
};

#define NUM_COMANDOS (sizeof(tabla_comandos) / sizeof(Comando))

// Escribe 'string' y rellena con espacios hasta alcanzar el ancho 'width'.
// Asume que 'string' tiene menos de 'width' caracteres.
static void writePadded(char *string, int width) {
  biosWrite(string, 0);
  // Contamos la longitud con puntero (evita que LLVM lo reemplace por strlen)
  const char *p = string;
  while (*p)
    p++;
  int len = (int)(p - string);
  // Rellenamos con espacios
  char sp[2] = {' ', '\0'};
  for (int i = len; i < width; i++)
    biosWrite(sp, 0);
}

int page_size;

// Control de paginación para comandos que listen elementos.
// Retorna false si el usuario presiona 'q' (terminar comando),
// o true si presiona 'c' o Enter (limpia pantalla y continúa).
static bool paginate(void) {
  char resp[8];
  biosWrite("Continuar? (c/Enter, q para salir): ", 0);
  read(resp, sizeof(resp));
  if (resp[0] == 'q' || resp[0] == 'Q') {
    return false;
  }
  biosClear();
  return true;
}

// ================================================================================
// Intern Functions
// ================================================================================

// Función de ayuda
void help() {
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

// Función de apagado
void sysOff() {
  biosWrite("Apagando sistema...", 0);
  final();
}

// Reinicio total del sistema
void reset() { main(); }

// Función que inicia el SO
void initSO() { return; }

// Enumeración de dispositivos
void enumdisp() {
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

// Lista de SSD de arranque
void lsboot() { return; }

// Setea el SSD para arrtancar arranque
void setboot() { return; }

// Función de borrado
void cls() { biosClear(); }

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