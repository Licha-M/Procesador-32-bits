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

## Comportamiento del Stack Pointer (SP) con CAL y RET

El **Stack Pointer (SP)** siempre apunta al último elemento agregado en la pila. Las instrucciones de control de flujo gestionan este puntero automáticamente de la siguiente manera:

* **Instrucción `CAL`:** Al ejecutarse, se le **suma 4** al valor del `SP` y se guarda la dirección de retorno en esa nueva ubicación.
* **Instrucción `RET`:** Lee la última dirección de retorno a la que apunta directamente el `SP` actual. En paralelo, **resta 4** al `SP` para recuperar su estado anterior.

Esto hace que si se observa a dónde apunta el `SP`, se obtendrá exactamente la última dirección de retorno. `RET` entonces ve esa dirección para saltar a ella y, en paralelo, guarda el nuevo `SP` haciéndole -4.

## Manejo de Interrupciones Anidadas y el LAPIC ISR

### Flujo de Entrada a una Interrupción

Cuando el programa de usuario recibe una interrupción y entra en modo kernel, el hardware inyecta automáticamente un `SCL`. La secuencia es la siguiente:

1. El hardware guarda en los registros **Shadow** (`RegE_K_1`, `RegE_K_2`) los registros `R1`, `Eflags` y `Carry`.
2. El kernel deshabilita las interrupciones (`En_Interrup = 0`).
3. Toma el `SP`, le suma 4 y guarda en la pila los registros necesarios para continuar: `EPC`, `Eflags` y `Carry`.
4. Una vez guardado el contexto, el kernel reactiva las interrupciones (`En_Interrup = 1`) y comienza a resolver la interrupción.

Si llega una nueva interrupción de mayor prioridad mientras se resuelve la anterior, **el proceso se repite desde el paso 1**, apilando un nuevo contexto sobre el anterior.

### El Registro ISR del LAPIC como "Pila de Prioridades"

El módulo LAPIC no solo sabe que "hay una interrupción activa", sino que lleva un registro exacto de cuáles están en curso mediante el **ISR (In-Service Register)**:

* Cuando llega la **Int 1**, se marca su bit en el ISR.
* Cuando la **Int 2** (de mayor prioridad) interrumpe a la primera, el hardware **marca un segundo bit en el ISR sin borrar el primero**.
* El LAPIC sabe que tiene dos tareas "en servicio", pero solo permite avanzar a la de mayor prioridad.

### Flujo de Retorno Correcto (Desenredo de la Pila)

Para volver a la primera interrupción sin errores se debe seguir este proceso:

1. **Finalización de la Int 2:** El manejador termina su tarea.
2. **Envío del EOI:** El software envía un comando EOI al LAPIC.
3. **Acción del hardware:** El LAPIC limpia **solo el bit de mayor prioridad activo en el ISR** (el de la Int 2). El bit de la Int 1 permanece encendido.
4. **Restauración de contexto:** El kernel hace POP de la pila recuperando el `EPC`, `Eflags` y `Carry` del manejador de la Int 1.
5. **Instrucción `SRT`:** El procesador carga el `EPC` en el PC y reanuda la ejecución del primer manejador justo donde fue cortado.

> 💡 **¿Por qué no "salta de nuevo" como interrupción nueva?** Porque el bit de la Int 1 en el ISR ya estaba activo. El LAPIC no genera un nuevo IRQ para algo que ya está procesándose. Solo cuando el primer manejador termine y mande **su propio EOI**, el LAPIC limpiará el último bit del ISR y quedará listo para interrupciones de menor prioridad.

> ⚠️ **Regla de Oro:** No se envía un único EOI al final de todo. Se debe enviar **un EOI por cada interrupción resuelta**, permitiendo que el hardware "pele las capas" del ISR una a una, volviendo secuencialmente desde la interrupción más urgente hasta el programa de usuario original.

### El Double Fault (`#DF`) — Vector 5

Si ocurre una **excepción** (bit 31 = 1 en el identificador de causa) mientras ya se está resolviendo una interrupción activa en el ISR, y el sistema no puede salvar el contexto (por ejemplo, `SP` inválido o fallo de la MMU al acceder al stack), el hardware detecta que el bit "en servicio" ya estaba activo para un evento crítico y dispara el **Vector 5 (`#DF` — Double Fault)**.

