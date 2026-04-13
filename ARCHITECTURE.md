# 🏗️ CPU Architecture - Análisis Técnico Detallado

Este documento proporciona una descripción técnica profunda de cada componente de la CPU y cómo interactúan entre sí.

---

## 1. Vista General de Datapath

```
                        ┌─────────────────────────────────────────────────┐
                        │         PROGRAM COUNTER (PC)                    │
                        │     Gestiona secuencia de instrucciones         │
                        └────────────────────┬────────────────────────────┘
                                             │
        ┌────────────────────────────────────┼────────────────────────────────┐
        │                                    │                                │
        │                            ┌───────▼────────┐                      │
        │                            │   IF: Fetch    │                      │
        │                            │  (IP translate)│                      │
        │                            └────────┬───────┘                      │
        │                                     │                              │
        │                            ┌────────▼───────┐                      │
        │                            │ ID: Decode     │                      │
        │                            │  (PLA ROM)     │                      │
        │                            └────────┬───────┘                      │
        │                                     │                              │
        │      ┌──────────────────────────────┼──────────────────────────┐   │
        │      │                              │                          │   │
        │  ┌───▼─────────┐         ┌─────────▼────────┐      ┌──────────▼─┐ │
        │  │   GPR/SPR   │         │  EX: Execute     │      │     ALU    │ │
        │  │  (16 + 11)  │◄────────┤      (EXU)       │      │  (Ops)     │ │
        │  │  Registers  │         │                  │      └───────┬────┘ │
        │  └──────┬──────┘         └───────┬──────────┘            │        │
        │         │                        │                       │        │
        │         └────────────────────────┼───────────────────────┘        │
        │                                  │                                 │
        │                         ┌────────▼───────┐                        │
        │                         │ MEM: Memory    │                        │
        │                         │  (RAM + MMU)   │                        │
        │                         └────────┬───────┘                        │
        │                                  │                                 │
        │                         ┌────────▼───────┐                        │
        │                         │ WB: Writeback  │                        │
        │                         │  (Registro)    │                        │
        │                         └────────┬───────┘                        │
        └─────────────────────────────────┼────────────────────────────────┘
                                          │
                                    Resultado
                                    escrito en
                                    registro
```

---

## 2. Etapa IF - Instruction Fetch

### Funciones Principales
1. Leer instrucción desde memoria (dirección = PC)
2. Actualizar PC (PC ← PC + 4, en direcciones de 32 bits)
3. Manejo de saltos (cuando se detectan en EX)
4. Interacción con MMU para traslación de direcciones (TODO)

### Diagrama Detallado

```
┌─────────────┐
│   Contador  │
│     PC      │
└──────┬──────┘
       │ (dirección virtual de instrucción)
       │
       ▼
┌────────────────────┐
│  Traslador MMU     │  ← TODO: Integración para IF
│  (Tabla de Páginas)│  Actualmente solo en MEM stage
└────────┬───────────┘
         │ (dirección física)
         │
         ▼
┌─────────────────────┐
│ Memoria ROM/RAM     │
│  (Instrucciones)    │
└────────┬────────────┘
         │ (Instr. 32-bit)
         │
         ▼
    [ID Stage]
```

### Señales de Control

```
Entrada:
  - PC_actual: Dirección actual (32 bits)
  - Salto_detectado: Del stage EX (control hazard)
  - Dirección_salto: Destino si salto (32 bits)
  - Reset: Reinicia PC a 0x00000000

Salida:
  - Instrucción: 32-bit opcode + operandos
  - PC_próximo: Para ID (forwarding)
  - Ready: Indica instrucción válida
```

### Flujo Ciclo a Ciclo

```
Ciclo N:
  1. Lee dirección PC_n
  2. Accede RAM[PC_n] → obtiene instrucción
  3. Calcula PC_n+1 = PC_n + 4

Ciclo N+1:
  1. IF envía instrucción a ID
  2. Simultáneamente:
     - Fetch siguiente instrucción en PC_n+1
     - O en caso de salto: fetch en dirección_salto
```

### Mejoras Pendientes

- **MMU en IF**: Actualmente IF accede RAM directamente
  - Necesita: Integración de traslador de direcciones
  - Impacto: +1 ciclo de latencia si miss en TLB
  - Beneficio: Soporte real de memoria virtual

