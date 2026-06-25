# 🏗️ Arquitectura y Microarquitectura del Procesador

## Visión General del Datapath

El procesador es un núcleo RISC de 32 bits segmentado en **5 etapas clásicas**, desacopladas mediante registros inter-etapa (`IFtoID`, `IDtoEX`, `EXtoMEM`, `MEMtoWB`). El bloque superior (`Pipeline 5x`) es la unidad central de cómputo; se conecta hacia afuera con dos bloques periféricos principales: la **interfaz de memoria/RAM** y el **LAPIC** (controlador local de interrupciones), compartiendo buses de `Addr`, `Data I/O`, `RoW` y la señal `Cause`.

```
┌─────────────────────────────────────────────────────────┐
│                       Pipeline 5x                        │
│  Ctrl   Addr   Data I/O ───────────────┬──── RAM         │
│                                          │                 │
│                                LAPIC ────┴── RoW / Cause / IRQ
│  Clk RST                              Clk RST   I/O APIC  │
└─────────────────────────────────────────────────────────┘
```

## Flujo del Pipeline de 5 Etapas

1. **IF (Instruction Fetch):** El módulo `IF` (con el submódulo `PC`) calcula y registra la dirección de la siguiente instrucción, gestiona el `Need Instr` hacia memoria y aplica el incremento `PC+4` por defecto. Expone `Data_In`, `RAM`, `Addr`, `PC` hacia el resto del datapath.
2. **ID (Instruction Decode):** El `Decoder` interpreta el OpCode, accede a la ROM/PLA para generar la *Control Word* de 16 bits, y extrae los campos de operandos (`A`, `B`, `E`, `K` — registro especial —, `Cause`, `Inmd`, `W`, `Out`, `Tipo`, `Ctrl`). En paralelo, el banco de registros (`REGN` para registros normales y `REGE` para registros especiales/sistema) entrega los valores de los operandos solicitados.
3. **EX (Execute):** La `ALU` ejecuta en paralelo las operaciones aritméticas (`ADD`, `SUB`, `MUL`, `DIV`) y lógicas (`NOR`, `AND`, `XOR`, shifts), seleccionando el resultado final mediante multiplexores controlados por el OpCode. El bloque `Brach` (Branch Unit) evalúa la condición de salto (`Cond`) contra los flags (`Carry`/`Eflags`) y determina si el salto se toma.
4. **MEM (Memory Access):** La `MMU` traduce de forma concurrente la dirección virtual generada por la ALU a una dirección física (vía TLB / Page Walker) para resolver accesos `LOD`/`STR` a la RAM, y emite excepciones de memoria a través de `Excp Gen`.
5. **WB (Write Back):** El resultado final (ALU, dato de RAM, o nuevo `SP`) se escribe en el banco de registros (`REG`/`REGN` para de uso general, o `REGE` para registros privilegiados), según lo indicado por el campo `MEM/REG` de la *Control Word*.

## Submódulos del Datapath

| Módulo (`.circ`) | Contenido |
| :--- | :--- |
| **`Control_FLush.circ`** | Program Counter (`PC`), `Decoder` basado en PLA, lógica de `Bypass` (resolución de hazards RAW) y lógica de invalidación `Flush`. |
| **`Unidad_Aritmetica.circ`** | `ALU` con operadores corriendo en paralelo (sumador con `c_in`/`c_out`, lógica AND/OR/NOR/XOR, shifters) seleccionados por multiplexores en función del OpCode, y la Branch Unit (`Brach`) para evaluación de condiciones. |
| **`Registros.circ`** | Banco de registros generales (`REGN`) con multiplexores y decodificadores dedicados, y el banco de registros del sistema (`REGE`) con protección de acceso controlada por la unidad lógica (bits `Kernel`, `A==E`). |
| **`MEM.circ`** | `MMU` con TLB (Translation Lookaside Buffer) y Page Walker para resolución de *misses*, generador unificado de excepciones (`Excp Gen`) por violación de acceso o fallo de página. |
| **`LAPIC.circ`** | Lógica combinacional y registros (`IRR`, `TPR`, `ISR`) para seleccionar y derivar el vector de interrupción de mayor prioridad hacia la CPU, junto con un `Timer` interno y dos puertos `IO_APIC`. |

## Bloques internos del datapath central (`Control_FLush.circ` / `Pipeline.circ`)

Según el diagrama del núcleo (`Core.jpg`), el datapath central conecta:

