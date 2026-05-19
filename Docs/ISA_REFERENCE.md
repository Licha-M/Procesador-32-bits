# 📋 Guía del Conjunto de Instrucciones (ISA)

El procesador usa un esquema de longitud fija de **32 bits (4 bytes)** dividido en campos predictivos que optimizan la etapa de decodificación en hardware.

## Segmentación de la Instrucción

- **31 - 29 (3 bits):** Tipo (Categoría de operación: ALU, Saltos, Memoria, Privilegiadas).
- **28 - 24 (5 bits):** OpCode (Código de operación único).
- **23 - 0 (24 bits):** Operandos segmentados dinámicamente (`REG A`, `REG B`, `REG C` de 4 bits, condiciones, o offsets e inmediatos de hasta 16 bits).

## Instrucciones Soportadas

| ID | Mnemónico | Tipo (3b) | OpCode (5b) | Descripción y Detalles |
| :---: | :---: | :---: | :---: | :--- |
| **0** | **NOP** | `000` | `00000` | Operación nula; no altera el estado del datapath (burbuja de pipeline / retardo). |
| **1** | **HLT** | `000` | `00001` | Detiene el núcleo (freeze del PC) para ahorro de energía hasta recibir interrupción. |
| **2** | **ADD** | `000` | `00010` | Suma aritmética: $REG\,C \leftarrow REG\,A + REG\,B$. Altera flags ALU. |
| **3** | **SUB** | `000` | `00011` | Resta aritmética: $REG\,C \leftarrow REG\,A - REG\,B$. Altera flags ALU. |
| **4** | **MUL** | `000` | `00100` | Multiplicación entera: $REG\,C \leftarrow REG\,A \times REG\,B$. Altera flags ALU. |
| **5** | **DIV** | `000` | `00101` | División entera: $REG\,C \leftarrow REG\,A \div REG\,B$. Altera flags ALU. |
| **6** | **NOR** | `000` | `00110` | Lógica bit a bit NOR: $REG\,C \leftarrow \neg(REG\,A \lor REG\,B)$. |
| **7** | **AND** | `000` | `00111` | Lógica bit a bit AND: $REG\,C \leftarrow REG\,A \land REG\,B$. |
| **8** | **XOR** | `000` | `01000` | Lógica bit a bit XOR: $REG\,C \leftarrow REG\,A \oplus REG\,B$. |
| **9** | **RSH** | `000` | `01001` | Desplazamiento lógico a la derecha de A por el valor en B. |
| **10**| **LSH** | `000` | `01010` | Desplazamiento lógico a la izquierda de A por el valor en B. |
| **11**| **GOF** | `000` | `01011` | Recupera y lee el estado de Overflow/Carry generado en operaciones previas. |
| **12**| **LDI** | `000` | `01100` | Carga inmediata: Transfiere constante directa de 16 bits a REG A. |
| **13**| **ADI** | `000` | `01101` | Suma inmediata: Suma constante directa de 16 bits al valor en REG A. |
| **14**| **JMP** | `Intr`| `01110` | Salto incondicional absoluto hacia la dirección contenida en REG B. |
| **15**| **BRH** | `Intr`| `01111` | Salto condicional evaluado por Branch Unit hacia la dirección en REG B si cumple 'Cond'. |
| **16**| **CAL** | `Intr`| `10000` | Llamada a subrutina: Salto guardando dirección de retorno en registros de control. |
| **17**| **RET** | `Intr`| `10001` | Retorno de subrutina: Restaura el flujo al punto inmediatamente posterior al CAL (+1). |
| **18**| **LOD** | `Mem` | `10010` | Carga desde memoria: Lee de RAM (Dirección: REG A + Offset) y escribe en REG B. |
| **19**| **STR** | `Mem` | `10011` | Almacenamiento en memoria: Escribe en RAM (Dirección: REG A + Offset) el dato de REG B. |
| **20**| **CYE** | `000` | `10100` | *Privilegiada:* Copia el contenido del Registro Especial al Registro Normal. |
| **21**| **CYR** | `000` | `10101` | *Privilegiada:* Copia el contenido del Registro Normal al Registro Especial. |
| **22**| **SCL** | `000` | `10110` | Syscall: Interrupción de software que transfiere control al SO (Modo Kernel). |
| **23**| **SRT** | `000` | `10111` | Syscall Return: Retorno del sistema operativo; restaura la ejecución desde EPC. |
