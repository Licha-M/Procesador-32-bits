# 📘 ISA Guide - Referencia Completa del Conjunto de Instrucciones

Este documento proporciona una referencia detallada para cada instrucción, con ejemplos de uso, formatos, y casos especiales.

---

## Convención de Notación

```
R[x]     = Contenido del registro x
[addr]   = Contenido de la memoria en dirección addr
←        = Asignación / operación
←⏱       = Asignación con actualización de banderas
PC       = Program Counter (contador de programa)
SP       = Stack Pointer (RE2)
∧        = AND lógico
∨        = OR lógico
⊕        = XOR lógico
<<, >>   = Shift izquierda/derecha
```

---

## FORMATO GENÉRICO DE INSTRUCCIONES

### Instrucción de Tipo R (Registro)

Operaciones entre registros:

```
Bits:  31-29  28-24  23-20  19-16  15-12  11-0
       Type   OpCode RegA   RegB   RegC   (reserved)

Ejemplo: ADD R3, R1, R2
         001  00010  0001   0010   0011   000000000000
```

### Instrucción de Tipo I (Inmediato)

Con valor inmediato:

```
Bits:  31-29  28-24  23-20  19-0
       Type   OpCode RegA   Immediato(16 bits)

Ejemplo: LDI R5, 0x1234
         001  01100  0101   0000000100100100
```

### Instrucción de Tipo J (Salto)

Control de flujo:

```
Bits:  31-29  28-24  23-20  19-16  15-0
       Type   OpCode RegA   RegB   (offset/reserved)

Ejemplo: JMP R7
         010  01110  0000   0111   0000000000000000
```

---

## 🔢 INSTRUCCIONES ARITMÉTICA

### ADD - Suma

**Sintaxis:** `ADD Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← R[A] + R[B]`

**Formato:**
```
31-29: 001 (Type)
28-24: 00010 (OpCode)
23-20: Número de Reg A
19-16: Número de Reg B
15-12: Número de Reg C
11-0:  Reservado
```

**Ejemplo:**
```assembly
ADD R3, R1, R2
; R3 = R1 + R2
; Si R1 = 0x00000005 y R2 = 0x00000003
; Entonces R3 = 0x00000008

Codificación binaria:
0x8208C00
001 00010 0001 0010 0011 000000000000
```

**Banderas actualizadas:**
- Z (Zero): 1 si resultado = 0
- N (Negative): 1 si bit 31 = 1
- C (Carry): 1 si hay overflow sin signo
- V (Overflow): 1 si overflow con signo

**Latencia:** 1 ciclo

**Notas:**
- Operación de 32 bits (suma modular)
- Resultado truncado a 32 bits
- Carry guardado en RE10 para instrucción GOF

---

### SUB - Resta

**Sintaxis:** `SUB Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← R[A] - R[B]`

**Ejemplo:**
```assembly
SUB R4, R5, R6
; R4 = R5 - R6
; Si R5 = 0x00000010 y R6 = 0x00000007
; Entonces R4 = 0x00000009

Codificación:
001 00011 0101 0110 0100 000000000000
```

**Banderas:** Z, N, C, V (mismo que ADD)

**Latencia:** 1 ciclo

**Notas:**
- Para números negativos: usar resta con número negativo
- Si A < B → resultado es 2^32 - (B - A) (complemento a 2)

---

### MUL - Multiplicación

**Sintaxis:** `MUL Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← (R[A] × R[B]) mod 2^32`

**Ejemplo:**
```assembly
MUL R1, R2, R3
; R3 = R1 × R2 (resultado truncado a 32 bits)
; Si R1 = 0x00000004 y R2 = 0x00000005
; Entonces R3 = 0x00000014 (20 en decimal)
```

**Banderas:** Z, N (truncado)

**Latencia:** 1 ciclo (multiplicador pipelined)

**Notas:**
- Resultado de 64 bits truncado a los 32 bits bajos
- Bits altos se descartan (no guardados en registro)
- Para multiplicación sin signo: use MUL directamente
- Para multiplicación con signo: extienda signos manualmente

---

### DIV - División

**Sintaxis:** `DIV Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← R[A] / R[B]` (división entera)

