#include "ecam.h"

#define MIN_BAR_POS 0xC0000000

#define OFF_VENDOR_DEVICE 0x00
#define OFF_COMMAND_STATUS 0x04
#define OFF_CLASSCODE_HDR 0x08
#define OFF_PSS 0x10
#define OFF_CAP_PTR_BRIDGE 0x14
#define OFF_MLIMITBASE 0x18
#define OFF_BAR(i) (0x10 + (uint32_t)(i) * 4)
#define OFF_ROM 0x20
#define OFF_CAP_PTR_DEV 0x24

volatile PCIe_Map *mapa = (volatile PCIe_Map *)(TABLE_Addr);
int map_size = 0;

void bus_Enumeration(uint32_t bus, int *next_bus_number, int *offset_BAR_Pos) {
  if (bus >= 256)
    return;
  for (uint32_t dev = 0; dev < 32; dev++) {
    for (uint32_t func = 0; func < 8; func++) {
      uintptr_t base = ECAM_ADDR(bus, dev, func);
      uint32_t vendor_device = ECAM_R(base, OFF_VENDOR_DEVICE);
      if ((vendor_device & 0xFFFF) == 0xFFFF) {
        if (bus != 0 && dev == 0)
          return;
        break;
      }
      if (map_size >= MAX_PCIE_DEVICES)
        return;

      int current_idx = map_size;
      mapa[current_idx].start_address = MIN_BAR_POS + *offset_BAR_Pos;
      mapa[current_idx].bus = (uint8_t)bus;
      mapa[current_idx].dev = (uint8_t)dev;
      mapa[current_idx].func = (uint8_t)func;

      uint32_t classcode_hdr = ECAM_R(base, OFF_CLASSCODE_HDR);
      mapa[current_idx].ClassCode = classcode_hdr;
      uint32_t tipo_cabecera = (classcode_hdr >> 24) & 0x7F;

      if (tipo_cabecera == 0x00) {
        uint32_t valor[4] = {0};
        for (int i = 0; i <= 3; i++) {
          ECAM_W(base, OFF_BAR(i), 0xFFFFFFFF);
          valor[i] = ECAM_R(base, OFF_BAR(i));
          if (valor[i] == 0)
            continue;
          if (valor[i] <= 4096) {
            ECAM_W(base, OFF_BAR(i), MIN_BAR_POS + *offset_BAR_Pos);
            *offset_BAR_Pos += 4096;
          } else {
            ECAM_W(base, OFF_BAR(i), MIN_BAR_POS + *offset_BAR_Pos);
            *offset_BAR_Pos += (valor[i] + 4095) & 0xFFFFF000;
          }
        }
        mapa[current_idx].size =
            (MIN_BAR_POS + *offset_BAR_Pos) - mapa[current_idx].start_address;
        mapa[current_idx].end_address = MIN_BAR_POS + *offset_BAR_Pos;
        (map_size)++;
        return;
      } else if (tipo_cabecera == 0x01) {
        *offset_BAR_Pos = (*offset_BAR_Pos + 0xFFFF) & 0xFFFF0000;
        mapa[current_idx].start_address = MIN_BAR_POS + *offset_BAR_Pos;
        (map_size)++;
        uint32_t secondary_bus = (uint32_t)*next_bus_number;
        uint32_t pss = ECAM_R(base, OFF_PSS);
        pss &= ~0x00FFFFFF;
        pss |= (bus & 0xFF);
        pss |= ((secondary_bus & 0xFF) << 8);
        pss |= ((secondary_bus & 0xFF) << 16);
        ECAM_W(base, OFF_PSS, pss);
        (*next_bus_number)++;
        bus_Enumeration(secondary_bus, next_bus_number, offset_BAR_Pos);
        if (*offset_BAR_Pos > (mapa[current_idx].start_address - MIN_BAR_POS)) {
          *offset_BAR_Pos = (*offset_BAR_Pos + 0xFFFF) & 0xFFFF0000;
        }
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
          ECAM_W(base, OFF_COMMAND_STATUS, 3);
        }
        ECAM_W(base, OFF_MLIMITBASE,
               (mbase & 0xFFFF) | ((mlimit & 0xFFFF) << 16));
      } else {
        break;
      }
      if (func == 0 && !((classcode_hdr >> 24) & 0x80)) {
        break;
      }
    }
  }
}

void PCIe_Bus_Enumeration(void) {
  uint32_t bus = 0;
  int next_bus_number = 1;
  int offset_BAR_Pos = 0;
  bus_Enumeration(bus, &next_bus_number, &offset_BAR_Pos);
}

int search(uint32_t tipo) {
  for (int i = 0; i < map_size; i++) {
    if ((mapa[i].ClassCode & 0x00FFFFFF) == tipo) {
      return i;
    }
  }
  return -1;
}
