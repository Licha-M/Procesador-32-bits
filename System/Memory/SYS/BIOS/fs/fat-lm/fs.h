#ifndef DRIVERS_FS_H
#define DRIVERS_FS_H

#include <stdbool.h>
#include <stdint.h>

// Driver de solo lectura para GPT + CustomFS (ver packer.py).

#define FS_OK 0
#define FS_ERR_IO (-1)           // falló nvm_read_sectors
#define FS_ERR_NOMEM (-2)
#define FS_ERR_NOT_GPT (-3)      // firma/CRC de GPT inválidos
#define FS_ERR_BAD_FS (-4)       // la partición no es CustomFS válido
#define FS_ERR_NOT_FOUND (-5)
#define FS_ERR_NOT_DIR (-6)
#define FS_ERR_IS_DIR (-7)
#define FS_ERR_CORRUPT (-8)      // cadena FAT / dirent inconsistente
#define FS_ERR_NAME_TOO_LONG (-9)
#define FS_ERR_PARAM (-10)

#define FS_NAME_MAX 31
#define FS_MAX_PARTS 16

#define FS_ATTR_READONLY 0x01
#define FS_ATTR_DIRECTORY 0x02
#define FS_ATTR_HIDDEN 0x04

// Una partición encontrada en la tabla GPT.
typedef struct {
  uint32_t first_lba;
  uint32_t sector_count;
  bool customfs;      // el GUID de tipo es el de CustomFS
  char name[37];      // nombre GPT (UTF-16 -> ASCII)
} FsPartInfo;

// Volumen montado (una partición CustomFS).
typedef struct {
  uint32_t disp;          // índice de NVM
  uint32_t part_lba;
  uint32_t fat_start;     // LBA absoluto de la FAT 1
  uint32_t data_start;    // LBA absoluto del clúster 2
  uint32_t root_cluster;
  uint32_t total_clusters;
  uint32_t cluster_bytes;
  uint8_t spc_shift;      // log2(sectores por clúster)
  uint8_t cluster_shift;  // log2(bytes por clúster)
  uint32_t cluster_mask;  // cluster_bytes - 1
  char label[33];
  uint8_t *fatBuf;        // caché de 1 página (4 KB) de FAT
  uint32_t fatLba;        // LBA donde empieza la página cacheada
  uint8_t *dataBuf;       // caché de 1 página (4 KB) de datos
  uint32_t dataLba;       // LBA (múltiplo de 8) de la página cacheada
} FsVolume;

// Resultado de fs_stat / fs_readdir.
typedef struct {
  char name[FS_NAME_MAX + 1];
  uint8_t attr;
  uint32_t first_cluster;
  uint32_t size;
  uint32_t mtime;
} FsStat;

typedef struct {
  FsVolume *v;
  uint32_t first;
  uint32_t size;
  uint32_t pos;
  uint32_t cluster;  // clúster que contiene el índice cidx de la cadena
  uint32_t cidx;
} FsFile;

typedef struct {
  FsVolume *v;
  uint32_t cluster;  // 0 = fin del directorio
  uint32_t offset;   // byte dentro del clúster actual
  uint32_t seen;     // clústeres recorridos (anti-ciclos)
} FsDir;

// Lista las particiones GPT del disco (verifica firma y CRC).
int fs_gpt_list(uint32_t disp, FsPartInfo *parts, uint32_t max,
                uint32_t *count);

// Monta una partición CustomFS / la busca por nombre GPT.
int fs_mount(FsVolume *v, uint32_t disp, const FsPartInfo *p);
int fs_mount_label(FsVolume *v, uint32_t disp, const char *label);
void fs_unmount(FsVolume *v);

// Rutas tipo "/boot/kernel.bin" relativas a la raíz del volumen.
int fs_stat(FsVolume *v, const char *path, FsStat *out);
int fs_open(FsVolume *v, const char *path, FsFile *f);
int fs_read(FsFile *f, void *buf, uint32_t n, uint32_t *got);
int fs_seek(FsFile *f, uint32_t pos);

int fs_opendir(FsVolume *v, const char *path, FsDir *d);
// 1 = entrada devuelta, 0 = fin, <0 = error. Omite "." y "..".
int fs_readdir(FsDir *d, FsStat *out);

#endif
