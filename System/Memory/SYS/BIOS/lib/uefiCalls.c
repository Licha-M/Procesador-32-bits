#include "uefiCalls.h"

// ---------------------------------------------------------------------------
// Constantes del sistema
// ---------------------------------------------------------------------------
#define PAGE_SIZE 4096u

// Regiones MMIO fijas conocidas en hardware
#define ADDR_ROM_START 0xFFF00000u // ROM del BIOS -> PERSISTENT_DATA
#define ADDR_LAPIC 0xFEE00000u     // LAPIC        -> BAR_SECTION

// El mapa de memoria vive aqui. Es la primera pagina que se reserva
// internamente: queda marcada PERSISTENT_DATA en initVarMap.
#define ADDR_MAP_PAGE 0x00002000u

// Valor sentinel para pagina/rango libre (no coincide con ningun tipo definido)
#define PAGE_FREE 0xFFu

// ---------------------------------------------------------------------------
// Estructura de entrada del mapa de memoria
// La direccion de inicio se calcula acumulando los tamaños anteriores.
// 8 bytes por entrada (2 palabras de 32 bits): cada campo se accede con una
// sola instruccion de 32 bits. No va packed: queda alineada naturalmente.
// ---------------------------------------------------------------------------
typedef struct {
  uint32_t size; // Tamaño del rango en bytes (multiplo de PAGE_SIZE)
  uint32_t type; // Tipo de la region
} MemMapEntry;

// Entradas que caben en la pagina del mapa (4096 / 8 = 512)
#define MAP_MAX_ENTRIES (PAGE_SIZE / (uint32_t)sizeof(MemMapEntry))

// ---------------------------------------------------------------------------
// Cabecera del heap pool
// Vive en la primera pagina de cada bloque de pool.
// Nunca va en .data: todos los campos arrancan en 0
// ---------------------------------------------------------------------------
typedef struct PoolBlock PoolBlock;
struct __attribute__((packed)) PoolBlock {
  PoolBlock *next; // Siguiente bloque libre en la free list
  uint32_t size;   // Tamaño utilizable de este bloque
};

// ---------------------------------------------------------------------------
// Variables globales
// ---------------------------------------------------------------------------
// Puntero al array de entradas del mapa de memoria.
static MemMapEntry *varMap; // .bss -> NULL al arrancar

// Numero de entradas validas en el mapa.
static uint32_t mapEntries; // .bss -> 0 al arrancar

// Puntero a la primera entrada libre de la free list del pool.
static PoolBlock *poolFreeList; // .bss -> NULL al arrancar

// Puntero al byte siguiente disponible dentro de la pagina de pool activa.
static uint8_t *poolBump; // .bss -> NULL al arrancar

// Espacio disponible en la pagina de pool activa.
static uint32_t poolRemaining; // .bss -> 0 al arrancar

