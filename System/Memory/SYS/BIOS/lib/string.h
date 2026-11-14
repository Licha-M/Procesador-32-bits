#ifndef LIB_STRING_H
#define LIB_STRING_H

#include <stddef.h>

int strcmp(const char *s1, const char *s2);
size_t strlen(const char *s);
int memcmp(const void *str1, const void *str2, size_t n);
void *strncpy(char *dest, const char *src, size_t n);
char *strtok(char *str, const char *delim);

#endif
