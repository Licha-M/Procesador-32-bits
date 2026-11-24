#include "fs.h"
#include "../../drivers/nvm/nvm.h"
#include <stddef.h>

#ifndef FS_ALLOC
#include "../../lib/uefiCalls.h"
#define FS_ALLOC(size, pp) allocatePool(DEVICE_DATA, (size), (void **)(pp))
#define FS_FREE(p) freePool((void **)&(p)) // freePool(void **) deja p en NULL
// Cachés: páginas de 4 KB alineadas a página (coinciden con la página del SSD)
#define FS_ALLOC_PAGES(n, pp)                                                  \
  allocatePages(ANY_MEMORY, DEVICE_DATA, (n), (void **)(pp))
#define FS_FREE_PAGES(n, p) freePages((n), (void **)&(p))
#endif

#define SECTOR 512
#define PAGE_SECTORS 8u // página del SSD = 4 KB = 8 sectores
#define PAGE_BYTES 4096u
#define FAT_EOF 0xFFFFFFFFu
#define FAT_EOF_MIN 0xFFFFFFF8u
#define NO_LBA 0xFFFFFFFFu
#define MAX_CMD_SECTORS 128u // tope de sectores por comando NVM
#define CHECK_GPT_CRC 1

// Offsets de las estructuras de packer.py (little endian, sin padding)
#define GPT_H_SIZE 12
#define GPT_H_CRC 16
#define GPT_H_CUR 24
#define GPT_H_ENT_LBA 72
#define GPT_H_ENT_COUNT 80
#define GPT_H_ENT_SIZE 84
#define GPT_H_ENT_CRC 88
#define GPT_E_FIRST 32
#define GPT_E_LAST 40
#define GPT_E_NAME 56

#define BPB_VERSION 8
#define BPB_BPS 10
#define BPB_SPC 12
#define BPB_NFATS 13
#define BPB_RESERVED 14
#define BPB_PART_START 16
#define BPB_FAT_SECTORS 32
#define BPB_ROOT 36
#define BPB_CLUSTERS 40
#define BPB_LABEL 56

#define DE_SIZE 64
#define DE_ATTR 32
#define DE_CLUSTER 36
#define DE_FSIZE 40
#define DE_MTIME 44

static const uint8_t CUSTOMFS_GUID[16] = {0x74, 0x73, 0x75, 0x43, 0x6D, 0x6F,
                                          0x53, 0x46, 0x00, 0x00, 0x00, 0x00,
                                          0x00, 0x00, 0x00, 0x01};

// ---- utilidades sin libc ---------------------------------------------------
static uint16_t rd16(const uint8_t *p) { return p[0] | (p[1] << 8); }
static uint32_t rd32(const uint8_t *p) {
  return (uint32_t)p[0] | ((uint32_t)p[1] << 8) | ((uint32_t)p[2] << 16) |
         ((uint32_t)p[3] << 24);
}
static void copy(void *d, const void *s, uint32_t n) {
  uint8_t *dd = d;
  const uint8_t *ss = s;
  while (n--)
    *dd++ = *ss++;
}
static bool same(const void *a, const void *b, uint32_t n) {
  const uint8_t *x = a, *y = b;
  while (n--)
    if (*x++ != *y++)
      return false;
  return true;
}
static bool streq(const char *a, const char *b) {
  while (*a && *a == *b) {
    a++;
    b++;
  }
  return *a == *b;
}
static uint8_t log2u(uint32_t v) {
  uint8_t s = 0;
  while ((1u << s) < v)
    s++;
  return s;
}
static uint32_t crc32Update(uint32_t c, const uint8_t *p, uint32_t n) {
  while (n--) {
    c ^= *p++;
    for (int i = 0; i < 8; i++)
      c = (c >> 1) ^ ((c & 1) ? 0xEDB88320u : 0);
  }
  return c;
}

static int devRead(uint32_t disp, uint32_t lba, uint32_t count, void *buf) {
  return nvm_read_sectors(disp, lba, count, (uint32_t *)buf) == NVM_OK
             ? FS_OK
             : FS_ERR_IO;
}