// ---------------------------------------------------------------------------
// Helpers internos
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Inicializacion del mapa de memoria.
// Solo pre-marca lo que el hardware impone:
//   - La pagina del propio mapa (0x00002000) -> PERSISTENT_DATA
//   - LAPIC fijo en hardware    (0xFEE00000) -> BAR_SECTION
//   - ROM fija en hardware      (0xFFF00000) -> PERSISTENT_DATA
// ---------------------------------------------------------------------------
static void initVarMap(void) {
  varMap = (MemMapEntry *)ADDR_MAP_PAGE;
  mapEntries = 0;
  uint32_t idx = 0;

  // --- [0x00000000 .. 0x00002000) : libre ---
  varMap[idx].size = ADDR_MAP_PAGE; // 0x2000 = 8 KB
  varMap[idx].type = PAGE_FREE;
  idx++;

  // --- [0x00002000 .. 0x00003000) : el mapa mismo -> PERSISTENT_DATA ---
  varMap[idx].size = PAGE_SIZE;
  varMap[idx].type = PERSISTENT_DATA;
  idx++;

  // --- [0x00003000 .. 0xFEE00000) : libre ---
  varMap[idx].size = ADDR_LAPIC - (ADDR_MAP_PAGE + PAGE_SIZE);
  varMap[idx].type = PAGE_FREE;
  idx++;

  // --- [0xFEE00000 .. 0xFEE01000) : LAPIC -> BAR_SECTION (hardware fijo) ---
  varMap[idx].size = PAGE_SIZE;
  varMap[idx].type = BAR_SECTION;
  idx++;

  // --- [0xFEE01000 .. 0xFFF00000) : libre ---
  varMap[idx].size = ADDR_ROM_START - (ADDR_LAPIC + PAGE_SIZE);
  varMap[idx].type = PAGE_FREE;
  idx++;

  // --- [0xFFF00000 .. 0x00000000) : ROM -> PERSISTENT_DATA
  varMap[idx].size = 0u - ADDR_ROM_START;
  varMap[idx].type = PERSISTENT_DATA;
  idx++;

  mapEntries = idx;
}

// Asegura que el mapa esta inicializado
static inline void ensureMapInit(void) {
  if (varMap == NULL)
    initVarMap();
}

// ---------------------------------------------------------------------------
// Busca en el mapa una region libre de al menos `neededBytes` bytes.
// Si `preferredAddr` != ANY_MEMORY busca exactamente esa direccion.
// Devuelve la direccion de inicio encontrada, o 0xFFFFFFFF si no hay hueco.
// Tambien retorna por `outIdx` el indice de la entrada donde empieza.
// ---------------------------------------------------------------------------
static uint32_t findFreeRegion(uint32_t preferredAddr, uint32_t neededBytes,
                               uint32_t *outIdx) {
  uint32_t cursor = 0u;
  for (uint32_t i = 0; i < mapEntries; i++) {
    if (varMap[i].type == PAGE_FREE && varMap[i].size >= neededBytes) {
      if (preferredAddr == ANY_MEMORY) {
        *outIdx = i;
        return cursor;
      }
      // Verificar si la direccion preferida cae dentro de este bloque libre
      if (preferredAddr >= cursor &&
          preferredAddr + neededBytes <= cursor + varMap[i].size &&
          (preferredAddr & (PAGE_SIZE - 1u)) == 0u) {
        *outIdx = i;
        return preferredAddr;
      }
    }
    cursor += varMap[i].size;
  }
  return 0xFFFFFFFFu;
}

// ---------------------------------------------------------------------------
// Divide la entrada `idx` para marcar `neededBytes` a partir de `offset` con
// `newType`. El prefijo y el sufijo sobrantes conservan el tipo original de
// la entrada. Puede crear hasta 2 entradas nuevas. Modifica el mapa en su
// lugar. Retorna 0 si ok, -1 si no hay espacio en el mapa.
// ---------------------------------------------------------------------------
static int splitAndMark(uint32_t idx, uint32_t offset, uint32_t neededBytes,
                        uint32_t newType) {
  uint32_t origSize = varMap[idx].size;
  uint32_t origType = varMap[idx].type;
  uint32_t suffix = origSize - offset - neededBytes;
  uint32_t newSlots = (uint32_t)(offset > 0u) + (uint32_t)(suffix > 0u);

  if (mapEntries + newSlots > MAP_MAX_ENTRIES)
    return -1;

  // Desplazar entradas hacia la derecha para hacer espacio
  if (newSlots > 0u) {
    for (uint32_t j = mapEntries + newSlots - 1u; j > idx + newSlots; j--) {
      varMap[j] = varMap[j - newSlots];
    }
  }

  uint32_t pos = idx;

  if (offset > 0u) {
    // Prefijo antes de la reserva
    varMap[pos].size = offset;
    varMap[pos].type = origType;
    pos++;
  }

  // La region marcada
  varMap[pos].size = neededBytes;
  varMap[pos].type = newType;
  pos++;

  if (suffix > 0u) {
    // Sufijo despues de la reserva
    varMap[pos].size = suffix;
    varMap[pos].type = origType;
  }

  mapEntries += newSlots;
  return 0;
}

