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
// 5 bytes por entrada: 4 de size + 1 de tipo.
// ---------------------------------------------------------------------------
typedef struct __attribute__((packed)) {
  uint32_t size; // Tamaño del rango en bytes (multiplo de PAGE_SIZE)
  uint8_t type;  // Tipo de la region
} MemMapEntry;

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
// Divide una entrada libre para reservar `neededBytes` a partir de `offset`
// dentro de la entrada `idx`. Puede crear hasta 2 entradas nuevas
// (prefix/suffix). Modifica el mapa en su lugar. Retorna 0 si ok, -1 si no hay
// espacio en el mapa.
// ---------------------------------------------------------------------------
#define MAP_MAX_ENTRIES 819u // Entradas que caben en una pagina de 4096 bytes

static int splitAndMark(uint32_t idx, uint32_t offset, uint32_t neededBytes,
                        uint8_t newType) {
  uint32_t origSize = varMap[idx].size;
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
    // Prefijo libre antes de la reserva
    varMap[pos].size = offset;
    varMap[pos].type = PAGE_FREE;
    pos++;
  }

  // La region reservada
  varMap[pos].size = neededBytes;
  varMap[pos].type = newType;
  pos++;

  if (suffix > 0u) {
    // Sufijo libre despues de la reserva
    varMap[pos].size = suffix;
    varMap[pos].type = PAGE_FREE;
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
//   2. Si no hay, intentar el bump allocator en la pagina activa.
//   3. Si la pagina activa se agota:
//      a. Volcar el sobrante de la pagina actual a la free list (no
//      desperdiciar). b. Pedir una nueva pagina al mapa de memoria. c. Usar el
//      bump en la nueva pagina.
// ---------------------------------------------------------------------------
int allocatePool(uint32_t type, uint32_t size, void **buffer) {
  if (buffer == NULL)
    return -1;
  if (type > BAR_SECTION || type < BOOT_ONLY_DATA)
    return -1;
  if (size == 0u)
    return -1;

  uint32_t flags = enterCriticalSection();

  ensureMapInit();

  // Alineacion minima a 4 bytes para accesos alineados
  uint32_t alignedSize = (size + 3u) & ~3u;
  uint32_t totalNeeded = alignedSize + (uint32_t)sizeof(PoolBlock);

  // 1. Intentar reutilizar desde la free list
  PoolBlock *prev = NULL;
  PoolBlock *cur = poolFreeList;
  while (cur != NULL) {
    if (cur->size >= alignedSize) {
      // Encontrado: si sobra espacio para otra cabecera mas al menos 4 bytes,
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

  // 2. Bump allocator: usar espacio restante en la pagina activa
  if (poolBump != NULL && poolRemaining >= totalNeeded) {
    PoolBlock *blk = (PoolBlock *)poolBump;
    blk->size = alignedSize;
    blk->next = NULL;
    poolBump += totalNeeded;
    poolRemaining -= totalNeeded;
    *buffer = (void *)((uint8_t *)blk + sizeof(PoolBlock));
    exitCriticalSection(flags);
    return 0;
  }

  // 3. La pagina activa no tiene espacio suficiente
  if (poolBump != NULL && poolRemaining >= (uint32_t)sizeof(PoolBlock) + 4u) {
    PoolBlock *leftover = (PoolBlock *)poolBump;
    leftover->size = poolRemaining - (uint32_t)sizeof(PoolBlock);
    leftover->next = poolFreeList;
    poolFreeList = leftover;
  }
  // La pagina activa queda agotada
  poolBump = NULL;
  poolRemaining = 0u;

  // Pedir una nueva pagina al mapa de memoria
  uint32_t idx = 0u;
  uint32_t foundAddr = findFreeRegion(ANY_MEMORY, PAGE_SIZE, &idx);
  if (foundAddr == 0xFFFFFFFFu) {
    exitCriticalSection(flags);
    return -1;
  }

  // Calcular offset dentro de la entrada encontrada y marcarla
  uint32_t cursor = 0u;
  for (uint32_t i = 0; i < idx; i++)
    cursor += varMap[i].size;
  uint32_t offset = foundAddr - cursor;

  if (splitAndMark(idx, offset, PAGE_SIZE, type) != 0) {
    exitCriticalSection(flags);
    return -1;
  }

  // Inicializar bump en la nueva pagina y alojar el bloque pedido
  poolBump = (uint8_t *)(uintptr_t)foundAddr;
  poolRemaining = PAGE_SIZE;

  if (poolRemaining >= totalNeeded) {
    PoolBlock *blk = (PoolBlock *)poolBump;
    blk->size = alignedSize;
    blk->next = NULL;
    poolBump += totalNeeded;
    poolRemaining -= totalNeeded;
    *buffer = (void *)((uint8_t *)blk + sizeof(PoolBlock));
    exitCriticalSection(flags);
    return 0;
  }

  // No deberia llegar aqui
  exitCriticalSection(flags);
  return -1;
}

// ---------------------------------------------------------------------------
// freePool — Devuelve un bloque al pool con fusión de bloques adyacentes
// y liberación de página al mapa si queda completamente libre.
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
  // 4. Liberar la pagina al mapa si el bloque fusionado la cubre entera.
  //    Condiciones:
  //      a) La cabecera del bloque esta justo al inicio de la pagina.
  //      b) size == PAGE_SIZE - sizeof(PoolBlock)
  //         (el primer header ocupa sizeof(PoolBlock) desde el inicio).
  // -------------------------------------------------------------------------
  uint32_t blkAddr = (uint32_t)(uintptr_t)blk;
  uint32_t pageBase = blkAddr & ~(PAGE_SIZE - 1u);

  if (blkAddr == pageBase &&
      blk->size == PAGE_SIZE - (uint32_t)sizeof(PoolBlock)) {

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

    // Marcar la pagina como PAGE_FREE en el mapa y fusionar vecinos
    uint32_t cursor = 0u;
    for (uint32_t i = 0; i < mapEntries; i++) {
      if (cursor == pageBase && varMap[i].size == PAGE_SIZE) {
        varMap[i].type = PAGE_FREE;
        coalesceMap();
        break;
      }
      cursor += varMap[i].size;
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
// freePages — Libera paginas marcandolas como libres y fusionando vecinos
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
    if (cursor == targetAddr && varMap[i].size == targetBytes) {
      varMap[i].type = PAGE_FREE;
      coalesceMap();
      *buffer = NULL;
      exitCriticalSection(flags);
      return;
    }
    cursor += varMap[i].size;
  }

  exitCriticalSection(flags);
}

// ---------------------------------------------------------------------------
// allocateIOMemory — Marca el rango [min, max] como BAR_SECTION en el mapa
// ---------------------------------------------------------------------------
int allocateIOMemory(uint32_t min, uint32_t max) {
  if (min >= max)
    return -1;
  // Alinear a pagina
  uint32_t alignedMin = min & ~(PAGE_SIZE - 1u);
  uint32_t alignedMax = (max + PAGE_SIZE - 1u) & ~(PAGE_SIZE - 1u);
  if (alignedMax < alignedMax - 1u) // desborde
    return -1;

  uint32_t flags = enterCriticalSection();

  ensureMapInit();

  uint32_t rangeSize = alignedMax - alignedMin;
  uint32_t cursor = 0u;

  // Recorrer el mapa buscando entradas que se solapen con [alignedMin,
  // alignedMax)
  uint32_t i = 0u;
  while (i < mapEntries) {
    uint32_t entryStart = cursor;
    uint32_t entryEnd = cursor + varMap[i].size;

    // Sin solapamiento: avanzar
    if (entryEnd <= alignedMin || entryStart >= alignedMax) {
      cursor += varMap[i].size;
      i++;
      continue;
    }

    // Hay solapamiento: calcular la interseccion
    uint32_t overlapStart = (entryStart > alignedMin) ? entryStart : alignedMin;
    uint32_t overlapEnd = (entryEnd < alignedMax) ? entryEnd : alignedMax;
    uint32_t overlapSize = overlapEnd - overlapStart;
    uint32_t offsetInEntry = overlapStart - entryStart;

    if (splitAndMark(i, offsetInEntry, overlapSize, BAR_SECTION) != 0) {
      exitCriticalSection(flags);
      return -1;
    }

    // Tras el split, la entrada marcada es la que sigue a las partes de
    // prefijo. Recalcular cursor y avanzar mas alla de la parte marcada.
    cursor = entryStart + offsetInEntry + overlapSize;
    // El indice despues del split apunta al sufijo (si existe) o a la siguiente
    // entrada. Sumamos las partes que se crearon:
    uint32_t partsCreated = (uint32_t)(offsetInEntry > 0u) + 1u;
    i += partsCreated;
  }

  // Fusionar entradas contiguas del mismo tipo para mantener el mapa compacto
  coalesceMap();

  (void)rangeSize; // calculado pero no necesario explicitamente
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