// ---- GPT -------------------------------------------------------------------
int fs_gpt_list(uint32_t disp, FsPartInfo *parts, uint32_t max,
                uint32_t *count) {
  uint8_t *buf = NULL;
  *count = 0;
  if (FS_ALLOC(SECTOR, &buf) != 0 || buf == NULL)
    return FS_ERR_NOMEM;

  int r = devRead(disp, 1, 1, buf); // cabecera primaria en LBA 1
  if (r != FS_OK)
    goto out;

  static const uint8_t sig[8] = {'E', 'F', 'I', ' ', 'P', 'A', 'R', 'T'};
  uint32_t hsize = rd32(buf + GPT_H_SIZE);
  uint32_t esize = rd32(buf + GPT_H_ENT_SIZE);
  uint32_t ecount = rd32(buf + GPT_H_ENT_COUNT);
  uint32_t elba = rd32(buf + GPT_H_ENT_LBA);
  uint32_t ecrc = rd32(buf + GPT_H_ENT_CRC);
  if (!same(buf, sig, 8) || hsize < 92 || hsize > SECTOR || esize < 128 ||
      (SECTOR % esize) != 0 || rd32(buf + GPT_H_CUR) != 1) {
    r = FS_ERR_NOT_GPT;
    goto out;
  }
#if CHECK_GPT_CRC
  {
    static const uint8_t zero[4] = {0, 0, 0, 0};
    uint32_t c = crc32Update(0xFFFFFFFFu, buf, GPT_H_CRC);
    c = crc32Update(c, zero, 4);
    c = crc32Update(c, buf + GPT_H_CRC + 4, hsize - GPT_H_CRC - 4);
    if ((c ^ 0xFFFFFFFFu) != rd32(buf + GPT_H_CRC)) {
      r = FS_ERR_NOT_GPT;
      goto out;
    }
  }
#endif

  uint32_t crc = 0xFFFFFFFFu;
  uint32_t remaining = ecount * esize; // bytes de la tabla
  uint32_t perSector = SECTOR / esize;
  uint32_t idx = 0;
  for (uint32_t lba = elba; remaining; lba++) {
    r = devRead(disp, lba, 1, buf);
    if (r != FS_OK)
      goto out;
    uint32_t chunk = remaining < SECTOR ? remaining : SECTOR;
    crc = crc32Update(crc, buf, chunk);
    remaining -= chunk;

    for (uint32_t e = 0; e < perSector && idx < ecount; e++, idx++) {
      const uint8_t *en = buf + e * esize;
      bool empty = true;
      for (int i = 0; i < 16; i++)
        if (en[i]) {
          empty = false;
          break;
        }
      if (empty || *count >= max)
        continue;
      if (rd32(en + GPT_E_FIRST + 4) || rd32(en + GPT_E_LAST + 4))
        continue; // LBA > 32 bits: fuera de alcance del driver NVM
      FsPartInfo *p = &parts[*count];
      p->first_lba = rd32(en + GPT_E_FIRST);
      p->sector_count = rd32(en + GPT_E_LAST) - p->first_lba + 1;
      p->customfs = same(en, CUSTOMFS_GUID, 16);
      int i;
      for (i = 0; i < 36; i++) {
        uint16_t ch = rd16(en + GPT_E_NAME + i * 2);
        if (ch == 0)
          break;
        p->name[i] = ch < 0x80 ? (char)ch : '?';
      }
      p->name[i] = 0;
      (*count)++;
    }
  }
#if CHECK_GPT_CRC
  if ((crc ^ 0xFFFFFFFFu) != ecrc) {
    *count = 0;
    r = FS_ERR_NOT_GPT;
    goto out;
  }
#else
  (void)crc;
  (void)ecrc;
#endif
  r = FS_OK;
out:
  FS_FREE(buf);
  return r;
}

