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
