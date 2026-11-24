#include "uefiCalls.h"

// Constantes de memoria y hardware
#define PAGE_SIZE 4096u            // Tamaño de página (4 KB)
#define ADDR_ROM_START 0xFFF00000u // Inicio de ROM del BIOS
#define ADDR_LAPIC 0xFEE00000u     // Dirección fija del LAPIC
#define ADDR_MAP_PAGE 0x00002000u  // Dirección donde se guarda el mapa de memoria
#define PAGE_FREE 0xFFu            // Identificador para rangos de memoria libres

// Entrada del mapa de memoria (dirección calculada acumulando tamaños)
typedef struct {
  uint32_t size; // Tamaño del rango en bytes (múltiplo de PAGE_SIZE)
  uint32_t type; // Tipo de memoria (ej. PAGE_FREE, PERSISTENT_DATA, etc.)
} MemMapEntry;

// Máximo de entradas posibles en una página de 4 KB (512 entradas)
#define MAP_MAX_ENTRIES (PAGE_SIZE / (uint32_t)sizeof(MemMapEntry))

// Cabecera que precede a cada bloque asignado en el pool (heap pequeño)
typedef struct PoolBlock PoolBlock;
struct __attribute__((packed)) PoolBlock {
  PoolBlock *next; // Siguiente bloque en la lista de libres
  uint32_t size;   // Tamaño útil del bloque en bytes
};

// Variables globales del sistema de memoria
static MemMapEntry *varMap;     // Puntero al mapa de memoria
static uint32_t mapEntries;     // Cantidad de entradas activas en el mapa
static PoolBlock *poolFreeList; // Lista de bloques libres reutilizables del pool
static uint8_t *poolBump;       // Puntero para asignación rápida en la página activa
static uint32_t poolRemaining;  // Bytes disponibles en la página activa del pool

// Inicializa el mapa de memoria con las regiones fijas conocidas
static void initVarMap(void) {
  varMap = (MemMapEntry *)ADDR_MAP_PAGE;
  mapEntries = 0;
  uint32_t idx = 0;

  // 0x00000000 a 0x00002000: Memoria RAM libre inicial (8 KB)
  varMap[idx].size = ADDR_MAP_PAGE;
  varMap[idx].type = PAGE_FREE;
  idx++;

  // 0x00002000 a 0x00003000: Página reservada para este mapa de memoria
  varMap[idx].size = PAGE_SIZE;
  varMap[idx].type = PERSISTENT_DATA;
  idx++;

  // 0x00003000 a 0xFEE00000: Memoria RAM libre principal
  varMap[idx].size = ADDR_LAPIC - (ADDR_MAP_PAGE + PAGE_SIZE);
  varMap[idx].type = PAGE_FREE;
  idx++;

  // 0xFEE00000 a 0xFEE01000: Espacio fijo del LAPIC (E/S de hardware)
  varMap[idx].size = PAGE_SIZE;
  varMap[idx].type = BAR_SECTION;
  idx++;

  // 0xFEE01000 a 0xFFF00000: Memoria RAM libre alta
  varMap[idx].size = ADDR_ROM_START - (ADDR_LAPIC + PAGE_SIZE);
  varMap[idx].type = PAGE_FREE;
  idx++;

  // 0xFFF00000 a 0xFFFFFFFF: ROM del BIOS (1 MB persistente)
  varMap[idx].size = 0u - ADDR_ROM_START;
  varMap[idx].type = PERSISTENT_DATA;
  idx++;

  mapEntries = idx;
}

// Inicializa el mapa si aún no está cargado
static inline void ensureMapInit(void) {
  if (varMap == NULL)
    initVarMap();
}

// Busca una región libre donde quepan al menos 'neededBytes'.
// Si 'preferredAddr' no es ANY_MEMORY, verifica que esa dirección específica esté libre.
static uint32_t findFreeRegion(uint32_t preferredAddr, uint32_t neededBytes,
                               uint32_t *outIdx) {
  uint32_t cursor = 0u;
  for (uint32_t i = 0; i < mapEntries; i++) {
    if (varMap[i].type == PAGE_FREE && varMap[i].size >= neededBytes) {
      // Si vale cualquier dirección, toma la primera disponible
      if (preferredAddr == ANY_MEMORY) {
        *outIdx = i;
        return cursor;
      }
      // Verifica que la dirección pedida quepa en el bloque y esté alineada a página
      if (preferredAddr >= cursor &&
          preferredAddr + neededBytes <= cursor + varMap[i].size &&
          (preferredAddr & (PAGE_SIZE - 1u)) == 0u) {
        *outIdx = i;
        return preferredAddr;
      }
    }
    cursor += varMap[i].size; // Avanza el cursor sumando el tamaño del bloque actual
  }
  return 0xFFFFFFFFu; // No se encontró espacio disponible
}