// ---- Caché de datos (1 página de SSD = 8 sectores)
// --------------------------- Devuelve un puntero al sector 'lba' dentro de la
// caché; si la página que lo contiene no está cargada, la lee entera con UN
// solo comando NVM.
static const uint8_t *dataPtr(FsVolume *v, uint32_t lba) {
  uint32_t base = lba & ~(PAGE_SECTORS - 1u);
  if (v->dataLba != base) {
    v->dataLba = NO_LBA;
    if (devRead(v->disp, base, PAGE_SECTORS, v->dataBuf) != FS_OK)
      return NULL;
    v->dataLba = base;
  }
  return v->dataBuf + ((lba - base) << 9);
}

// ---- Montaje ---------------------------------------------------------------
int fs_mount(FsVolume *v, uint32_t disp, const FsPartInfo *p) {
  if (!p->customfs)
    return FS_ERR_BAD_FS;
  uint8_t *mem = NULL; // 2 páginas: caché de FAT + caché de datos
  if (FS_ALLOC_PAGES(2, &mem) != 0 || mem == NULL)
    return FS_ERR_NOMEM;
  v->fatBuf = mem;
  v->dataBuf = mem + PAGE_BYTES;
  v->fatLba = NO_LBA;
  v->dataLba = NO_LBA;
  v->disp = disp;

  int r = FS_OK;
  const uint8_t *b = dataPtr(v, p->first_lba); // sector 0 de la partición
  if (b == NULL) {
    r = FS_ERR_IO;
    goto fail;
  }

  uint32_t spc = b[BPB_SPC], nfats = b[BPB_NFATS];
  uint32_t reserved = rd16(b + BPB_RESERVED);
  uint32_t fatSectors = rd32(b + BPB_FAT_SECTORS);
  v->root_cluster = rd32(b + BPB_ROOT);
  v->total_clusters = rd32(b + BPB_CLUSTERS);

  if (!same(b, "CUSTOMFS", 8) || rd16(b + BPB_VERSION) != 1 ||
      rd16(b + BPB_BPS) != SECTOR || spc == 0 || (spc & (spc - 1)) ||
      nfats < 1 || nfats > 2 || reserved == 0 ||
      rd32(b + BPB_PART_START) != p->first_lba || v->root_cluster < 2 ||
      v->total_clusters == 0 || v->total_clusters + 2 > (fatSectors << 7)) {
    r = FS_ERR_BAD_FS;
    goto fail;
  }

  v->part_lba = p->first_lba;
  v->spc_shift = log2u(spc);
  v->cluster_shift = v->spc_shift + 9;
  v->cluster_bytes = SECTOR << v->spc_shift;
  v->cluster_mask = v->cluster_bytes - 1;
  v->fat_start = p->first_lba + reserved;
  v->data_start = v->fat_start + (nfats == 2 ? fatSectors << 1 : fatSectors);
  copy(v->label, b + BPB_LABEL, 32);
  v->label[32] = 0;
  return FS_OK;

fail:
  FS_FREE_PAGES(2, mem);
  v->fatBuf = v->dataBuf = NULL;
  return r;
}

int fs_mount_label(FsVolume *v, uint32_t disp, const char *label) {
  FsPartInfo parts[FS_MAX_PARTS];
  uint32_t n;
  int r = fs_gpt_list(disp, parts, FS_MAX_PARTS, &n);
  if (r != FS_OK)
    return r;
  for (uint32_t i = 0; i < n; i++)
    if (parts[i].customfs && streq(parts[i].name, label))
      return fs_mount(v, disp, &parts[i]);
  return FS_ERR_NOT_FOUND;
}

void fs_unmount(FsVolume *v) {
  if (v->fatBuf)
    FS_FREE_PAGES(2, v->fatBuf); // dataBuf comparte la misma reserva
  v->fatBuf = v->dataBuf = NULL;
}

// ---- Capa de clústeres / FAT ----------------------------------------------
static uint32_t clusterLba(FsVolume *v, uint32_t c) {
  return v->data_start + ((c - 2) << v->spc_shift);
}