// ---------------------------------------------------------------------------
// Fusiona entradas contiguas del mismo tipo.
// Recorre el mapa una sola vez.
// ---------------------------------------------------------------------------
static void coalesceMap(void) {
  for (uint32_t i = 0; i + 1u < mapEntries; i++) {
    if (varMap[i].type == varMap[i + 1u].type) {
      // Verificar que no desborde uint32_t
      if (varMap[i].size <= 0xFFFFFFFFu - varMap[i + 1u].size) {
        varMap[i].size += varMap[i + 1u].size;
        // Desplazar el resto hacia la izquierda
        for (uint32_t j = i + 1u; j + 1u < mapEntries; j++) {
          varMap[j] = varMap[j + 1u];
        }
        mapEntries--;
        i--; // Revisar la misma posicion de nuevo
      }
    }
  }
}

// ---------------------------------------------------------------------------
// allocatePool — Aloja porciones pequeñas de RAM (en Bytes)
//
// Flujo:
//   1. Buscar en la free list un bloque ya liberado que encaje.
//   2. Si no hay, usar el bump allocator en la pagina activa.
//   3. Si la pagina activa no alcanza:
//      a. Volcar el sobrante a la free list (no desperdiciar).
//      b. Pedir una pagina nueva con allocatePages.
//      c. Usar el bump en la nueva pagina.
// ---------------------------------------------------------------------------
int allocatePool(uint32_t type, uint32_t size, void **buffer) {
  if (buffer == NULL)
    return -1;
  if (type > BAR_SECTION || type < BOOT_ONLY_DATA)
    return -1;
  // Un bloque (cabecera + datos) debe caber en una pagina
  if (size == 0u || size > PAGE_SIZE - (uint32_t)sizeof(PoolBlock))
    return -1;

  // Alineacion minima a 4 bytes para accesos alineados
  uint32_t alignedSize = (size + 3u) & ~3u;
  uint32_t totalNeeded = alignedSize + (uint32_t)sizeof(PoolBlock);

  uint32_t flags = enterCriticalSection();

  // 1. Intentar reutilizar desde la free list
  PoolBlock *prev = NULL;
  PoolBlock *cur = poolFreeList;
  while (cur != NULL) {
    if (cur->size >= alignedSize) {
      // Si sobra espacio para otra cabecera mas al menos 4 bytes,
      // fragmentar y devolver el resto a la free list.
      if (cur->size >= alignedSize + (uint32_t)sizeof(PoolBlock) + 4u) {
        PoolBlock *remainder =
            (PoolBlock *)((uint8_t *)cur + sizeof(PoolBlock) + alignedSize);
        remainder->size = cur->size - alignedSize - (uint32_t)sizeof(PoolBlock);
        remainder->next = cur->next;
        cur->size = alignedSize;
        if (prev != NULL)
          prev->next = remainder;
        else
          poolFreeList = remainder;
      } else {
        // No vale la pena fragmentar: entregar el bloque completo
        if (prev != NULL)
          prev->next = cur->next;
        else
          poolFreeList = cur->next;
      }
      *buffer = (void *)((uint8_t *)cur + sizeof(PoolBlock));
      exitCriticalSection(flags);
      return 0;
    }
    prev = cur;
    cur = cur->next;
  }

  // 2/3. Bump allocator. Si la pagina activa no alcanza, se cambia por otra.
  if (poolBump == NULL || poolRemaining < totalNeeded) {
    // Volcar el sobrante de la pagina actual a la free list
    if (poolBump != NULL && poolRemaining >= (uint32_t)sizeof(PoolBlock) + 4u) {
      PoolBlock *leftover = (PoolBlock *)poolBump;
      leftover->size = poolRemaining - (uint32_t)sizeof(PoolBlock);
      leftover->next = poolFreeList;
      poolFreeList = leftover;
    }
    poolBump = NULL;
    poolRemaining = 0u;

    // Pedir una pagina nueva al mapa de memoria
    void *page = NULL;
    if (allocatePages(ANY_MEMORY, type, 1u, &page) != 0) {
      exitCriticalSection(flags);
      return -1;
    }
    poolBump = (uint8_t *)page;
    poolRemaining = PAGE_SIZE;
  }

  PoolBlock *blk = (PoolBlock *)poolBump;
  blk->size = alignedSize;
  blk->next = NULL;
  poolBump += totalNeeded;
  poolRemaining -= totalNeeded;
  *buffer = (void *)((uint8_t *)blk + sizeof(PoolBlock));

  exitCriticalSection(flags);
  return 0;
}

