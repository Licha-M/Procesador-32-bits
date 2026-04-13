# 📝 Examples - Ejemplos de Código Ensamblador

Este documento contiene ejemplos de código ensamblador para probar el CPU, organizados por complejidad.

**STATUS:** ⚠️ En desarrollo  
**Prerequisito:** Completar MMU para IF stage (ver `MEMORY_SYSTEM.md`)

---

## 0. ESTRUCTURA DE UN PROGRAMA

### Formato General

```assembly
; Programa simple para CPU de 32 bits
; Estructura:
;   1. Inicializar registros y memoria
;   2. Realizar operaciones
;   3. Saltar si es necesario
;   4. Halt cuando termina

; Convención:
;   - R0: Parámetro/retorno
;   - R1: Dirección de retorno (para funciones)
;   - R2-R6: Argumentos de función
;   - R14-R15: Guardado del kernel
;   - RE2: Stack Pointer

; Cómo ensamblar (futuro):
;   $ assembler programa.asm programa.bin
;   $ logisim-evolution CPU.circ
;   Cargar: programa.bin @ 0x00000000
```

---

## 1. PROGRAMAS TRIVIALES

### 1.1 - NOP (No Operation)

**Propósito:** Verificar que CPU arranca y ejecuta sin errores

```assembly
; Archivo: test_nop.asm
; Descripción: Programa que solo ejecuta NOP y se detiene
; Esperado: CPU ejecuta sin cambios

NOP
HLT
```

**Verificación:**
- [ ] CPU arranca en PC = 0x00000000
- [ ] Ejecuta NOP sin efectos
- [ ] Llega a HLT y se detiene

---

### 1.2 - Load Immediate

**Propósito:** Probar carga de valores inmediatos

```assembly
; Archivo: test_ldi.asm
; Descripción: Carga varios valores en registros
; Resultado: R1=0x1234, R2=0x5678, R3=-1

LDI R1, 0x1234    ; Carga positivo
LDI R2, 0x5678    ; Carga otro positivo
LDI R3, -1        ; Carga negativo (0xFFFFFFFF con sign extend)
HLT
```

**Verificación en Logisim:**
- [ ] R1 = 0x00001234
- [ ] R2 = 0x00005678
- [ ] R3 = 0xFFFFFFFF (extensión de signo desde -1)

---

## 2. OPERACIONES ARITMÉTICO-LÓGICAS

### 2.1 - Suma Simple

```assembly
; Archivo: test_add.asm
; Descripción: ADD básico
; Resultado: R3 = 8 (5 + 3)

LDI R1, 5         ; R1 = 5
LDI R2, 3         ; R2 = 3
ADD R3, R1, R2    ; R3 = R1 + R2 = 8
HLT
```

**Verificación:**
- [ ] R3 = 8

**Latencia observada:**
- Ciclo 1: IF[LDI R1, 5]
- Ciclo 2: IF[LDI R2, 3], ID[LDI R1, 5]
- Ciclo 3: IF[ADD], ID[LDI R2, 3], EX[LDI R1, 5]
- Ciclo 4: IF[HLT], ID[ADD], EX[LDI R2, 3], MEM[LDI R1, 5]
- Ciclo 5: ID[HLT], EX[ADD], MEM[LDI R2, 3], WB[LDI R1, 5]
- Ciclo 6: EX[HLT], MEM[ADD], WB[LDI R2, 3]
- Ciclo 7: MEM[HLT], WB[ADD]
- **Total: 7 ciclos para 3 instrucciones (IPC = 0.43)**

---

### 2.2 - Suma Múltiple (Suma Acumulativa)

```assembly
; Archivo: test_add_accum.asm
; Descripción: Suma 1+2+3+4+5
; Resultado: R1 = 15

LDI R1, 0         ; Acumulador = 0
ADI R1, 1         ; R1 += 1 = 1
ADI R1, 2         ; R1 += 2 = 3
ADI R1, 3         ; R1 += 3 = 6
ADI R1, 4         ; R1 += 4 = 10
ADI R1, 5         ; R1 += 5 = 15
HLT
```

**Verificación:**
- [ ] R1 = 15

---

### 2.3 - Resta

```assembly
; Archivo: test_sub.asm
; Descripción: SUB y manejo de negativos
; Resultado: R3 = -2 (3 - 5)

LDI R1, 3         ; R1 = 3
LDI R2, 5         ; R2 = 5
SUB R3, R1, R2    ; R3 = R1 - R2 = -2 = 0xFFFFFFFE
HLT
```

**Verificación:**
- [ ] R3 = 0xFFFFFFFE (complemento a 2 de -2)

---

### 2.4 - Multiplicación

```assembly
; Archivo: test_mul.asm
; Descripción: MUL 7 × 6
; Resultado: R3 = 42

LDI R1, 7
LDI R2, 6
MUL R3, R1, R2    ; R3 = 7 × 6 = 42
HLT
```