**Ejemplo:**
```assembly
DIV R1, R2, R3
; R3 = R1 / R2 (cociente entero)
; Si R1 = 0x0000000E (14) y R2 = 0x00000003 (3)
; Entonces R3 = 0x00000004 (4, resto descartado)
```

**Banderas:** Z, N

**Latencia:** 1 ciclo (divisor pipelined)

**Excepciones:**
- Si R[B] = 0 → **DIVIDE_BY_ZERO exception**
  - PC guardado en EPC (RE1)
  - Handler ejecutado
  - Instrucción se reintenta o salta a handler

**Notas:**
- División entera (sin punto flotante)
- Resto se descarta (no disponible)
- Para números negativos: comportamiento dependiente de implementación

---

## 🔧 INSTRUCCIONES LÓGICAS Y DESPLAZAMIENTO

### AND - AND Lógico

**Sintaxis:** `AND Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← R[A] ∧ R[B]` (bit a bit)

**Ejemplo:**
```assembly
AND R1, R2, R3
; R3 = R1 AND R2
; Si R1 = 0b11110000 y R2 = 0b10101010
; Entonces R3 = 0b10100000

Uso práctico: Máscara de bits
  MOV R1, 0xFF00FF00  (carga máscara)
  AND R2, R1, R2      (mascara bits de R2)
```

**Latencia:** 1 ciclo

**Banderas:** Z, N

---

### OR - OR Lógico

**Sintaxis:** No implementado directamente, usar NOR dos veces o con AND**

Opción: Usar NOR(NOR(A, 0), NOR(B, 0)) = A ∨ B

---

### XOR - XOR Lógico

**Sintaxis:** `XOR Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← R[A] ⊕ R[B]`

**Ejemplo:**
```assembly
XOR R1, R2, R3
; R3 = R1 XOR R2
; Bit-by-bit diferencia

Uso: Alternar bits
  XOR R1, R1, R1    ; Limpia R1 (XOR consigo mismo = 0)
  XOR R2, R3, R2    ; Invierte ciertos bits de R2
```

**Latencia:** 1 ciclo

**Notas:**
- `XOR Reg, Reg, Reg` es forma eficiente de limpiar registro a 0

---

### NOR - NOR Lógico

**Sintaxis:** `NOR Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← ¬(R[A] ∨ R[B])`

**Ejemplo:**
```assembly
NOR R1, R2, R3
; R3 = NOT(R1 OR R2)
; Si R1 = 0x000000FF y R2 = 0x0000FF00
; Entonces R3 = 0xFFFF0000
```

**Latencia:** 1 ciclo

**Notas:**
- NOR es puerta universal (puede implementar cualquier función lógica)
- `NOR R0, R0, Reg` = NOT(Reg) cuando R0=0

---

### LSH - Left Shift (Desplazamiento Izquierda)

**Sintaxis:** `LSH Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← R[A] << R[B]`

(Desplaza R[A] hacia la izquierda R[B] posiciones, rellena con ceros)

**Ejemplo:**
```assembly
LSH R1, R2, R3
; R3 = R1 << R2
; Si R1 = 0x00000001 y R2 = 4
; Entonces R3 = 0x00000010

Uso: Multiplicar por potencia de 2
  LSH R1, 2, R1    ; R1 = R1 * 4 (shift 2 posiciones)
```

**Latencia:** 1 ciclo

**Notas:**
- Bits que salen a la izquierda se pierden
- Relleno con ceros

---

### RSH - Right Shift (Desplazamiento Derecha)

**Sintaxis:** `RSH Reg_A, Reg_B, Reg_C`

**Operación:** `R[C] ← R[A] >> R[B]`

(Desplaza R[A] hacia la derecha R[B] posiciones)

**Ejemplo:**
```assembly
RSH R1, R2, R3
; R3 = R1 >> R2 (shift lógico, relleno con ceros)
; Si R1 = 0x00000010 y R2 = 2
; Entonces R3 = 0x00000004

Uso: Dividir entre potencia de 2
  RSH R1, 1, R1    ; R1 = R1 / 2
```

**Latencia:** 1 ciclo

**Notas:**
- Shift lógico (relleno con ceros, sin extensión de signo)
- Bits que salen a la derecha se pierden
- Carry guardado en RE10