// Divide una entrada en hasta 3 partes: [sobrante antes] + [zona asignada] + [sobrante después]
static int splitAndMark(uint32_t idx, uint32_t offset, uint32_t neededBytes,
                        uint32_t newType) {
  uint32_t origSize = varMap[idx].size;
  uint32_t origType = varMap[idx].type;
  uint32_t suffix = origSize - offset - neededBytes; // Espacio libre que queda al final
  // Calcula si se crearán 0, 1 o 2 ranuras extra
  uint32_t newSlots = (uint32_t)(offset > 0u) + (uint32_t)(suffix > 0u);

  // Verifica que las nuevas entradas no superen la capacidad de la página
  if (mapEntries + newSlots > MAP_MAX_ENTRIES)
    return -1;

  // Desplaza las entradas hacia la derecha para abrir espacio a las nuevas
  if (newSlots > 0u) {
    for (uint32_t j = mapEntries + newSlots - 1u; j > idx + newSlots; j--) {
      varMap[j] = varMap[j - newSlots];
    }
  }

  uint32_t pos = idx;

  // 1. Guarda la parte sobrante previa (si la reserva no empezó en offset 0)
  if (offset > 0u) {
    varMap[pos].size = offset;
    varMap[pos].type = origType;
    pos++;
  }

  // 2. Coloca la nueva región asignada
  varMap[pos].size = neededBytes;
  varMap[pos].type = newType;
  pos++;

  // 3. Guarda la parte sobrante posterior (si sobró espacio al final)
  if (suffix > 0u) {
    varMap[pos].size = suffix;
    varMap[pos].type = origType;
  }

  mapEntries += newSlots;
  return 0;
}

// Une entradas consecutivas que tengan el mismo tipo para reducir la fragmentación
static void coalesceMap(void) {
  for (uint32_t i = 0; i + 1u < mapEntries; i++) {
    if (varMap[i].type == varMap[i + 1u].type) {
      // Suma los tamaños asegurando no desbordar uint32_t
      if (varMap[i].size <= 0xFFFFFFFFu - varMap[i + 1u].size) {
        varMap[i].size += varMap[i + 1u].size;
        // Desplaza el resto hacia la izquierda para eliminar la entrada fusionada
        for (uint32_t j = i + 1u; j + 1u < mapEntries; j++) {
          varMap[j] = varMap[j + 1u];
        }
        mapEntries--;
        i--; // Revisa de nuevo este índice por si el siguiente bloque también coincide
      }
    }
  }
}

// Reserva una porción pequeña de memoria en bytes (heap pool)
int allocatePool(uint32_t type, uint32_t size, void **buffer) {
  if (buffer == NULL)
    return -1;
  if (type > BAR_SECTION || type < BOOT_ONLY_DATA)
    return -1;
  // El bloque con su cabecera debe caber en una sola página de 4 KB
  if (size == 0u || size > PAGE_SIZE - (uint32_t)sizeof(PoolBlock))
    return -1;

  // Redondea el tamaño a múltiplo de 4 bytes para mantener alineación de 32 bits
  uint32_t alignedSize = (size + 3u) & ~3u;
  uint32_t totalNeeded = alignedSize + (uint32_t)sizeof(PoolBlock);

  uint32_t flags = enterCriticalSection();

  // 1. Intenta reutilizar un bloque de la lista de libres (free list)
  PoolBlock *prev = NULL;
  PoolBlock *cur = poolFreeList;
  while (cur != NULL) {
    if (cur->size >= alignedSize) {
      // Si sobra suficiente espacio para otro bloque (cabecera + mínimo 4 bytes), lo fragmenta
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
        // Si el sobrante es pequeño, entrega el bloque completo sin dividir
        if (prev != NULL)
          prev->next = cur->next;
        else
          poolFreeList = cur->next;
      }
      // Devuelve el puntero a los datos (justo después de la cabecera)
      *buffer = (void *)((uint8_t *)cur + sizeof(PoolBlock));
      exitCriticalSection(flags);
      return 0;
    }
    prev = cur;
    cur = cur->next;
  }

  // 2. Si no hay bloque libre, usa la página activa (bump allocator)
  // Si la página no alcanza o aún no hay, se pide una página nueva
  if (poolBump == NULL || poolRemaining < totalNeeded) {
    // Si la página actual tenía espacio sobrante utilizable, lo guarda en la free list
    if (poolBump != NULL && poolRemaining >= (uint32_t)sizeof(PoolBlock) + 4u) {
      PoolBlock *leftover = (PoolBlock *)poolBump;
      leftover->size = poolRemaining - (uint32_t)sizeof(PoolBlock);
      leftover->next = poolFreeList;
      poolFreeList = leftover;
    }
    poolBump = NULL;
    poolRemaining = 0u;

    // Pide una nueva página al mapa de memoria
    void *page = NULL;
    if (allocatePages(ANY_MEMORY, type, 1u, &page) != 0) {
      exitCriticalSection(flags);
      return -1;
    }
    poolBump = (uint8_t *)page;
    poolRemaining = PAGE_SIZE;
  }

  // Asigna desde la página activa avanzando el puntero secuencialmente
  PoolBlock *blk = (PoolBlock *)poolBump;
  blk->size = alignedSize;
  blk->next = NULL;
  poolBump += totalNeeded;
  poolRemaining -= totalNeeded;
  *buffer = (void *)((uint8_t *)blk + sizeof(PoolBlock));

  exitCriticalSection(flags);
  return 0;
}

