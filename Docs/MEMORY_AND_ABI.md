# 🧠 Sistema de Memoria e Interfaz ABI

## Mapa de Registros y ABI (Application Binary Interface)

El procesador expone **16 registros simétricos** de uso general (`R0`–`R15`). Estos registros tienen un propósito semántico dual: funcionan como registros de propósito general (GPR) durante la ejecución normal de usuario, y adoptan un **alias especial** con roles específicos de hardware/sistema cuando el procesador entra en Modo Kernel (tras un `SCL`) o cuando el hardware accede directamente a ellos.

| Reg | Alias Normal | Rol en Aplicación / Syscall | Alias Especial | Rol en Hardware / Kernel |
| :---: | :--- | :--- | :--- | :--- |
| **R0** | `R0` | Reservado / Limpieza interna | `RE0` | Reservado. No usar. |
| **R1** | `R1` | Motivo de la llamada y Resultado | `EPC` | *Exception Program Counter*: dirección exacta a reanudar tras `SRT`. Guardado por hardware al ingresar al kernel. |
| **R2** | `R2` | Parámetro de entrada 1 | `SP` | *Stack Pointer*: puntero físico de la pila activa del proceso. |
| **R3** | `R3` | Parámetro de entrada 2 | `PCID` | *Process Context ID*: almacenado dentro de la MMU para aislar espacios de páginas. |
| **R4** | `R4` | Parámetro de entrada 3 | `CR3` | Base de la tabla de páginas: puntero a la raíz de la estructura de traslación de memoria virtual. |
| **R5** | `R5` | Parámetro de entrada 4 | `CR2` | *Page Fault Linear Address*: dirección virtual que causó el último fallo de memoria. |
| **R6** | `R6` | Parámetro de entrada 5 | `CR0` | Control de la MMU y estado de banderas globales (ver [CONTROL_UNIT.md](./CONTROL_UNIT.md)). |
| **R7** | `R7` | Posible puntero (opcional) | `Cause` | Identificador de excepción: ID de la interrupción/excepción generada. Puede ser escrito de forma asíncrona por cualquier subsistema (MMU, decodificador, LAPIC). |
| **R8** | `R8` | Uso general (fuera de ABI) | — | Sin definir. Libre para el kernel. |
| **R9** | `R9` | Uso general (fuera de ABI) | `Eflags` | Registro de flags de la ALU (Zero, Carry, Overflow, signo). Ubicado dentro de la ALU/Branch Unit. |
| **R10** | `R10` | Uso general (fuera de ABI) | `Carry` | Bit de acarreo persistente para encadenamiento de operaciones multi-word. |
| **R11** | `R11` | Uso general (fuera de ABI) | `TR` | *Task Register*: puntero a la TSS (*Task State Segment*), que contiene el `SP` de Kernel (`RSP0`) y los distintos punteros `IST`. |
| **R12** | `R12` | Uso general (fuera de ABI) | `SyS-JMP` | Vector de salto automático: dirección del punto de entrada del manejador de Syscalls del SO. El hardware salta aquí al detectar `SCL`. |
| **R13** | `R13` | Uso general (fuera de ABI) | `RegE Kernel` | **Registro Shadow del Kernel** (reservado exclusivamente para el kernel; ver nota abajo). |
| **R14** | `R14` | Uso general (fuera de ABI) | `RegE Kernel` | **Registro Shadow del Kernel**. |
| **R15** | `R15` | Uso general (fuera de ABI) | `RegE Kernel` | **Registro Shadow del Kernel**. |

> ⚠️ **Principio crítico de hardware (cambio de contexto):** Los registros `R13`, `R14` y `R15` (`RegE Kernel`) están físicamente protegidos. Son de uso exclusivo del micronúcleo para resguardar punteros críticos inmediatamente tras la interrupción, **antes** de volcar el bloque completo de registros del espacio de usuario en la pila física del sistema. Nunca deben ser escritos por código de usuario.

> 📝 **Nota sobre R3/PCID:** El alias `PCID` es gestionado internamente por la MMU y no reside en el banco de registros principal; se accede vía instrucciones privilegiadas (`CYE`/`CYR`) o por la propia MMU de forma transparente.

