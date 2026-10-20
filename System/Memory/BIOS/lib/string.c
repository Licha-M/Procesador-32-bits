#include "string.h"
#include <stdint.h>

int strcmp(const char *s1, const char *s2) {
  // 1. Alinear s1 a 4 bytes
  while ((uintptr_t)s1 & 3) {
    if (*s1 != *s2 || *s1 == '\0') {
      return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    }
    s1++;
    s2++;
  }

  uint32_t magic_mask = 0x80808080UL;
  uint32_t lo_mask = 0x01010101UL;

  while (1) {
    // Protección contra lectura fuera de página (evita Segfault al leer 4 bytes
    // cerca del límite)
    if (((uintptr_t)s1 & 4095) > 4092 || ((uintptr_t)s2 & 4095) > 4092) {
      while (*s1 != '\0' && *s1 == *s2) {
        s1++;
        s2++;
      }
      return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    }

    uint32_t val1 = *(const uint32_t *)s1;
    uint32_t val2 = *(const uint32_t *)s2;

    uint32_t has_zero = (val1 - lo_mask) & ~val1 & magic_mask;
    uint32_t diff = val1 ^ val2;

    if (has_zero || diff) {
      for (int i = 0; i < 4; i++) {
        if (s1[i] != s2[i] || s1[i] == '\0') {
          return *(const unsigned char *)(s1 + i) -
                 *(const unsigned char *)(s2 + i);
        }
      }
    }
    s1 += 4;
    s2 += 4;
  }
}

size_t strlen(const char *s) {
  const char *p = s;

  // 1. Alinear el puntero a una frontera de 4 bytes
  while ((uintptr_t)p & 3) {
    if (*p == '\0')
      return p - s;
    p++;
  }

  uint32_t magic_mask = 0x80808080UL;
  uint32_t lo_mask = 0x01010101UL;

  // 2. Bucle principal con bloques de 32 bits optimizados y seguros
  while (1) {
    // Protección de página para evitar lecturas fuera de límites
    if (((uintptr_t)p & 4095) > 4092) {
      while (*p != '\0') {
        p++;
      }
      return p - s;
    }

    uint32_t val = *(const uint32_t *)p;

    if ((val - lo_mask) & ~val & magic_mask) {
      if (p[0] == '\0')
        return p - s;
      if (p[1] == '\0')
        return p + 1 - s;
      if (p[2] == '\0')
        return p + 2 - s;
      return p + 3 - s;
    }
    p += 4;
  }
}

int memcmp(const void *str1, const void *str2, size_t n) {
  const unsigned char *p1 = (const unsigned char *)str1;
  const unsigned char *p2 = (const unsigned char *)str2;

  // Implementación estándar segura y optimizada por el compilador
  for (size_t i = 0; i < n; i++) {
    if (p1[i] != p2[i]) {
      return p1[i] - p2[i];
    }
  }

  return 0;
}

void *strncpy(char *dest, const char *src, size_t n) {
  if (n == 0)
    return dest;

  char *d = dest;
  const char *s = src;

  // 1. Alinear el destino a una frontera de 4 bytes
  while (((uintptr_t)d & 3) != 0 && n > 0) {
    if ((*d++ = *s++) == '\0') {
      n--;
      goto pad_zeros;
    }
    n--;
  }

  // 2. Copia optimizada de 4 en 4 bytes si el origen también está alineado
  if (((uintptr_t)s & 3) == 0) {
    while (n >= 4) {
      // Protección contra lectura fuera de página
      if (((uintptr_t)s & 4095) > 4092) {
        break;
      }

      uint32_t word = *(const uint32_t *)s;

      if ((word - 0x01010101UL) & ~word & 0x80808080UL) {
        break; // Contiene un '\0', salir al bucle byte a byte
      }

      *(uint32_t *)d = word;
      d += 4;
      s += 4;
      n -= 4;
    }
  }

  // 3. Copia de bytes restantes
  while (n > 0) {
    if ((*d++ = *s++) == '\0') {
      n--;
      break;
    }
    n--;
  }

pad_zeros:
  // 4. Relleno con ceros requerido por strncpy (optimizado con bloques de 32
  // bits)
  if (n > 0) {
    while (((uintptr_t)d & 3) != 0 && n > 0) {
      *d++ = '\0';
      n--;
    }
    while (n >= 4) {
      *(uint32_t *)d = 0;
      d += 4;
      n -= 4;
    }
    while (n > 0) {
      *d++ = '\0';
      n--;
    }
  }

  return dest;
}

char *strtok(char *str, const char *delim) {
  // Al remover _Thread_local, la variable es compartida por todos los hilos.
  static char *last_token = NULL;

  if (str != NULL) {
    last_token = str;
  }
  if (last_token == NULL || *last_token == '\0') {
    return NULL;
  }

  // Tabla de búsqueda O(1) de 256 bits
  uint32_t table[8] = {0};

  while (*delim) {
    unsigned char c = (unsigned char)*delim;
    table[c >> 5] |= (1U << (c & 31));
    delim++;
  }

  // Saltar delimitadores iniciales
  while (*last_token) {
    unsigned char c = (unsigned char)*last_token;
    if (!(table[c >> 5] & (1U << (c & 31)))) {
      break;
    }
    last_token++;
  }

  if (*last_token == '\0') {
    return NULL;
  }

  char *token_start = last_token;

  // Buscar el final del token
  while (*last_token) {
    unsigned char c = (unsigned char)*last_token;
    if (table[c >> 5] & (1U << (c & 31))) {
      *last_token = '\0';
      last_token++;
      return token_start;
    }
    last_token++;
  }

  return token_start;
}