// Libera un bloque del pool, une bloques contiguos y libera la página si quedó vacía
void freePool(void **buffer) {
  if (buffer == NULL || *buffer == NULL)
    return;

  uint32_t flags = enterCriticalSection();

  // Retrocede para apuntar a la cabecera del bloque que precede a los datos
  PoolBlock *blk = (PoolBlock *)((uint8_t *)*buffer - sizeof(PoolBlock));
  *buffer = NULL;

  // 1. Inserta el bloque en la lista de libres ordenado por dirección de memoria
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

  // 2. Intenta fusionar el bloque con su sucesor si están pegados en la misma página
  if (blk->next != NULL) {
    uint8_t *blkEnd = (uint8_t *)blk + sizeof(PoolBlock) + blk->size;
    // Máscara ~(PAGE_SIZE - 1): limpia los 12 bits bajos para obtener la base de la página
    uint32_t blkPage = (uint32_t)(uintptr_t)blk & ~(PAGE_SIZE - 1u);
    uint32_t nextPage = (uint32_t)(uintptr_t)blk->next & ~(PAGE_SIZE - 1u);
    if (blkEnd == (uint8_t *)blk->next && blkPage == nextPage) {
      blk->size += (uint32_t)sizeof(PoolBlock) + blk->next->size;
      blk->next = blk->next->next;
    }
  }

  // 3. Intenta fusionar el bloque predecesor con este bloque si están pegados
  if (prev != NULL) {
    uint8_t *prevEnd = (uint8_t *)prev + sizeof(PoolBlock) + prev->size;
    uint32_t prevPage = (uint32_t)(uintptr_t)prev & ~(PAGE_SIZE - 1u);
    uint32_t blkPage2 = (uint32_t)(uintptr_t)blk & ~(PAGE_SIZE - 1u);
    if (prevEnd == (uint8_t *)blk && prevPage == blkPage2) {
      prev->size += (uint32_t)sizeof(PoolBlock) + blk->size;
      prev->next = blk->next;
      blk = prev; // Ahora 'blk' apunta al bloque unificado
    }
  }

  // 4. Si el bloque unificado ocupa toda la página, devuelve la página completa al mapa
  uint32_t blkAddr = (uint32_t)(uintptr_t)blk;
  uint32_t pageBase = blkAddr & ~(PAGE_SIZE - 1u);

  // Comprueba que empiece al inicio de página y tenga el tamaño completo menos la cabecera
  if (blkAddr == pageBase &&
      blk->size == PAGE_SIZE - (uint32_t)sizeof(PoolBlock)) {

    void *page = (void *)(uintptr_t)pageBase;
    freePages(1u, &page);

    // Si freePages tuvo éxito (puso page en NULL), remueve el bloque de la free list
    if (page == NULL) {
      if (blk == poolFreeList) {
        poolFreeList = blk->next;
      } else {
        PoolBlock *p = poolFreeList;
        while (p != NULL && p->next != blk)
          p = p->next;
        if (p != NULL)
          p->next = blk->next;
      }

      // Si la página liberada era la que usaba el asignador activo (bump), la desactiva
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

// Reserva una cantidad de páginas de memoria de 4 KB
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
  // Busca una región libre con el tamaño requerido
  uint32_t foundAddr = findFreeRegion(address, neededBytes, &idx);

  if (foundAddr == 0xFFFFFFFFu) {
    exitCriticalSection(flags);
    return -1;
  }

  // Calcula la posición exacta (offset) donde empieza la reserva dentro de la entrada
  uint32_t cursor = 0u;
  for (uint32_t i = 0; i < idx; i++)
    cursor += varMap[i].size;
  uint32_t offset = foundAddr - cursor;

  // Divide la entrada del mapa y le asigna el tipo solicitado
  if (splitAndMark(idx, offset, neededBytes, type) != 0) {
    exitCriticalSection(flags);
    return -1;
  }

  *buffer = (void *)(uintptr_t)foundAddr;
  exitCriticalSection(flags);
  return 0;
}

// Libera páginas de memoria marcándolas como PAGE_FREE y fusionando vecinos
void freePages(uint32_t cant, void **buffer) {
  if (buffer == NULL || *buffer == NULL || cant == 0u)
    return;

  uint32_t flags = enterCriticalSection();

  ensureMapInit();

  uint32_t targetAddr = (uint32_t)(uintptr_t)*buffer;
  uint32_t targetBytes = cant * PAGE_SIZE;
  uint32_t cursor = 0u;

  for (uint32_t i = 0; i < mapEntries; i++) {
    // Encuentra la entrada que contiene completamente el rango a liberar
    if (targetAddr >= cursor &&
        targetAddr - cursor + targetBytes <= varMap[i].size) {
      if (varMap[i].type != PAGE_FREE &&
          splitAndMark(i, targetAddr - cursor, targetBytes, PAGE_FREE) == 0) {
        coalesceMap(); // Une con bloques libres adyacentes
        *buffer = NULL;
      }
      exitCriticalSection(flags);
      return;
    }
    cursor += varMap[i].size;
  }

  exitCriticalSection(flags);
}

// Marca un rango de direcciones físicas como memoria para dispositivos (BAR_SECTION)
int allocateIOMemory(uint32_t min, uint32_t max) {
  if (min >= max)
    return -1;

  // Evita desbordamiento al redondear al final del espacio de 32 bits
  if (max > 0u - PAGE_SIZE)
    return -1;

  // Alinea los límites a páginas completas (min hacia abajo, max hacia arriba)
  uint32_t alignedMin = min & ~(PAGE_SIZE - 1u);
  uint32_t alignedMax = (max + PAGE_SIZE - 1u) & ~(PAGE_SIZE - 1u);

  uint32_t flags = enterCriticalSection();

  ensureMapInit();

  // Paso 1: Validar que todo el rango solicitado esté libre o ya sea BAR_SECTION
  uint32_t cursor = 0u;
  for (uint32_t i = 0u; i < mapEntries; i++) {
    uint32_t entryStart = cursor;
    uint32_t size = varMap[i].size;
    if (entryStart >= alignedMax)
      break;
    // Comprueba si la entrada se cruza con el rango solicitado
    if (alignedMin < entryStart || (alignedMin - entryStart) < size) {
      uint32_t t = varMap[i].type;
      if (t != PAGE_FREE && t != BAR_SECTION) {
        exitCriticalSection(flags);
        return -1; // Conflicto: la memoria ya está usada por otro tipo
      }
    }
    cursor += size;
  }

  // Verifica con antelación que haya espacio en la tabla para nuevas entradas
  if (mapEntries + 2u > MAP_MAX_ENTRIES) {
    exitCriticalSection(flags);
    return -1;
  }

  // Paso 2: Marcar como BAR_SECTION las zonas libres del rango
  cursor = 0u;
  uint32_t i = 0u;
  while (i < mapEntries) {
    uint32_t entryStart = cursor;
    uint32_t size = varMap[i].size;
    if (entryStart >= alignedMax)
      break;

    // Si la entrada actual está antes del rango solicitado, continuar
    if (alignedMin >= entryStart && (alignedMin - entryStart) >= size) {
      cursor += size;
      i++;
      continue;
    }

    // Si ya era BAR_SECTION, no requiere cambios
    if (varMap[i].type == BAR_SECTION) {
      cursor += size;
      i++;
      continue;
    }

    // Calcula la intersección entre la entrada libre y el rango deseado
    uint32_t overlapStart = (entryStart > alignedMin) ? entryStart : alignedMin;
    uint32_t overlapEnd =
        ((alignedMax - entryStart) < size) ? alignedMax : (entryStart + size);
    uint32_t offsetInEntry = overlapStart - entryStart;
    uint32_t overlapSize = overlapEnd - overlapStart;

    if (splitAndMark(i, offsetInEntry, overlapSize, BAR_SECTION) != 0) {
      exitCriticalSection(flags);
      return -1;
    }

    // Avanza el cursor y el índice saltando las entradas generadas por la división
    cursor = overlapEnd;
    i += (offsetInEntry > 0u) ? 2u : 1u;
  }

  coalesceMap(); // Fusiona regiones contiguas del mismo tipo

  exitCriticalSection(flags);
  return 0;
}

// Devuelve la dirección en memoria del mapa de regiones
uint32_t getVarMap(void) {
  uint32_t flags = enterCriticalSection();
  ensureMapInit();
  uint32_t addr = (uint32_t)(uintptr_t)varMap;
  exitCriticalSection(flags);
  return addr;
}
