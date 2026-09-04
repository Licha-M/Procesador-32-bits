#ifndef FUNCTIONS_H
#define FUNCTIONS_H
#include <stdint.h>

#define ECAM_BASE 0xE0000000  // Base del espacio ECAM
#define TABLE_Addr 0x08000000 // Espacio para guardar la tabla de dispositivos

// Tabla para el Kernel
typedef struct __attribute__((packed)) {
  volatile uint32_t start_address;
  volatile uint32_t end_address;
  volatile uint32_t size;
  volatile uint32_t ClassCode;
  volatile uint8_t bus;
  volatile uint8_t dev;
  volatile uint8_t func;
} PCIe_Map;

// Registros bajos de ECAM.
typedef struct __attribute__((packed)) {
  volatile uint32_t VendorID_DeviceID;    // Offset 0x00
  volatile uint32_t Command_Status;       // Offset 0x04
  volatile uint32_t ClassCode_HeaderType; // Offset 0x08
  uint32_t Relleno[(4096 - 0x0C) / 4];    // Offset 0x0C. Rellena los otros 4084
                                          // bytes para completar los 4KB.
} PCIe_ECAMs;

// Registros altos de ECAM para puentes PCIe.
typedef struct __attribute__((packed)) {
  volatile uint32_t PSS;                  // Offset 0x10
  volatile uint32_t Capabilities_Pointer; // Offset 0x14
  volatile uint32_t MLimitBase;           // Offset 0x18
  uint32_t Relleno[(4096 - 0x1C) / 4];    // Offset 0x1C. Rellena los otros 4068
                                          // bytes para completar los 4KB.
} PCIe_Bridge_Config;

// Registros altos ECAM para dispositivos PCIe.
typedef struct __attribute__((packed)) {
  volatile uint32_t BAR[4];               // Offset 0x10
  volatile uint32_t ROM;                  // Offset 0x20
  volatile uint32_t Capabilities_Pointer; // Offset 0x24
  uint32_t Relleno[(4096 - 0x28) / 4];    // Offset 0x28. Rellena los otros 4056
                                          // bytes para completar los 4KB.
} PCIe_Device_Config;

// Estructura final ECAM
typedef struct __attribute__((packed)) {
  PCIe_ECAMs Header; // Primeros 12 bytes comunes
  union {
    PCIe_Device_Config Device;     // Si Header.HeaderType == 0x00
    PCIe_Bridge_Config Bridge;     // Si Header.HeaderType == 0x01
    uint32_t Raw[(4096 - 12) / 4]; // Mapeo crudo del resto de los 4KB
  } Type;
} PCIe_ECAM_Slot;

int PCIe_Bus_Enumeration(void);

#endif