---

## 🚩 INSTRUCCIONES DE BANDERAS

### GOF - Get Overflow Flag

**Sintaxis:** `GOF Reg_A`

**Operación:** `R[A] ← RE10` (copia carry anterior)

**Ejemplo:**
```assembly
ADD R1, R2, R3    ; Operación que genera carry
GOF R4            ; R4 = carry anterior (0 o 1)
BRH R4, handler   ; Si carry, salta a handler

Formato:
001 01011 AAAA 0000 0000 000000000001
```

**Latencia:** 1 ciclo

**Notas:**
- Carga el carry flag (C) de la instrucción anterior en un registro
- Útil para aritmética de precisión múltiple
- Carry está en RE10, actualizado por instrucciones ALU

---

## 📥 INSTRUCCIONES INMEDIATO

### LDI - Load Immediate

**Sintaxis:** `LDI Reg_A, Immediato16`

**Operación:** `R[A] ← sign_extend(Immediato)`

**Ejemplo:**
```assembly
LDI R1, 0x1234
; R1 = 0x00001234 (extensión de signo)
; Si inmediato es 0xFFFF → R1 = 0xFFFFFFFF

Cargando valores grandes (32-bit):
  LDI R1, 0x1234      ; Carga 0x00001234
  LSH R1, 16, R1      ; Shift a la izquierda 16 bits
  ADI R1, 0x5678      ; Suma 0x5678 al resultado
  ; Ahora R1 = 0x12345678
```

**Formato:**
```
31-29: 001 (Type)
28-24: 01100 (OpCode)
23-20: Número de Reg A
19-0:  Inmediato (16 bits, extendido con signo a 32)
```

**Latencia:** 1 ciclo

**Notas:**
- Sign-extend: Si bit 15 = 1, bits 31-16 se llenan con 1s
- Útil para constantes pequeñas
- Para valores grandes (32-bit), combinar con shifts

---

### ADI - Add Immediate

**Sintaxis:** `ADI Reg_A, Immediato16`

**Operación:** `R[A] ← R[A] + sign_extend(Immediato)`

**Ejemplo:**
```assembly
LDI R1, 0x0010      ; R1 = 0x00000010
ADI R1, 0x0005      ; R1 = 0x00000015
; Si R1 = 0x0100 y Inm = 0xFFFF (-1)
; Entonces R1 = 0x00FF (decremento)
```

**Formato:**
```
001 01101 AAAA IIII IIII IIII IIII IIII
```

**Latencia:** 1 ciclo

**Banderas:** Z, N, C, V

**Notas:**
- Modifica registro directamente
- Inmediato se extiende con signo (permite negativos)
- Útil para ajustes de dirección (stack, punteros)

---

## 🔀 INSTRUCCIONES CONTROL DE FLUJO

### JMP - Jump Incondicional

**Sintaxis:** `JMP Reg_B`

**Operación:** `PC ← R[B]`

(Salta a dirección almacenada en registro)

**Ejemplo:**
```assembly
LDI R7, 0x0100      ; Carga dirección destino en R7
JMP R7              ; Salta a 0x0100

Formato:
010 01110 0000 BBBB 0000 0000 0000 0000
        (OpCode)    (Reg destino)
```

**Latencia:** 1 ciclo

**Control Hazard:** 
- CPU asume "no salto"
- Si predicción incorrecta → flush (2-3 ciclos de penalización)

**Notas:**
- Destino debe ser dirección válida (en memoria de instrucciones)
- Direcciones alineadas a 4 bytes recomendadas (32-bit instructions)

---

### BRH - Branch Condicional

**Sintaxis:** `BRH Condición, Reg_B`

**Operación:**
```
SI (condición cierta):
  PC ← R[B]
SINO:
  PC ← PC + 4 (siguiente instrucción)
```

**Ejemplo:**
```assembly
ADD R1, R2, R3      ; Operación que actualiza banderas
BRH R9, R7          ; Si Z=1 (resultado=0), salta a R7

; Codificación:
; 010 01111 CCCC BBBB 0000 0000 0000 0000
;           (Cond) (Destino)

Condiciones soportadas (campo Reg A = condición):
  0000 = Z (resultado cero)
  0001 = N (resultado negativo)
  0010 = C (carry flag)
  0011 = V (overflow flag)
  0100 = Z ∨ N (cero o negativo)
  (otros bits = reserved)
```