// ---------------------------------------------------------------------------
// freePool — Devuelve un bloque al pool con fusión de bloques adyacentes
// y, si la pagina queda completamente libre, la devuelve con freePages.
// ---------------------------------------------------------------------------
void freePool(void **buffer) {
  if (buffer == NULL || *buffer == NULL)
    return;

  uint32_t flags = enterCriticalSection();

  PoolBlock *blk = (PoolBlock *)((uint8_t *)*buffer - sizeof(PoolBlock));
  *buffer = NULL;

  // -------------------------------------------------------------------------
  // 1. Insercion ordenada por direccion para detectar adyacencias.
  // -------------------------------------------------------------------------
  PoolBlock *prev = NULL;
  PoolBlock *cur = poolFreeList;
  while (cur != NULL && (uintptr_t)cur < (uintptr_t)blk) {
    prev = cur;
    cur = cur->next;
  }
  blk->next = cur;
  if (prev != NULL)
    prev->next = blk;
  else
    poolFreeList = blk;

  // -------------------------------------------------------------------------
  // 2. Intentar fusionar blk con su sucesor (si son contiguos en la pagina).
  // -------------------------------------------------------------------------
  if (blk->next != NULL) {
    uint8_t *blkEnd = (uint8_t *)blk + sizeof(PoolBlock) + blk->size;
    uint32_t blkPage = (uint32_t)(uintptr_t)blk & ~(PAGE_SIZE - 1u);
    uint32_t nextPage = (uint32_t)(uintptr_t)blk->next & ~(PAGE_SIZE - 1u);
    if (blkEnd == (uint8_t *)blk->next && blkPage == nextPage) {
      blk->size += (uint32_t)sizeof(PoolBlock) + blk->next->size;
      blk->next = blk->next->next;
    }
  }

  // -------------------------------------------------------------------------
  // 3. Intentar fusionar el predecesor con blk.
  //    Tras la fusion el bloque resultante pasa a ser prev.
  // -------------------------------------------------------------------------
  if (prev != NULL) {
    uint8_t *prevEnd = (uint8_t *)prev + sizeof(PoolBlock) + prev->size;
    uint32_t prevPage = (uint32_t)(uintptr_t)prev & ~(PAGE_SIZE - 1u);
    uint32_t blkPage2 = (uint32_t)(uintptr_t)blk & ~(PAGE_SIZE - 1u);
    if (prevEnd == (uint8_t *)blk && prevPage == blkPage2) {
      prev->size += (uint32_t)sizeof(PoolBlock) + blk->size;
      prev->next = blk->next;
      blk = prev; // el bloque fusionado es ahora prev
    }
  }

  // -------------------------------------------------------------------------
  // 4. Si el bloque fusionado cubre la pagina entera, devolverla con
  //    freePages. Condiciones:
  //      a) La cabecera del bloque esta justo al inicio de la pagina.
  //      b) size == PAGE_SIZE - sizeof(PoolBlock)
  // -------------------------------------------------------------------------
  uint32_t blkAddr = (uint32_t)(uintptr_t)blk;
  uint32_t pageBase = blkAddr & ~(PAGE_SIZE - 1u);

  if (blkAddr == pageBase &&
      blk->size == PAGE_SIZE - (uint32_t)sizeof(PoolBlock)) {

    // freePages pone `page` en NULL solo si la pagina se libero en el mapa.
    // Si falla, el bloque se queda en la free list y no se pierde la pagina.
    void *page = (void *)(uintptr_t)pageBase;
    freePages(1u, &page);

    if (page == NULL) {
      // Quitar el bloque de la free list del pool
      if (blk == poolFreeList) {
        poolFreeList = blk->next;
      } else {
        PoolBlock *p = poolFreeList;
        while (p != NULL && p->next != blk)
          p = p->next;
        if (p != NULL)
          p->next = blk->next;
      }

      // Si el bump activo apuntaba a esta pagina ya no es valido
      if (poolBump != NULL) {
        uint32_t bumpPage = (uint32_t)(uintptr_t)poolBump & ~(PAGE_SIZE - 1u);
        if (bumpPage == pageBase) {
          poolBump = NULL;
          poolRemaining = 0u;
        }
      }
    }
  }

  exitCriticalSection(flags);
}