---

## 3. Etapa ID - Instruction Decode

### Funciones Principales
1. Decodificar OpCode (5 bits)
2. Generar Control Word (16 bits) via PLA ROM
3. Extraer campos de registros (Reg A, B, C)
4. Preparar inmediatos/offsets
5. Detectar dependencias (para forwarding)

### Decodificador PLA

```
Entrada: OpCode (5 bits) + OpType (2 bits)
         ↓
     PLA ROM (128 × 16)
         ↓
Salida: Control Word (16 bits)
```

**Implementación:**
- ROM con 32 direcciones (una por opcode)
- Cada entrada es un palabra de 16 bits
- Latencia: Combinacional (0 ciclos)

### Lectura de Operandos

```
Control Word bits → Selectores

Bit 15 (A==E): ¿Usar registro especial?
  0 → Leer Reg A (GPR normal)
  1 → Leer Reg A (Especial)

Bits 23-20 (Reg A): Número de registro (4 bits = 16 opciones)
Bits 19-16 (Reg B): Número de registro
Bits 15-12 (Reg C): Número de registro (destino)

Bits 11-0 (Inmediato): 12 bits que se interpretan como:
  - 16-bit immediato (para LDI)
  - Offset de memoria (para LOD, STR)
  - Condición (para BRH)
```

### Detección de Hazards de Datos

```
¿La instrucción actual lee un registro que la anterior escribe?

  Instrucción N-1: opcode → C (escribe en C)
  Instrucción N:   opcode → usa A o B

Comparar:
  - si (Reg_C_anterior == Reg_A_actual) → RAW hazard en A
  - si (Reg_C_anterior == Reg_B_actual) → RAW hazard en B

Señal a EX: forwarding_needed = 1
           forwarding_source = (MEM o EX stage)
```

### Tabla de Decodificación Parcial

```
OpCode │Tipo │Instrucción │Operandos │Control Word │Notas
───────┼─────┼─────────────┼──────────┼─────────────┼──────
00010  │001  │ADD          │A,B→C     │0000100000000100 │Sumador
00011  │001  │SUB          │A,B→C     │0000100000000100 │Restador
01100  │001  │LDI          │Imm→A     │0000100000000010 │Inmediato
01110  │010  │JMP          │Reg→PC    │0000000000010000 │Salto
```

---

## 4. Etapa EX - Execute

### Funciones Principales
1. Ejecutar operación (ALU)
2. Calcular direcciones de memoria (para LOD/STR)
3. Evaluar condiciones de salto
4. Detectar control hazards (saltos)
5. Generar forwarding paths

### Flujo de Ejecución

```
┌─────────────────────────────────┐
│ Leer operandos A, B             │
│ (posiblemente con forwarding)   │
└────────────┬────────────────────┘
             │
      ┌──────▼──────┐
      │   Selector  │
      │ (Inmediato?)│
      └──────┬──────┘
             │
    ┌────────┴────────┐
    │                 │
┌───▼────┐       ┌───▼────────┐
│Reg B   │       │  Inmediato  │
│(16bit) │       │  (12 bits)  │
└───┬────┘       └───┬─────────┘
    │                │
    └────────┬───────┘
             │
         ┌───▼────────────────┐
         │  ALU (Operaciones) │
         │                    │
         │ ADD, SUB, MUL, DIV │
         │ AND, OR, XOR, NOR  │
         │ LSH, RSH           │
         └───┬────────────────┘
             │
      ┌──────▼──────────┐
      │  Resultado 32b  │
      │  + Flags (Z,N,C,V)
      └─────────────────┘
```

### Componente ALU

**Operaciones soportadas:**

```
Aritmética:
  ADD (32-bit)   resultado = A + B, actualiza flags
  SUB (32-bit)   resultado = A - B, actualiza flags
  MUL (32-bit)   resultado = A * B (truncado a 32 bits)
  DIV (32-bit)   resultado = A / B (entero)

Lógica:
  AND            resultado = A & B
  OR             resultado = A | B
  XOR            resultado = A ^ B
  NOR            resultado = ~(A | B)

Desplazamiento:
  LSH (shift left)    resultado = A << B
  RSH (shift right)   resultado = A >> B (lógico)
```