- **`IF`**: recibe `Data_In`, `RAM` (dato leído), `Addr` y emite `PC`, `Need Instr`. Internamente posee el bloque `PC` con un multiplexor para soportar saltos (`Flush`/`JMP`/`BRH`/`CAL`/`RET`/`SCL`/`SRT`) y reinicio.
- **`Decoder`**: recibe la instrucción cruda (`In`) y produce los campos `A`, `B`, `E`, `K`, `Cause`, `Inmd` (inmediato extendido), `W` (registro destino), `Out`, `Tipo`, `Ctrl` (Control Word de 16 bits).
- **`REGN` / `REGE`**: bancos de registros (normal y especial). `REGE` expone salidas auxiliares con propósito de hardware: `EPC`, `SP`, `RegE_MMU`, `Sys_JMP`, `Kernel`.
- **`Bypass`**: recibe `Data B`, `Reg A`, `Reg B`, `Data A`, `Inmd`, y las señales `WB`, `Res`, `W`, `MEM Res`, `W` provenientes de las etapas posteriores (EX/MEM y MEM/WB) para resolver hazards RAW antes de entrar a la ALU.
- **`ALU`**: opera sobre `A`/`B`/`Carry`, expone `Op` (selector de operación) y `Out`. Incluye un sumador explícito con `c_in`/`c_out` para la propagación del acarreo (`Carry`/`Overflow`).
- **`Brach` (Branch Unit)**: evalúa la condición (`Cond`) sobre los flags resultantes de la ALU y decide si el salto/branch se concreta.
- **`Flush`**: recibe `Brh`, `Out`, señales `Clk`/`RST` y produce las señales de invalidación hacia `IF`/`ID` cuando un salto se confirma tarde o se dispara una excepción.
- **`Excp Gen`**: recibe `EPC_in`, `Cause`, `SCL/SRT`, `Cntrl`, produce `Out`, `Exceptio_Write` y realimenta `Cause` hacia el resto del sistema (incluido el LAPIC).
- **`MMU`**: posee puertos `Kernel`, `IF`, `MEM`, `RAM`, `Ctrl`, `RegE`, `Excp`, además de un *extensor* `0/64/32` para adaptar el ancho del bus de datos (de 32 a 64 bits) en accesos a memoria de doble palabra.

## Resolución de Hazards y Stalls

### Data Hazards (RAW)

La arquitectura implementa **Forwarding (Bypass)** de datos. El submódulo `Bypass`, dentro de la unidad de control, compara los registros destino que viajan por las etapas `EX/MEM` y `MEM/WB` con las fuentes (`Reg A`, `Reg B`) requeridas en la etapa de ejecución actual. Si existe coincidencia, el procesador redirige el dato desde los buses de las últimas etapas directamente hacia la `ALU`, evitando *stalls* en la mayoría de los casos.

> ⚠️ **Excepción — instrucciones `LOD` consecutivas:** Cuando dos instrucciones de carga (`LOD`) son consecutivas y la segunda depende del dato recién leído por la primera, el Bypass no puede adelantar el dato a tiempo (el dato de RAM llega al final de `MEM`, no en `EX`), por lo que se **fuerza obligatoriamente la inyección de una burbuja de 1 ciclo** (stall de 1 ciclo) para esperar el resultado de la primera carga.

### Control Hazards

Se emplea **predicción estática de "No-Salto"**: el hardware asume siempre `PC+4` como siguiente dirección y la precarga especulativamente en `IF`.

Si en la etapa `EX` la `Branch Unit` evalúa que la condición de salto (`BRH`) se cumple, o si se decodifica un salto incondicional (`JMP`, `CAL`, `RET`, `SCL`, `SRT`), y esto implica un cambio del `PC` distinto al especulado:

1. Se emite inmediatamente una señal **`Flush`** hacia las etapas tempranas `IF` e `ID`.
2. Esto invalida (convierte en `NOP`/burbuja) las instrucciones en vuelo que fueron cargadas incorrectamente por la especulación.
3. El Program Counter se actualiza hacia la dirección real de destino.
4. Esto implica una **penalización temporal de 2-3 ciclos** de pipeline vacíos (burbujas) por cada salto efectivamente tomado.

El mismo mecanismo de `Flush` se reutiliza cuando ocurre una excepción/interrupción: el `Excp Gen` solicita el `Flush` de las instrucciones de usuario en vuelo antes de saltar al manejador del kernel (ver [INTERRUPTS_AND_EXCEPTIONS.md](./INTERRUPTS_AND_EXCEPTIONS.md)).

## Buses Externos del Núcleo (`Pipeline 5x`)

| Puerto | Ancho | Dirección | Descripción |
| :--- | :---: | :---: | :--- |
| `Ctrl` | — | salida | Señales de control hacia la interfaz de memoria. |
| `Addr` | 32 bits | salida | Dirección física calculada para el acceso a RAM. |
| `Data I/O` | 32/64 bits | bidireccional | Bus de datos compartido con RAM y LAPIC. |
| `RAM` | — | entrada | Dato leído de memoria. |
| `RoW` | 2 bits | salida | Señal de Lectura/Escritura hacia RAM (ver [CONTROL_UNIT.md](./CONTROL_UNIT.md)). |
| `Cause` | 32 bits | bidireccional | Identificador de excepción/interrupción, compartido con el LAPIC. |
| `IRQ` | 1 bit | entrada | Señal de interrupción pendiente proveniente del LAPIC. |
| `I/O APIC` | 2 × 64 bits | entrada | Líneas de interrupción externas hacia el LAPIC. |
| `Clk` / `RST` | 1 bit | entrada | Reloj y reset globales, replicados al LAPIC. |
