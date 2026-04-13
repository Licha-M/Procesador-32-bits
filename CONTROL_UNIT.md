# ⚙️ Control Unit - Unidad de Control (PLA)

Este documento describe la unidad de control, la tabla PLA (Programmable Logic Array), y cómo se generan las Control Words que orquestan toda la microarquitectura.

---

## 1. VISIÓN GENERAL DE UNIDAD DE CONTROL

### Función Principal

La unidad de control es responsable de:

1. **Decodificar instrucciones** (extraer OpCode)
2. **Generar Control Word** (16 bits de señales de control)
3. **Orquestar el datapath** (mux selectores, enables, etc.)
4. **Coordinar etapas del pipeline** (señales de sincronización)

### Arquitectura Simple: PLA ROM

```
┌─────────────────────┐
│ OpCode (5 bits)     │
│ + Optype (2 bits)   │
└──────────┬──────────┘
           │
           ▼
    ┌──────────────┐
    │ PLA ROM      │
    │ 32 × 16      │  Lectura combinacional
    │ (direcciones)│  (0 ciclos de latencia)
    └──────┬───────┘
           │
           ▼
┌──────────────────────────┐
│ Control Word (16 bits)   │
│ Señales de control       │
└──────────────────────────┘
```

### Ventajas de PLA

- Simple de implementar en Logisim
- Latencia combinacional (sin ciclos extra)
- Fácil de modificar (cambiar tabla)
- Determinístico (mismo input → mismo output)

### Alternativas

| Método | Latencia | Flexibilidad | Área |
|--------|----------|--------------|------|
| PLA ROM | 0 | Media | Pequeña |
| Lógica Combinacional Pura | 0 | Baja | Media |
| Microcode (ROM) | 1+ | Alta | Grande |
| State Machine | 1+ | Media | Media |

---

## 2. CONTROL WORD - 16 BITS DE AUTORIDAD

Cada instrucción requiere una Control Word de 16 bits que determina el comportamiento de todo el CPU.

### Desglose Bit por Bit

```
Bit 15: A==E (Igualar Especial)
─────────────────────────────────
  1 = Leer registro Especial (RE0-RE10) en operando A
  0 = Leer registro Normal (R0-R15) en operando A
  
  Uso: Instrucciones CYE/CYR que acceden registros especiales

Bits 14-13: MEM/REG (Multiplexor Origen Datos)
─────────────────────────────────────────────
  00 = ALU output (para instrucciones ALU)
  01 = RAM read (para LOD)
  10 = Stack Pointer / SP
  11 = Inmediato (para LDI)
  
  Controla qué dato escribe en WB

Bit 12: En REGE (Enable Registros Especiales)
──────────────────────────────────────────────
  1 = Permite escritura en RE[C]
  0 = Escritura deshabilitada
  
  Uso: CYR, SRT que modifican registros especiales

Bit 11: En REG (Enable Registros Normales)
───────────────────────────────────────────
  1 = Permite escritura en R[C]
  0 = Escritura deshabilitada
  
  Uso: La mayoría de instrucciones ALU, LOD

Bit 10: HLT (Halt / Detener Reloj)
──────────────────────────────────
  1 = Detiene reloj del CPU
  0 = Reloj funcionando
  
  Uso: Instrucción HLT

Bit 9: RET (Return)
───────────────────
  1 = Habilita lógica de retorno (leer SP, PC = [SP])
  0 = Deshabilitada
  
  Uso: RET, SRT

Bits 8-7: RoW (Read or Write en Memoria)
─────────────────────────────────────
  00 = Sin acceso (NOP, ALU ops)
  01 = Read (LOD)
  10 = Write (STR)
  11 = Reserved
  
  Controla lectura/escritura en RAM

Bit 6: Kernel (Modo Kernel)
────────────────────────────
  1 = Ejecutar en modo kernel (privilegiado)
  0 = Modo usuario
  
  Nota: En instrucción SCL se pone 1 (trap)
        En instrucción SRT se restaura CR0

Bit 5: BRH (Branch Condicional)
────────────────────────────────
  1 = Evaluar condición de salto
  0 = No evaluar
  
  Uso: BRH

Bit 4: JMP (Jump Incondicional)
────────────────────────────────
  1 = Realiza salto incondicional
  0 = No salta
  
  Uso: JMP

Bit 3: CAL (Call)
──────────────────
  1 = Guarda dirección de retorno en stack
  0 = No guarda
  
  Uso: CAL (Llamada a función)

Bit 2: En Branch (Enable Comparador de Branch)
───────────────────────────────────────────────
  1 = Habilita lógica de comparación de banderas
  0 = Deshabilitada
  
  Uso: BRH

Bit 1: Inmediato (Usar Inmediato en ALU)
────────────────────────────────────────
  1 = ALU usa inmediato en lugar de Reg[B]
  0 = ALU usa Reg[B] normal
  
  Uso: ADI, LDI

Bit 0: Overflow (Habilitar Carry a ALU)
────────────────────────────────────────
  1 = Incluir carry anterior en operación ALU
  0 = No incluir
  
  Uso: Aritmética de precisión múltiple, GOF
```

