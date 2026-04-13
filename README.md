# 💻 32-bit Custom CPU Architecture

![Status](https://img.shields.io/badge/Status-In%20Development-orange) ![Language](https://img.shields.io/badge/Language-VHDL%20%26%20Logisim-blue)

Este repositorio contiene el diseño completo e implementación de una **arquitectura de procesador de 32 bits personalizada** con pipeline de 5 etapas, unidad de control programable (PLA), sistema de memoria virtual con paginación, y soporte para excepciones e interrupciones.

El proyecto integra:
- **Logisim-evolution v3.9.0**: Diseño y simulación de la lógica digital
- **VHDL / ModelSim**: Implementación de componentes críticos
- **Sistema completo**: Desde la fetch de instrucciones hasta escritura de resultados

---

## 📊 Especificaciones Técnicas Principales

| Característica | Especificación |
|---|---|
| **Ancho de instrucción** | 32 bits (longitud fija) |
| **Ancho de datos** | 32 bits |
| **Direccionamiento** | 32 bits (4 GB de espacio de direcciones) |
| **Pipeline** | 5 etapas: IF → ID → EX → MEM → WB |
| **Registros GPR** | 16 registros de 32 bits (R0-R15) |
| **Registros especiales** | 11 registros de control (RE1-RE11) |
| **Memoria virtual** | Sí, con paginación de 4KB |
| **Unidad de control** | PLA ROM (16 bits de salida) |
| **Conjunto de instrucciones** | 24 instrucciones (ALU, Lógica, Flujo, Memoria, Sistema) |
| **Latencia MUL/DIV** | 1 ciclo (pipelined) |
| **Interrupciones** | Parcialmente anidadas |

---

## 🏗️ Arquitectura General

### Pipeline de 5 Etapas

```
┌─────────────────────────────────────────────────────────────────┐
│                      CICLO DE RELOJ                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  [IF]      [ID]      [EX]      [MEM]     [WB]                  │
│  Fetch  → Decode → Execute → Memory → Writeback                │
│  Instr  Operands  Operation  Load/Store  Result                │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

IF (Instruction Fetch):
  - Lee instrucción desde memoria de instrucciones
  - Actualiza PC (Program Counter)
  - Interactúa con MMU para traslación de direcciones

ID (Instruction Decode):
  - Decodifica OpCode (5 bits)
  - Lee operandos de registros (A, B)
  - Genera Control Word (16 bits) desde tabla PLA
  - Prepara inmediatos y offset

EX (Execute):
  - Ejecuta operación en ALU (ADD, SUB, MUL, DIV, lógica, shifts)
  - Calcula direcciones para saltos (JMP, BRH)
  - Evalúa condiciones para branches
  - MUL/DIV se completan en 1 ciclo

MEM (Memory):
  - Lee/escribe datos en RAM (para LOD, STR)
  - Maneja paginación (MMU activa)
  - Acceso a memoria virtual

WB (Writeback):
  - Escribe resultado en registro destino (C)
  - Actualiza banderas (Z, N, C, V) si aplica
  - Cierra el ciclo de instrucción
```

### Manejo de Hazards

**Data Hazards (RAW - Read After Write):**
- **Solución**: Forwarding/Bypass desde etapa EX y MEM
- Detecta dependencias y redirige datos directamente
- Evita stalls en la mayoría de casos

**Control Hazards (Saltos):**
- **Estrategia**: Asume no-salto (predicción optimista)
- Si se detecta que el salto debería ocurrir → **Flush** del pipeline
- Costo: 2-3 ciclos de penalización en caso de error
- Se implementa en módulo `Control_FLush.circ`

---

## 📁 Estructura del Proyecto

```
/
├── README.md                          # Este archivo (visión general)
├── ARCHITECTURE.md                    # Diseño detallado de la CPU
├── ISA_GUIDE.md                       # Guía completa del conjunto de instrucciones
├── PIPELINE_HAZARDS.md                # Análisis de riesgos y soluciones
├── MEMORY_SYSTEM.md                   # Sistema de memoria y MMU
├── CONTROL_UNIT.md                    # Unidad de control (PLA)
├── EXAMPLES.md                        # Ejemplos de código ensamblador
│
├── /Core                              # Módulos principales de Logisim
│   ├── Inst.xlsx                      # Tabla de instrucciones (referencia)
│   ├── Intr                           # Tabla PLA (programa de control)
│   │
│   ├── Pipeline.circ                  # Implementación del pipeline (5 etapas)
│   ├── Control_FLush.circ             # Manejo de control hazards y flush
│   ├── Unidad_Aritmetica.circ         # ALU (operaciones)
│   ├── Registros.circ                 # Banco de registros (R0-R15, RE1-RE11)
│   ├── MEM.circ                       # Memoria (RAM) y control de acceso
│   ├── LAPIC.circ                     # Local APIC (interrupciones)
│   └── (otros módulos de soporte)
│
└── /docs                              # Documentación adicional
    ├── HAZARD_EXAMPLES.md             # Ejemplos de situaciones de hazard
    ├── MMU_TODO.md                    # Plan para MMU en IF stage
    └── TESTING.md                     # Guía de testing
```

---

## 🧠 Formato de Instrucciones

Las instrucciones se organizan en campos de 4 bits para optimizar la decodificación:

```
┌─────┬───────┬──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
│31-29│ 28-24 │  23-20   │  19-16   │  15-12   │  11-8    │   7-4    │   3-0    │
├─────┼───────┼──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤
│Type │OpCode │  Reg A   │  Reg B   │  Reg C   │Imm/Offset│Imm/Offset│Imm/Offset│
│     │(5bit)│ (4 bits)  │ (4 bits) │ (4 bits) │(4 bits)  │ (4 bits) │ (4 bits) │
└─────┴───────┴──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘

TIPO:
  001 = Instrucción normal de procesamiento
  010 = Instrucción de flujo (saltos, llamadas)
  011 = Instrucción de memoria
  100 = Instrucción de sistema/kernel
  000 = Reserved / Control

CAMPOS DE OPERANDOS:
  - Reg A, Reg B, Reg C: Selectores de registro (4 bits = 16 opciones)
  - Inm/Offset (12 bits totales): Inmediato de 16 bits o desplazamiento
    Se usan en 3 campos de 4 bits cada uno para máxima flexibilidad
```

### Ejemplos de Codificación

```assembly
# ADD R3, R1, R2
# Tipo=001, OpCode=00010, RegA=0001, RegB=0010, RegC=0011
# Binario: 001 00010 0001 0010 0011 0000 0000 0000
# Hex: 0x8208C00

# LDI R5, 0x1234  (Load Immediate)
# Tipo=001, OpCode=01100, RegA=0101, Inmediato=0x1234
# Binario: 001 01100 0101 0001 0010 0011 0100 0000
# Hex: 0x8B0E340

# JMP R7  (Jump - destino en registro R7)
# Tipo=010, OpCode=01110, RegB=0111
# Binario: 010 01110 0000 0111 0000 0000 0000 0000
# Hex: 0xA3870000
```

---

## 📋 Conjunto de Instrucciones (ISA - 24 instrucciones)

### Instrucciones ALU (Aritmética)

| OpCode | Mnemónico | Operandos | Latencia | Banderas | Descripción |
|--------|-----------|-----------|----------|----------|-------------|
| `00010` | **ADD** | A, B → C | 1 ciclo | Z,N,C,V | Suma: C = A + B |
| `00011` | **SUB** | A, B → C | 1 ciclo | Z,N,C,V | Resta: C = A - B |
| `00100` | **MUL** | A, B → C | 1 ciclo | Z,N | Multiplicación: C = A × B |
| `00101` | **DIV** | A, B → C | 1 ciclo | Z,N | División: C = A ÷ B |

### Instrucciones Lógicas y de Desplazamiento

| OpCode | Mnemónico | Operandos | Latencia | Descripción |
|--------|-----------|-----------|----------|-------------|
| `00110` | **NOR** | A, B → C | 1 ciclo | NOR bit a bit |
| `00111` | **AND** | A, B → C | 1 ciclo | AND bit a bit |
| `01000` | **XOR** | A, B → C | 1 ciclo | XOR bit a bit |
| `01001` | **RSH** | A, B → C | 1 ciclo | Shift derecha: C = A >> B |
| `01010` | **LSH** | A, B → C | 1 ciclo | Shift izquierda: C = A << B |

### Instrucciones de Banderas y Datos Inmediatos

| OpCode | Mnemónico | Operandos | Latencia | Descripción |
|--------|-----------|-----------|----------|-------------|
| `01011` | **GOF** | → A | 1 ciclo | Lee carry anterior en A |
| `01100` | **LDI** | Imm16 → A | 1 ciclo | Carga inmediato de 16 bits |
| `01101` | **ADI** | A, Imm16 → A | 1 ciclo | Suma inmediato: A = A + Imm16 |

### Instrucciones de Control de Flujo

| OpCode | Mnemónico | Operandos | Latencia | Hazard | Descripción |
|--------|-----------|-----------|----------|--------|-------------|
| `01110` | **JMP** | Reg(dir) | 1 ciclo | Control | Salto incondicional al registro |
| `01111` | **BRH** | Cond, Reg(dir) | 1 ciclo | Control | Salto condicional (si banderas) |
| `10000` | **CAL** | Reg(dir) | 1 ciclo | Control | Call: guarda PC+1 en stack |
| `10001` | **RET** | | 1 ciclo | Control | Return: salta a dirección en stack |

### Instrucciones de Memoria

| OpCode | Mnemónico | Operandos | Latencia | Descripción |
|--------|-----------|-----------|----------|-------------|
| `10010` | **LOD** | [Reg+Offset] → Reg | 2 ciclos | Load: lee RAM (+ penalización MMU) |
| `10011` | **STR** | Reg → [Reg+Offset] | 2 ciclos | Store: escribe RAM (+ penalización MMU) |

### Instrucciones de Sistema/Kernel

| OpCode | Mnemónico | Operandos | Latencia | Privilegio | Descripción |
|--------|-----------|-----------|----------|-----------|-------------|
| `10100` | **CYE** | SpecReg → GenReg | 1 ciclo | Kernel | Copy de Especial a Normal |
| `10101` | **CYR** | GenReg → SpecReg | 1 ciclo | Kernel | Copy de Normal a Especial |
| `10110` | **SCL** | (Syscall) | Var | Kernel | Llamada al sistema (trap) |
| `10111` | **SRT** | | Var | Kernel | Return from trap/exception |
| `00000` | **NOP** | | 1 ciclo | - | No Operation |
| `00001` | **HLT** | | 1 ciclo | - | Halt: detiene CPU hasta INT |

---

## 🗄️ Modelo de Registros

### Registros de Propósito General (16 registros × 32 bits)

```
R0:   Entrada/Salida de syscall (Input/Output)
R1:   Dirección de retorno (RET, CAL)
R2-R6:   Argumentos de función
R7:   Puntero opcional / Causa de excepción
R8-R13:  Uso general (No preservados)
R14-R15: Kernel context save
```

### Registros Especiales (11 registros × 32 bits)

```
RE1 (EPC):   Exception Program Counter (dirección de la instrucción que causó excepción)
RE2 (SP):    Stack Pointer (puntero de pila)
RE3 (PCID):  Process Context ID
RE4 (CR3):   Page Directory Base Register (para MMU)
RE5 (CR2):   Page Fault Linear Address
RE6 (CR0):   Registro de control de la MMU
RE7:         Causa de excepción
RE8 (IDTR):  Interrupt Descriptor Table Register
RE9 (Eflags): Banderas de estado (Z, N, C, V)
RE10 (Carry): Carry anterior (para GOF)
RE11 (TR):   Task Register
```

---

## ⚙️ Unidad de Control (PLA ROM)

La CPU utiliza una **Programmable Logic Array (PLA) implementada como ROM** para generar la Control Word de 16 bits desde el OpCode (5 bits).

### Control Word (16 bits - MSB a LSB)

```
Bit  Nombre      Función
──────────────────────────────────────────────────
15   A==E        1=Lee Reg Especial; 0=Lee Reg Normal
14-13 MEM/REG    Selector de origen (ALU, RAM, SP, Inmediato)
12   En REGE     Enable escribir Registros Especiales
11   En REG      Enable escribir Registros Normales
10   HLT         Señal halt (detiene reloj)
09   RET         Habilita lógica de retorno
08-07 RoW        Read or Write en RAM (00=nada, 01=read, 10=write, 11=reserved)
06   Kernel      Modo privilegiado (1=kernel, 0=user)
05   BRH         Evalúa salto condicional
04   JMP         Habilita salto incondicional
03   CAL         Almacena dirección retorno
02   En Branch   Enable comparador de Branch
01   Inmediato   1=usa inmediato; 0=usa Reg B
00   Overflow    Habilita carry a ALU
```

### Tabla PLA (Extracto - Ver archivo `Intr` para completa)

```
OpCode  Control Word (16 bits bin)  Instrucción
──────────────────────────────────────────────
00000   0000000000000000           NOP
00001   0000010000000000           HLT
00010   0000100000000100           ADD
00011   0000100000000100           SUB
...     ...                        ...
```

Cada OpCode mapea a una Control Word específica que orquesta toda la microarquitectura.

---

## 💾 Sistema de Memoria

### Arquitectura de Memoria Virtual

```
Espacio Virtual (32 bits)          Espacio Físico (32 bits)
┌──────────────────────────────┐   ┌──────────────────────────────┐
│  Programa / Heap             │   │                              │
│  (0x00000000 - 0x7FFFFFFF)   │   │     Páginas Físicas          │
├──────────────────────────────┤   │     (4KB cada una)           │
│  Stack                       │   │     (Mapeo via TLB/PageTbl)  │
│  (0x80000000 - 0xFFFFFFFF)   │   │                              │
└──────────────────────────────┘   └──────────────────────────────┘
        ↓           ↓
        └─── MMU ───┘
        (Traslación de direcciones)
```

### MMU - Estado Actual

**✅ Implementado:**
- Paginación de 4KB
- Tabla de páginas en memoria
- Protección de memoria
- Banderas de página (presente, lectura/escritura, ejecutable)

**⚠️ En desarrollo:**
- Integración con etapa IF (Instruction Fetch)
- Necesita traer instrucciones de memoria virtual
- Actualmente solo MEM stage usa MMU
- TODO: Añadir caché de TLB para optimizar accesos

### Acceso a Memoria

```
Instrucción LOD/STR:
┌────┐      ┌─────────┐      ┌──────────┐      ┌────┐
│ ID │ ---→ │ EX calc │ ---→ │   MMU    │ ---→ │RAM │
└────┘      │ address │      │ translate│      └────┘
            └─────────┘      └──────────┘
```

---

## 🔌 Interrupciones y Excepciones

### Características

- **LAPIC implementado** en módulo `LAPIC.circ`
- **Interrupciones parcialmente anidadas**
- **Mecanismo de context save** mediante registros especiales

### Flujo de Excepción

```
1. Evento (INT, exception, syscall)
   ↓
2. CPU guarda contexto:
   - PC en EPC (RE1)
   - Flags en Eflags (RE9)
   - Modo anterior en CR0
   ↓
3. Salta a handler (dirección en IDTR)
   ↓
4. Kernel maneja excepción
   ↓
5. Ejecuta SRT (return from trap)
   - Restaura contexto desde RE1, RE9
   - Vuelve a modo user
```

### Tipos Soportados

- Excepciones de CPU (divide by zero, invalid opcode)
- Page faults (MMU)
- Syscalls (SCL instruction)
- Interrupciones externas (LAPIC)

---

## 🚀 Cómo Usar Este Proyecto

### 1. Abrir en Logisim-evolution

```bash
logisim-evolution /Core/Pipeline.circ
```

Cada módulo se puede simular independientemente:
- `Unidad_Aritmetica.circ` - Prueba operaciones ALU
- `Registros.circ` - Prueba banco de registros
- `MEM.circ` - Prueba memoria y MMU
- `Pipeline.circ` - Prueba pipeline completo

### 2. Compilar VHDL (ModelSim)

```bash
vhdl . compile
vsim -gui top_module
```

### 3. Cargar Programa en Memoria

Ver `EXAMPLES.md` para cómo ensamblar y cargar código.

---

## ⚠️ Estado del Proyecto y TODOs

### ✅ Completado
- [x] Pipeline de 5 etapas funcional
- [x] ALU con operaciones aritméticas y lógicas
- [x] Banco de 16 registros GPR + 11 especiales
- [x] Unidad de control con PLA ROM
- [x] Sistema de memoria (RAM) con paginación
- [x] LAPIC para interrupciones
- [x] Forwarding para hazards de datos
- [x] Flush para hazards de control

### 🚧 En Desarrollo
- [ ] **MMU para etapa IF** (fetch de instrucciones virtuales)
  - Actualmente IF trae instrucciones de RAM directamente
  - Necesita integración con traslación de direcciones
  - Ver `MEMORY_SYSTEM.md` para detalles
- [ ] Caché de instrucciones (I-cache)
- [ ] Optimización de latencias
- [ ] Ejemplos de código ensamblador y test

### 📋 Planificado
- [ ] TLB (Translation Lookaside Buffer)
- [ ] Interrupciones totalmente anidadas
- [ ] Debugger integrado
- [ ] Generador de código
- [ ] Simulador más rápido

---

## 📚 Documentación Adicional

Este proyecto incluye documentación modular para mayor claridad:

- **`ARCHITECTURE.md`** - Diseño detallado de cada componente
- **`ISA_GUIDE.md`** - Guía completa del conjunto de instrucciones
- **`PIPELINE_HAZARDS.md`** - Análisis profundo de riesgos
- **`MEMORY_SYSTEM.md`** - Sistema de memoria y MMU
- **`CONTROL_UNIT.md`** - Diseño de la unidad de control
- **`EXAMPLES.md`** - Ejemplos de código (en desarrollo)

---

## 🔧 Requisitos

- **Logisim-evolution 3.9.0+**
- **VHDL Compiler** (GHDL o ModelSim) - opcional
- **Ensamblador custom** - para traducir .asm → binario (en desarrollo)

---

## 📈 Estimaciones de Performance

| Operación | Ciclos | Notas |
|-----------|--------|-------|
| ADD/SUB/AND/OR/XOR | 1 | Pipelined, forwarding disponible |
| MUL | 1 | Multiplicador pipelined |
| DIV | 1 | Divisor pipelined |
| LOD (hit TLB) | 2 | 1 para cálculo, 1 para acceso |
| LOD (miss TLB) | 4+ | + penalización de page walk |
| STR (hit TLB) | 2 | Similar a LOD |
| JMP (no salto) | 1 | Predicción correcta (asume no-salto) |
| JMP (salto erróneo) | 4 | Flush + refetch + 2-3 ciclos |

---

## 👥 Contribuciones y Feedback

Las áreas clave para contribución son:
1. Implementación de MMU en IF stage
2. Escritura de ejemplos en ensamblador
3. Optimización del pipeline
4. Testing y validación

---

## 📄 Licencia

Proyecto académico de código abierto.

---

## 🙏 Agradecimientos

Diseñado como proyecto educativo para entender arquitecturas de CPU modernas y técnicas de pipeline.

---

**Última actualización:** Abril 2026  
**Versión:** 1.1 (Documentación mejorada)