// Siguiente clúster de la cadena: FAT_EOF si termina, 0 si hay error.
static uint32_t fatNext(FsVolume *v, uint32_t c) {
  if (c < 2 || c > v->total_clusters + 1)
    return 0;
  uint32_t lba = v->fat_start + ((c >> 10) << 3); // 1024 entradas por página
  if (lba != v->fatLba) {
    v->fatLba = NO_LBA;
    if (devRead(v->disp, lba, PAGE_SECTORS, v->fatBuf) != FS_OK)
      return 0;
    v->fatLba = lba;
  }
  uint32_t n = rd32(v->fatBuf + ((c & 1023) << 2));
  if (n >= FAT_EOF_MIN)
    return FAT_EOF;
  if (n < 2 || n > v->total_clusters + 1)
    return 0; // libre / defectuoso / fuera de rango dentro de una cadena
  return n;
}

// ---- Directorios -----------------------------------------------------------
static int dirOpen(FsVolume *v, uint32_t cluster, FsDir *d) {
  if (cluster < 2 || cluster > v->total_clusters + 1)
    return FS_ERR_CORRUPT;
  d->v = v;
  d->cluster = cluster;
  d->offset = 0;
  d->seen = 1;
  return FS_OK;
}

// Como fs_readdir pero incluye "." y "..".
static int dirNext(FsDir *d, FsStat *out) {
  FsVolume *v = d->v;
  for (;;) {
    if (d->cluster == 0)
      return 0;
    const uint8_t *sec =
        dataPtr(v, clusterLba(v, d->cluster) + (d->offset >> 9));
    if (sec == NULL)
      return FS_ERR_IO;
    const uint8_t *e = sec + (d->offset & (SECTOR - 1));
    bool end = (e[0] == 0); // name[0] == 0 => fin del directorio
    bool deleted = (e[0] == 0xE5);
    if (!end && !deleted) {
      copy(out->name, e, 32);
      out->name[FS_NAME_MAX] = 0;
      out->attr = e[DE_ATTR];
      out->first_cluster = rd32(e + DE_CLUSTER);
      out->size = rd32(e + DE_FSIZE);
      out->mtime = rd32(e + DE_MTIME);
    }
    d->offset += DE_SIZE;
    if (end) {
      d->cluster = 0;
      return 0;
    }
    if (d->offset >= v->cluster_bytes) {
      uint32_t nx = fatNext(v, d->cluster);
      if (nx == 0 || ++d->seen > v->total_clusters)
        return FS_ERR_CORRUPT;
      d->cluster = (nx == FAT_EOF) ? 0 : nx;
      d->offset = 0;
    }
    if (!deleted)
      return 1;
  }
}

int fs_readdir(FsDir *d, FsStat *out) {
  for (;;) {
    int r = dirNext(d, out);
    if (r <= 0)
      return r;
    if (!streq(out->name, ".") && !streq(out->name, ".."))
      return 1;
  }
}

// ---- Rutas -----------------------------------------------------------------
int fs_stat(FsVolume *v, const char *path, FsStat *out) {
  FsStat cur;
  cur.name[0] = '/';
  cur.name[1] = 0;
  cur.attr = FS_ATTR_DIRECTORY;
  cur.first_cluster = v->root_cluster;
  cur.size = 0;
  cur.mtime = 0;

  const char *p = path;
  while (*p) {
    while (*p == '/')
      p++;
    if (!*p)
      break;
    char comp[FS_NAME_MAX + 1];
    uint32_t len = 0;
    while (*p && *p != '/') {
      if (len >= FS_NAME_MAX)
        return FS_ERR_NAME_TOO_LONG;
      comp[len++] = *p++;
    }
    comp[len] = 0;

    if (!(cur.attr & FS_ATTR_DIRECTORY))
      return FS_ERR_NOT_DIR;
    if (streq(comp, "."))
      continue;
    if (streq(comp, "..") && cur.first_cluster == v->root_cluster)
      continue; // la raíz no tiene "..": se queda en la raíz

    FsDir d;
    int r = dirOpen(v, cur.first_cluster, &d);
    if (r != FS_OK)
      return r;
    FsStat ent;
    bool found = false;
    while ((r = dirNext(&d, &ent)) > 0) {
      if (streq(ent.name, comp)) {
        found = true;
        break;
      }
    }
    if (r < 0)
      return r;
    if (!found)
      return FS_ERR_NOT_FOUND;
    cur = ent;
  }
  *out = cur;
  return FS_OK;
}