### Representación Binaria

```
Bit:  15 14-13 12 11 10 9 8-7 6 5 4 3 2 1 0
      A= MEM En En HLT R RoW K BR JM CA EN IMM OV
      == /REG RG REG          H  OW WN EN   IMM

Ejemplo ADD:    0000100000000100
                   = A==0, MEM=00, EnRG=1, HLT=0, 
                     RET=0, RoW=00, Kernel=0, BRH=0,
                     JMP=0, CAL=0, EnBr=0, Imm=1, OV=0

Ejemplo LDI:    0000100000000010
                   = A==0, MEM=11, EnRG=1, HLT=0,
                     RET=0, RoW=00, Kernel=0, BRH=0,
                     JMP=0, CAL=0, EnBr=0, Imm=1, OV=0
```

---

## 3. TABLA PLA COMPLETA (32 entradas)

### Formato: OpCode → Control Word

```
OpCode | Mnemónico | Tipo | Control Word (hex) | Control Word (bin)
────────────────────────────────────────────────────────────────────
00000  | NOP       | -    | 0x0000             | 0000000000000000
00001  | HLT       | -    | 0x0400             | 0000010000000000
00010  | ADD       | ALU  | 0x0C04             | 0000110000000100
00011  | SUB       | ALU  | 0x0C04             | 0000110000000100
00100  | MUL       | ALU  | 0x0C04             | 0000110000000100
00101  | DIV       | ALU  | 0x0C04             | 0000110000000100
00110  | NOR       | ALU  | 0x0C04             | 0000110000000100
00111  | AND       | ALU  | 0x0C04             | 0000110000000100
01000  | XOR       | ALU  | 0x0C04             | 0000110000000100
01001  | RSH       | ALU  | 0x0C04             | 0000110000000100
01010  | LSH       | ALU  | 0x0C04             | 0000110000000100
01011  | GOF       | FLAG | 0x0C01             | 0000110000000001
01100  | LDI       | IMM  | 0x0C02             | 0000110000000010
01101  | ADI       | IMM  | 0x0C06             | 0000110000000110
01110  | JMP       | CTL  | 0x0010             | 0000000000010000
01111  | BRH       | CTL  | 0x0020             | 0000000000100000
10000  | CAL       | CTL  | 0x5C68             | 0101110001101000
10001  | RET       | CTL  | 0x2410             | 0010010000010000
10010  | LOD       | MEM  | 0x0C32             | 0000110000110010
10011  | STR       | MEM  | 0x0C02             | 0000110000000010
10100  | CYE       | SYS  | 0x8C00             | 1000110000000000
10101  | CYR       | SYS  | 0x2400             | 0010010000000000
10110  | SCL       | SYS  | 0x0440             | 0000010001000000
10111  | SRT       | SYS  | 0x0440             | 0000010001000000
────────────────────────────────────────────────────────────────────
```

### Análisis de Instrucciones Clave

#### ADD (00010) → 0x0C04

```
Binario: 0000110000000100
         A= MEM EnRE EnREG HLT RET RoW K BRH JMP CAL EnBr Imm OV
         0  00    1    1    0   0  00  0  0   0   0    0   1  0

Significado:
  - A==0: Lee Reg Normal (no especial)
  - MEM=00: ALU output (no RAM, no imm)
  - EnREG=1: Escribe en registro normal
  - Imm=1: ALU toma inmediato (pero ADI lo usa, ADD ignora)
  - OV=0: Sin carry previo
  
Flujo de datos:
  Reg[A] → ALU
  Reg[B] → ALU (o Imm si Imm=1)
  ALU output → WB → Reg[C]
```

#### LDI (01100) → 0x0C02

```
Binario: 0000110000000010
         0  00    1    1    0   0  00  0  0   0   0    0   1  0

Diferencia vs ADD:
  - Mismo control word!
  - La diferencia está en la ALU:
    Si Imm=1, ALU puede tomar inmediato
    
Flujo:
  Inmediato (12 bits) → ALU
  ALU suma 0: output = Inmediato
  Output → WB → Reg[A]
```

