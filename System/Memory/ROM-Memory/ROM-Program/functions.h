#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "inter_IRQs.h"

// ============================================================
// ECAM Bus Enumeration
// ============================================================

#define ECAM_BASE 0xE0000000 // Base del espacio ECAM
#define ECAM_ADDR(bus, dev, func)                                              \
  (ECAM_BASE | ((uint32_t)(bus) << 20) | ((uint32_t)(dev) << 15) |             \
   ((uint32_t)(func) << 12))
#define TABLE_Addr 0x08000000 // Espacio para guardar la tabla de dispositivos
#define MAX_PCIE_DEVICES 64   // Cantidad maxima de dispositivos

// ---------------------------------------------------------------------------
// Macros de acceso ECAM: siempre de 32 bits (INT LOD / INT STR).
// El cast a (volatile uint32_t*) obliga al compilador a emitir INT.
// ---------------------------------------------------------------------------
#define ECAM_R(base, off)                                                      \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)))
#define ECAM_W(base, off, val)                                                 \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)) =               \
       (uint32_t)(val))

extern int map_size; // Número de entradas registradas

// Tabla para el Kernel
typedef struct {
  volatile uint32_t start_address;
  volatile uint32_t end_address;
  volatile uint32_t size;
  volatile uint32_t ClassCode;
  volatile uint8_t bus;
  volatile uint8_t dev;
  volatile uint8_t func;
} PCIe_Map;

extern volatile PCIe_Map *mapa;

// Registros bajos de ECAM (sin packed: todos los campos son uint32_t
// alineados).
typedef struct {
  volatile uint32_t VendorID_DeviceID;    // Offset 0x00
  volatile uint32_t Command_Status;       // Offset 0x04
  volatile uint32_t ClassCode_HeaderType; // Offset 0x08
  volatile uint32_t Reserved; // Offset 0x0C (BIST/LatTimer/CacheLineSize)
} PCIe_ECAMs;
// sizeof(PCIe_ECAMs) == 16 bytes → Type.Bridge.PSS queda en offset 0x10

// Registros altos de ECAM para puentes PCIe.
typedef struct {
  volatile uint32_t PSS;                  // Offset 0x10
  volatile uint32_t Capabilities_Pointer; // Offset 0x14
  volatile uint32_t MLimitBase;           // Offset 0x18
} PCIe_Bridge_Config;

// Registros altos ECAM para dispositivos PCIe.
typedef struct {
  volatile uint32_t BAR[4];               // Offset 0x10
  volatile uint32_t ROM;                  // Offset 0x20
  volatile uint32_t Capabilities_Pointer; // Offset 0x24
} PCIe_Device_Config;

// Estructura final ECAM: el padding de 4KB se centraliza en el Raw del union.
typedef struct {
  PCIe_ECAMs Header; // Offset 0x00: 12 bytes comunes
  union {
    PCIe_Device_Config Device; // Si Header.HeaderType == 0x00 (offset 0x0C)
    PCIe_Bridge_Config Bridge; // Si Header.HeaderType == 0x01 (offset 0x0C)
    uint32_t
        Raw[(4096 - 12) / 4]; // Padding para completar los 4KB del slot ECAM
  } Type;
} PCIe_ECAM_Slot;

void PCIe_Bus_Enumeration(void);

// Buscador de dispositivos
int search(uint32_t tipo);

// ============================================================
// Display System
// ============================================================

// Función inicial
bool displaySearch();

// Función de limpieza
void biosClear(void);

// Función principal
void biosWrite(char string[], int cant);

// Conversión de entero a ASCII (devuelve dirección en memoria del buffer ASCII)
char *intToAscii(int num);

// Reemplazo de strcmp de string.h
int strcmp(const char *s1, const char *s2);

// ============================================================
// Input System
// ============================================================

// Buscador de keyboard
bool keyboardSearch();

// Función principal de lectura
int read(char *out_buffer, int max_size);

// ============================================================
// IRQs System
// ============================================================

#define LAPIC_BASE_ADDR 0xFEE00000 // Base del LAPIC

// Tipo puntero a función para manejadores de IRQ.
typedef uint32_t (*IRQHandler)(uint32_t eflags, uint32_t epc);

// Inicialización de LAPIC
void initLAPIC();

// ============================================================
// Syscalls System
// ============================================================

uint32_t syscallsHandler(uint32_t *regs, uint32_t eflags, uint32_t epc);

// ============================================================
// Shell
// ============================================================

// Shell de la Bios. Puerta al futuro SO
void BiosShell();

#endif
