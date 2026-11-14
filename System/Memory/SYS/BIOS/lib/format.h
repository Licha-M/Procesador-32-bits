#ifndef LIB_FORMAT_H
#define LIB_FORMAT_H

#include <stdint.h>

#define FMT_INT       0 
#define FMT_UINT      1 
#define FMT_HEX       2 
#define FMT_HEX_TRUNC 2 
#define FMT_HEX_FULL  3 

char *ToAscii(uint32_t num, int fmt);

#endif
