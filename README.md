# 💻 32-bit Custom CPU Architecture

Este repositorio contiene el diseño completo y la implementación de una arquitectura de procesador de 32 bits personalizada. El proyecto integra el diseño de hardware digital mediante simulación en **Logisim-evolution**, junto con la verificación y síntesis de módulos críticos utilizando **VHDL** y **ModelSim**.

## 📁 Estructura del Proyecto

Todos los módulos lógicos y el datapath principal están organizados en la carpeta raíz del núcleo:
* **/Core**: Contiene todos los archivos `.circ` (Logisim-evolution) que componen la CPU (ALU, Registros, Pipeline, MEM, LAPIC, Control).

## 🛠 Especificaciones de la Arquitectura

* **Ancho de Instrucción:** 32 bits (instrucciones de longitud fija).
* **Direccionamiento:** 32 bits (Capacidad de direccionamiento físico de hasta 4GB de RAM).
* **Paginación:** Sistema de memoria virtual mediante MMU con paginación de 4KB.
* **Tecnologías:**
    * **Logisim-evolution v3.9.0:** Entorno de simulación visual y diseño lógico.
    * **VHDL / ModelSim:** Utilizado para la implementación de componentes complejos como el codificador de prioridad y el circuito de conteo de población.

---

## 🧠 Formato de Instrucciones

Las instrucciones se dividen en campos específicos para optimizar la decodificación en un solo ciclo o mediante pipeline:

| bits 31-29 | bits 28-24 | bits 23-20 | bits 19-16 | bits 15-12 | bits 11-8 | bits 7-4 | bits 3-0 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Tipo | **OpCode** | Reg A | Reg B | Reg C | Inm/Offset | Inm/Offset | Inm/Offset |

### Tabla de Instrucciones (ISA)

| OpCode | Mnemónico | Tipo | Descripción |
| :--- | :--- | :--- | :--- |
| `00000` | **NOP** | Control | Operación nula. |
| `00001` | **HLT** | Control | Detiene el núcleo hasta interrupción. |
| `00010` | **ADD** | ALU | Suma A + B -> C. |
| `00011` | **SUB** | ALU | Resta A - B -> C. |
| `00100` | **MUL** | ALU | Multiplicación A * B -> C. |
| `00101` | **DIV** | ALU | División A / B -> C. |
| `00110` | **NOR** | Lógica | Operación NOR bit a bit. |
| `00111` | **AND** | Lógica | Operación AND bit a bit. |
| `01000` | **XOR** | Lógica | Operación XOR bit a bit. |
| `01001` | **RSH** | Lógica | Shift a la derecha. |
| `01010` | **LSH** | Lógica | Shift a la izquierda. |
| `01011` | **GOF** | Flags | Lee el acarreo (Carry) anterior. |
| `01100` | **LDI** | Inm | Carga inmediato (16 bits) en Registro. |
| `01101` | **ADI** | Inm | Suma inmediato a Registro. |
| `01110` | **JMP** | Flujo | Salto incondicional. |
| `01111` | **BRH** | Flujo | Salto condicional basado en banderas. |
| `10000` | **CAL** | Flujo | Llamada a subrutina. |
| `10001` | **RET** | Flujo | Retorno de subrutina. |
| `10010` | **LOD** | Memoria | Carga dato de RAM a Registro. |
| `10011` | **STR** | Memoria | Almacena dato de Registro en RAM. |
| `10100` | **CYE** | System | Mueve de Registro Especial a Normal. |
| `10101` | **CYR** | System | Mueve de Registro Normal a Especial. |
| `10110` | **SCL** | Kernel | Llamada al Sistema (Syscall). |
| `10111` | **SRT** | Kernel | Retorno de interrupción/excepción. |

---

## 🗄️ Modelo de Registros

### Registros de Propósito General (GPR) - ABI Context
Utilizados para operaciones aritméticas y transferencia de datos. En modo Kernel/Syscall, siguen la siguiente convención:

* **R0:** Motivo de la llamada (Input) / Resultado (Output).
* **R1:** Dirección de retorno para `SRT`.
* **R2 - R6:** Argumentos de función (1 al 5).
* **R7:** Puntero opcional / Causa de la excepción.
* **R8 - R13:** Uso general (No preservados por la ABI).
* **R14 - R15:** Uso exclusivo del Kernel (Guardado de contexto).

### Registros Especiales (Control)
* **RE1 (EPC):** Exception Program Counter.
* **RE2 (SP):** Stack Pointer (Puntero de pila).
* **RE3 (PCID):** Process Context ID.
* **RE4 (CR3):** Page Directory Base Register.
* **RE5 (CR2):** Page Fault Linear Address.
* **RE6 (CR0):** Registro de control de la MMU.
* **RE7 (Cause):** Registro de causa de excepción.
* **RE8 (IDTR):** Interrupt Descriptor Table Register.
* **RE9 (Eflags):** Banderas de estado (Z, N, C, V).
* **RE10 (Carry):** Almacenamiento del acarreo anterior.
* **RE11 (TR):** Task Register (Dirección al TSS para gestión de privilegios).

---

## ⚙️ Unidad de Control (PLA)

La CPU utiliza una **Control Word de 16 bits** generada por una tabla de programa PLA. Esta palabra orquesta todos los habilitadores y selectores del datapath.

### Desglose de la Control Word (Bits 15-0)

| Bit | Nombre | Función |
| :--- | :--- | :--- |
| **15** | A==E | Fuerza que el operando A sea el Registro Especial seleccionado. |
| **14-13** | MEM/REG | Selector de origen de datos (ALU, RAM, SP, Inmediato, etc.). |
| **12** | En REGE | Habilita escritura en Registros Especiales. |
| **11** | En REG | Habilita escritura en Registros Normales. |
| **10** | HLT | Señal de parada del reloj del sistema. |
| **09** | RET | Habilita la lógica de retorno de subrutina. |
| **08-07** | RoW | Control de lectura/escritura en RAM (Read or Write). |
| **06** | Kernel | Indica que la CPU opera en modo privilegiado. |
| **05** | BRH | Habilita la evaluación de salto condicional. |
| **04** | JMP | Habilita salto incondicional. |
| **03** | CAL | Habilita almacenamiento de dirección de retorno en Stack. |
| **02** | En Branch | Habilita el comparador de la Branch Unit. |
| **01** | Inmediato | Selecciona el valor inmediato en lugar del Registro B. |
| **00** | Overflow | Habilita el paso del bit de acarreo a la ALU. |

### Tabla de Programación PLA (Extracto de `Intr`)
```text
# OpCode  Control Word (16 bits)
00000 0000000000000000 #NOP
00001 0000010000000000 #HLT
00010 0000100000000100 #ADD
00011 0000100000000100 #SUB
00100 0000100000000100 #MUL
00101 0000100000000100 #DIV
00110 0000100000000100 #NOR
00111 0000100000000100 #AND
01000 0000100000000100 #XOR
01001 0000100000000100 #RSH
01010 0000100000000100 #LSH
01011 0000100000000001 #GOF
01100 0000100000000010 #LDI
01101 0000100000000110 #ADI
01110 0000000000010000 #JMP
01111 0000000000100000 #BRH
10000 0101000110001000 #CAL
10001 0010000100000000 #RET
10010 0000100110000010 #LOD
10011 0000100000000010 #STR
10100 1000100000000000 #CYE
10101 0010000000000000 #CYR
10110 0000000001000000 #SCL
10111 0000000001000000 #SRT
