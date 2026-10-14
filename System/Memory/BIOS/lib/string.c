#include "string.h"
#include <stdint.h>

int strcmp(const char *s1, const char *s2) {
  while (*s1 && (*s1 == *s2)) {
    s1++;
    s2++;
  }
  return *(const unsigned char *)s1 - *(const unsigned char *)s2;
}

size_t strlen(const char *s) {
  size_t i = 0;
  while (s[i] != '\0') {
    i++;
  }
  return i;
}
