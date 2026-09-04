#include "functions.h"

#define MIN_BAR_POS 0xC0000000 // Offset para la asignación de memoria
#define MAX_PCIE_DEVICES 64    // Cantidad maxima de dispositivos

// Busqueda por fuerza bruta de dispositivos
void bus_Enumeration(uint32_t bus, volatile PCIe_Map *mapa, int *map_size,
                     int *next_bus_number, int *offset_BAR_Pos) {
  if (bus >= 256)
    return;

  for (uint32_t dev = 0; dev < 32; dev++) {
    for (uint32_t func = 0; func < 8; func++) {
      // 1. Calcular el desplazamiento exacto del slot ECAM
      // (Bits: Bus=20, Dev=15, Func=12)
      uintptr_t offset = (bus << 20) | (dev << 15) | (func << 12);
      // 2. Mapear dinámicamente el puntero a la dirección física calculada
      volatile PCIe_ECAM_Slot *dispositivo =
          (volatile PCIe_ECAM_Slot *)(ECAM_BASE + offset);

      if ((dispositivo->Header.VendorID_DeviceID & 0xFFFF) != 0xFFFF) {

        if (*map_size >= MAX_PCIE_DEVICES)
          return;

        int current_idx = *map_size;
        mapa[current_idx].start_address = MIN_BAR_POS + *offset_BAR_Pos;
        mapa[current_idx].bus = bus;
        mapa[current_idx].dev = dev;
        mapa[current_idx].func = func;
        mapa[current_idx].ClassCode = dispositivo->Header.ClassCode_HeaderType;

        // Extraer tipo de cabecera
        uint8_t tipo_cabecera =
            (dispositivo->Header.ClassCode_HeaderType >> 24) & 0x7F;

        if (tipo_cabecera == 0x00) {
          // Es un dispositivo PCIe

          // Obtenemos los registros BAR
          uint32_t valor[4] = {0};
          for (int i = 0; i <= 3; i++) {
            dispositivo->Type.Device.BAR[i] = 0xFFFFFFFF;
            valor[i] = dispositivo->Type.Device.BAR[i];

            // Si BAR responde con 0, no se le asigna espacio
            if (valor[i] == 0)
              continue;

            if (valor[i] <= 4096) {
              // Si requiere 4KB o menos se le asigna 4KB
              dispositivo->Type.Device.BAR[i] = (MIN_BAR_POS + *offset_BAR_Pos);
              *offset_BAR_Pos += 4096;
            } else {
              // Si requiere más de 4KB, se le asigna un multiplo de 4KB
              dispositivo->Type.Device.BAR[i] = (MIN_BAR_POS + *offset_BAR_Pos);
              // Se redondea al múltiplo de 4KB más cercano
              *offset_BAR_Pos += (valor[i] + 4095) & 0xFFFFF000;
            }
          }

          // Guardamos los datos de tamaño, y final
          mapa[current_idx].size =
              (MIN_BAR_POS + *offset_BAR_Pos) - mapa[current_idx].start_address;
          mapa[current_idx].end_address = MIN_BAR_POS + *offset_BAR_Pos;
          (*map_size)++;

        } else if (tipo_cabecera == 0x01) {
          // Es un puente PCIe

          // Contabilizamos el puente PCIe
          (*map_size)++;

          uint8_t secondary_bus = *next_bus_number;

          // Asignamos número primario y subordinado temporal en el PSS
          uint32_t pss = dispositivo->Type.Bridge.PSS;
          pss &= ~0x00FFFFFF;  // Limpiar bits 0-23 (Primary, Secondary,
                               // Subordinate)
          pss |= (bus & 0xFF); // Primary (bits 0-7)
          pss |= ((*next_bus_number & 0xFF)
                  << 16); // Subordinate temporal (bits 16-23)
          dispositivo->Type.Bridge.PSS = pss;

          (*next_bus_number)++;

          bus_Enumeration(secondary_bus, mapa, map_size, next_bus_number,
                          offset_BAR_Pos);

          // Actualizamos bus secundario y subordinado final
          pss = dispositivo->Type.Bridge.PSS;
          pss &= ~0x00FFFF00; // Limpiar bits 8-23 (Secondary y Subordinate)
          pss |= ((secondary_bus & 0xFF) << 8); // Secondary (bits 8-15)
          pss |= (((*next_bus_number - 1) & 0xFF)
                  << 16); // Subordinate final (bits 16-23)
          dispositivo->Type.Bridge.PSS = pss;

          // Anotar tamaño maximo y total del puente
          uint32_t end_address = MIN_BAR_POS + *offset_BAR_Pos;
          mapa[current_idx].end_address = end_address;
          mapa[current_idx].size =
              end_address - mapa[current_idx].start_address;

          // Anotar MLimit y MBase (16 bits más significativos)
          uint16_t mbase = (mapa[current_idx].start_address >> 16) & 0xFFF0;
          uint16_t mlimit = (end_address > mapa[current_idx].start_address)
                                ? ((end_address - 1) >> 16) & 0xFFF0
                                : mbase;

          dispositivo->Type.Bridge.MLimitBase =
              (mbase & 0xFFFF) | ((mlimit & 0xFFFF) << 16);

        } else {
          break;
        }
      }

      if (func == 0 &&
          !((dispositivo->Header.ClassCode_HeaderType >> 24) & 0x80)) {
        // Si el bit 7 es 0, no hay más funciones
        break;
      }
    }
  }
}

// Iniciador de la función
int PCIe_Bus_Enumeration(void) {
  volatile PCIe_Map *mapa =
      (volatile PCIe_Map *)(TABLE_Addr); // Tabla que almacena la información.

  uint32_t bus = 0;        // Se inicia desde el bus 0
  int next_bus_number = 1; // El primer puente tiene el número 1
  int map_size = 0;        // Tamaño de la tabla de información
  int offset_BAR_Pos = 0;  // Offset dentro del espacio de direcciones
  bus_Enumeration(bus, mapa, &map_size, &next_bus_number, &offset_BAR_Pos);
  
  return map_size;
}