**Latencia:** 1 ciclo

**Control Hazard:**
- Si predicción (no-salto) es incorrecta → flush

**Notas:**
- Evalúa banderas de operación anterior
- Útil para bucles y condicionales
- Requiere operación que actualice banderas antes

---

### CAL - Call (Llamada a Subrutina)

**Sintaxis:** `CAL Reg_B`

**Operación:**
```
1. Guarda PC+1 en stack (SP -= 4, [SP] = PC+1)
2. PC ← R[B]  (salta a función)
```

**Ejemplo:**
```assembly
LDI R7, funcion_dir     ; Dirección de función en R7
CAL R7                  ; Llama a función
; (control salta a funcion_dir)
; (dirección de retorno guardada en stack)

Formato:
010 10000 0000 BBBB 0000 0000 0000 0000
        (OpCode)   (Destino)

Control Word: 0101000110001000
  Bit 3 (CAL) = 1: almacena dirección retorno
  Bit 8-7 (RoW) = 11: escrita en stack
```

**Latencia:** 1 ciclo

**Notas:**
- Dirección de retorno guardada en RE2 (Stack Pointer)
- Debe usarse con RET para retornar
- Stack crece hacia direcciones más bajas (SP decrece)

---

### RET - Return (Retorno de Subrutina)

**Sintaxis:** `RET`

**Operación:**
```
1. PC ← [SP]  (recupera dirección de return)
2. SP += 4    (ajusta stack pointer)
```

**Ejemplo:**
```assembly
; Dentro de función...
ADD R1, R2, R3        ; Hace trabajo
RET                   ; Retorna a llamador

Formato:
010 10001 0000 0000 0000 0000 0000 0000
        (OpCode)
```

**Latencia:** 1 ciclo

**Control Word:** 0010000100000000
  Bit 9 (RET) = 1: habilita lógica de retorno

**Notas:**
- Recupera dirección guardada por CAL
- Restaura ejecución en punto de llamada
- Stack debe estar bien balanceado (CAL/RET pares)

---

## 💾 INSTRUCCIONES MEMORIA

### LOD - Load (Lectura de Memoria)

**Sintaxis:** `LOD Reg_A, Offset, Reg_B`

**Operación:**
```
dirección ← R[A] + sign_extend(Offset)
R[B] ← [dirección]  (lee datos de RAM)
```

**Ejemplo:**
```assembly
LDI R1, 0x1000        ; Base address en R1
LOD R1, 0x0004, R2    ; R2 = memoria[0x1004]
; Si memoria[0x1004] = 0xDEADBEEF
; Entonces R2 = 0xDEADBEEF

Lectura de array:
  LDI R1, base_array
  LOD R1, 0x0000, R2   ; primer elemento
  LOD R1, 0x0004, R3   ; segundo elemento (4 bytes después)
  LOD R1, 0x0008, R4   ; tercer elemento

Formato:
011 10010 AAAA BBBB IIII IIII IIII IIII
```

**Latencia:** 2 ciclos

**Excepciones:**
- Si dirección no está en tabla de páginas → **PAGE_FAULT**
  - Kernel carga página
  - Instrucción reintentada

**Notas:**
- Offset es 16-bit con signo (permite +/- direcciones)
- Acceso de 32 bits (word)
- Interactúa con MMU para traslación
- Forwarding disponible desde MEM stage

---

### STR - Store (Escritura en Memoria)

**Sintaxis:** `STR Reg_A, Offset, Reg_B`

**Operación:**
```
dirección ← R[A] + sign_extend(Offset)
[dirección] ← R[B]  (escribe datos en RAM)
```

**Ejemplo:**
```assembly
LDI R1, 0x2000        ; Dirección destino
LDI R2, 0x12345678    ; Dato a escribir
STR R1, 0x0000, R2    ; memoria[0x2000] = 0x12345678

Escritura de array:
  LDI R1, base_array
  LDI R2, 0xAAAAAAAA  ; dato
  STR R1, 0x0000, R2   ; escribe en [base_array]
  STR R1, 0x0004, R2   ; escribe en [base_array + 4]

Formato:
011 10011 AAAA BBBB IIII IIII IIII IIII
```