#### CAL (10000) → 0x5C68

```
Binario: 0101110001101000
         A= MEM EnRE EnREG HLT RET RoW K BRH JMP CAL EnBr Imm OV
         0  10    1    1    0   1  11  0  0   1   1    0   0  0

Bits especiales:
  - RET=1: Habilita lógica de retorno (lee SP)
  - RoW=11: Escribe en memoria (stack)
  - CAL=1: Guarda dirección retorno
  - JMP=1: Salta incondicional
  
Flujo:
  1. PC+1 → Stack
  2. Reg[B] → ALU
  3. ALU output → PC (salta)
```

#### LOD (10010) → 0x0C32

```
Binario: 0000110000110010
         A= MEM EnRE EnREG HLT RET RoW K BRH JMP CAL EnBr Imm OV
         0  00    1    1    0   0  01  0  0   0   0    0   1  0

Bits especiales:
  - MEM=00: ALU calcula dirección
  - RoW=01: Read (lectura de RAM)
  - Imm=1: Offset inmediato
  
Flujo:
  1. Reg[A] + Imm → ALU (calcula dirección)
  2. ALU output → Dirección de memoria
  3. RAM[dirección] → WB → Reg[B]
```

---

## 4. IMPLEMENTACIÓN EN LOGISIM

### Circuito PLA ROM en Logisim

```
Componente: ROM (Memory)

Configuración:
  - Address bits: 7 (para 2^7=128 direcciones)
  - Data bits: 16 (Control Word)
  - Inicialización: Tabla PLA (32 × 16)

En Logisim:
  1. Crear ROM
  2. Cargar archivo "Intr" (tabla PLA)
  3. Conectar:
     Input: OpCode (5 bits) + bits extra (2)
     Output: Control Word (16 bits)
  
  Dentro de Pipeline.circ o Control_Flush.circ
```

### Lectura de Tabla

```
// Pseudocódigo VHDL
architecture rtl of ControlUnit is
  type pla_table is array (0 to 31) of std_logic_vector(15 downto 0);
  constant pla : pla_table := (
    0  => "0000000000000000",  -- NOP
    1  => "0000010000000000",  -- HLT
    2  => "0000100000000100",  -- ADD
    3  => "0000100000000100",  -- SUB
    ...
    20 => "1000100000000000",  -- CYE
    ...
  );
  
begin
  control_word <= pla(to_integer(unsigned(opcode)));
end rtl;
```

---

## 5. DISTRIBUCIÓN DE SEÑALES

### Desde Control Word a Datapath

```
┌─────────────────────────────────┐
│ Control Word (16 bits)          │
└─────────────────────────────────┘
           │
    ┌──────┴──────┬───────┬─────┬─────────┐
    │             │       │     │         │
    ▼             ▼       ▼     ▼         ▼
┌────────┐  ┌─────────┐ ┌──┐ ┌──┐ ┌──────────┐
│Registro│  │ Memoria │ │AL│ │PC│ │Excepción │
│Control │  │ Control │ │U │ │Co│ │ Handler  │
└────────┘  └─────────┘ └──┘ └──┘ └──────────┘
```

### Mapa de Distribución

```
Control Word bits → Destino

Bit 15 (A==E) → Multiplexor Reg A (GPR vs SPR)
Bits 14-13 (MEM/REG) → Multiplexor WB (qué dato escribe)
Bit 12 (EnREGE) → Enable escribir registros especiales
Bit 11 (EnREG) → Enable escribir registros normales
Bit 10 (HLT) → Deshabilitador de reloj
Bit 9 (RET) → Stack pointer logic
Bits 8-7 (RoW) → Controlador de memoria (R/W)
Bit 6 (Kernel) → Modo privilegiado flag
Bit 5 (BRH) → Evaluador de condiciones
Bit 4 (JMP) → Multiplexor PC (salto)
Bit 3 (CAL) → Stack guarda dirección
Bit 2 (EnBr) → Comparador de banderas
Bit 1 (Imm) → Multiplexor ALU operando B
Bit 0 (OV) → Carry anterior a ALU
```

---

## 6. REGLAS DE DECODIFICACIÓN

### Patrón: Operaciones ALU

