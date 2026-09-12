#include "functions.h"

#define MIN_BAR_POS 0xC0000000 // Base para la asignación de memoria BAR
#define MAX_PCIE_DEVICES 64    // Cantidad maxima de dispositivos

// ---------------------------------------------------------------------------
// Macros de acceso ECAM: siempre de 32 bits (INT LOD / INT STR).
// El cast a (volatile uint32_t*) obliga al compilador a emitir INT.
// ---------------------------------------------------------------------------
#define ECAM_R(base, off)                                                      \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)))
#define ECAM_W(base, off, val)                                                 \
  (*(volatile uint32_t *)((uintptr_t)(base) + (uint32_t)(off)) =               \
       (uint32_t)(val))

// ---------------------------------------------------------------------------
// Offsets del encabezado comun (PCIe_ECAMs, 16 bytes)
// ---------------------------------------------------------------------------
#define OFF_VENDOR_DEVICE 0x00  // VendorID | DeviceID
#define OFF_COMMAND_STATUS 0x04 // Command  | Status
#define OFF_CLASSCODE_HDR 0x08  // ClassCode | Subclass | ProgIF | HeaderType
// 0x0C: Reserved (BIST / LatencyTimer / CacheLineSize)

// ---------------------------------------------------------------------------
// Offsets del tipo Puente (PCIe_Bridge_Config, a partir de 0x10)
// ---------------------------------------------------------------------------
#define OFF_PSS 0x10            // Primary | Secondary | Subordinate bus
#define OFF_CAP_PTR_BRIDGE 0x14 // Capabilities Pointer
#define OFF_MLIMITBASE 0x18     // Memory Limit | Memory Base

// ---------------------------------------------------------------------------
// Offsets del tipo Dispositivo (PCIe_Device_Config, a partir de 0x10)
// ---------------------------------------------------------------------------
#define OFF_BAR(i) (0x10 + (uint32_t)(i) * 4) // BAR 0-3
#define OFF_ROM 0x20                          // Expansion ROM Base
#define OFF_CAP_PTR_DEV 0x24                  // Capabilities Pointer