**Latencia:**
- Operaciones estándar (ADD, AND, etc.): 1 ciclo
- MUL: 1 ciclo (multiplicador pipelined)
- DIV: 1 ciclo (divisor iterativo en pipeline)

### Banderas (Eflags)

Se actualizan según resultado:

```
Z (Zero):      set si resultado == 0
N (Negative):  set si bit 31 == 1
C (Carry):     set si hay overflow en suma/resta
V (Overflow):  set si signed overflow
```

Guardadas en RE9 (Eflags) para instrucciones futuras.

### Detección de Control Hazards

```
Instrucción actual es JMP o BRH:
  1. Calcular dirección destino
  2. Evaluar condición (para BRH)
  3. Comparar con PC_predicho (que asumió no-salto)
  
  Si predicción_incorrecta:
    - Generar señal FLUSH
    - Cargar dirección correcta en PC
    - Descartar 2-3 instrucciones en pipeline
```

---

## 5. Etapa MEM - Memory Access

### Funciones Principales
1. Acceder memoria (LOD - lectura, STR - escritura)
2. Traslación de direcciones virtuales → físicas (MMU)
3. Protección de memoria
4. Forwarding de datos

### Estructura de Memoria

```
Espacio de direcciones: 32 bits (4 GB)
Tamaño página: 4 KB (12 bits de offset)

Dirección virtual: [19 bits PPN | 12 bits offset]
Tabla de páginas: en memoria, manejada por kernel

Ejemplo:
  Dirección virtual: 0x12345678
  PPN (bits 31-12): 0x12345
  Offset (bits 11-0): 0x678
  
  Lookup tabla de páginas[0x12345] → PFN (Physical Frame Number)
  Dirección física: [PFN | 0x678]
```

### MMU - Memory Management Unit

**Componentes:**

```
┌─────────────────────────────────────────┐
│        Translation Lookaside Buffer      │ (TODO: implementar)
│        (Caché de traducciones)          │
└─────────────────────────────────────────┘
              ↓ (miss)
┌─────────────────────────────────────────┐
│     Page Table Walker                   │
│ (Camina tabla en memoria)               │
│ Actual: Integrado en MEM stage          │
└─────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────┐
│  Translation: Virtual → Physical        │
│  Valida permisos, carga física, offset  │
└─────────────────────────────────────────┘
```

**Estado Actual:**
- ✅ Paginación básica funcional
- ✅ Tabla de páginas en RAM
- ⚠️ Sin TLB (cada acceso busca tabla)
- ❌ IF stage no usa traslación

**Registros de Control:**
```
CR0 (Control Register 0):
  Bits [0]:    Enable paging
  Bits [1]:    Write protect (kernel only write)
  Bits [2-31]: Reserved

CR3 (Page Directory Base):
  Dirección física de tabla de páginas raíz
  Típicamente: 0x00001000 (primera página)

CR2 (Page Fault Address):
  Dirección que causó page fault
```

### Acceso a Memoria

```
Operación LOD (Load):
  1. Dirección = Reg[A] + Offset (calculate en EX, usado aquí)
  2. Traslación MMU: virtual → física
  3. Lectura desde RAM[dirección_física]
  4. Resultado disponible en próxima etapa (WB)
  Latencia total: 2 ciclos

Operación STR (Store):
  1. Dirección = Reg[A] + Offset
  2. Traslación MMU
  3. Escritura en RAM[dirección_física]
  4. Confirmación en próxima etapa
  Latencia total: 2 ciclos

En caso de page fault:
  1. Exception → handler kernel
  2. Kernel puede cargar página en memoria
  3. Instrucción se reintenta desde EX
```

### Forwarding desde MEM

```
Si instrucción N-1 hace LOD:
  N-1: LOD R5 ← [0x1000]    (lee dato en MEM)
  N:   ADD R7, R5, R3        (usa R5)

Entonces:
  - Dato leído en MEM está disponible al final de MEM
  - Se forwarde a EX de instrucción N
  - Evita stall de 1 ciclo
```

---

## 6. Etapa WB - Writeback

