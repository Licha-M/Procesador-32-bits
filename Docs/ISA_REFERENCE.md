# 📋 Guía del Conjunto de Instrucciones (ISA)

El procesador usa un esquema de **longitud fija de 32 bits (4 bytes)**, dividido en campos predictivos que optimizan la etapa de decodificación en hardware.

## Formato General de la Instrucción

| Bits | Tamaño | Campo | Descripción |
| :---: | :---: | :--- | :--- |
| **31-29** | 3 bits | `Tipo` | Categoría de la operación (ALU/normal, `Intr` para control de flujo, `int 32 / char 8` para memoria). |
| **28-24** | 5 bits | `OpCode` | Código de operación único (32 valores posibles, 24 implementados). |
| **23-0** | 24 bits | Operandos | Segmentados dinámicamente según la instrucción: `REG A`, `REG B`, `REG C`, `REG E` (registro especial), `Cond` (condición de salto), valores inmediatos u offsets de hasta 16 bits. |

Los registros (`REG A`, `REG B`, `REG C`, `REG E`) ocupan **4 bits** cada uno dentro del campo de operandos, suficientes para direccionar los 16 registros (`R0`–`R15`).

## Instrucciones Soportadas

| ID | Mnemónico | Tipo | OpCode (5b) | Campos de operandos | Descripción funcional |
| :---: | :---: | :---: | :---: | :--- | :--- |
| **0** | **NOP** | — | `00000` | — | Operación nula; no altera el estado del datapath. Usada como burbuja de pipeline / retardo, y también como valor por defecto del registro `Cause` (sin excepción). |
| **1** | **HLT** | — | `00001` | — | Detiene el núcleo (congela el `PC` e inhabilita los ciclos de reloj de fetch) hasta recibir una interrupción o instrucción externa. Altera flags ALU (marcado `X`). |
| **2** | **ADD** | ALU | `00010` | `REG A`, `REG B`, `REG C` | Suma aritmética: $REG\,C \leftarrow REG\,A + REG\,B$. Altera flags ALU. |
| **3** | **SUB** | ALU | `00011` | `REG A`, `REG B`, `REG C` | Resta aritmética: $REG\,C \leftarrow REG\,A - REG\,B$. Altera flags ALU. |
| **4** | **MUL** | ALU | `00100` | `REG A`, `REG B`, `REG C` | Multiplicación entera: $REG\,C \leftarrow REG\,A \times REG\,B$. Altera flags ALU. |
| **5** | **DIV** | ALU | `00101` | `REG A`, `REG B`, `REG C` | División entera: $REG\,C \leftarrow REG\,A \div REG\,B$. Altera flags ALU. |
| **6** | **NOR** | Lógica | `00110` | `REG A`, `REG B`, `REG C` | Lógica bit a bit NOR: $REG\,C \leftarrow \neg(REG\,A \lor REG\,B)$. Altera flags ALU. |
| **7** | **AND** | Lógica | `00111` | `REG A`, `REG B`, `REG C` | Lógica bit a bit AND: $REG\,C \leftarrow REG\,A \land REG\,B$. Altera flags ALU. |
| **8** | **XOR** | Lógica | `01000` | `REG A`, `REG B`, `REG C` | Lógica bit a bit XOR: $REG\,C \leftarrow REG\,A \oplus REG\,B$. Altera flags ALU. |
| **9** | **RSH** | Shift | `01001` | `REG A`, `REG B`, `REG C` | Desplazamiento lógico a la derecha: $REG\,C \leftarrow REG\,A \gg REG\,B$. Altera flags ALU. |
| **10**| **LSH** | Shift | `01010` | `REG A`, `REG B`, `REG C` | Desplazamiento lógico a la izquierda: $REG\,C \leftarrow REG\,A \ll REG\,B$. Altera flags ALU. |
| **11**| **GOF** | ALU | `01011` | `REG A` | "Get OverFlow": recupera el bit de *Carry/Overflow* persistente generado por la operación ALU anterior y lo escribe en `REG A`. No usa inmediato. |
| **12**| **LDI** | Inmediato | `01100` | `REG A`, `Inmediato` (16 bits) | Carga inmediata: transfiere una constante de 16 bits (extendida) directamente a `REG A`. No altera flags. |
| **13**| **ADI** | Inmediato | `01101` | `REG A`, `Inmediato` (16 bits) | Suma inmediata: $REG\,A \leftarrow REG\,A + Inmediato$. Altera flags ALU. |
| **14**| **JMP** | `Intr` | `01110` | `REG B` | Salto incondicional absoluto: el `PC` toma el valor contenido en `REG B`. |
| **15**| **BRH** | `Intr` | `01111` | `Cond`, `REG B` | Salto condicional: si la condición `Cond` evaluada por la Branch Unit se cumple, el `PC` toma el valor de `REG B`. |
| **16**| **CAL** | `Intr` | `10000` | `REG B` | Llamada a subrutina: incrementa `SP` en 4, guarda la dirección de retorno en la pila (vía registro especial), y salta a la dirección en `REG B`. |
| **17**| **RET** | `Intr` | `10001` | — | Retorno de subrutina: lee la dirección de retorno apuntada por `SP`, salta a esa dirección, y decrementa `SP` en 4. |
| **18**| **LOD** | `int 32 / char 8` | `10010` | `REG A`, `REG B`, `Offset` (16 bits) | Carga desde memoria: lee de RAM en la dirección `REG A + Offset` y escribe el resultado en `REG B`. Usa inmediato (offset con signo extendido). |
| **19**| **STR** | `int 32 / char 8` | `10011` | `REG A`, `REG B`, `Offset` (16 bits) | Almacenamiento en memoria: escribe en RAM, en la dirección `REG A + Offset`, el dato contenido en `REG B`. Usa inmediato. |
| **20**| **CYE** | Privilegiada | `10100` | `REG E`, `REG A` | Copia el contenido de un **registro especial** (`REG E`) a un **registro normal** (`REG A`). Altera flags (marcado `X`). |
| **21**| **CYR** | Privilegiada | `10101` | `REG A`, `REG E` | Copia el contenido de un **registro normal** (`REG A`) a un **registro especial** (`REG E`). |
| **22**| **SCL** | Sistema | `10110` | — | *Syscall*: interrupción de software que transfiere el control al Sistema Operativo (transición a Modo Kernel y salto al vector `SyS-JMP`). |
| **23**| **SRT** | Sistema | `10111` | — | *Syscall Return*: retorno del SO a la dirección guardada en `EPC`; restaura el modo de ejecución previo. Altera flags (marcado `X`). |

> 📌 **Campos no usados:** Los `OpCodes` `11000`–`11111` (24-31) no están asignados; su ejecución dispara la excepción **Vector 4 — Invalid Opcode** (ver [INTERRUPTS_AND_EXCEPTIONS.md](./INTERRUPTS_AND_EXCEPTIONS.md)).

## Notas sobre Operandos Especiales

- **`Cond` (BRH):** Campo de 4 bits que codifica la condición de salto a evaluar contra los `Eflags`/`Carry` (Zero, Carry, Overflow, signo, etc.) en la Branch Unit.
- **`REG E` (CYE/CYR):** Direcciona uno de los registros especiales/sistema (`REGE`), listados en [MEMORY_AND_ABI.md](./MEMORY_AND_ABI.md). El acceso a `REGE` está protegido: solo es válido en `Kernel = 1`; en caso contrario se dispara **Vector 3 — General Protection Fault**.
- **Inmediatos:** Todos los inmediatos de 16 bits se extienden con signo (*sign-extend*) a 32 bits antes de ingresar a la ALU mediante el multiplexor controlado por el bit `Inmediato` de la Control Word.
