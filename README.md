# 💻 Procesador de 32 bits — Arquitectura Custom en Logisim-Evolution

![Estado](https://img.shields.io/badge/Estado-En%20Desarrollo-orange)
![Plataforma](https://img.shields.io/badge/Plataforma-Logisim--Evolution%203.9.0-blue)
![Pipeline](https://img.shields.io/badge/Pipeline-5%20Etapas-green)
![ISA](https://img.shields.io/badge/ISA-24%20instrucciones-purple)

Este repositorio contiene el diseño completo e implementación de una **arquitectura de procesador de 32 bits personalizada**, construida íntegramente en **Logisim-Evolution v3.9.0**. El procesador implementa un pipeline de 5 etapas, una unidad de control basada en PLA ROM, un sistema de memoria virtual con paginación de 4 KB, y soporte para interrupciones y excepciones.

---

## 📊 Especificaciones Técnicas

| Característica             | Especificación                                           |
|----------------------------|----------------------------------------------------------|
| **Ancho de instrucción**   | 32 bits (longitud fija)                                  |
| **Ancho de datos**         | 32 bits                                                  |
| **Espacio de direcciones** | 32 bits (4 GB)                                           |
| **Pipeline**               | 5 etapas: IF → ID → EX → MEM → WB                       |
| **Registros GPR**          | 16 registros de 32 bits (R0–R15)                         |
| **Registros especiales**   | 11 registros de control (RE1–RE11)                       |
| **Memoria virtual**        | Paginación de 4 KB                                       |
| **Unidad de control**      | PLA ROM (tabla de 24 entradas × 16 bits de Control Word) |
| **Conjunto de instrucciones** | 24 instrucciones (ALU, Lógica, Flujo, Memoria, Sistema) |
| **Latencia MUL/DIV**       | 1 ciclo (pipelined)                                      |
| **Interrupciones**         | Parcialmente anidadas (LAPIC)                            |

---

## 📁 Estructura del Proyecto

```
Procesador-32-bits/
│
├── README.md                  ← Este archivo (visión general)
├── Intr                       ← Tabla PLA: OpCode → Control Word (archivo ROM de Logisim)
├── Inst.xlsx                  ← Planilla con información completa de instrucciones y señales
│
├── Core/                      ← Módulos principales de Logisim-Evolution
│   ├── Pipeline.circ          ← Pipeline completo de 5 etapas (módulo principal)
│   ├── Control_FLush.circ     ← Unidad de control + manejo de hazards y flush
│   ├── Unidad_Aritmetica.circ ← ALU (aritmética, lógica y desplazamientos)
│   ├── Registros.circ         ← Banco de registros (R0–R15 + RE1–RE11)
│   ├── MEM.circ               ← Memoria RAM + MMU (traslación de direcciones)
│   └── LAPIC.circ             ← Controlador de interrupciones locales (Local APIC)
│
└── Docs/                      ← Documentación técnica detallada
    ├── ARCHITECTURE.md        ← Análisis técnico completo del datapath
    ├── ISA_GUIDE.md           ← Referencia detallada de cada instrucción
    ├── PIPELINE_HAZARDS.md    ← Riesgos del pipeline y soluciones implementadas
    ├── MEMORY_SYSTEM.md       ← Sistema de memoria y MMU
    ├── CONTROL_UNIT.md        ← Unidad de control PLA (bit a bit)
    └── EXAMPLES.md            ← Ejemplos de código ensamblador
```

> **Nota:** `Intr` es el archivo fuente de la ROM del PLA que se carga directamente en Logisim. `Inst.xlsx` contiene la tabla completa de instrucciones con sus señales de control.

---

## 🏗️ Arquitectura General — Pipeline de 5 Etapas

```
┌──────────────────────────────────────────────────────────────────┐
│                       CICLO DE RELOJ                             │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│   [IF]       [ID]       [EX]       [MEM]      [WB]              │
│   Fetch  →  Decode  →  Execute →  Memory  →  Writeback          │
│  (ROM/RAM) (PLA ROM)   (ALU)    (RAM+MMU)   (Registros)         │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

### Etapa IF — Instruction Fetch

- Lee la instrucción de 32 bits desde la memoria de instrucciones (ROM/RAM).
- Actualiza el Program Counter: `PC ← PC + 4`.
- En caso de salto detectado en EX: `PC ← dirección_correcta` (tras flush).
- **Pendiente:** integración de MMU para traslación de direcciones virtuales en IF.

### Etapa ID — Instruction Decode

- Decodifica el OpCode (5 bits) mediante la **PLA ROM** (`Intr`).
- Genera la **Control Word de 16 bits** que orquesta todo el datapath.
- Lee operandos de los bancos de registros (puertos A y B).
- Prepara inmediatos, offsets y detecta dependencias de datos (hazards RAW).

### Etapa EX — Execute

- Ejecuta la operación en la **ALU** (ADD, SUB, MUL, DIV, AND, XOR, NOR, LSH, RSH).
- Calcula direcciones para instrucciones de memoria (LOD/STR) y saltos.
- Detecta **control hazards**: si la predicción de no-salto fue incorrecta, emite señal de FLUSH.
- Resuelve **data hazards** mediante forwarding desde EX y MEM.

### Etapa MEM — Memory Access

- Accede a la RAM para instrucciones `LOD` (lectura) y `STR` (escritura).
- La **MMU** traslada direcciones virtuales a físicas usando la tabla de páginas.
- Genera excepciones de **page fault** si la página no está mapeada.
- Proporciona datos para forwarding a la etapa EX.

### Etapa WB — Writeback

- Escribe el resultado en el registro destino (Reg C).
- Actualiza las banderas de estado (Z, N, C, V) en RE9 (Eflags).
- Habilita escritura en registros normales (GPR) o especiales (SPR) según la Control Word.

---

## 🧠 Formato de Instrucciones

Las instrucciones tienen una longitud fija de 32 bits, organizadas en campos de 4 bits:

```
 31  30  29  │  28  27  26  25  24  │  23-20  │  19-16  │  15-12  │  11-0
─────────────┼─────────────────────┼─────────┼─────────┼─────────┼──────────
   Tipo(3b)  │     OpCode (5b)     │  Reg A  │  Reg B  │  Reg C  │ Inmediato
             │                     │  (4b)   │  (4b)   │  (4b)   │  (12b)
```

### Tipos de instrucción (bits 31–29)

| Tipo | Código | Descripción                            |
|------|--------|----------------------------------------|
| R    | `001`  | Instrucción de procesamiento (ALU)     |
| I    | `001`  | Con inmediato (LDI, ADI)               |
| J    | `010`  | Control de flujo (JMP, BRH, CAL, RET) |
| M    | `011`  | Acceso a memoria (LOD, STR)            |
| S    | `100`  | Sistema / kernel (CYE, CYR, SCL, SRT) |

### Ejemplos de codificación

```assembly
# ADD R3, R1, R2 → R3 = R1 + R2
# Tipo=001, OpCode=00010, RegA=0001, RegB=0010, RegC=0011
# Binario: 001 00010 0001 0010 0011 000000000000
# Hex:     0x0820C000

# LDI R5, 0x1234 → R5 = 0x00001234
# Tipo=001, OpCode=01100, RegA=0101, Imm=0x1234
# Binario: 001 01100 0101 0001 0010 001101000000

# JMP R7 → PC = R7
# Tipo=010, OpCode=01110, RegB=0111
# Binario: 010 01110 0000 0111 0000 000000000000
```

---

## 📋 Conjunto de Instrucciones — ISA (24 instrucciones)

### Instrucciones ALU — Aritmética

| OpCode  | Mnemónico | Operandos  | Latencia | Banderas | Descripción                    |
|---------|-----------|------------|----------|----------|--------------------------------|
| `00010` | **ADD**   | A, B → C  | 1 ciclo  | Z,N,C,V  | Suma: `C = A + B`              |
| `00011` | **SUB**   | A, B → C  | 1 ciclo  | Z,N,C,V  | Resta: `C = A − B`             |
| `00100` | **MUL**   | A, B → C  | 1 ciclo  | Z,N      | Multiplicación: `C = A × B` (mod 2³²) |
| `00101` | **DIV**   | A, B → C  | 1 ciclo  | Z,N      | División entera: `C = A ÷ B`   |

### Instrucciones Lógicas y de Desplazamiento

| OpCode  | Mnemónico | Operandos  | Latencia | Descripción                     |
|---------|-----------|------------|----------|---------------------------------|
| `00110` | **NOR**   | A, B → C  | 1 ciclo  | NOR bit a bit: `C = ¬(A ∨ B)`  |
| `00111` | **AND**   | A, B → C  | 1 ciclo  | AND bit a bit: `C = A ∧ B`     |
| `01000` | **XOR**   | A, B → C  | 1 ciclo  | XOR bit a bit: `C = A ⊕ B`     |
| `01001` | **RSH**   | A, B → C  | 1 ciclo  | Shift derecha: `C = A >> B`     |
| `01010` | **LSH**   | A, B → C  | 1 ciclo  | Shift izquierda: `C = A << B`   |

### Instrucciones de Inmediato y Banderas

| OpCode  | Mnemónico | Operandos       | Latencia | Descripción                          |
|---------|-----------|-----------------|----------|--------------------------------------|
| `01011` | **GOF**   | → A             | 1 ciclo  | Lee carry anterior (RE10) en Reg A   |
| `01100` | **LDI**   | Imm16 → A       | 1 ciclo  | Carga inmediato de 16 bits (sign-ext)|
| `01101` | **ADI**   | A + Imm16 → A   | 1 ciclo  | Suma inmediato: `A = A + Imm16`      |

### Instrucciones de Control de Flujo

| OpCode  | Mnemónico | Operandos      | Latencia | Descripción                              |
|---------|-----------|----------------|----------|------------------------------------------|
| `01110` | **JMP**   | Reg(dir)       | 1 ciclo  | Salto incondicional: `PC = Reg[B]`       |
| `01111` | **BRH**   | Cond, Reg(dir) | 1 ciclo  | Salto condicional (evalúa banderas)      |
| `10000` | **CAL**   | Reg(dir)       | 1 ciclo  | Call: guarda `PC+1` en stack, salta      |
| `10001` | **RET**   | —              | 1 ciclo  | Return: `PC ← [SP]`, ajusta SP          |

### Instrucciones de Memoria

| OpCode  | Mnemónico | Operandos               | Latencia | Descripción                              |
|---------|-----------|-------------------------|----------|------------------------------------------|
| `10010` | **LOD**   | \[Reg+Offset\] → Reg   | 2 ciclos | Load: lee 32 bits de RAM (vía MMU)       |
| `10011` | **STR**   | Reg → \[Reg+Offset\]   | 2 ciclos | Store: escribe 32 bits en RAM (vía MMU)  |

### Instrucciones de Sistema / Kernel

| OpCode  | Mnemónico | Operandos           | Privilegio | Descripción                              |
|---------|-----------|---------------------|------------|------------------------------------------|
| `10100` | **CYE**   | RegEsp → RegNorm    | Kernel     | Copia registro especial a normal         |
| `10101` | **CYR**   | RegNorm → RegEsp    | Kernel     | Copia registro normal a especial         |
| `10110` | **SCL**   | (syscall)           | Kernel     | Trap al kernel (guarda contexto, salta)  |
| `10111` | **SRT**   | —                   | Kernel     | Return from trap (restaura contexto)     |
| `00000` | **NOP**   | —                   | —          | No Operation (1 ciclo)                   |
| `00001` | **HLT**   | —                   | —          | Halt: detiene el reloj hasta interrupción|

---

## 🗄️ Modelo de Registros

### Registros de Propósito General — GPR (R0–R15, 32 bits c/u)

```
R0        → Entrada/salida de syscall (número y resultado)
R1        → Dirección de retorno (para CAL/RET)
R2–R6     → Argumentos de función (convención ABI)
R7        → Puntero auxiliar / causa de excepción
R8–R13    → Uso general (no preservados entre llamadas)
R14–R15   → Guardado de contexto kernel
```

### Registros Especiales — SPR (RE1–RE11, 32 bits c/u)

| Registro  | Alias  | Función                                                |
|-----------|--------|--------------------------------------------------------|
| RE1       | EPC    | Exception Program Counter (PC al momento de excepción)|
| RE2       | SP     | Stack Pointer                                          |
| RE3       | PCID   | Process Context ID                                     |
| RE4       | CR3    | Page Directory Base Register (base tabla de páginas)   |
| RE5       | CR2    | Dirección lineal que causó page fault                  |
| RE6       | CR0    | Registro de control de la MMU (bit 0 = enable paging)  |
| RE7       | —      | Causa de excepción                                     |
| RE8       | IDTR   | Interrupt Descriptor Table Register                    |
| RE9       | Eflags | Banderas de estado (Z, N, C, V)                        |
| RE10      | Carry  | Carry anterior (para instrucción GOF)                  |
| RE11      | TR     | Task Register                                          |

---

## ⚙️ Unidad de Control — PLA ROM

La unidad de control es una **ROM de 24 entradas × 16 bits** que genera la Control Word a partir del OpCode (5 bits). La lectura es combinacional (latencia cero).

El archivo fuente de la ROM es **`Intr`** (en la raíz del proyecto), que se carga directamente en Logisim.

### Control Word — 16 bits (MSB → LSB)

```
Bit   Señal        Descripción
────────────────────────────────────────────────────────────
 15   A==E         1 = Lee Reg Especial; 0 = Lee Reg Normal
14–13 MEM/REG      Selector de origen para WB:
                     00 = ALU output
                     01 = RAM (LOD)
                     10 = Stack Pointer
                     11 = Inmediato (LDI)
 12   En REGE      1 = Enable escritura en registros especiales
 11   En REG       1 = Enable escritura en registros normales
 10   HLT          1 = Detiene el reloj (instrucción HLT)
  9   RET          1 = Habilita lógica de retorno (SP → PC)
 8–7  RoW          Acceso a RAM: 00=nada, 01=read, 10=write, 11=reservado
  6   Kernel       1 = Modo privilegiado
  5   BRH          1 = Evalúa condición de salto condicional
  4   JMP          1 = Habilita salto incondicional
  3   CAL          1 = Guarda dirección de retorno en stack
  2   En Branch    1 = Habilita comparador de banderas (BRH)
  1   Inmediato    1 = ALU usa inmediato en lugar de Reg[B]
  0   Overflow     1 = Incluye carry anterior en la operación ALU
```

### Tabla PLA completa — archivo `Intr`

```
OpCode   Control Word (16 bits)    Instrucción
─────────────────────────────────────────────
00000    0000000000000000          NOP
00001    0000010000000000          HLT
00010    0000100000000100          ADD
00011    0000100000000100          SUB
00100    0000100000000100          MUL
00101    0000100000000100          DIV
00110    0000100000000100          NOR
00111    0000100000000100          AND
01000    0000100000000100          XOR
01001    0000100000000100          RSH
01010    0000100000000100          LSH
01011    0000100000000001          GOF
01100    0000100000000010          LDI
01101    0000100000000110          ADI
01110    0000000000010000          JMP
01111    0000000000100000          BRH
10000    0101000110001000          CAL
10001    0010000100000000          RET
10010    0000100110000010          LOD
10011    0000100000000010          STR
10100    1000100000000000          CYE
10101    0010000000000000          CYR
10110    0000000001000000          SCL
10111    0000000001000000          SRT
```

> **Nota:** Las instrucciones ADD, SUB, MUL, DIV, NOR, AND, XOR, RSH y LSH comparten Control Word (`0000100000000100`) porque la ALU diferencia la operación a través del OpCode directamente.

---

## 💾 Sistema de Memoria y MMU

### Mapa de Memoria Virtual (32 bits)

```
Espacio Virtual (32 bits)          Espacio Físico (32 bits)
┌──────────────────────────────┐   ┌──────────────────────────────┐
│  Programa / Heap             │   │                              │
│  (0x00000000 – 0x7FFFFFFF)   │──►│  Páginas Físicas (4 KB c/u)  │
├──────────────────────────────┤   │  Mapeo via Tabla de Páginas  │
│  Stack                       │──►│  (manejada por kernel)       │
│  (0x80000000 – 0xFFFFFFFF)   │   │                              │
└──────────────────────────────┘   └──────────────────────────────┘
               │
             [MMU]
         (traslación de
          direcciones)
```

- **Tamaño de página:** 4 KB (12 bits de offset)
- **Tabla de páginas:** residente en RAM, gestionada por el kernel
- **Registros de control:** CR3 (base de tabla), CR2 (fault address), CR0 (enable paging)

### Estado actual de la MMU

| Componente                         | Estado          |
|------------------------------------|-----------------|
| Paginación de 4 KB                 | ✅ Implementado  |
| Tabla de páginas en RAM            | ✅ Implementado  |
| Protección de memoria              | ✅ Implementado  |
| TLB (Translation Lookaside Buffer) | ⚠️ Pendiente    |
| MMU integrada en etapa IF          | ⚠️ Pendiente    |

---

## 🔄 Manejo de Hazards

### Data Hazards — RAW (Read After Write)

**Problema:** Una instrucción necesita leer un registro que la instrucción anterior aún no escribió.

**Solución implementada — Forwarding/Bypass:**
- Se detecta la dependencia comparando el registro destino de la instrucción anterior con los registros fuente de la actual.
- El dato se redirige directamente desde la salida de EX o MEM a la entrada de la ALU.
- Evita stalls en la mayoría de los casos.

```
Ejemplo:
  ADD R1, R2, R3     ← Escribe R1 en WB (ciclo 5)
  SUB R4, R1, R5     ← Lee R1 en EX (ciclo 4) → Forward desde EX
```

**Caso sin solución por forwarding (stall necesario):**
```
  LOD R5, [R1]       ← Dato disponible al final de MEM
  ADD R6, R5, R7     ← Necesita R5 en EX → requiere 1 ciclo de stall
```

### Control Hazards — Saltos

**Estrategia:** predicción de no-salto (fetch siempre de `PC + 4`).

**Si la predicción falla** (en EX se detecta que sí debe saltar):
1. Se emite señal `FLUSH` desde `Control_FLush.circ`.
2. Se descartan las instrucciones en IF e ID.
3. Se carga la dirección correcta en PC.
4. **Penalización:** 2–3 ciclos de pipeline vacío.

---

## 🔌 Interrupciones y Excepciones

### Módulo LAPIC (`LAPIC.circ`)

- Controlador de interrupciones locales (Local APIC).
- Soporta interrupciones parcialmente anidadas.

### Flujo de Excepción / Syscall

```
1. Evento (INT externa, excepción interna, instrucción SCL)
   ↓
2. CPU guarda contexto:
   • PC actual → RE1 (EPC)
   • Banderas → RE9 (Eflags)
   • Modo anterior → RE6 (CR0)
   ↓
3. Salta al handler (dirección en RE8 / IDTR)
   ↓
4. Kernel atiende la excepción o syscall
   ↓
5. Instrucción SRT restaura contexto:
   • PC ← RE1 (EPC)
   • Banderas ← RE9 (Eflags)
   • Modo ← usuario
```

### Tipos de excepción soportados

- **Divide by zero** → instrucción DIV con B = 0
- **Invalid opcode** → OpCode no reconocido
- **Page fault** → dirección virtual no mapeada (MMU)
- **Privilege violation** → instrucción kernel en modo usuario
- **Syscall (SCL)** → trap voluntario al kernel
- **Interrupción externa** → señal al LAPIC

---

## 📈 Estimaciones de Rendimiento (Pipeline)

| Operación                | Ciclos        | Notas                                         |
|--------------------------|---------------|-----------------------------------------------|
| ADD / SUB / AND / XOR    | 1             | Pipelined, forwarding disponible              |
| MUL / DIV                | 1             | Pipelined                                     |
| LOD (sin page fault)     | 2             | 1 ciclo EX + 1 ciclo MEM                      |
| LOD (con page fault)     | 4+            | + penalización por page walk                  |
| STR                      | 2             | Similar a LOD                                 |
| JMP / BRH (no-salto)     | 1             | Predicción correcta                           |
| JMP / BRH (salto erróneo)| 4             | Flush + refetch + 2–3 ciclos de penalización  |

---

## 🚀 Cómo Usar el Proyecto

### 1. Abrir en Logisim-Evolution

```bash
# Abrir el módulo principal del pipeline
java -jar logisim-evolution.jar Core/Pipeline.circ
```

Cada módulo puede simularse de forma independiente:

| Módulo                   | Descripción                                |
|--------------------------|--------------------------------------------|
| `Core/Pipeline.circ`     | Pipeline completo (módulo principal)       |
| `Core/Control_FLush.circ`| Unidad de control + flush de saltos        |
| `Core/Unidad_Aritmetica.circ` | Prueba de operaciones ALU             |
| `Core/Registros.circ`    | Banco de registros GPR + SPR               |
| `Core/MEM.circ`          | Memoria y MMU                              |
| `Core/LAPIC.circ`        | Controlador de interrupciones              |

### 2. Cargar la tabla PLA

El archivo `Intr` (en la raíz del proyecto) es la tabla de la ROM PLA. Para cargarlo en Logisim:

1. Abrir el componente ROM dentro de `Control_FLush.circ` o `Pipeline.circ`.
2. Hacer clic derecho → **Edit Contents**.
3. Cargar el archivo `Intr`.

### 3. Información adicional

- `Inst.xlsx` — Planilla con la tabla completa de instrucciones, señales de control y mapas de bits.
- `Docs/ISA_GUIDE.md` — Referencia detallada de cada instrucción con ejemplos.
- `Docs/EXAMPLES.md` — Programas de ejemplo en ensamblador.

---

## ⚠️ Estado del Proyecto

### ✅ Completado

- [x] Pipeline de 5 etapas funcional
- [x] ALU con operaciones aritméticas, lógicas y de desplazamiento
- [x] Banco de registros: 16 GPR + 11 SPR
- [x] Unidad de control con PLA ROM (tabla `Intr`)
- [x] Sistema de memoria RAM con paginación de 4 KB
- [x] LAPIC para interrupciones externas
- [x] Forwarding para data hazards (RAW)
- [x] Flush para control hazards (saltos)
- [x] ISA de 24 instrucciones completa

### 🚧 En Desarrollo

- [ ] **MMU para etapa IF** — actualmente IF accede RAM sin traslación de direcciones
- [ ] **TLB** (Translation Lookaside Buffer) — para optimizar accesos a memoria
- [ ] Caché de instrucciones (I-cache)
- [ ] Interrupciones totalmente anidadas

### 📋 Planificado

- [ ] Ensamblador custom (`.asm` → binario de 32 bits)
- [ ] Ejemplos de código más completos
- [ ] Depurador integrado para simulación

---

## 📚 Documentación Adicional

Toda la documentación técnica se encuentra en la carpeta `Docs/`:

| Archivo                  | Contenido                                             |
|--------------------------|-------------------------------------------------------|
| `ARCHITECTURE.md`        | Datapath completo, etapas, timing y cronograma        |
| `ISA_GUIDE.md`           | Referencia detallada de cada instrucción con ejemplos |
| `PIPELINE_HAZARDS.md`    | Análisis de riesgos y soluciones implementadas        |
| `MEMORY_SYSTEM.md`       | Sistema de memoria virtual y MMU                      |
| `CONTROL_UNIT.md`        | Unidad de control, bits de la Control Word y PLA      |
| `EXAMPLES.md`            | Ejemplos de programas en ensamblador                  |

---

## 🔧 Requisitos

- **Logisim-Evolution 3.9.0+** — para abrir y simular los archivos `.circ`
- **Java 11+** — requerido por Logisim-Evolution
- **Microsoft Excel / LibreOffice Calc** — para consultar `Inst.xlsx`

---

## 📄 Licencia

Proyecto académico de código abierto. Libre para uso educativo.

---

**Última actualización:** Mayo 2026  
**Versión:** 1.2 — Documentación completa y revisada
