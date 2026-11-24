#ifndef DRIVERS_BOOT_H
#define DRIVERS_BOOT_H

#include "../fs/fat-lm/fs.h"
#include <stdbool.h>
#include <stdint.h>

// Bootloaders encontrados en las particiones EFI de todas las NVM.
// El ID que ve el usuario es el índice en bootEntries.

#define BOOT_MAX_ENTRIES 32

#define BOOT_OK 0
#define BOOT_ERR_BAD_ID (-1) // ID inexistente
#define BOOT_ERR_FS (-2)     // no se pudo montar la partición EFI
#define BOOT_ERR_FILE (-3)   // no existe / vacío / error de lectura
#define BOOT_ERR_MEM (-4)    // no hay memoria para cargarlo

typedef struct {
  uint32_t disp;                // índice de NVM donde está
  char folder[FS_NAME_MAX + 1]; // carpeta dentro de la partición EFI
  char file[FS_NAME_MAX + 1];   // nombre del .bin
} BootEntry;

extern BootEntry *bootEntries;
extern uint32_t bootCount;
extern int32_t bootSelected; // ID elegido con setboot, -1 si ninguno

// Reserva la tabla y la deja vacía. Llamar antes de escanear discos.
int bootInit(void);

// Agrega a la tabla los .bin de la partición EFI de la NVM 'disp' (omite la
// carpeta EFI_Services). Devuelve cuántos agregó; 0 = no booteable.
uint32_t bootScanDisk(uint32_t disp);

// Carga el bootloader 'id' en memoria y le entrega el control.
// Solo retorna si falló (código negativo) o si el bootloader devolvió el
// control (BOOT_OK).
int bootRun(uint32_t id);

#endif