> 📝 **Nota sobre R9/Eflags y R10/Carry:** Estos registros son gestionados por la ALU/Branch Unit y se actualizan automáticamente por las instrucciones que alteran flags. Se accede a ellos via `CYE` en modo kernel.

---

## Convención de Llamada (Calling Convention)

| Rol | Registro | Descripción |
| :--- | :---: | :--- |
| Número de syscall / Resultado de retorno | `R1` | Se escribe antes de `SCL`; contiene el resultado al retornar del SO. |
| Parámetros 1–5 | `R2`–`R6` | Argumentos de entrada a la syscall. |
| Puntero opcional (buffer, puntero de retorno) | `R7` | Uso opcional según la syscall. |
| Uso libre del llamador | `R8`–`R15` | No preservados por el SO durante una syscall. |

---

## Comportamiento del Stack Pointer (SP) con `CAL` y `RET`

El **Stack Pointer (`SP`)** siempre apunta al **último elemento agregado** en la pila (pila descendente). Las instrucciones de control de flujo gestionan este puntero automáticamente:

### Instrucción `CAL`
1. Se **suma 4** al valor actual del `SP`.
2. Se guarda la **dirección de retorno** (`PC+4` del punto de llamada) en la dirección apuntada por el nuevo `SP`.
3. El `PC` salta a la dirección contenida en `REG B`.

Observación: si se lee directamente el `SP` después de un `CAL`, apuntará exactamente a la última dirección de retorno guardada.

### Instrucción `RET`
1. Lee la dirección de retorno a la que apunta el `SP` actual.
2. En paralelo, **resta 4** al `SP` para recuperar su estado anterior.
3. El `PC` salta a la dirección leída.

```
Estado de la pila tras CAL anidados:
  SP → [ dirección de retorno de CAL más reciente ]
       [ dirección de retorno de CAL anterior       ]
       [ ...                                         ]
       [ fondo de la pila                            ]
```

---

## Alineación de Estructuras en Memoria

Para simplificar los accesos `LOD`/`STR` a alta velocidad y habilitar verificaciones de límites nativas (*bounds checking*) en hardware, la arquitectura impone una regla estricta para los arrays:

> 📐 **Regla de Gestión de Arrays:** Todo vector o arreglo estructurado almacenado en memoria reserva obligatoriamente su **primer offset (Dirección Base, Offset 0)** para declarar de forma explícita el **tamaño entero (longitud)** del array. El puntero de la aplicación referencia este bloque de cabecera.

```
Dirección Base (puntero del array):
  [Offset 0] = N (longitud del array)
  [Offset 1] = elemento[0]
  [Offset 2] = elemento[1]
  ...
  [Offset N] = elemento[N-1]
```

### Regla de Alineación de Accesos

Todo acceso a memoria (`LOD`/`STR`, o saltos cuya dirección destino ingresa a `FETCH`) **debe terminar en los 2 bits menos significativos en `00`** (dirección múltiplo de 4 bytes). Un acceso con los bits `[1:0]` distintos de `00` dispara la excepción **Vector 6 — Alignment Fault**.

---

## Manejo de Interrupciones Anidadas

### Flujo de Entrada a una Interrupción

Cuando el programa de usuario recibe una interrupción y el hardware inyecta `SCL`:

1. El hardware guarda automáticamente en los registros **Shadow** (`R13`/`R14`/`R15`) los registros críticos de contexto (`R1`, `Eflags`, `Carry`) antes de que el banco de GPR sea modificado.
2. El kernel deshabilita las interrupciones (`CR0.En_Interrup = 0`) para proteger el contexto.
3. El kernel toma el `SP`, le suma 4 y guarda en la pila los registros necesarios para reanudar: `EPC`, `Eflags` y `Carry`.
4. Una vez persistido el contexto en la pila, el kernel reactiva las interrupciones (`CR0.En_Interrup = 1`) y comienza a resolver la interrupción.

Si llega una nueva interrupción de mayor prioridad mientras se resuelve la anterior, **el proceso se repite desde el paso 1**, apilando un nuevo contexto sobre el anterior (anidamiento).

### El Registro ISR del LAPIC como "Pila de Prioridades"

El módulo LAPIC lleva un registro exacto de las interrupciones en curso mediante el **ISR (In-Service Register)**:

- Al llegar la **Int 1**, se marca su bit en el ISR.
- Cuando la **Int 2** (mayor prioridad) interrumpe a la primera, el hardware **marca un segundo bit en el ISR sin borrar el primero**.
- El LAPIC sabe que hay dos tareas "en servicio", pero solo permite avanzar a la de mayor prioridad.

### Flujo de Retorno Correcto (Desenredo de la Pila)

Para volver a la primera interrupción sin errores:

1. El manejador de la Int 2 finaliza su tarea.
2. El software envía un comando **EOI** al LAPIC.
3. El LAPIC limpia **solo el bit de mayor prioridad activo en el ISR** (el de la Int 2). El bit de la Int 1 permanece encendido.
4. El kernel hace `POP` de la pila recuperando el `EPC`, `Eflags` y `Carry` del manejador de la Int 1.
5. La instrucción **`SRT`** carga el `EPC` en el `PC` y reanuda la ejecución del primer manejador exactamente donde fue interrumpido.

> 💡 **¿Por qué no "salta de nuevo" como interrupción nueva?** Porque el bit de la Int 1 en el ISR ya estaba activo. El LAPIC no genera un nuevo IRQ para algo que ya está en servicio. Solo cuando el primer manejador termine y envíe **su propio EOI**, el LAPIC limpiará el último bit del ISR y quedará listo para interrupciones de menor prioridad.

> ⚠️ **Regla de Oro:** No se envía un único EOI al final de todo. Se debe enviar **un EOI por cada interrupción resuelta**, permitiendo al hardware "pelar las capas" del ISR una a una.

---

## Manejadores de Hoja (*Leaf Handlers*) con Shadow Registers

Para interrupciones **livianas o de alta frecuencia** (tick de reloj, lectura de estado de periférico), es posible implementar un **manejador de hoja** que opere exclusivamente con los registros shadow `R13`/`R14`/`R15`, sin tocar la RAM en ningún momento.

### Flujo de Salto Rápido (Sin RAM)

1. El hardware deshabilita las interrupciones automáticamente al entrar en Modo Kernel.
2. El Kernel opera únicamente con `R13`, `R14` y `R15` (Shadow Registers).
3. Los registros `R0`–`R12` del usuario **no se tocan**, evitando las lentas operaciones `STR`/`LOD` a RAM.
4. El Kernel ejecuta `SRT` y el programa de usuario continúa en tiempo récord.

### Comparación de Ciclos Estimados

| Tipo de Manejador | Ciclos Estimados | Motivo |
| :--- | :---: | :--- |
| **Con Stack (RAM)** | 10 – 20 ciclos | Guardar y recuperar registros implica accesos lentos a memoria. |
| **Con Shadow Registers** | 2 – 3 ciclos | Entrar, mover datos con `R13`/`R14`/`R15` y salir, sin acceso a RAM. |

### Limitación Crítica: Flags y Carry

Si el manejador usa la ALU (ej. un `ADD` sobre `R14`), **los flags del usuario se corromperán**. Este flujo rápido solo es seguro si el manejador realiza exclusivamente movimientos de datos (`LOD`/`STR` entre periférico y memoria) que **no afecten `Eflags` ni `Carry`**, o si la arquitectura implementa un registro `EPSW` que guarde las flags automáticamente al ingresar al Modo Kernel.

### ¿Cuándo NO Usar Este Método?

- **Riesgo de anidamiento:** Si el manejador necesita que otra interrupción de mayor prioridad pueda interrumpirlo, **se debe usar el stack**. El anidamiento requiere liberar el `EPC` y los shadow registers para el siguiente nivel.
- **Complejidad del cálculo:** Si el manejador necesita más de tres registros de trabajo (`R13`/`R14`/`R15`), se vería forzado a usar registros de usuario, corrompiendo el estado del programa.

> 💡 **Conclusión:** Para interrupciones críticas en tiempo pero simples en lógica, la estrategia óptima es mantener las interrupciones **desactivadas**, operar solo con `R13`/`R14`/`R15` para evitar la RAM, y salir rápidamente con `SRT`. Esto maximiza el IPC y minimiza el impacto del cambio de contexto.