En esta arquitectura, el `#DF` es el **"freno de mano"**: el sistema operativo debe abortar el programa de usuario de forma inmediata para evitar que el núcleo entre en un estado inconsistente o en un **Triple Fault** (reset físico del procesador).

---

## Manejadores de Hoja (Leaf Handlers) con Shadow Registers

Para interrupciones **livianas o de alta frecuencia** (como un tick de reloj simple o verificar el estado de un periférico), es posible implementar un **manejador de hoja** (*leaf handler*) que opera exclusivamente con los registros shadow `R14` y `R15`, sin tocar la RAM en ningún momento.

### Flujo de Salto Rápido (Sin RAM)

Cuando llega una interrupción simple, el hardware realiza la inyección del `SCL` y el núcleo ejecuta la siguiente secuencia optimizada:

1. **Deshabilitación automática:** El hardware deshabilita las interrupciones al entrar en modo Kernel para proteger el `EPC` y los registros `R14`/`R15` de una sobreescritura asíncrona.
2. **Uso exclusivo de Shadow Registers:** El Kernel opera únicamente con `R14` y `R15`. Por ejemplo, `R14` puede apuntar a la dirección base de los registros de E/S y `R15` actuar como valor temporal.
3. **Preservación del entorno de usuario:** Como el Kernel no usa `R0`–`R13`, **no hay necesidad de salvarlos en el stack** (se evitan las lentas operaciones `STR`/`LOD` a RAM).
4. **Retorno inmediato:** El Kernel ejecuta `SRT` y el programa de usuario continúa en tiempo récord.

### Limitación Crítica: Flags y Carry

Para que este método funcione sin efectos secundarios, el manejador **no debe alterar el estado lógico del programa de usuario**:

* Si el manejador usa la ALU (ej. un `ADD` en `R14`), las **flags de usuario se perderán**.
* Este flujo solo es seguro si el manejador realiza exclusivamente movimientos de datos (`LOD`/`STR` entre periférico y memoria) que no afecten `Eflags` ni `Carry`, o si la arquitectura implementa un registro **EPSW** que guarde las flags automáticamente al entrar al modo Kernel.

### Comparación de Ciclos

En un procesador de baja frecuencia, la diferencia es significativa:

| Tipo de Manejador | Ciclos Estimados | Motivo |
| :--- | :---: | :--- |
| **Con Stack (RAM)** | 10 – 20 ciclos | Guardar y recuperar registros implica accesos lentos a memoria. |
| **Con Shadow Registers** | 2 – 3 ciclos | Entrar, mover un dato con `R14`/`R15` y salir. Sin acceso a RAM. |

### ¿Cuándo NO Usar Este Método?

Este camino rápido **no es adecuado** en los siguientes casos:

* **Riesgo de anidamiento:** Si se necesita que una interrupción de mayor prioridad pueda interrumpir a este manejador, se **debe** usar el stack. El anidamiento requiere liberar el `EPC` y los shadow registers para el siguiente nivel de interrupción.
* **Complejidad del cálculo:** Si el manejador necesita más de dos registros de trabajo (`R14`, `R15`), estaría forzado a usar los registros de usuario, corrompiendo el estado del programa.

> 💡 **Conclusión:** Para interrupciones críticas en tiempo pero simples en lógica, la estrategia óptima es mantener las interrupciones **desactivadas**, operar solo con `R14` y `R15` para evitar la RAM, y salir rápidamente con `SRT`. Esto maximiza el IPC y minimiza el impacto del cambio de contexto en una arquitectura RISC de recursos limitados.

---

## Configuración del Registro de Control Maestro `CR0`

Configurable vía hardware asíncrono o software a través de los bits inferiores de `CR0`:
* **Bit 2:** `En_Interrup` (Habilitación global de interrupciones de hardware).
* **Bit 1:** `En_TLB` (Activación del Translation Lookaside Buffer para la caché de páginas).
* **Bit 0:** `En_MMU` (Habilitación del motor general de la Unidad de Gestión de Memoria).
