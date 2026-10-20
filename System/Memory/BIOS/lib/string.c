#include "string.h"
#include <stdint.h>

int strcmp(const char *s1, const char *s2) {
  // 1. Alinear s1 a 4 bytes (s2 podría no quedar alineado, lo cual es
  // aceptable)
  while ((uintptr_t)s1 & 3) {
    if (*s1 != *s2 || *s1 == '\0') {
      return *(const unsigned char *)s1 - *(const unsigned char *)s2;
    }
    s1++;
    s2++;
  }

  const uint32_t *w1 = (const uint32_t *)s1;
  const uint32_t *w2 = (const uint32_t *)s2;

  uint32_t magic_mask = 0x80808080UL;
  uint32_t lo_mask = 0x01010101UL;

  while (1) {
    uint32_t val1 = *w1;
    uint32_t val2 =
        *w2; // Nota: Puede causar penalización si s2 no está alineado

    // ¿Hay algún byte cero en w1?
    uint32_t has_zero = (val1 - lo_mask) & ~val1 & magic_mask;
    // ¿Difieren las palabras?
    uint32_t diff = val1 ^ val2;

    if (has_zero || diff) {
      // Consolidar byte por byte en la palabra actual para dar el resultado
      // correcto
      s1 = (const char *)w1;
      s2 = (const char *)w2;
      for (int i = 0; i < 4; i++) {
        if (s1[i] != s2[i] || s1[i] == '\0') {
          return *(const unsigned char *)(s1 + i) -
                 *(const unsigned char *)(s2 + i);
        }
      }
    }
    w1++;
    w2++;
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

  // 2. Bucle principal: procesar 4 bytes a la vez
  const uint32_t *w = (const uint32_t *)p;
  uint32_t magic_mask = 0x80808080UL;
  uint32_t lo_mask = 0x01010101UL;

  while (1) {
    uint32_t val = *w;
    // Detecta si algún byte en 'val' es cero
    if ((val - lo_mask) & ~val & magic_mask) {
      // Volver a apuntar con caracteres para encontrar el byte exacto
      p = (const char *)w;
      if (p[0] == '\0')
        return p - s;
      if (p[1] == '\0')
        return p + 1 - s;
      if (p[2] == '\0')
        return p + 2 - s;
      return p + 3 - s;
    }
    w++;
  }
}

int memcmp(const void *str1, const void *str2, size_t n) {
  const unsigned char *p1 = (const unsigned char *)str1;
  const unsigned char *p2 = (const unsigned char *)str2;

  for (size_t i = 0; i < n; i++) {
    if (p1[i] != p2[i]) {
      // Retorna la diferencia:
      // Positivo si p1 es mayor, Negativo si p2 es mayor
      return p1[i] - p2[i];
    }
  }

  // Si llegó aquí, los primeros 'n' bytes son exactamente iguales
  return 0;
}

void *strncpy(char *dest, const char *src, size_t n) {
  if (n == 0)
    return dest;

  char *d = dest;
  const char *s = src;

  // 1. Alinear el destino a una frontera de 4 bytes (32 bits)
  while (((uintptr_t)d & 3) != 0) {
    if ((*d++ = *s++) == '\0') {
      n--;
      goto pad_zeros; // Si encontramos \0, rellenamos el resto
    }
    if (--n == 0)
      return dest;
  }

  // 2. Copiar de 4 en 4 bytes si el origen también está alineado (evita
  // lecturas no alineadas)
  if (((uintptr_t)s & 3) == 0) {
    const uint32_t *s32 = (const uint32_t *)s;
    uint32_t *d32 = (uint32_t *)d;

    while (n >= 4) {
      uint32_t word = *s32;

      // Truco de bits: Detecta si la palabra de 32 bits contiene un byte cero
      // (\0) (word - 0x01010101) & ~word & 0x80808080
      if ((word - 0x01010101) & ~word & 0x80808080) {
        break; // Hay un \0 en estos 4 bytes, salir al bucle byte a byte
      }

      *d32++ = word;
      s32++;
      n -= 4;
    }
    d = (char *)d32;
    s = (const char *)s32;
  }

  // 3. Copiar los bytes restantes o manejar el final de la cadena
  while (n > 0) {
    if ((*d++ = *s++) == '\0') {
      n--;
      break;
    }
    n--;
  }

pad_zeros:
  // 4. Requisito de strncpy: Rellenar con ceros si n > longitud de src
  if (n > 0) {
    // Rellenar por bloques de 32 bits si quedan muchos ceros
    while (((uintptr_t)d & 3) != 0 && n > 0) {
      *d++ = '\0';
      n--;
    }
    uint32_t *d32 = (uint32_t *)d;
    while (n >= 4) {
      *d32++ = 0;
      n -= 4;
    }
    d = (char *)d32;
    while (n > 0) {
      *d++ = '\0';
      n--;
    }
  }

  return dest;
}

char *strtok(char *str, const char *delim) {
  static char *last_token = NULL;
  if (str != NULL) {
    last_token = str;
  }
  if (last_token == NULL || *last_token == '\0') {
    return NULL;
  }

  // Crear una tabla de búsqueda (Lookup Table) de 256 bits (32 bytes)
  uint32_t table[8] = {0};

  // Llenar la tabla con los delimitadores
  while (*delim) {
    unsigned char c = (unsigned char)*delim;
    table[c >> 5] |= (1U << (c & 31));
    delim++;
  }

  // Saltar delimitadores iniciales
  while (*last_token) {
    unsigned char c = (unsigned char)*last_token;
    if (!(table[c >> 5] & (1U << (c & 31)))) {
      break; // Encontró el inicio del token
    }
    last_token++;
  }

  if (*last_token == '\0') {
    return NULL;
  }

  char *token_start = last_token;

  // Buscar el final del token (próximo delimitador)
  while (*last_token) {
    unsigned char c = (unsigned char)*last_token;
    if (table[c >> 5] & (1U << (c & 31))) {
      *last_token = '\0'; // Cortar el token
      last_token++;
      return token_start;
    }
    last_token++;
  }

  return token_start;
}
