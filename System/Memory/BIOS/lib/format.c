#include "format.h"
#include "../hal/lapic.h"

#define ASCII_POOL_SIZE 8
#define ASCII_BUF_SIZE 32

static char ascii_pool[ASCII_POOL_SIZE][ASCII_BUF_SIZE];
static int current_pool_index = 0;

char *ToAscii(uint32_t num, int fmt) {
  uint32_t flags_guardadas = enterCriticalSection();
  char *ascii_buffer = ascii_pool[current_pool_index];
  current_pool_index = (current_pool_index + 1) % ASCII_POOL_SIZE;
  exitCriticalSection(flags_guardadas);

  char *p = ascii_buffer + ASCII_BUF_SIZE - 1;
  *p = '\0';

  if (fmt == FMT_HEX_FULL) {
    for (int i = 0; i < 8; i++) {
      uint32_t nibble = num & 0xFu;
      *--p = (char)(nibble < 10 ? '0' + nibble : 'A' + nibble - 10);
      num >>= 4;
    }
    return p;
  }

  if (fmt == FMT_HEX || fmt == FMT_HEX_TRUNC) {
    if (__builtin_expect(num == 0, 0)) {
      *--p = '0';
    } else {
      while (num > 0) {
        uint32_t nibble = num & 0xFu;
        *--p = (char)(nibble < 10 ? '0' + nibble : 'A' + nibble - 10);
        num >>= 4;
      }
    }
    return p;
  }

  uint32_t uval;
  uint32_t mask = 0;
  if (fmt == FMT_INT) {
    uint32_t is_neg = num >> 31;
    mask = 0u - is_neg;
    uval = (num ^ mask) - mask;
  } else {
    uval = num;
  }

  if (__builtin_expect(uval == 0, 0)) {
    *--p = '0';
  } else {
    while (uval > 0) {
      uint32_t r = uval % 10;
      uval = uval / 10;
      *--p = '0' + (char)r;
    }
  }
  if (mask)
    *--p = '-';
  return p;
}