// ---------------------------------------------------------------------------
// allocatePages — Aloja paginas enteras de RAM
// ---------------------------------------------------------------------------
int allocatePages(uint32_t address, uint32_t type, uint32_t cant,
                  void **buffer) {
  if (buffer == NULL)
    return -1;
  if (type > BAR_SECTION || type < BOOT_ONLY_DATA)
    return -1;
  if (cant == 0u)
    return -1;

  uint32_t flags = enterCriticalSection();

  ensureMapInit();

  uint32_t neededBytes = cant * PAGE_SIZE;
  uint32_t idx = 0u;
  uint32_t foundAddr = findFreeRegion(address, neededBytes, &idx);

  if (foundAddr == 0xFFFFFFFFu) {
    exitCriticalSection(flags);
    return -1;
  }

  // Calcular el offset de foundAddr dentro de la entrada idx
  uint32_t cursor = 0u;
  for (uint32_t i = 0; i < idx; i++)
    cursor += varMap[i].size;
  uint32_t offset = foundAddr - cursor;

  if (splitAndMark(idx, offset, neededBytes, type) != 0) {
    exitCriticalSection(flags);
    return -1;
  }

  *buffer = (void *)(uintptr_t)foundAddr;
  exitCriticalSection(flags);
  return 0;
}

// ---------------------------------------------------------------------------
// freePages — Libera paginas marcandolas como libres y fusionando vecinos.
// El rango puede ser parte de una entrada mas grande (el mapa fusiona
// regiones contiguas del mismo tipo). Si se libera, *buffer queda en NULL.
// ---------------------------------------------------------------------------
void freePages(uint32_t cant, void **buffer) {
  if (buffer == NULL || *buffer == NULL || cant == 0u)
    return;

  uint32_t flags = enterCriticalSection();

  ensureMapInit();

  uint32_t targetAddr = (uint32_t)(uintptr_t)*buffer;
  uint32_t targetBytes = cant * PAGE_SIZE;
  uint32_t cursor = 0u;

  for (uint32_t i = 0; i < mapEntries; i++) {
    // El rango debe caer entero dentro de la entrada i (sin desbordar)
    if (targetAddr >= cursor &&
        targetAddr - cursor + targetBytes <= varMap[i].size) {
      if (varMap[i].type != PAGE_FREE &&
          splitAndMark(i, targetAddr - cursor, targetBytes, PAGE_FREE) == 0) {
        coalesceMap();
        *buffer = NULL;
      }
      exitCriticalSection(flags);
      return;
    }
    cursor += varMap[i].size;
  }

  exitCriticalSection(flags);
}