### Funciones Principales
1. Escribir resultado en registro destino
2. Actualizar banderas
3. Mantener coherencia de registros

### Flujo

```
Resultado (32 bits) de EX/MEM
      ↓
   ¿Es válido?
      ↓
  ¿Qué tipo de instrucción?
  ├─ Aritmética → Escribe en Reg[C], actualiza flags
  ├─ LOD → Escribe dato en Reg[C]
  ├─ LDI → Escribe inmediato en Reg[C]
  ├─ JMP/BRH → No escribe (ya actualizó PC)
  ├─ CAL → Escribe PC+1 en stack pointer
  └─ (otros casos específicos)
      ↓
Escribe enable_reg_normal o enable_reg_especial
```

### Señales de Control

```
Del stage MEM:
  - Resultado (32 bits)
  - Reg_destino (4 bits) = Reg C
  - Es_especial (1 bit)
  - Write_enable (1 bit)

Escritura simultánea:
  - Bancos de registros actualizados
  - Flags guardadas en RE9
  - Próxima instrucción puede leer inmediatamente
    (lectura en ID, escritura en WB de ciclo anterior)
```

---

## 7. Forwarding - Datos en Pipeline

### Problema: Data Hazards

```
Ciclo 1: ADD R1, R2, R3       ; R1 ← R2 + R3
        IF  ID  EX  MEM WB

Ciclo 2: SUB R4, R1, R5       ; R4 ← R1 - R5  (R1 no escrito aún)
            IF  ID  EX  MEM WB
                ↑ Lee R1, pero WB en ciclo 5 → Hazard RAW
```

### Solución: Forwarding/Bypass

```
En ciclo 2, cuando ID necesita leer R1:
  - Detecta que ADD escribirá R1 en ciclo 5
  - BUT ADD ya calculó valor en ciclo 3 (EX)
  
Hay 3 opciones:
  a) Stall 2 ciclos (ineficiente)
  b) Forwarde desde EX (disponible ciclo 3)
  c) Forwarde desde MEM (disponible ciclo 4)

Implementación:
  - Multiplexor en entrada de ALU
  - Selecciona: operando normal o data forwardeada
  - Logic de comparación: ¿reg_actual == reg_a_escribir?
```

### Diagrama de Forwarding

```
    ┌─────────────┐
    │ ADD EX res  │ ← Forwarding desde EX
    │ (R1 ← ...)  │
    └────────┬────┘
             │
             ▼
    ┌──────────────────┐
    │    Multiplexor   │
    │ (selector de Fwd)│
    └────────┬─────────┘
             │
    ┌────────▼──────────┐
    │   ALU (SUB)       │
    │ (usa R1 correcto) │
    └───────────────────┘
```

### Casos de Forwarding

```
Forward desde EX:
  ADD R1, ...  (resultado en EX)
  SUB R2, R1, ...  (ID necesita R1)
  → Forward desde output de EX a input de ALU

Forward desde MEM:
  LOD R3, [...]  (MEM accede RAM)
  ADD R4, R3, ...  (ID necesita R3)
  → Forward desde output de MEM a input de ALU

Cuando NO se puede forwardear:
  LOD R5, [...]    (1 ciclo: EX, luego MEM)
  ADD R6, R5, ...  (ID necesita R5 inmediatamente)
  → Necesita STALL 1 ciclo
```

---

## 8. Flush - Control Hazards

### Problema: Predicción de Saltos

```
CPU asume "no-salto" (next PC = PC + 4):

Ciclo 1: BRH R7, R8           ; Salto si condición
        IF  ID  EX  ...

Ciclo 2: Instrucción siguiente (predicción: no salto)
            IF  ID  EX  ...

Ciclo 3: En EX, se detecta que SÍ debe saltar
                  → Dirección correcta ≠ PC+4
                  → FLUSH pipeline
```

### Mecanismo de Flush

```
Cuando se detecta predicción incorrecta:

Estado actual del pipeline:
┌─────────────────────────────────────┐
│ IF: Instrucción X (incorrecta)     │
│ ID: Instrucción Y (incorrecta)     │
│ EX: BRH (detecta error)            │
│ MEM: instrucción anterior          │
│ WB: instrucción anterior           │
└─────────────────────────────────────┘

FLUSH sequence:
1. Cancel IF stage
2. Cancel ID stage
3. Cancel EX stage (pero antes guarda dirección correcta)
4. Load nuevas instrucciones desde dirección_salto

Costo: 2-3 ciclos de pipeline vacío
```

