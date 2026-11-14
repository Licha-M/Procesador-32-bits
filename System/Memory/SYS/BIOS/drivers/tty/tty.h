#ifndef DRIVERS_TTY_H
#define DRIVERS_TTY_H

#include <stdbool.h>

#define TTY_MSI_NUM 127

bool displaySearch(void);
void biosClear(void);
void biosWrite(char string[], int cant);

#endif
