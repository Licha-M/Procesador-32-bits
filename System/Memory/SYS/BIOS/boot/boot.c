#include "boot.h"
#include "../lib/string.h"
#include "../lib/uefiCalls.h"

#define BOOT_PART "EFI"          // etiqueta GPT de la partición de arranque
#define BOOT_SKIP "EFI_Services" // carpeta que no cuenta como bootloader
#define BOOT_PAGE_SHIFT 12       // páginas de 4 KB

// Dónde y como se carga el .bin. Si tu bootloader está linkeado a una
// dirección fija, poné aquí esa dirección (alineada a 4 KB); con ANY_MEMORY
// el binario tiene que ser independiente de la posición.
#define BOOT_LOAD_ADDR ANY_MEMORY

BootEntry *bootEntries = NULL;
uint32_t bootCount = 0;
int32_t bootSelected;

// true si el nombre termina en ".bin" (sin distinguir mayúsculas)
static bool hasBinExt(const char *n) {
  size_t l = strlen(n);
  if (l <= 4)
    return false;
  const char *e = n + l - 4;
  return e[0] == '.' && (e[1] | 0x20) == 'b' && (e[2] | 0x20) == 'i' &&
         (e[3] | 0x20) == 'n';
}

int bootInit(void) {
  bootCount = 0;
  bootSelected = -1;
  bootEntries = NULL;
  if (allocatePool(DEVICE_DATA, sizeof(BootEntry) * BOOT_MAX_ENTRIES,
                   (void **)&bootEntries) != 0 ||
      bootEntries == NULL) {
    bootEntries = NULL;
    return -1;
  }
  return 0;
}

uint32_t bootScanDisk(uint32_t disp) {
  if (bootEntries == NULL)
    return 0;

  FsVolume vol;
  if (fs_mount_label(&vol, disp, BOOT_PART) != FS_OK)
    return 0; // sin GPT válida o sin partición EFI

  uint32_t added = 0;
  FsDir root;
  FsStat folder;
  if (fs_opendir(&vol, "/", &root) == FS_OK) {
    while (bootCount < BOOT_MAX_ENTRIES && fs_readdir(&root, &folder) > 0) {
      if (!(folder.attr & FS_ATTR_DIRECTORY) ||
          strcmp(folder.name, BOOT_SKIP) == 0)
        continue;

      char path[FS_NAME_MAX + 2]; // "/" + carpeta + '\0'
      path[0] = '/';
      strncpy(path + 1, folder.name, FS_NAME_MAX);
      path[FS_NAME_MAX + 1] = 0;

      FsDir dir;
      FsStat file;
      if (fs_opendir(&vol, path, &dir) != FS_OK)
        continue;
      while (bootCount < BOOT_MAX_ENTRIES && fs_readdir(&dir, &file) > 0) {
        if ((file.attr & FS_ATTR_DIRECTORY) || file.size == 0 ||
            !hasBinExt(file.name))
          continue;
        BootEntry *e = &bootEntries[bootCount++];
        e->disp = disp;
        strncpy(e->folder, folder.name, FS_NAME_MAX);
        e->folder[FS_NAME_MAX] = 0;
        strncpy(e->file, file.name, FS_NAME_MAX);
        e->file[FS_NAME_MAX] = 0;
        added++;
      }
    }
  }
  fs_unmount(&vol); // libera las 2 páginas de caché
  return added;
}

// Arma "/carpeta/archivo" en 'path' (tamaño mínimo 2*FS_NAME_MAX + 3).
static void buildPath(char *path, const BootEntry *e) {
  uint32_t n = 0;
  path[n++] = '/';
  for (const char *p = e->folder; *p; p++)
    path[n++] = *p;
  path[n++] = '/';
  for (const char *p = e->file; *p; p++)
    path[n++] = *p;
  path[n] = 0;
}

int bootRun(uint32_t id) {
  if (id >= bootCount)
    return BOOT_ERR_BAD_ID;
  const BootEntry *e = &bootEntries[id];

  FsVolume vol;
  if (fs_mount_label(&vol, e->disp, BOOT_PART) != FS_OK)
    return BOOT_ERR_FS;

  char path[2 * FS_NAME_MAX + 3];
  buildPath(path, e);

  FsStat st;
  if (fs_stat(&vol, path, &st) != FS_OK || (st.attr & FS_ATTR_DIRECTORY) ||
      st.size == 0) {
    fs_unmount(&vol);
    return BOOT_ERR_FILE;
  }

  uint32_t pages = (st.size + (1u << BOOT_PAGE_SHIFT) - 1u) >> BOOT_PAGE_SHIFT;
  void *base = NULL;
  if (allocatePages(BOOT_LOAD_ADDR, BOOTLOADER_CODE, pages, &base) != 0 ||
      base == NULL) {
    fs_unmount(&vol);
    return BOOT_ERR_MEM;
  }

  FsFile f;
  uint32_t got = 0;
  int r = fs_open(&vol, path, &f);
  if (r == FS_OK)
    r = fs_read(&f, base, st.size,
                &got); // base alineada a 4 KB: lectura directa
  fs_unmount(&vol);    // ya no hace falta el FS
  if (r != FS_OK || got != st.size) {
    freePages(pages, &base);
    return BOOT_ERR_FILE;
  }

#ifndef BOOT_NO_JUMP
  ((void (*)(void))base)(); // entrega el control al bootloader
#endif

  freePages(pages, &base); // si el bootloader devolvió el control
  return BOOT_OK;
}
