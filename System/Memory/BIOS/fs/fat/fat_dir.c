#include "../../drivers/nvm/nvm.h"
#include "../../drivers/tty/tty.h"
#include "../../hal/lapic.h"
#include "../../lib/string.h"
#include "fat_types.h"

// Declaramos la función externa o la incluimos si está en fat.h
extern uint32_t fat_get_next_cluster(uint32_t cluster);

// Este buffer vive en la sección de datos globales, no en la pila.
// Está alineado implícitamente y es seguro para lecturas de 4KB del SSD.
static uint8_t fat_page_buffer[HARDWARE_PAGE_SIZE];

/**
 * Busca un archivo o carpeta dentro de un clúster de directorio específico.
 */
int fat_find_file(uint32_t dir_cluster, const char *target_name,
                  struct directoryEntry *out_entry) {
  uint32_t bytes_per_sector = current_vol[nvm_selected].bytes_per_sector;
  uint32_t sectors_per_cluster = current_vol[nvm_selected].sectors_per_cluster;

  // Validación de seguridad para el hardware
  if (bytes_per_sector > HARDWARE_PAGE_SIZE) {
    return -1;
  }

  uint32_t current_cluster = dir_cluster;

  while (current_cluster != 0xFFFFFFFF && current_cluster < 0x0FFFFFF8) {
    uint32_t start_lba = fat_cluster_to_lba(current_cluster);
    if (start_lba == 0xFFFFFFFF)
      return -1;

    for (uint32_t s = 0; s < sectors_per_cluster; s++) {
      // Leemos de forma segura una página completa de 4KB en el buffer global
      int response = nvm_read_sectors(nvm_selected, start_lba + s, 1,
                                      (uint32_t *)fat_page_buffer);
      if (response == NVM_INVALID_OPTION) {
        irqOff();
        system_panic = true;
        biosWrite("Error en el acceso al NVM", 0);
        final();
      } else if (response == NVM_DEVICE_NOT_RECOGNIZED) {
        biosWrite("Dispositivo NVM no reconocido", 0);
        return NVM_DEVICE_NOT_RECOGNIZED;
      }

      uint32_t entries_per_sector =
          bytes_per_sector / sizeof(struct directoryEntry);
      struct directoryEntry *entries = (struct directoryEntry *)fat_page_buffer;

      for (uint32_t i = 0; i < entries_per_sector; i++) {
        if (entries[i].name[0] == 0x00)
          return -1;

        if (entries[i].name[0] == 0xE5)
          continue;

        if (memcmp(entries[i].name, target_name, 13) == 0) {
          if (out_entry != NULL) {
            *out_entry = entries[i];
          }
          return 0;
        }
      }
    }
    current_cluster = fat_get_next_cluster(current_cluster);
  }
  return -1;
}

/**
 * Permite navegar por rutas separadas por barras (ej: "/sistema/kernel.bin")
 * o buscar directamente en la raíz si la ruta es simple ("boot.bin").
 */
int fat_navigate_path(const char *path, struct directoryEntry *out_entry) {
  // En FAT32, por defecto el directorio raíz suele comenzar en el clúster
  // especificado en el BPB (o puedes asumir el clúster raíz estándar,
  // típicamente el clúster 2 en FAT32).
  uint32_t current_cluster = 2;

  char path_copy[128];
  strncpy(path_copy, path, sizeof(path_copy));

  char *token = strtok(path_copy, "/");
  struct directoryEntry current_entry;

  while (token != NULL) {
    int response = fat_find_file(current_cluster, token, &current_entry);
    if (response != 0)
      return response; // No se encontró el directorio o archivo en este nivel

    // Verificamos si es una carpeta (puedes revisar el byte de atributos, ej:
    // 0x10 es directorio)
    if (current_entry.attributes & 0x10) {
      current_cluster = current_entry.first_cluster;
      token = strtok(NULL, "/");
    } else {
      // Si llegamos a un archivo pero aún quedan tokens en la ruta, hay un
      // error
      char *next_token = strtok(NULL, "/");
      if (next_token != NULL) {
        return -1; // Intentó entrar a un archivo como si fuera carpeta
      }
      break;
    }
  }

  if (out_entry != NULL) {
    *out_entry = current_entry;
  }
  return 0;
}