### Señales de Control

```
Cuando en EX:
  - salto_detectado = 1
  - dirección_correcta = [valor calculado]

Propagar a IF:
  - PC ← dirección_correcta
  - Descartar instrucciones en IF, ID, EX

Pipeline vacío por 2-3 ciclos
```

---

## 9. Interacción Completa: Ejemplo Paso a Paso

### Programa Simple

```assembly
LDI R1, 0x0010    ; Carga 16 en R1
ADD R2, R1, R0    ; R2 ← R1 + R0 (16 + 0 = 16)
JMP R2            ; Salta a dirección 16
```

### Ejecución por Ciclos

```
┌──────────────────────────────────────────────────────────┐
│ CICLO 1                                                  │
├──────────────────────────────────────────────────────────┤
│ IF: Lee instrucción LDI    (de PC=0)                    │
│ ID: -                                                    │
│ EX: -                                                    │
│ MEM: -                                                   │
│ WB: -                                                    │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ CICLO 2                                                  │
├──────────────────────────────────────────────────────────┤
│ IF: Lee instrucción ADD    (de PC=4)                    │
│ ID: Decodifica LDI         (Lee Inm=0x0010)            │
│ EX: -                                                    │
│ MEM: -                                                   │
│ WB: -                                                    │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ CICLO 3                                                  │
├──────────────────────────────────────────────────────────┤
│ IF: Lee instrucción JMP    (de PC=8)                    │
│ ID: Decodifica ADD         (Lee R1, R0)               │
│ EX: Carga inmediato        (R1 ← 0x0010)              │
│ MEM: -                                                   │
│ WB: -                                                    │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ CICLO 4                                                  │
├──────────────────────────────────────────────────────────┤
│ IF: Lee instrucción siguiente (de PC=12) [PREDICCIÓN]  │
│ ID: Decodifica JMP         (Lee R2)                    │
│ EX: ADD con forwarding     (R1=0x10 forwarded)        │
│      R2 ← 0x10 + 0 = 0x10                             │
│ MEM: -                                                   │
│ WB: Escribe R1 ← 0x0010    [LDI completa]             │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ CICLO 5                                                  │
├──────────────────────────────────────────────────────────┤
│ IF: -  [FLUSH]            (cancelada, salto incorrecto) │
│ ID: - [FLUSH]                                           │
│ EX: JMP evalúa:           R2=0x10 (desde forwarding)   │
│     SALTO CALCULADO = 0x10 ≠ PC_predicho (12)         │
│     → FLUSH SIGNAL                                      │
│ MEM: -                                                   │
│ WB: Escribe R2 ← 0x0010   [ADD completa]              │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ CICLO 6                                                  │
├──────────────────────────────────────────────────────────┤
│ IF: Lee instrucción @0x10 (CORRECCIÓN)                 │
│ ID: -                                                    │
│ EX: -                                                    │
│ MEM: -                                                   │
│ WB: -                                                    │
└──────────────────────────────────────────────────────────┘
```

**Resumen:**
- Pipeline lleno en ciclos 3-4
- Flush en ciclo 5 (2-3 ciclos de penalización)
- Instrucciones se ejecutan: 4 ciclos para 3 instrucciones = IPC ~0.75

---

## 10. Registros y Banco de Registros

### Estructura

```
┌─────────────────────────────────────────┐
│      BANCO DE REGISTROS                 │
│  Read ports: 2 (A, B) - combinacional   │
│  Write port: 1 (C) - sincrónico         │
├─────────────────────────────────────────┤
│                                         │
│  GPR (16 × 32 bits):                   │
│  R0-R15     Propósito general           │
│             (R0-R1 especiales en ABI)   │
│                                         │
│  SPR (11 × 32 bits):                   │
│  RE1 (EPC), RE2 (SP), ..., RE11 (TR)   │
│                                         │
└─────────────────────────────────────────┘

    │      │      │
    │      │      └─ Write addr (4 bits) + Write data
    │      └──────── Read B addr (4 bits) → operando B
    └────────────── Read A addr (4 bits) → operando A
```