// ---------------------------------------------------------------------------
// Enumeración de bus PCIe
// ---------------------------------------------------------------------------
void bus_Enumeration(uint32_t bus, volatile PCIe_Map *mapa, int *map_size,
                     int *next_bus_number, int *offset_BAR_Pos) {
  if (bus >= 256)
    return;

  for (uint32_t dev = 0; dev < 32; dev++) {
    for (uint32_t func = 0; func < 8; func++) {

      // Dirección base del slot ECAM (Bits: Bus=20, Dev=15, Func=12)
      uintptr_t base = ECAM_BASE + ((bus << 20) | (dev << 15) | (func << 12));

      // ---- Verificar si hay dispositivo ----
      uint32_t vendor_device = ECAM_R(base, OFF_VENDOR_DEVICE);
      if ((vendor_device & 0xFFFF) == 0xFFFF) {
        // No hay dispositivo en este slot
        break;
      }

      if (*map_size >= MAX_PCIE_DEVICES)
        return;

      int current_idx = *map_size;
      mapa[current_idx].start_address = MIN_BAR_POS + *offset_BAR_Pos;
      mapa[current_idx].bus = (uint8_t)bus;
      mapa[current_idx].dev = (uint8_t)dev;
      mapa[current_idx].func = (uint8_t)func;

      // Leer ClassCode+HeaderType (1 lectura INT de 32 bits)
      uint32_t classcode_hdr = ECAM_R(base, OFF_CLASSCODE_HDR);
      mapa[current_idx].ClassCode = classcode_hdr;

      // Tipo de cabecera: bits [30:24] del registro
      uint32_t tipo_cabecera = (classcode_hdr >> 24) & 0x7F;

      // ================================================================
      if (tipo_cabecera == 0x00) {
        // ---- Dispositivo PCIe ----------------------------------------

        uint32_t valor[4] = {0};
        for (int i = 0; i <= 3; i++) {
          // Probar tamaño del BAR: escribir ~0, leer respuesta
          ECAM_W(base, OFF_BAR(i), 0xFFFFFFFF);
          valor[i] = ECAM_R(base, OFF_BAR(i));

          if (valor[i] == 0)
            continue; // BAR no implementado

          if (valor[i] <= 4096) {
            // Requiere 4 KB o menos → asignar 4 KB
            ECAM_W(base, OFF_BAR(i), MIN_BAR_POS + *offset_BAR_Pos);
            *offset_BAR_Pos += 4096;
          } else {
            // Requiere más de 4 KB → redondear al múltiplo de 4 KB
            ECAM_W(base, OFF_BAR(i), MIN_BAR_POS + *offset_BAR_Pos);
            *offset_BAR_Pos += (valor[i] + 4095) & 0xFFFFF000;
          }
        }

        mapa[current_idx].size =
            (MIN_BAR_POS + *offset_BAR_Pos) - mapa[current_idx].start_address;
        mapa[current_idx].end_address = MIN_BAR_POS + *offset_BAR_Pos;
        (*map_size)++;

        // Activar MMIO
        ECAM_W(base, OFF_COMMAND_STATUS, 1);

        // ================================================================
      } else if (tipo_cabecera == 0x01) {
        // ---- Puente PCIe ---------------------------------------------

        (*map_size)++;

        uint32_t secondary_bus = (uint32_t)*next_bus_number;

        // Escribir PSS: Primary, Secondary (para que el puente rutee el bus) y
        // Subordinate temporal
        uint32_t pss = ECAM_R(base, OFF_PSS);
        pss &= ~0x00FFFFFF;  // Limpiar Primary, Secondary, Subordinate
        pss |= (bus & 0xFF); // Primary (bits 0-7)
        pss |= ((secondary_bus & 0xFF) << 8); // Secondary (bits 8-15) ← CRÍTICO
                                              // para que el puente rutee ECAM
        pss |= ((secondary_bus & 0xFF)
                << 16); // Subordinate temporal = secondary_bus (se actualiza
                        // post-recursión)
        ECAM_W(base, OFF_PSS, pss);

        (*next_bus_number)++;

        // Enumerar el bus secundario
        bus_Enumeration(secondary_bus, mapa, map_size, next_bus_number,
                        offset_BAR_Pos);

        // Actualizar Secondary y Subordinate final en el PSS
        pss = ECAM_R(base, OFF_PSS);
        pss &= ~0x00FFFF00;                   // Limpiar Secondary y Subordinate
        pss |= ((secondary_bus & 0xFF) << 8); // Secondary (bits 8-15)
        pss |= (((*next_bus_number - 1) & 0xFF)
                << 16); // Subordinate final (bits 16-23)
        ECAM_W(base, OFF_PSS, pss);

        // Anotar tamaño y dirección final del puente
        uint32_t end_address = MIN_BAR_POS + *offset_BAR_Pos;
        mapa[current_idx].end_address = end_address;
        mapa[current_idx].size = end_address - mapa[current_idx].start_address;

        // Anotar MLimit y MBase (bits [15:4] de cada dirección de 32 bits)
        uint32_t mbase = (mapa[current_idx].start_address >> 16) & 0xFFF0;
        uint32_t mlimit = (end_address > mapa[current_idx].start_address)
                              ? ((end_address - 1) >> 16) & 0xFFF0
                              : mbase;
        ECAM_W(base, OFF_MLIMITBASE,
               (mbase & 0xFFFF) | ((mlimit & 0xFFFF) << 16));

        // Activar MMIO solo si hay memoria asignada detrás del puente
        if (end_address > mapa[current_idx].start_address) {
          ECAM_W(base, OFF_COMMAND_STATUS, 1);
        }

        // ================================================================
      } else {
        // Tipo de cabecera desconocido → saltar al siguiente dispositivo
        break;
      }

      // Si bit 7 del HeaderType es 0 en función 0, no hay más funciones
      if (func == 0 && !((classcode_hdr >> 24) & 0x80)) {
        break;
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Punto de entrada de la enumeración PCIe
// ---------------------------------------------------------------------------
int PCIe_Bus_Enumeration(void) {
  volatile PCIe_Map *mapa =
      (volatile PCIe_Map *)(TABLE_Addr); // Tabla de dispositivos

  uint32_t bus = 0;        // Empezar desde el bus raíz
  int next_bus_number = 1; // Primer bus asignado a un puente
  int map_size = 0;        // Número de entradas registradas
  int offset_BAR_Pos = 0;  // Offset actual del espacio BAR

  bus_Enumeration(bus, mapa, &map_size, &next_bus_number, &offset_BAR_Pos);

  return map_size;
}