```
OpCode: 00010-01010 (ADD, SUB, MUL, DIV, NOR, AND, XOR, RSH, LSH)
Patrón:
  - Siempre: EnREG=1 (escribe resultado)
  - Siempre: MEM=00 (usa ALU)
  - Siempre: RoW=00 (sin RAM)
  - Puede usar Imm=0 o 1 (depende instrucción)

Control Word Template: 0000_1_00_1_0_0_00_0_0_0_0_0_?_?
                            │ │ │ │ │ │ │ │ │ │ │ │ │ └─ Varía
                            │ │ │ │ │ │ │ │ │ │ │ │ └──── Varía
                            │ │ │ │ │ │ │ │ │ │ │ └───── Reserved
                            │ │ │ │ │ │ │ │ │ │ └────── Reserved
                            │ │ │ │ │ │ │ │ │ └─────── Always 0
                            │ │ │ │ │ │ │ │ └────────── Always 0
                            │ │ │ │ │ │ │ └─────────── Always 0
                            └─────────────────────────── Common
```

### Patrón: Instrucciones de Control de Flujo

```
OpCode: 01110-10001 (JMP, BRH, CAL, RET)
Patrón:
  - Siempre: Modifica PC
  - Algunos: Guardan/restauran estado (RET)
  - CAL: Especial (guarda dirección y salta)

JMP:     0000_0_00_0_0_0_00_0_0_1_0_0_0_0 = 0x0010
BRH:     0000_0_00_0_0_0_00_0_0_1_0_0_0_0 = 0x0020 (+ EnBr)
CAL:     0101_1_10_1_1_0_11_0_0_1_1_0_0_0 = 0x5C68
RET:     0010_0_10_0_0_1_00_0_0_0_0_0_0_0 = 0x2410
```

### Patrón: Instrucciones de Memoria

```
OpCode: 10010-10011 (LOD, STR)
Patrón:
  - Siempre: Usa Imm=1 (offset de memoria)
  - LOD: RoW=01 (lectura)
  - STR: RoW=10 (escritura)

LOD:     0000_1_00_1_1_0_01_0_0_0_0_0_1_0 = 0x0C32
STR:     0000_1_00_1_1_0_10_0_0_0_0_0_1_0 = 0x0C22
```

---

## 7. TABLA DE REFERENCIA RÁPIDA

### Grupos de Instrucciones

**ALU Operations (0x0C04):**
```
ADD, SUB, MUL, DIV, NOR, AND, XOR, RSH, LSH
Único patrón: 0x0C04
EnREG=1, MEM=00, RoW=00, Imm=1, OV=0 (variable)
```

**Immediate Operations (0x0C02, 0x0C06):**
```
LDI:  0x0C02 (load immediate)
ADI:  0x0C06 (add immediate, con OV)
Ambas: Imm=1, EnREG=1
```

**Control Flow (0x0010-0x5C68):**
```
JMP:  0x0010 (salto simple)
BRH:  0x0020 (branch + evaluación)
CAL:  0x5C68 (call - guarda retorno)
RET:  0x2410 (return)
```

**Memory Access (0x0C32, 0x0C22):**
```
LOD:  0x0C32 (load, RoW=01)
STR:  0x0C22 (store, RoW=10)
Ambas: Imm=1, EnREG=1
```

**System Instructions (0x8C00, 0x2400, 0x0440):**
```
CYE:  0x8C00 (copy especial a normal, A==1)
CYR:  0x2400 (copy normal a especial)
SCL:  0x0440 (syscall, Kernel=1)
SRT:  0x0440 (return trap, Kernel=1)
```

---

## 8. DEPURACIÓN Y TESTING

### Verificar Control Words

Para cada instrucción, verificar:

```
1. ¿Es el datapath correcto?
   - ¿Se lee desde registros esperados?
   - ¿Se escribe en registro destino?
   - ¿Accede memoria si es LOD/STR?

2. ¿Son las banderas actualizadas?
   - ¿Se guarda Z/N/C/V?
   - ¿Se pueden leer con GOF?

3. ¿Se comporta el pipeline?
   - ¿Hay stalls por hazards?
   - ¿Se forwardea correctamente?

Teste cada grupo:
  [✓] ALU operations
  [✓] Memory operations
  [✓] Control flow
  [✓] Special instructions
```

### Test Program para Control Unit

```assembly
; Test de todas las instrucciones principales
NOP                    ; 00000: Debería ser no-op
LDI R1, 0x1234        ; 01100: Carga valor
LDI R2, 0x0005        ; 01100: Carga valor
ADD R3, R1, R2        ; 00010: Suma
ADI R3, 0x1000        ; 01101: Suma inmediato
LOD R4, [R1]          ; 10010: Lee memoria
STR R1, 0x0000, R4    ; 10011: Escribe memoria
JMP R3                ; 01110: Salto
HLT                   ; 00001: Halt
```

---

**Control Unit Documentation Complete. Para implementación, cargar tabla PLA en ROM de Logisim.**