int fs_opendir(FsVolume *v, const char *path, FsDir *d) {
  FsStat st;
  int r = fs_stat(v, path, &st);
  if (r != FS_OK)
    return r;
  if (!(st.attr & FS_ATTR_DIRECTORY))
    return FS_ERR_NOT_DIR;
  return dirOpen(v, st.first_cluster, d);
}

// ---- Archivos --------------------------------------------------------------
int fs_open(FsVolume *v, const char *path, FsFile *f) {
  FsStat st;
  int r = fs_stat(v, path, &st);
  if (r != FS_OK)
    return r;
  if (st.attr & FS_ATTR_DIRECTORY)
    return FS_ERR_IS_DIR;
  f->v = v;
  f->first = st.first_cluster; // 0 si el archivo está vacío
  f->size = st.size;
  f->pos = 0;
  f->cluster = st.first_cluster;
  f->cidx = 0;
  return FS_OK;
}

int fs_seek(FsFile *f, uint32_t pos) {
  f->pos = pos > f->size ? f->size : pos;
  return FS_OK;
}

// Deja f->cluster en el clúster que contiene f->pos.
static int fileSeekCluster(FsFile *f) {
  FsVolume *v = f->v;
  uint32_t target = f->pos >> v->cluster_shift;
  if (f->cluster == 0 || target < f->cidx) {
    f->cluster = f->first;
    f->cidx = 0;
  }
  while (f->cidx < target) {
    uint32_t nx = fatNext(v, f->cluster);
    if (nx == 0 || nx == FAT_EOF)
      return FS_ERR_CORRUPT;
    f->cluster = nx;
    f->cidx++;
  }
  return FS_OK;
}

int fs_read(FsFile *f, void *buf, uint32_t n, uint32_t *got) {
  FsVolume *v = f->v;
  uint8_t *dst = buf;
  uint32_t done = 0;
  int r = FS_OK;

  if (f->pos >= f->size)
    n = 0;
  else if (n > f->size - f->pos)
    n = f->size - f->pos;

  while (n) {
    r = fileSeekCluster(f);
    if (r != FS_OK)
      break;
    uint32_t off = f->pos & v->cluster_mask;
    uint32_t bytes;

    if (off == 0 && n >= v->cluster_bytes && ((uintptr_t)dst & 3) == 0) {
      // Camino rápido: clústeres contiguos -> un solo comando NVM directo
      uint32_t maxRun = n >> v->cluster_shift;
      if (maxRun > (MAX_CMD_SECTORS >> v->spc_shift))
        maxRun = MAX_CMD_SECTORS >> v->spc_shift;
      uint32_t run = 1, last = f->cluster;
      while (run < maxRun) {
        uint32_t nx = fatNext(v, last);
        if (nx != last + 1)
          break;
        last = nx;
        run++;
      }
      r = devRead(v->disp, clusterLba(v, f->cluster), run << v->spc_shift, dst);
      if (r != FS_OK)
        break;
      f->cluster = last;
      f->cidx += run - 1;
      bytes = run << v->cluster_shift;
    } else {
      // Camino general: copia desde la caché de página (sin salir del
      // clúster ni de la página, porque el siguiente clúster puede no ser
      // contiguo)
      uint32_t lba = clusterLba(v, f->cluster) + (off >> 9);
      uint32_t inPage =
          ((lba & (PAGE_SECTORS - 1u)) << 9) + (off & (SECTOR - 1));
      bytes = PAGE_BYTES - inPage;
      if (bytes > v->cluster_bytes - off)
        bytes = v->cluster_bytes - off;
      if (bytes > n)
        bytes = n;
      const uint8_t *src = dataPtr(v, lba);
      if (src == NULL) {
        r = FS_ERR_IO;
        break;
      }
      copy(dst, src + (off & (SECTOR - 1)), bytes);
    }
    f->pos += bytes;
    dst += bytes;
    n -= bytes;
    done += bytes;
  }
  *got = done;
  return r;
}