**Verificación:**
- [ ] R3 = 42

---

### 2.5 - División

```assembly
; Archivo: test_div.asm
; Descripción: DIV 20 / 3
; Resultado: R3 = 6 (resto descartado)

LDI R1, 20
LDI R2, 3
DIV R3, R1, R2    ; R3 = 20 / 3 = 6
HLT
```

**Verificación:**
- [ ] R3 = 6

---

### 2.6 - Operaciones Lógicas

```assembly
; Archivo: test_logic.asm
; Descripción: AND, XOR, NOR
; Resultado: Verificar bits resultantes

LDI R1, 0xF0F0    ; Patrón 1111_0000_1111_0000
LDI R2, 0x0FF0    ; Patrón 0000_1111_1111_0000

AND R3, R1, R2    ; R3 = 0x00F0 (solo bits comunes)
XOR R4, R1, R2    ; R4 = 0xFF00 (bits diferentes)
NOR R5, R1, R2    ; R5 = 0xF00F (negación de OR)

HLT
```

**Verificación:**
- [ ] R3 = 0x00F0
- [ ] R4 = 0xFF00
- [ ] R5 = 0xF00F

---

### 2.7 - Shifts

```assembly
; Archivo: test_shifts.asm
; Descripción: Shift izquierda y derecha
; Resultado: Multiplicación/división por potencias de 2

LDI R1, 0x0001    ; 1
LSH R2, R1, 4     ; R2 = 1 << 4 = 16

LDI R3, 0x0100    ; 256
RSH R4, R3, 3     ; R4 = 256 >> 3 = 32

HLT
```

**Verificación:**
- [ ] R2 = 16
- [ ] R4 = 32

---

## 3. DATA HAZARDS Y FORWARDING

### 3.1 - RAW Hazard con Forwarding

```assembly
; Archivo: test_forward.asm
; Descripción: Usa resultado inmediatamente
; Propósito: Verificar que forwarding funciona sin stalls

LDI R1, 10
LDI R2, 5
ADD R3, R1, R2    ; R3 = 15
ADD R4, R3, R1    ; HAZARD: R4 usa R3 que acaba de escribirse
                  ; Debería funcionar con forwarding (sin stall)
HLT
```

**Esperado:**
- [ ] R4 = 25
- [ ] Sin ciclos extra (forwarding desde EX)

**Timing:**
```
Ciclo  IF           ID           EX           MEM          WB
────────────────────────────────────────────────────────────
1      LDI R1,10
2      LDI R2,5     LDI R1,10
3      ADD R3       LDI R2,5     LDI R1,10
4      ADD R4       ADD R3       LDI R2,5     LDI R1,10
5      HLT          ADD R4(FWD)  ADD R3       LDI R2,5     LDI R1,10
6                   HLT          ADD R4(FWD)  ADD R3       LDI R2,5
7                                HLT          ADD R4       ADD R3
8                                             HLT          ADD R4

FWD = Forwarding desde EX stage
Resultado: Sin stalls, ADD R4 usa R3 desde forwarding
```

---

### 3.2 - LOD Hazard (Stall Necesario)

```assembly
; Archivo: test_lod_hazard.asm
; Descripción: Leer dato y usarlo inmediatamente
; Propósito: Observar stall de 1 ciclo

; Primero, preparar memoria (necesita MMU)
LDI R1, 0x2000    ; Dirección base
LDI R2, 0xDEAD    ; Dato a escribir
STR R1, R2        ; Guarda en memoria @ 0x2000

LOD R3, [R1]      ; Lee de 0x2000 → R3 = 0xDEAD
ADD R4, R3, R1    ; HAZARD: Necesita R3, pero LOD aún en MEM
                  ; Requiere 1 stall automático
HLT
```

**Esperado:**
- [ ] R3 = 0xDEAD
- [ ] R4 = 0xDEAD + 0x2000 = 0x2DEAD
- [ ] 1 ciclo de stall automático (detectable en traza)

---

## 4. CONTROL FLOW

### 4.1 - Jump Incondicional

```assembly
; Archivo: test_jmp.asm
; Descripción: Salto simple
; Propósito: Verificar JMP y predicción de saltos

LDI R1, 10
LDI R2, 20
JMP R7            ; SALTO incorrecto (predicción asume no-salto)
                  ; Detector en EX genera FLUSH
                  ; → 2-3 ciclos de penalización

; Esto no se ejecuta (por el salto)
LDI R3, 30

; Código de destino del salto
LDI R7, 0         ; Ubicación @ que salta R7
HLT
```

**Esperado:**
- [ ] R1 = 10
- [ ] R2 = 20
- [ ] R3 no se asigna (no se ejecuta)
- [ ] Penalty de 2-3 ciclos por flush

