# ⚙️ Microarquitectura: Señales de la Unidad de Control

La Unidad de Control del pipeline, ubicada en `Control_FLush.circ` (bloque `Decoder`), traduce el **OpCode** activo proveniente de `IF` en una **palabra binaria de control (`Control Word`) de 16 bits**. Esta palabra gobierna los selectores de los multiplexores, los habilitadores de escritura y las compuertas lógicas del resto del datapath.

## Definición del Vector de Control de 16 Bits (MSB → LSB)

| Bit | Nombre de Señal | Función y Comportamiento Lógico en el Hardware |
| :---: | :--- | :--- |
| **15** | `A==E` | Fuerza que el bus del operando A iguale la salida del Registro Especial (`REGE`) seleccionado por el campo `K`. Usado por `CYE` para leer el registro especial fuente. |
| **14-13**| `MEM/REG` | Selector del MUX de escritura en WB: `00` = dato proviene de la **ALU**; `01` = dato **leído de RAM**; `10` = **nuevo Stack Pointer (SP)**; `11` = **bloqueo / No Write** (no se escribe ningún registro). |
| **12** | `EnREGE` | Habilita la línea de escritura en el Banco de Registros Especiales/Sistema (`REGE`). Solo válido en `Kernel = 1` o para instrucciones que gestionan la pila de control (`CAL`, `RET`). |
| **11** | `EnREG` | Habilita la línea de escritura en el Banco de Registros Normales (GPR / `REGN`). |
| **10** | `HLT` | Congela la fase de *Instruction Fetch* e inhabilita los ciclos de reloj del núcleo hasta la recepción de una interrupción externa. |
| **9** | `RET` | Activa el subsistema secuenciador del hardware encargado de recuperar la dirección física de retorno desde la pila (vía `SP`). |
| **8-7** | `RoW` | Control de la memoria RAM: `00` y `01` = **sin operación sobre RAM**; `10` = habilita **modo Lectura**; `11` = habilita **modo Escritura**. |
| **6** | `Kernel` | Señal que indica una transición activa al anillo de máxima prioridad (Modo Kernel / Anillo 0), o el retorno desde él. Se activa para llamar al kernel o para regresar de él. |
| **5** | `BRH` | Habilita el análisis lógico de salto condicional directamente sobre la `Branch Unit`; su salida se compara contra el resultado de dicha unidad. |
| **4** | `JMP` | Habilita la línea física de sobre-escritura **incondicional** del Program Counter (`PC`). |
| **3** | `CAL` | Activa el subsistema/secuencia de pasos en hardware que habilitan los saltos con guardado de contexto (llamada a subrutina). |
| **2** | `EnBranch` | Permite o deniega el guardado (*latch*) de los resultados comparativos de la ALU en los `Eflags`. |
| **1** | `Inmediato`| Conmuta el multiplexor del bus del operando B en la etapa de ejecución para inyectar una constante extendida en signo proveniente de la instrucción original de 16 bits. |
| **0** | `Overflow` | Habilita la lectura/inyección del bit de acarreo persistente (*Carry/Overflow*) de la operación anterior sobre la nueva operación de la ALU (usado por `GOF`). |

## Matriz Completa de Firmware (Control Word por Instrucción)

La siguiente tabla refleja los valores exactos, bit a bit, almacenados en la ROM de decodificación (`Intr` / PLA), según la planilla de control oficial del proyecto (`Inst.xlsx`):

```text
Mnemónico | A==E | MEM/REG | EnREGE | EnREG | HLT | RET | RoW  | Kernel | BRH | JMP | CAL | EnBranch | Inmediato | Overflow
NOP       |  0   |   00    |   0    |   0   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    0     |     0     |    0
HLT       |  0   |   00    |   0    |   0   |  1  |  0  |  00  |   0    |  0  |  0  |  0  |    0     |     0     |    0
ADD       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
SUB       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
MUL       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
DIV       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
NOR       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
AND       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
XOR       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
RSH       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
LSH       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     0     |    0
GOF       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    0     |     0     |    1
LDI       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    0     |     1     |    0
ADI       |  0   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    1     |     1     |    0
JMP       |  0   |   00    |   0    |   0   |  0  |  0  |  00  |   0    |  0  |  1  |  0  |    0     |     0     |    0
BRH       |  0   |   00    |   0    |   0   |  0  |  0  |  00  |   0    |  1  |  0  |  0  |    0     |     0     |    0
CAL       |  0   |   10    |   1    |   0   |  0  |  0  |  11  |   0    |  0  |  0  |  1  |    0     |     0     |    0
RET       |  0   |   00    |   1    |   0   |  0  |  1  |  10  |   0    |  0  |  0  |  0  |    0     |     0     |    0
LOD       |  0   |   01    |   0    |   1   |  0  |  0  |  10  |   0    |  0  |  0  |  0  |    0     |     1     |    0
STR       |  0   |   00    |   0    |   1   |  0  |  0  |  11  |   0    |  0  |  0  |  0  |    0     |     1     |    0
CYE       |  1   |   00    |   0    |   1   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    0     |     0     |    0
CYR       |  0   |   00    |   1    |   0   |  0  |  0  |  00  |   0    |  0  |  0  |  0  |    0     |     0     |    0
SCL       |  0   |   00    |   0    |   0   |  0  |  0  |  00  |   1    |  0  |  1  |  0  |    0     |     0     |    0
SRT       |  0   |   00    |   0    |   0   |  0  |  0  |  00  |   1    |  0  |  0  |  0  |    0     |     0     |    0
```

