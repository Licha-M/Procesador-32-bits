# 🏗️ Arquitectura y Microarquitectura del Procesador

## Flujo del Pipeline de 5 Etapas

El procesador está segmentado en 5 etapas clásicas, desacopladas mediante registros inter-etapa (`IFtoID`, `IDtoEX`, `EXtoMEM`, `MEMtoWB`).

1. **IF (Instruction Fetch):** `Instr_Fecher` carga la instrucción en memoria y actualiza el PC.
2. **ID (Instruction Decode):** El decodificador lee el OpCode, accede a la ROM PLA para generar la *Control Word* y solicita los operandos al banco de registros.
3. **EX (Execute):** La ALU paralela ejecuta operaciones aritméticas (ADD, SUB, MUL, DIV) y lógicas. La Unidad Branch evalúa las condiciones de los saltos.
4. **MEM (Memory Access):** La MMU traduce la dirección virtual a física de forma concurrente para resolver accesos a la RAM.
5. **WB (Write Back):** Escritura final de resultados en el banco de registros (`REG` de uso general o `REGE` privilegiados).

## Submódulos del Datapath

- **Control_FLush.circ**: Contiene el Program Counter, el Decodificador basado en PLA, la lógica de Bypass (resolución de Hazards RAW) y la lógica de invalidación Flush.
- **Unidad_Aritmetica.circ**: Operadores que corren en paralelo utilizando demultiplexores y multiplexores en función del OpCode para inyectar un solo resultado final hacia MEM.
- **Registros.circ**: Banco de registros generales con multiplexores y decodificadores dedicados. Los registros del sistema (REGE) poseen medidas estrictas de protección controladas por la unidad lógica.
- **MEM.circ**: Controla el acceso a memoria con el TLB (Translation Lookaside Buffer), Page Walker en caso de miss, y un generador unificado de excepciones por violación de acceso.
- **LAPIC.circ**: Lógica combinacional y registros (IRR, TPR, ISR) para seleccionar y derivar el vector de interrupción de mayor prioridad al CPU.

## Resolución de Hazards y Stalls

### Data Hazards (RAW)
La arquitectura emplea **Forwarding (Bypass)** de datos. El submódulo de Bypass en la unidad de control compara los registros destino (que viajan por MEM o WB) con las fuentes requeridas en la etapa de ejecución actual. Si existe una coincidencia, el procesador redirige el dato desde los buses de las últimas etapas hacia la ALU, evitando *stalls*, salvo en instrucciones consecutivas de lectura de memoria (`LOD`) que fuerzan obligatoriamente la inyección de una burbuja de 1 ciclo.

### Control Hazards
Se emplea **Predicción Estática de No-Salto** (el hardware asume y precarga siempre `PC+4`). 
Si la etapa EX evalúa que la condición de salto (`BRH`) o de salto incondicional (`JMP`) requería un cambio del PC, se emite inmediatamente una señal `Flush` a las etapas tempranas IF e ID. Esto invalida las instrucciones en vuelo cargadas incorrectamente y actualiza el contador de programa hacia la dirección real, lo que implica una penalización temporal de 2-3 ciclos del pipeline vacíos.