---

### 4.2 - Branch Condicional

```assembly
; Archivo: test_brh.asm
; Descripción: Salto condicional basado en banderas
; Propósito: Verificar BRH y evaluación de flags

LDI R1, 5
LDI R2, 5
SUB R3, R1, R2    ; R3 = 0 (resultado cero)
                  ; Actualiza flags: Z=1

BRH R3, then_label  ; Si Z=1, salta a then_label
                    ; Aquí Z=1, así que SALTA

; Código ELSE (no se ejecuta)
LDI R4, 100
JMP end_label

; Código THEN (se ejecuta)
then_label:
LDI R4, 200

end_label:
HLT
```

**Esperado:**
- [ ] R4 = 200 (rama THEN)
- [ ] No se ejecuta rama ELSE

---

### 4.3 - Bucle Simple

```assembly
; Archivo: test_loop.asm
; Descripción: Bucle que cuenta hacia atrás
; Propósito: Verificar loops y múltiples saltos

LDI R1, 5         ; Contador = 5
LDI R2, 0         ; Acumulador = 0

loop_start:       ; Etiqueta de inicio del bucle
ADD R2, R2, R1    ; Acumulador += contador
ADI R1, -1        ; Contador -= 1
BRH R1, loop_start ; Si contador != 0, vuelve
                  ; Salta si Z=0 (no es cero)

HLT
; Resultado: R2 = 5+4+3+2+1 = 15
```

**Esperado:**
- [ ] R2 = 15 (suma 5+4+3+2+1)
- [ ] Múltiples saltos (4 veces en bucle)

**Iterations:**
```
Iter 1: R1=5, R2=5, ADI→R1=4, salto atrás
Iter 2: R1=4, R2=9, ADI→R1=3, salto atrás
Iter 3: R1=3, R2=12, ADI→R1=2, salto atrás
Iter 4: R1=2, R2=14, ADI→R1=1, salto atrás
Iter 5: R1=1, R2=15, ADI→R1=0, Z=1 → Sin salto
End
```

---

## 5. LLAMADAS Y RETORNOS DE FUNCIONES

### 5.1 - Función Simple

```assembly
; Archivo: test_function.asm
; Descripción: Llamada a función y retorno
; Propósito: Verificar CAL y RET

LDI R2, 10        ; Argumento
CAL func          ; Llama función (PC+1 guardado en stack)

; De vuelta aquí
LDI R3, 99        ; Después de retorno
HLT

; Definición de función
func:
ADD R1, R2, R2    ; R1 = R2 + R2 = 20
RET               ; Retorna a CAL + 1
```

**Esperado:**
- [ ] R1 = 20
- [ ] Control retorna a después de CAL
- [ ] R3 se asigna después

---

### 5.2 - Función Recursiva (Factorial)

```assembly
; Archivo: test_factorial.asm
; Descripción: Calcula 4! = 24
; Propósito: Verificar recursión

; Convención:
;  R0: Entrada (N)
;  R1: Salida (N!)
;  R2-R6: Registros de trabajo

LDI R0, 4         ; Queremos 4!
CAL factorial     ; Llamar función

HLT

; factorial(N):
;   if (N <= 1) return 1
;   else return N * factorial(N-1)

factorial:
  ; Guardar N en stack (para cuando retorne recursión)
  LDI R5, SP      ; Guardar SP actual
  
  ; Base case
  LDI R2, 1
  SUB R3, R0, R2  ; R3 = N - 1
  BRH Z, base_case ; Si N-1 = 0 (es decir N=1), caso base
  
  ; Caso recursivo
  ADI R0, -1      ; N = N - 1
  CAL factorial   ; factorial(N-1)
  
  ; R1 ahora tiene (N-1)!
  LDI R2, (N original) ; Necesita guardar N
  MUL R1, R1, R2  ; R1 = R1 * N
  RET
  
base_case:
  LDI R1, 1       ; Base case: 0! = 1 o 1! = 1
  RET

; Nota: Esta versión simplificada
; Versión real requiere guardar registros en stack
```

**Esperado:**
- [ ] R1 = 24

---

## 6. ACCESO A MEMORIA

### 6.1 - Almacenamiento y Lectura

```assembly
; Archivo: test_memory.asm
; Descripción: Escribir y leer de memoria
; Propósito: Verificar STR y LOD

; Dirección de datos: 0x2000
LDI R1, 0x2000    ; Dirección base

; Escribir
LDI R2, 0xABCD    ; Dato a escribir
STR R1, 0, R2     ; Guarda R2 @ [R1 + 0] = 0x2000

LDI R3, 0x1234    ; Otro dato
STR R1, 4, R3     ; Guarda R3 @ [R1 + 4] = 0x2004

; Leer
LOD R4, 0, R1     ; Lee [R1 + 0] → R4 (espera: 0xABCD)
LOD R5, 4, R1     ; Lee [R1 + 4] → R5 (espera: 0x1234)

HLT
```

