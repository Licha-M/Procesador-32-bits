#ifndef FAT_TYPES_H
#define FAT_TYPES_H

#include <stdbool.h>
#include <stdint.h>

extern volatile uint32_t nvm_selected;

// Estructura global para guardar los datos calculados del disco montado
typedef struct {
  uint32_t fat_start_lba;
  uint32_t data_start_lba;
  uint32_t sectors_per_cluster;
  uint32_t bytes_per_cluster;
  uint16_t bytes_per_sector;
} fat_volume_t;

extern fat_volume_t current_vol[32];

// Estructura de archivo simplificada
struct directoryEntry {
  uint8_t name[13];       // Formato de nombre
  uint8_t attributes;     // Datos del archivo
  uint32_t first_cluster; // Dirección del primer clúster
  uint32_t file_size;     // En bytes
} __attribute__((packed));

int fat_mount(void);
int fat_find_file(uint32_t dir_cluster, const char *target_name,
                  struct directoryEntry *out_entry);
uint32_t fat_cluster_to_lba(uint32_t cluster);

#endif