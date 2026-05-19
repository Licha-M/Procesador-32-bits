# ⚙️ Microarquitectura: Señales de la Unidad de Control

La Unidad de Control del pipeline en `Control_FLush.circ` actúa traduciendo el OpCode activo proveniente de la etapa IF hacia una palabra binaria de control estricta de 16 bits. Esta *Control Word* es la que gobierna los selectores de los multiplexores, los habilitadores de escritura y compuertas lógicas dentro del resto del Datapath del procesador.

## Definición del Vector de Control de 16 Bits (MSB a LSB)

| Bit | Nombre de Señal | Función y Comportamiento Lógico en el Hardware |
| :---: | :--- | :--- |
| **15** | `A==E` | Fuerza que el bus del operando A iguale la salida del Registro Especial seleccionado. |
| **14-13**| `MEM/REG` | Selector del MUX de WB: `00` (Salida de ALU), `01` (Dato leído de RAM), `10` (Nuevo Stack Pointer - SP), `11` (Bloqueo/No Write). |
| **12** | `EnREGE` | Habilita la línea de escritura en el Banco de Registros Especiales y de sistema. |
| **11** | `EnREG` | Habilita la línea de escritura en el Banco de Registros Normales (GPR). |
| **10** | `HLT` | Congela la fase de Instruction Fetch e inhabilita los ciclos de reloj del núcleo hasta la recepción de una interrupción externa. |
| **9** | `RET` | Activa el subsistema secuenciador del hardware para recuperar la dirección física de retorno. |
| **8-7** | `RoW` | Control de la memoria RAM: `00/01` (Sin operación sobre RAM), `10` (Habilita modo Lectura), `11` (Habilita modo Escritura en RAM). |
| **6** | `Kernel` | Bandera de estado que dictamina una transición activa al anillo de máxima prioridad (Modo Kernel / Anillo 0). |
| **5** | `BRH` | Habilita el análisis lógico de salto condicional directamente sobre la Branch Unit. |
| **4** | `JMP` | Habilita la línea física incondicional de sobre-escritura del Contador de Programa (PC). |
| **3** | `CAL` | Inicia la sub-rutina de estado para guardar en hardware el contexto y saltar a funciones anidadas. |
| **2** | `EnBranch` | Permite o deniega almacenar y latch-ear los resultados comparativos de la ALU en los *Eflags*. |
| **1** | `Inmediato`| Conmuta el multiplexor del bus del operando B en la etapa de ejecución para inyectar una constante extendida en signo proveniente de la instrucción original de 16 bits. |
| **0** | `Overflow` | Habilita la inyección y evaluación del bit de acarreo persistente (*Carry/Overflow*) anterior sobre la nueva sumatoria de la ALU. |

## Matriz Completa de Firmware (Control Word por Instrucción)

La siguiente tabla refleja los valores exactos, bit a bit, que se encuentran almacenados y quemados dentro de la ROM de decodificación lógica (`Intr` / PLA), cruzando la instrucción con las señales que habilitará durante su paso por la segmentación:

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

> **Aclaración sobre optimización de hardware:** Múltiples instrucciones en la categoría aritmética, lógica y de desplazamiento comparten idéntica Control Word (`0000100000000100`). Esto se debe a que la Unidad de Control del Pipeline delega la selección final al circuito multiplexado interno de la ALU, el cual inspecciona directamente el OpCode en la etapa EX para canalizar la operación por el demultiplexor y operador correcto (Adder, Subtractor, Gates o Shifters).