### Timing

```
Lectura (Combinacional - sin ciclo de reloj):
  Addr_A --→ |
              └→ Multiplexor → Data_A
  Addr_B --→ |

Escritura (Sincrónico - requiere ciclo de reloj):
  Write_addr ──→ |
                  └→ Decodificador
  Write_data ──→ |
  Write_en ────→ Flip-flops

  En flanco de reloj:
    Registros[Write_addr] ← Write_data
```

### Protección de Registros Especiales

Algunos registros especiales (RE1, RE3-RE8, RE11) solo pueden escribirse en modo Kernel:

```
Control word bit 6 = Kernel
  Si Kernel==0 (user mode) e instrucción intenta escribir SPR:
    → Exception (PRIV_VIOLATION)
    → Handler kernel maneja error
```

---

## 11. Unidad de Control (PLA)

### Tabla PLA Completa

Cada fila = (OpCode + bits de control) → Control Word

```
OpCode   Function Unit    Control Word (16 bits)
────────────────────────────────────────────
00000    NOP              0000000000000000
00001    HLT              0000010000000000
00010    ADD              0000100000000100
00011    SUB              0000100000000100
00100    MUL              0000100000000100
00101    DIV              0000100000000100
00110    NOR              0000100000000100
00111    AND              0000100000000100
01000    XOR              0000100000000100
01001    RSH              0000100000000100
01010    LSH              0000100000000100
01011    GOF              0000100000000001
01100    LDI              0000100000000010
01101    ADI              0000100000000110
01110    JMP              0000000000010000
01111    BRH              0000000000100000
10000    CAL              0101000110001000
10001    RET              0010000100000000
10010    LOD              0000100110000010
10011    STR              0000100000000010
10100    CYE              1000100000000000
10101    CYR              0010000000000000
10110    SCL              0000000001000000
10111    SRT              0000000001000000
```

Ver `CONTROL_UNIT.md` para detalles de cada bit.

---

## 12. Cronograma General (Timing)

### Período de Reloj

Asumiendo tecnología FPGA/ASIC moderada:

```
T_ciclo = max(
  T_fetch,          (acceso a ROM)
  T_decodificador,  (PLA ROM)
  T_ALU,            (operación aritmética)
  T_memory,         (acceso RAM)
  T_multiplexor     (forwarding)
) + margen_setup

Típicamente: ~5-10 ns en FPGA moderno
         → ~100-200 MHz reloj máximo
```

### Latencias de Instrucción

```
Instrucción       IF  ID  EX  MEM WB  Total
────────────────────────────────────────
ADD R3,R1,R2      1   1   1   -   1    4 ciclos
LDI R1, 0x1234    1   1   1   -   1    4 ciclos
LOD R1, [R2]      1   1   1   1   1    5 ciclos
STR [R1], R2      1   1   1   1   -    4 ciclos
JMP R1            1   1   1   -   -    3 ciclos (+ flush si error)

Con pipelining (throughput):
  Si no hay hazards: 1 instrucción / ciclo
  Con hazards: < 1 instr/ciclo
  Con flush: penalización de 2-3 ciclos
```

---

## Resumen de Componentes Clave

| Componente | Ubicación | Función | Estado |
|---|---|---|---|
| Program Counter (PC) | IF | Mantiene secuencia | ✅ |
| Instruction ROM | IF | Almacena programa | ✅ |
| MMU (IF) | IF | Traslación IF | 🚧 TODO |
| Decodificador (PLA) | ID | Genera control | ✅ |
| Banco Registros | ID/WB | Almacena datos | ✅ |
| ALU | EX | Operaciones | ✅ |
| Forwarding Logic | EX/ID | Evita hazards | ✅ |
| RAM | MEM | Memoria datos | ✅ |
| MMU (MEM) | MEM | Traslación virtual | ✅ |
| Flush Logic | EX/IF | Control hazards | ✅ |

---

**Documento completo de la arquitectura. Para más detalles en instrucciones específicas, ver `ISA_GUIDE.md`.**
