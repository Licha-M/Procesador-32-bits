#include "../../bios_types.h"
#include "../../drivers/nvm/nvm.h"
#include "../../drivers/tty/tty.h"
#include "../../hal/lapic.h"
#include "fat_types.h"
#include <stdbool.h>
#include <stdint.h>

#define FAT_EOF 0xFFFFFFF8

// Lee la tabla FAT para encontrar el siguiente clúster de un archivo.
uint32_t fat_get_next_cluster(uint32_t cluster) {

  // Calculamos la posición del cluster
  uint32_t fat_offset = cluster * 4;
  // Sector dentro del cluster
  uint32_t fat_sector =
      current_vol[nvm_selected].fat_start_lba +
      (fat_offset / current_vol[nvm_selected].bytes_per_sector);
  // Offset dentro del sector
  uint32_t entry_offset =
      fat_offset % current_vol[nvm_selected].bytes_per_sector;

  // Buffer del sector
  uint32_t sector_buffer[HARDWARE_PAGE_SIZE / sizeof(uint32_t)];

  // Leemos la pagina y revisamos que salio todo bien
  int response = nvm_read_sectors(nvm_selected, fat_sector, 1, sector_buffer);

  if (response == NVM_INVALID_OPTION) {
    irqOff();
    system_panic = true;
    biosWrite("Error en el acceso al NVM", 0);
    final();
  } else if (response == NVM_DEVICE_NOT_RECOGNIZED) {
    biosWrite("Dispositivo NVM no reconocido", 0);
    return NVM_DEVICE_NOT_RECOGNIZED;
  }

  // Ordena el buffer y extrae el siguiente cluster
  uint32_t *fat_entries = (uint32_t *)sector_buffer;
  uint32_t next_cluster = fat_entries[entry_offset / 4];

  // Revisamos que el archivo no termine ahi
  if (next_cluster >= FAT_EOF)
    return 0xFFFFFFFF;

  return next_cluster;
}