**Esperado:**
- [ ] RAM[0x2000] = 0xABCD
- [ ] RAM[0x2004] = 0x1234
- [ ] R4 = 0xABCD
- [ ] R5 = 0x1234

---

### 6.2 - Array Processing

```assembly
; Archivo: test_array.asm
; Descripción: Procesar array en memoria
; Propósito: Verificar loops con memoria

; Array @ 0x2000: [1, 2, 3, 4, 5]
; Tamaño: 5 elementos × 4 bytes = 20 bytes

LDI R1, 0x2000    ; Base del array
LDI R2, 5         ; Contador (5 elementos)
LDI R3, 0         ; Acumulador = suma

loop:
LOD R4, 0, R1     ; R4 = [R1 + 0] (elemento actual)
ADD R3, R3, R4    ; suma += R4
ADI R1, 4         ; R1 += 4 (siguiente elemento)
ADI R2, -1        ; contador--
BRH R2, loop      ; Si contador != 0, continúa

; R3 = 1+2+3+4+5 = 15

HLT
```

**Esperado:**
- [ ] R3 = 15

---

## 7. SISTEMA Y KERNEL (Futuro)

Estos ejemplos requieren implementación completa de excepciones.

### 7.1 - Syscall

```assembly
; Archivo: test_syscall.asm
; Descripción: Llamar al kernel
; Nota: Requiere handler de kernel

LDI R0, 1         ; Syscall #1 (ejemplo: print)
LDI R1, msg       ; Dirección de mensaje
SCL               ; Trap al kernel

; De vuelta en user mode
HLT
```

---

## 8. PLAN DE TESTING PROGRESIVO

### Fase 1: Instrucciones Básicas ✅
- [ ] test_nop.asm
- [ ] test_ldi.asm
- [ ] test_add.asm
- [ ] test_sub.asm

### Fase 2: Operaciones ALU
- [ ] test_mul.asm
- [ ] test_div.asm
- [ ] test_logic.asm
- [ ] test_shifts.asm

### Fase 3: Hazards y Pipeline
- [ ] test_forward.asm (forwarding)
- [ ] test_lod_hazard.asm (stall)
- [ ] test_loop.asm (múltiples saltos)

### Fase 4: Control de Flujo
- [ ] test_jmp.asm
- [ ] test_brh.asm
- [ ] test_function.asm

### Fase 5: Memoria y MMU (REQUIERE COMPLETAR MMU EN IF)
- [ ] test_memory.asm
- [ ] test_array.asm
- [ ] test_factorial.asm

### Fase 6: Kernel y Excepciones
- [ ] test_syscall.asm
- [ ] test_exception.asm

---

## 9. HERRAMIENTAS PARA TESTING

### Simulación en Logisim

```bash
# Abrir CPU
logisim-evolution /Core/Pipeline.circ

# Pasos para probar:
1. Cargar programa:
   - Opciones → Preferencias → Memoria
   - Cargar programa.bin a dirección 0x00000000

2. Ejecutar paso a paso:
   - Ctrl+K: Un ciclo
   - Ctrl+L: Ejecutar
   - F10: Detener

3. Inspeccionar estado:
   - Ver registros en Banco_Registros
   - Ver RAM en MEM.circ
   - Ver PC en IF stage
   - Ver banderas en Eflags
```

### Verificación Manual

```
Después de ejecutar programa:
1. ¿Están los registros esperados?
   - Inspect Registros.circ → R1, R2, R3, etc.

2. ¿Está la memoria modificada?
   - Inspect MEM.circ → RAM[0x2000], etc.

3. ¿Es el timing correcto?
   - Contar ciclos en timeline
   - Comparar con predicción de latencia

4. ¿Se detiene el CPU?
   - HLT debe parar el reloj
```

---

## 10. PRÓXIMOS PASOS

1. **Completar MMU para IF** (Ver `MEMORY_SYSTEM.md`)
   - [ ] Integrar traslador en IF stage
   - [ ] Testing sin paginación (CR0.PG=0)
   - [ ] Testing con paginación (CR0.PG=1)

2. **Escribir Ensamblador**
   - [ ] Parser de sintaxis .asm
   - [ ] Generador de código binario
   - [ ] Manejo de etiquetas y referencias

3. **Crear más ejemplos**
   - [ ] Desde Fase 5 en adelante
   - [ ] Programas más complejos
   - [ ] Benchmark de performance

4. **Documentar resultados**
   - [ ] Screenshots de ejecución
   - [ ] Timing diagrams
   - [ ] Análisis de performance

---

**Ejemplos en desarrollo. Completar MMU y crear Fase 5-6 después.**
