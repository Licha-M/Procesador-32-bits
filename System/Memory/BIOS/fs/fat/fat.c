#include "../../bios_types.h"
#include "../../drivers/nvm/nvm.h"
#include "../../drivers/tty/tty.h"
#include "../../hal/lapic.h"
#include "fat_types.h"
#include <stdint.h>

struct fat_boot_sector {
  uint8_t jmp_boot[12]; // Instrucción de salto (JMP)

  // --- BIOS Parameter Block (BPB) ---
  uint16_t bytes_per_sector;   // Típicamente 512
  uint8_t sectors_per_cluster; // Sectores por clúster
  uint16_t reserved_sectors;   // Sectores reservados antes de la FAT
  uint8_t num_fats;            // Número de tablas FAT
  uint16_t sectors_per_fat;    // Sectores que ocupa cada tabla FAT
  uint32_t total_sectors;      // Total de sectores

  // --- Extended Boot Record (FAT16/FAT12) ---
  uint32_t volume_id;           // Número de serie del volumen
  uint8_t volume_label[11];     // Etiqueta del volumen
  uint8_t file_system_type[11]; // Indica que FS usa

  // --- Código de arranque y firma ---
  uint8_t boot_code[460];  // Código ejecutable del bootloader
  uint16_t signature_word; // Firma de fin de sector: 0xAA55
  uint8_t raw[3584];
} __attribute__((packed));

fat_volume_t current_vol[32];

volatile uint32_t nvm_selected = 0;

// Montaje del sistema FAT
int fat_mount(NvmDev *dev) {

  struct fat_boot_sector BPB;
  int response = nvm_read_sectors(nvm_selected, 0, 1, (uint32_t *)&BPB);
  if (response == NVM_INVALID_OPTION) {
    irqOff();
    system_panic = true;
    biosWrite("Error en el acceso al NVM", 0);
    final();
  } else if (response == NVM_DEVICE_NOT_RECOGNIZED) {
    biosWrite("Dispositivo NVM no reconocido", 0);
    return NVM_DEVICE_NOT_RECOGNIZED;
  }

  if (BPB.signature_word != 0xAA55) {
    // El disco no tiene una firma FAT válida
    return -1;
  }

  uint32_t fat_size = BPB.sectors_per_fat;
  uint32_t reserved = BPB.reserved_sectors;
  uint32_t num_fats = BPB.num_fats;

  // Comienzo de tablas FAT
  current_vol[nvm_selected].fat_start_lba = reserved;
  // Zona de datos
  current_vol[nvm_selected].data_start_lba = reserved + (num_fats * fat_size);
  // Sectores por cluster
  current_vol[nvm_selected].sectors_per_cluster = BPB.sectors_per_cluster;
  // Bytes por cluster
  current_vol[nvm_selected].bytes_per_cluster =
      BPB.bytes_per_sector * BPB.sectors_per_cluster;
  // Bytes por sector
  current_vol[nvm_selected].bytes_per_sector = BPB.bytes_per_sector;

  strncpy(dev->name, (const char *)(BPB.volume_label), 11);
  dev->name[11] = '\0';

  return 0;
}

uint32_t fat_cluster_to_lba(uint32_t cluster) {
  // Fórmula: LBA_Data_Inicio + cluster * sectores_por_cluster
  return (cluster >= 2) ? current_vol[nvm_selected].data_start_lba +
                              ((cluster - 2) *
                               current_vol[nvm_selected].sectors_per_cluster)
                        : 0xFFFFFFFF;
}