> **Aclaración sobre optimización de hardware:** Múltiples instrucciones de la categoría aritmética, lógica y de desplazamiento (`ADD`, `SUB`, `MUL`, `DIV`, `NOR`, `AND`, `XOR`, `RSH`, `LSH`) comparten idéntica Control Word (`0000100000000100`). Esto se debe a que la Unidad de Control delega la selección final al circuito multiplexado interno de la `ALU`, el cual inspecciona directamente el `OpCode` en la etapa `EX` para canalizar la operación por el demultiplexor/operador correcto (Adder, Subtractor, Gates lógicas o Shifters).

> ⚠️ **Corrección respecto a documentación previa:** La fila de `SCL` y `SRT` se corrigió en base a `Inst.xlsx` (fuente de la ROM real). La versión previa de este documento indicaba para `SCL` los bits `Kernel=0, BRH=1, JMP=0, CAL=1`, lo cual era **incorrecto**. El valor real es `Kernel=1, JMP=1, BRH=0, CAL=0`: al ejecutar `SCL`, el hardware activa `Kernel` (transición de anillo) y reutiliza la línea `JMP` para forzar el salto incondicional del `PC` hacia la dirección apuntada por `SyS-JMP` (`R12`). De forma simétrica, `SRT` activa únicamente `Kernel=1` (retorno de anillo), ya que la carga del `PC` desde `EPC` es gestionada por el secuenciador de `Excp Gen`, no por la línea `JMP`.

## Tablas de Decodificación de Campos Multi-bit

### `RoW` (bits 8-7) — Control de Memoria RAM

| Valor | Significado |
| :---: | :--- |
| `00` | Sin operación sobre RAM |
| `01` | Sin operación sobre RAM |
| `10` | Habilita modo **Lectura** |
| `11` | Habilita modo **Escritura** |

### `MEM/REG` (bits 14-13) — Selector del MUX de Write-Back

| Valor | Significado |
| :---: | :--- |
| `00` | El dato a escribir proviene de la **ALU** |
| `01` | El dato a escribir proviene de **RAM** (resultado de `LOD`) |
| `10` | El dato a escribir es el **nuevo Stack Pointer (SP)** (`CAL`/`RET`) |
| `11` | **No Write** — bloqueo de escritura en el banco de registros |

## Significado Resumido de cada Bit de Control

| Bit | Señal | Significado |
| :---: | :--- | :--- |
| 0 | `Overflow` | Habilita la lectura del *Carry* guardado por la operación anterior. |
| 1 | `Inmediato` | Habilita el uso de valores inmediatos. |
| 2 | `EnBranch` | Habilita el guardado de la comparación / uso de flags. |
| 3 | `CAL` | Activa el subsistema/secuencia de pasos que permiten los saltos con contexto. |
| 4 | `JMP` | Habilita el salto incondicional. |
| 5 | `BRH` | Habilita el salto condicional; se compara con la salida de la Branch Unit. |
| 6 | `Kernel` | Se activa al llamar al kernel o al regresar de él. |
| 7-8 | `RoW` | Dicta cómo debe actuar la RAM ante un pedido de datos. |
| 9 | `RET` | Activa el subsistema que permite recuperar la dirección de retorno. |
| 10 | `HLT` | Congela el núcleo hasta que llegue una interrupción. |
| 11 | `EnREG` | Habilita el guardado en registros normales. |
| 12 | `EnREGE` | Habilita el guardado en registros especiales. |
| 13-14 | `MEM/REG` | Determina de dónde viene el dato para su posterior envío (WB). |
| 15 | `A==E` | Hace que el operando A sea igual al registro especial pedido. |

## Registro de Control Maestro `CR0`

Configurable vía hardware asíncrono o software a través de los bits inferiores de `CR0` (registro especial mapeado en `R6`):

| Bit | Señal | Función |
| :---: | :--- | :--- |
| **2** | `En_Interrup` | Habilitación global de interrupciones de hardware. |
| **1** | `En_TLB` | Activación del *Translation Lookaside Buffer* para la caché de páginas. |
| **0** | `En_MMU` | Habilitación del motor general de la Unidad de Gestión de Memoria. |

## Flags de Página (Tabla de Páginas)

Cada entrada de la tabla de páginas posee un byte de flags con la siguiente distribución (bits 7-0):

| Bit | Flag | Descripción |
| :---: | :--- | :--- |
| 3 | `Global` | La página es global (no se invalida entre cambios de `PCID`/contexto). |
| 2 | `KernelOnly` | La página solo es accesible en Modo Kernel. |
| 1 | `ReadOnly` | La página es de solo lectura (un `STR` sobre ella dispara Vector 2). |
| 0 | `Present` | La página está mapeada físicamente (si es `0`, dispara *Page Fault*). |

> Los bits 7-4 de los Flags de Página no tienen una asignación documentada; quedan reservados para extensiones futuras.
