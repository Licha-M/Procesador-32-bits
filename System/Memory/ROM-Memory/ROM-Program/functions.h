#ifndef FUNCTIONS_H
#define FUNCTIONS_H
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// ============================================================
// ECAM Bus Enumeration
// ============================================================

#define ECAM_BASE 0xE0000000  // Base del espacio ECAM
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

// Estructura registros TTY
typedef struct {
  volatile uint32_t comand;
  volatile uint32_t word_Addr;
  volatile uint32_t length;
  volatile uint32_t cant;
} TtyRegisters;

// Estructura registros GPU (No implementado)
// typedef struct {

// } GpuRegisters;

// Función inicial
void displaySearch();

// Función principal
void biosWrite(char string[], int cant);

// Conversión de entero a ASCII (devuelve dirección en memoria del buffer ASCII)
char *intToAscii(int num);

#endif
