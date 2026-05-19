# 🧠 Sistema de Memoria e Interfaz ABI

## Alineación de Estructuras en Memoria

Para simplificar las cargas y almacenamientos (`LOD`/`STR`) a alta velocidad y habilitar chequeos de límites nativos (Bounds Checking) en hardware, la arquitectura dicta una regla estricta para la gestión de datos persistentes:

> 📐 **Regla de Gestión de Arrays:** Todo vector o arreglo estructurado almacenado en el espacio físico de memoria reserva obligatoriamente su primer offset (Dirección Base, $Offset\,0$) para declarar de forma explícita el tamaño entero (longitud) del array. El puntero de la aplicación referencia este bloque principal.

## Entorno de Ejecución e Interfaz Binaria de Aplicación (ABI)

El procesador expone un mapeo de 16 registros simétricos de uso general, que transforman su propósito semántico cuando se realiza una llamada al sistema (`SCL`) o se ingresa al entorno restringido del Kernel.

| Registro | Alias Normal | Rol en Syscall / Aplicación | Alias Especial | Rol en Hardware / Kernel |
| :---: | :--- | :--- | :--- | :--- |
| **R0** | `R0` | Uso general | `RE0` | Reservado (Limpieza interna). |
| **R1** | `R1` | Motivo de llamada y Resultado | `EPC` | *Exception Program Counter*. Dirección exacta a reanudar tras `SRT`. |
| **R2** | `R2` | Parámetro Entrada 1 | `SP` | *Stack Pointer*. Puntero físico de la pila activa. |
| **R3** | `R3` | Parámetro Entrada 2 | `PCID` | *Process Context ID* (Almacenado dentro de la MMU). |
| **R4** | `R4` | Parámetro Entrada 3 | `CR3` | Base de la Tabla de Páginas (Puntero a raíz de traslación). |
| **R5** | `R5` | Parámetro Entrada 4 | `CR2` | *Page Fault Linear Address*. Dirección virtual del fallo de memoria. |
| **R6** | `R6` | Parámetro Entrada 5 | `CR0` | Control de la MMU y estado de banderas globales. |
| **R7** | `R7` | Puntero Opcional | `Cause` | Identificador de Excepción (ID de la interrupción generada). |
| **R8** | `R8` | Uso General | — | Libre. |
| **R9** | `R9` | Uso General | `Eflags` | Registro de Flags ALU. |
| **R10**| `R10` | Uso General | `Carry` | Bit de acarreo persistente para encadenamientos. |
| **R11**| `R11` | Uso General | `TR` | *Task Register* (Puntero a TSS, SP0 de kernel). |
| **R12**| `R12` | Uso General | `SyS-JMP` | Vector de salto automático (Punto de entrada de Syscalls). |
| **R13**| `R13` | Uso General | — | Libre. |
| **R14**| `R14` | Uso General | `RegE_K_1` | **Registro Shadow del Kernel**. |
| **R15**| `R15` | Uso General | `RegE_K_2` | **Registro Shadow del Kernel**. |

> ⚠️ **Principio Crítico de Hardware (Cambio de Contexto):** Los registros especiales `R14` y `R15` (`RegE Kernel`) están físicamente aislados. Son usados única y exclusivamente por el micronúcleo para resguardar punteros críticos inmediatamente tras la interrupción, antes de escribir y volcar el bloque completo de registros del espacio de usuario en la pila física del sistema.

## Configuración del Registro de Control Maestro `CR0`

Configurable vía hardware asíncrono o software a través de los bits inferiores de `CR0`:
* **Bit 2:** `En_Interrup` (Habilitación global de interrupciones de hardware).
* **Bit 1:** `En_TLB` (Activación del Translation Lookaside Buffer para la caché de páginas).
* **Bit 0:** `En_MMU` (Habilitación del motor general de la Unidad de Gestión de Memoria).