**Latencia:** 2 ciclos

**Excepciones:**
- PAGE_FAULT si página no está mapeada
- PROTECTION_FAULT si página es read-only

**Notas:**
- Escribe 32-bit word
- Requiere dirección y dato en registros
- Offset permite direccionamiento relativo

---

## ⚙️ INSTRUCCIONES SISTEMA/KERNEL

### CYE - Copy Especial a Normal

**Sintaxis:** `CYE Reg_E, Reg_A`

**Operación:** `R[A] ← RE[E]` (copia registro especial a normal)

**Ejemplo:**
```assembly
CYE RE1, R1      ; R1 = RE1 (copia EPC)
; Ahora R1 contiene dirección de excepción para inspeccionar

Formato:
100 10100 EEEE AAAA 0000 0000 0000 0000
        (OpCode)  (Esp) (Norm)
```

**Latencia:** 1 ciclo

**Privilegio:** Kernel only (RE6 bit 0 debe ser 1)

**Excepciones:**
- Si en user mode → PRIVILEGE_VIOLATION

**Notas:**
- Permite kernel leer registros de control
- Útil para inspeccionar estado del CPU

---

### CYR - Copy Normal a Especial

**Sintaxis:** `CYR Reg_A, Reg_E`

**Operación:** `RE[E] ← R[A]` (copia registro normal a especial)

**Ejemplo:**
```assembly
LDI R1, 0x80001000   ; Nueva dirección base pág
CYR R1, RE4          ; RE4 (CR3) = R1
; Ahora CR3 apunta a nueva tabla de páginas

Configurar stack:
  LDI R1, 0x10000    ; Dirección stack
  CYR R1, RE2        ; RE2 (SP) = 0x10000
```

**Latencia:** 1 ciclo

**Privilegio:** Kernel only

**Notas:**
- Modifica registros de control (CR0-CR6, IDTR, etc.)
- No debe permitirse en user mode

---

### SCL - Syscall

**Sintaxis:** `SCL`

**Operación:**
```
1. Guarda contexto:
   - PC en RE1 (EPC)
   - Flags en RE9 (Eflags)
   - Modo usuario en CR0
2. Cambia a modo kernel
3. Salta a handler de syscall (desde IDTR)
```

**Ejemplo:**
```assembly
LDI R0, 1           ; Syscall #1 (print)
LDI R1, puntero_str ; Argumento: puntero a string
SCL                 ; Trap al kernel
; Kernel maneja, luego ejecuta SRT para retornar

Formato:
100 10110 0000 0000 0000 0000 0000 0000
        (OpCode)
```

**Latencia:** Variable (depende handler)

**Contexto:**
- R0: Número de syscall (input)
- R1-R7: Argumentos
- R0: Resultado (output)

**Notas:**
- Mecanismo para aplicaciones user-mode llamar kernel
- Kernel valida argumentos antes de ejecutar
- Control Word bit 6 = 1 (modo kernel)

---

### SRT - Return from Trap

**Sintaxis:** `SRT`

**Operación:**
```
1. Restaura PC ← RE1 (EPC)
2. Restaura flags ← RE9 (Eflags)
3. Cambia a modo usuario (CR0 bit 0 = 0)
```

**Ejemplo:**
```assembly
; Handler de syscall o excepción...
; ... hace trabajo del kernel ...
SRT
; Retorna a aplicación user-mode
```

**Latencia:** Variable

**Formato:**
```
100 10111 0000 0000 0000 0000 0000 0000
        (OpCode)
```

**Notas:**
- Complemento de SCL
- Restaura estado de CPU
- Vuelve a user mode

---

## 🔄 INSTRUCCIONES ESPECIALES

### NOP - No Operation

**Sintaxis:** `NOP`

**Operación:** (nada - 1 ciclo)

**Ejemplo:**
```assembly
ADD R1, R2, R3
NOP              ; Espera 1 ciclo (para evitar hazard)
ADD R4, R1, R5   ; R1 ya está disponible

Formato:
000 00000 0000 0000 0000 0000 0000 0000
```

