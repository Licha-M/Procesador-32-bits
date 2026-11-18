#include "uefiCalls.h"

// Lee la cantidad de RAM ECAM_R(ECAM_ADDR(0, 0, 0), 0x4)

// Aloja porciones pequeñas de RAM, medidas en Bytes
int allocatePool(uint32_t type, uint32_t size, void **buffer) { return 0; }

// Aloja paginas enteras de RAM
int allocatePages(uint32_t addres, uint32_t type, uint32_t cant,
                  void **buffer) {
  return 0;
}