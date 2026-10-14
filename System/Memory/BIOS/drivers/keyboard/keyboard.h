#ifndef DRIVERS_KEYBOARD_H
#define DRIVERS_KEYBOARD_H

#include <stdbool.h>

#define KEYBOARD_MSI_NUM 126

bool keyboardSearch(void);
int readInput(char *out_buffer, int max_size);

#endif
