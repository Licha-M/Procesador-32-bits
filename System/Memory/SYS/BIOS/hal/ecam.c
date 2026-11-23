#include "ecam.h"
#include "../lib/uefiCalls.h"

#define MIN_BAR_POS 0xC0000000u

// Fin del espacio para BARs: ahi empieza el LAPIC (0xFEE00000).
// BAR_SPACE_SIZE es el offset maximo que puede alcanzar offset_BAR_Pos.
#define MAX_BAR_POS 0xFEE00000u
#define BAR_SPACE_SIZE (MAX_BAR_POS - MIN_BAR_POS)

#define OFF_VENDOR_DEVICE 0x00
#define OFF_COMMAND_STATUS 0x04
#define OFF_CLASSCODE_HDR 0x08
#define OFF_PSS 0x10
#define OFF_CAP_PTR_BRIDGE 0x14
#define OFF_MLIMITBASE 0x18
#define OFF_BAR(i) (0x10 + (uint32_t)(i) * 4)
#define OFF_ROM 0x20
#define OFF_CAP_PTR_DEV 0x24

// Error fatal durante la enumeracion: no se puede seguir asignando BARs.
// do/while(0) para que sea una sola sentencia (seguro dentro de if/else).
#define ENUM_ABORT()                                                           \
  do {                                                                         \
    final();                                                                   \
  } while (0)

volatile PCIe_Map *mapa = NULL;

// Enumeración de buses PCIe.
void bus_Enumeration(uint32_t bus, uint32_t *next_bus_number,
                     uint32_t *offset_BAR_Pos) {

  if (bus >= 256)
    return;

  for (uint32_t dev = (bus == 0) ? 1 : 0; dev < 32; dev++) {
    for (uint32_t func = 0; func < 8; func++) {
      uintptr_t base = ECAM_ADDR(bus, dev, func);
      uint32_t vendor_device = ECAM_R(base, OFF_VENDOR_DEVICE);
      if ((vendor_device & 0xFFFF) == 0xFFFF) {
        break;
      }
      if (Globals->map_size >= MAX_PCIE_DEVICES)
        return;

      uint32_t classcode_hdr = ECAM_R(base, OFF_CLASSCODE_HDR);
      uint32_t tipo_cabecera = (classcode_hdr >> 24) & 0x7F;

      // En el bus 0 no hay endpoints: se ignora el dispositivo
      if (tipo_cabecera == 0x00 && bus == 0)
        break;

      uint32_t current_idx = Globals->map_size;
      mapa[current_idx].start_address = MIN_BAR_POS + *offset_BAR_Pos;
      mapa[current_idx].bus = (uint8_t)bus;
      mapa[current_idx].dev = (uint8_t)dev;
      mapa[current_idx].func = (uint8_t)func;
      mapa[current_idx].ClassCode = classcode_hdr;

      if (tipo_cabecera == 0x00) {
        // ---- Endpoint (solo en buses secundarios) ----
        // No reserva con allocateIOMemory: lo cubre la ventana del puente.
        uint32_t valor[4] = {0};
        for (int i = 0; i <= 3; i++) {
          ECAM_W(base, OFF_BAR(i), 0xFFFFFFFF);
          valor[i] = ECAM_R(base, OFF_BAR(i));
          if (valor[i] == 0)
            continue;

          // El dispositivo informa el tamaño en bytes (minimo 1 pagina)
          uint32_t bar_size = (valor[i] <= 4096) ? 4096 : valor[i];

          // Debe entrar antes del LAPIC (el offset nunca supera
          // BAR_SPACE_SIZE)
          if (bar_size > BAR_SPACE_SIZE - *offset_BAR_Pos)
            ENUM_ABORT();

          // Redondear a pagina (sin desborde: bar_size <= BAR_SPACE_SIZE)
          bar_size = (bar_size + 4095) & 0xFFFFF000;

          // Tras redondear tambien debe entrar
          if (bar_size > BAR_SPACE_SIZE - *offset_BAR_Pos)
            ENUM_ABORT();

          ECAM_W(base, OFF_BAR(i), MIN_BAR_POS + *offset_BAR_Pos);
          *offset_BAR_Pos += bar_size;
        }
        mapa[current_idx].size =
            (MIN_BAR_POS + *offset_BAR_Pos) - mapa[current_idx].start_address;
        mapa[current_idx].end_address = MIN_BAR_POS + *offset_BAR_Pos;

        (Globals->map_size)++;
        return;

      } else if (tipo_cabecera == 0x01) {
        // ---- Puente ----
        // La ventana de un puente se alinea a 64 KB
        *offset_BAR_Pos = (*offset_BAR_Pos + 0xFFFF) & 0xFFFF0000;
        if (*offset_BAR_Pos > BAR_SPACE_SIZE)
          ENUM_ABORT();

        // Hay que poder numerar un bus secundario nuevo (0..255)
        if (*next_bus_number > 255)
          ENUM_ABORT();

        mapa[current_idx].start_address = MIN_BAR_POS + *offset_BAR_Pos;
        (Globals->map_size)++;

        uint32_t secondary_bus = (uint32_t)*next_bus_number;
        uint32_t pss = ECAM_R(base, OFF_PSS);
        pss &= ~0x00FFFFFF;
        pss |= (bus & 0xFF);
        pss |= ((secondary_bus & 0xFF) << 8);
        pss |= ((secondary_bus & 0xFF) << 16);
        ECAM_W(base, OFF_PSS, pss);
        (*next_bus_number)++;

        bus_Enumeration(secondary_bus, next_bus_number, offset_BAR_Pos);

        // Si los hijos consumieron espacio, cerrar la ventana alineada a 64
        // KB
        if (*offset_BAR_Pos > (mapa[current_idx].start_address - MIN_BAR_POS)) {
          *offset_BAR_Pos = (*offset_BAR_Pos + 0xFFFF) & 0xFFFF0000;
          if (*offset_BAR_Pos > BAR_SPACE_SIZE)
            ENUM_ABORT();
        }

        // Subordinate = ultimo bus usado debajo de este puente
        pss = ECAM_R(base, OFF_PSS);
        pss &= ~0x00FFFF00;
        pss |= ((secondary_bus & 0xFF) << 8);
        pss |= (((*next_bus_number - 1) & 0xFF) << 16);
        ECAM_W(base, OFF_PSS, pss);

        uint32_t end_address = MIN_BAR_POS + *offset_BAR_Pos;
        mapa[current_idx].end_address = end_address;
        mapa[current_idx].size = end_address - mapa[current_idx].start_address;

        uint32_t mbase = 0;
        uint32_t mlimit = 0;
        if (end_address > mapa[current_idx].start_address) {
          mbase = (mapa[current_idx].start_address >> 16) & 0xFFFF;
          mlimit = ((end_address - 1) >> 16) & 0xFFFF;

          // Solo los puentes del bus 0 reservan: su ventana completa ya
          // incluye a los hijos, puentes anidados y el relleno de alineacion.
          if (bus == 0 && allocateIOMemory(mapa[current_idx].start_address,
                                           end_address) != 0)
            ENUM_ABORT();
        }
        ECAM_W(base, OFF_MLIMITBASE,
               (mbase & 0xFFFF) | ((mlimit & 0xFFFF) << 16));
        // Memory space + bus master del puente
        ECAM_W(base, OFF_COMMAND_STATUS, 3);

      } else {
        break;
      }

      // Si no es multifuncion, no mirar las funciones 1..7
      if (func == 0 && !((classcode_hdr >> 24) & 0x80)) {
        break;
      }
    }
  }
}