// ---------------------------------------------------------------------------
// allocateIOMemory — Marca el rango [min, max) como BAR_SECTION en el mapa.
// ---------------------------------------------------------------------------
int allocateIOMemory(uint32_t min, uint32_t max) {
  if (min >= max)
    return -1;

  // Redondear hacia arriba no debe desbordar uint32_t
  if (max > 0u - PAGE_SIZE)
    return -1;

  uint32_t alignedMin = min & ~(PAGE_SIZE - 1u);
  uint32_t alignedMax = (max + PAGE_SIZE - 1u) & ~(PAGE_SIZE - 1u);

  uint32_t flags = enterCriticalSection();

  ensureMapInit();

  // Pasada 1: verificar que todo lo que se solapa es libre o ya BAR_SECTION
  uint32_t cursor = 0u;
  for (uint32_t i = 0u; i < mapEntries; i++) {
    uint32_t entryStart = cursor;
    uint32_t size = varMap[i].size;
    if (entryStart >= alignedMax)
      break;
    // Solapa si alignedMin cae antes del fin de la entrada (sin sumar, para
    // no desbordar en la ultima entrada)
    if (alignedMin < entryStart || (alignedMin - entryStart) < size) {
      uint32_t t = varMap[i].type;
      if (t != PAGE_FREE && t != BAR_SECTION) {
        exitCriticalSection(flags);
        return -1;
      }
    }
    cursor += size;
  }

  // Cada marcado agrega como maximo 2 entradas en total (prefijo de la primera
  // entrada solapada y sufijo de la ultima). Comprobarlo antes de empezar para
  // no dejar el rango marcado a medias.
  if (mapEntries + 2u > MAP_MAX_ENTRIES) {
    exitCriticalSection(flags);
    return -1;
  }

  // Pasada 2: marcar
  cursor = 0u;
  uint32_t i = 0u;
  while (i < mapEntries) {
    uint32_t entryStart = cursor;
    uint32_t size = varMap[i].size;
    if (entryStart >= alignedMax)
      break;

    // Sin solapamiento (la entrada termina antes de alignedMin)
    if (alignedMin >= entryStart && (alignedMin - entryStart) >= size) {
      cursor += size;
      i++;
      continue;
    }

    // Ya es BAR_SECTION: nada que dividir
    if (varMap[i].type == BAR_SECTION) {
      cursor += size;
      i++;
      continue;
    }

    // Entrada PAGE_FREE solapada: calcular la interseccion sin desbordes
    uint32_t overlapStart = (entryStart > alignedMin) ? entryStart : alignedMin;
    uint32_t overlapEnd =
        ((alignedMax - entryStart) < size) ? alignedMax : (entryStart + size);
    uint32_t offsetInEntry = overlapStart - entryStart;
    uint32_t overlapSize = overlapEnd - overlapStart;

    if (splitAndMark(i, offsetInEntry, overlapSize, BAR_SECTION) != 0) {
      // No deberia ocurrir (capacidad verificada arriba)
      exitCriticalSection(flags);
      return -1;
    }

    // Despues del split: [prefijo?][marcada][sufijo?]. Saltar hasta justo
    // despues de la marcada; el sufijo (si existe) empieza en overlapEnd.
    cursor = overlapEnd;
    i += (offsetInEntry > 0u) ? 2u : 1u;
  }

  coalesceMap();

  exitCriticalSection(flags);
  return 0;
}

// ---------------------------------------------------------------------------
// getVarMap — Devuelve la direccion del mapa de memoria como uint32_t
// ---------------------------------------------------------------------------
uint32_t getVarMap(void) {
  uint32_t flags = enterCriticalSection();
  ensureMapInit();
  uint32_t addr = (uint32_t)(uintptr_t)varMap;
  exitCriticalSection(flags);
  return addr;
}