**Latencia:** 1 ciclo

**Notas:**
- Relleno para alinear instrucciones
- Puede usarse para resolver hazards manualmente
- Aunque forwarding y hazard detection reducen necesidad

---

### HLT - Halt

**Sintaxis:** `HLT`

**Operación:** (detiene CPU hasta interrupción)

**Ejemplo:**
```assembly
; Final de programa...
HLT              ; Espera indefinidamente
; CPU se detiene, vuelve a ejecutar si INT
```

**Formato:**
```
000 00001 0000 0000 0000 0000 0000 0000
```

**Latencia:** ∞ (hasta interrupción)

**Control Word:** 0000010000000000 (bit 10 = HLT)

**Notas:**
- Entrada de reloj deshabilitada
- Despierta con interrupción externa
- Útil para ahorro de energía

---

## 📋 TABLA RESUMEN DE INSTRUCCIONES

| Opcode | Mnemónico | Tipo | Operandos | Latencia | Flags |
|--------|-----------|------|-----------|----------|-------|
| 00000 | NOP | - | - | 1 | - |
| 00001 | HLT | - | - | ∞ | - |
| 00010 | ADD | R | A,B→C | 1 | Z,N,C,V |
| 00011 | SUB | R | A,B→C | 1 | Z,N,C,V |
| 00100 | MUL | R | A,B→C | 1 | Z,N |
| 00101 | DIV | R | A,B→C | 1 | Z,N |
| 00110 | NOR | R | A,B→C | 1 | Z,N |
| 00111 | AND | R | A,B→C | 1 | Z,N |
| 01000 | XOR | R | A,B→C | 1 | Z,N |
| 01001 | RSH | R | A,B→C | 1 | Z,N,C |
| 01010 | LSH | R | A,B→C | 1 | Z,N,C |
| 01011 | GOF | R | →A | 1 | - |
| 01100 | LDI | I | Imm→A | 1 | - |
| 01101 | ADI | I | A,Imm→A | 1 | Z,N,C,V |
| 01110 | JMP | J | Reg→PC | 1 | - |
| 01111 | BRH | J | Cond,Reg→PC | 1 | - |
| 10000 | CAL | J | Reg,→PC,stack | 1 | - |
| 10001 | RET | J | stack→PC | 1 | - |
| 10010 | LOD | I | [A+Off]→B | 2 | - |
| 10011 | STR | I | B→[A+Off] | 2 | - |
| 10100 | CYE | R | E→A | 1 | - |
| 10101 | CYR | R | A→E | 1 | - |
| 10110 | SCL | - | (trap) | Var | - |
| 10111 | SRT | - | (return) | Var | - |

---

## Guía de Uso Común

### Patrón: Bucle

```assembly
; Bucle que suma 10 veces
LDI R1, 10          ; R1 = contador = 10
LDI R2, 0           ; R2 = suma = 0
LDI R3, inicio      ; R3 = dirección de inicio del bucle

loop:
ADD R2, R1, R2      ; R2 += R1
ADI R1, -1          ; R1 -= 1
BRH R1, loop        ; Si R1 != 0, vuelve a loop
; Resultado: R2 = 10 + 9 + 8 + ... + 1 = 55
```

### Patrón: Función

```assembly
; Llamar función
funcion_dir:
  LDI R5, 0x1000    ; dirección función
  CAL R5            ; llama
  ; Retorna aquí

; Implementación función
funcion:
  ADD R2, R3, R1    ; R1 = R2 + R3
  RET               ; retorna
```

### Patrón: Condicional

```assembly
; IF-ELSE
CMP R1, R2          ; (hipotético: comparar)
                    ; O usar: SUB R1, R2, R0 (actualiza flags)
BRH R7, else_label  ; SI iguales, salta a else
ADD R3, R4, R3      ; THEN: R3 = R3 + R4
JMP end             ; salta a end
else_label:
SUB R3, R4, R3      ; ELSE: R3 = R3 - R4
end:
; Continúa...
```

---

**ISA Guide Completa. Para ejemplos ejecutables, ver `EXAMPLES.md`.**