void PCIe_Bus_Enumeration(void) {
  uint32_t bus = 0;
  uint32_t next_bus_number = 1;
  uint32_t offset_BAR_Pos = 0;

  if (allocatePages(TABLE_Addr, DEVICE_TABLE, 1, (void **)&mapa) != 0) {
    // Sino devuelve 0 se toma como error cantidad de memoria insuficiente
    final();
  }

  bus_Enumeration(bus, &next_bus_number, &offset_BAR_Pos);
}

// Busca y devuelve el offset del primer dispositivo encontrado
int searchFirst(uint32_t tipo) {
  for (uint32_t i = 0; i < Globals->map_size; i++) {
    if ((mapa[i].ClassCode & 0x00FFFFFF) == tipo) {
      return (int)i;
    }
  }
  return -1;
}

#define MAX_SEARCH_CAPACITY 32
// Busca y devuelve la cantidad de dispositivos encontrados (32 maximo)
uint32_t search(uint32_t tipo, uint32_t buffer[MAX_SEARCH_CAPACITY]) {

  uint32_t count = 0;

  for (uint32_t i = 0; i < Globals->map_size; i++) {
    if ((mapa[i].ClassCode & 0x00FFFFFF) == tipo) {
      buffer[count] = ECAM_ADDR(mapa[i].bus, mapa[i].dev, mapa[i].func);
      count++;
      if (count >= MAX_SEARCH_CAPACITY) {
        return count;
      }
    }
  }

  return count;
}