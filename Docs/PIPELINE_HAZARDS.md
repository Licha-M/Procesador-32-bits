# 🔄 Pipeline Hazards - Análisis y Soluciones

Este documento analiza los problemas que pueden surgir en un pipeline de 5 etapas y cómo se resuelven en esta CPU.

---

## Conceptos Fundamentales

### ¿Qué es un Hazard?

Un **hazard** es una situación donde el pipeline no puede procesar instrucciones en forma secuencial sin que ocurran conflictos o resultados incorrectos.

**Tres tipos principales:**
1. **Data Hazards** - Conflictos de dependencias de datos
2. **Control Hazards** - Conflictos causados por saltos
3. **Structural Hazards** - Conflictos por recursos limitados

---

## 1. DATA HAZARDS (Hazards de Datos)

### Tipos de Dependencias de Datos

Cuando una instrucción depende del resultado de una anterior:

```
RAW (Read After Write) - Lectura después de escritura
  ADD R3, R1, R2    ; Escribe en R3
  SUB R4, R3, R5    ; Lee R3 (depende de ADD)

WAR (Write After Read) - Escritura después de lectura
  (Raro en pipeline forward, puede ocurrir en out-of-order)

WAW (Write After Write) - Escritura después de escritura
  (También raro con renombramiento de registros)
```

En este CPU nos enfocamos en **RAW**, que es el más común.

### Ejemplo: RAW Hazard

```
Ciclo 1:  IF[ADD R3,R1,R2]
Ciclo 2:  IF[SUB R4,R3,R5]  ID[ADD R3,R1,R2]
Ciclo 3:                      IF[SUB R4,R3,R5]  ID[...] EX[ADD]
Ciclo 4:                                         IF[...]  ID[SUB - LEE R3!]
                                                        EX[...] MEM[ADD - ESCRIBE R3]

Problema: En ciclo 4, SUB quiere leer R3, pero ADD no lo escribe hasta ciclo 5 (WB)
Resultado: SUB leería valor antiguo de R3 → INCORRECTO
```

### Solución 1: Stalling (Burbuja en Pipeline)

Insertar ciclos NOP hasta que dato esté disponible:

```
ADD R3, R1, R2
NOP                    ; Ciclo de espera
NOP                    ; Ciclo de espera
SUB R4, R3, R5         ; Ahora R3 es válido

Pipeline:
Ciclo 1: IF[ADD]
Ciclo 2: ID[ADD]       IF[NOP]
Ciclo 3: EX[ADD]       ID[NOP]        IF[NOP]
Ciclo 4: MEM[ADD]      EX[NOP]        ID[NOP]       IF[SUB]
Ciclo 5: WB[ADD]       MEM[NOP]       EX[NOP]       ID[SUB]
Ciclo 6:               WB[NOP]        MEM[NOP]      EX[SUB]

R3 está disponible en WB (ciclo 5), SUB lo usa en EX (ciclo 6) ✓
```

**Problema:** Muchos ciclos desperdiciados

### Solución 2: Forwarding (Bypass)

Pasar datos directamente desde etapas anteriores sin esperar WB:

```
ADD R3, R1, R2    ; EX: R3 ← R1 + R2 (resultado disponible fin de EX)
SUB R4, R3, R5    ; ID/EX: necesita R3

Pipeline con Forwarding:
┌────────────────────────────────────────┐
│ Ciclo 3: ADD en EX, resultado disponible│
│ Ciclo 4: SUB en EX, usa resultado de ADD│
└────────────────────────────────────────┘

Multiplexador en ALU redirige:
    Normal: ALU input = Reg[B]
    Forward: ALU input = Output_EX

Resultado: ADD R3... → FORWARD → SUB usa R3 correctamente
```

**Ventaja:** Sin ciclos desperdiciados

### Implementación de Forwarding

**Lógica de detección:**

```verilog
// Detector de dependencias (en etapa ID)
if (RegC_de_EX == RegA_actual) {
  forward_A = 1;  // Forwarde desde EX
} 
else if (RegC_de_MEM == RegA_actual) {
  forward_A = 1;  // Forwarde desde MEM
}

if (RegC_de_EX == RegB_actual) {
  forward_B = 1;  // Forwarde desde EX
}
else if (RegC_de_MEM == RegB_actual) {
  forward_B = 1;  // Forwarde desde MEM
}
```

**Multiplexor en ALU:**

```
                    Forward_A
                        │
    ┌───────────────────┼────────────┐
    │                   │            │
    ▼                   ▼            ▼
┌──────────┐      ┌──────────┐   ┌──────────┐
│ Reg[A]   │      │ Output_  │   │ Output_  │
│ (normal) │      │ EX       │   │ MEM      │
└──────────┘      └──────────┘   └──────────┘
    │                   │            │
    └───────────────────┼────────────┘
                        │
                        ▼
                    ALU Input A
```

### Caso: LOD Hazard (No puede forwardearse)

```
LOD R5, [address]  ; MEM: Accede RAM (dato no disponible en EX)
ADD R6, R5, R3     ; Quiere usar R5 inmediatamente

Pipeline:
Ciclo 1: IF[LOD]
Ciclo 2: ID[LOD]  IF[ADD]
Ciclo 3: EX[LOD]  ID[ADD]        IF[...]
Ciclo 4: MEM[LOD] EX[ADD - REQ R5] ID[...] (¡R5 no está listo!)
                  (Stall)

Solución: Stall de 1 ciclo
Ciclo 4: MEM[LOD]  STALL   ID[ADD]
Ciclo 5: WB[LOD]   EX[ADD] (ahora R5 está disponible)
```

### Tabla de Forwarding Disponible

| Instrucción N-1 | Instrucción N | Puede Forwarded? | Notas |
|---|---|---|---|
| ADD/SUB/MUL/DIV | Instrucción que usa resultado | SÍ | Desde EX o MEM |
| LDI/ADI | Instrucción que usa | SÍ | Desde EX |
| LOD | Inmediata siguiente | NO | Stall 1 ciclo necesario |
| CAL | RET | NO | Stall posible |
| Cualquiera | GOF (usa carry) | Parcial | Carry guardado en RE10 |

### Hazard de Escribir Después de Leer (WAR) - NO OCURRE

En nuestro pipeline forward, WAR no ocurre porque:
- Lecturas ocurren en ID (temprano)
- Escrituras ocurren en WB (tardío)
- Orden es respetado

```
ADD R2, R1, R3   ; Lee R1, R3 en ID
SUB R1, ...      ; Escribe R1 en WB

Orden: Lectura de R1 (ciclo 2) → Escritura de R1 (ciclo 5) ✓
```

---

## 2. CONTROL HAZARDS (Hazards de Control)

### Problema: Predicción de Saltos

El CPU **asume "no salto"** (next PC = PC + 4):

```
Ciclo N: IF fetch instrucción @ PC=X
         Predicción: siguiente @ X+4

Ciclo N+1: IF fetch @ X+4 (predicción)
           ID decodifica instrucción

Ciclo N+2: Si instrucción en ID es salto y DEBE saltar
           Pero ya tienen instrucciones equivocadas en IF, ID

           Verdadera dirección es X+100 (ejemplo)
           Predicción fue X+4 ← INCORRECTA
```

### Mecanismo: Detect & Flush

```
┌─────────────────────────────────────────────┐
│ Instrucción de salto llega a EX stage       │
├─────────────────────────────────────────────┤
│ EX calcula dirección real del salto         │
│                                             │
│ SI (dirección_real ≠ PC_predicho):         │
│   1. Generar FLUSH signal                   │
│   2. Cancelar IF, ID, EX stages            │
│   3. Cargar PC ← dirección_real            │
│   4. Fetch instrucciones desde nuevo PC    │
│                                             │
│ Costo: 2-3 ciclos de pipeline vacío        │
└─────────────────────────────────────────────┘
```

### Ejemplo: JMP Detectado Tardíamente

```assembly
LDI R7, 0x0100      ; Carga dirección destino
JMP R7              ; Salta a 0x0100
; Instrucción siguiente (predicción: no salto)
```

**Ejecución:**

```
Ciclo 1: IF[LDI @PC=0]     Pred_next=4
Ciclo 2: ID[LDI @PC=4]     IF[JMP @PC=4]    Pred_next=8
Ciclo 3: EX[LDI @PC=8]     ID[JMP @PC=8]    IF[NOP @PC=8] Pred_next=12
Ciclo 4: MEM[LDI @PC=12]   EX[JMP @PC=12]   ID[NOP @PC=12] IF[...@PC=12]
         (LDI escribe R7=0x0100)
Ciclo 5: WB[LDI]           MEM[JMP @PC=12]  EX[NOP @PC=12]

         En Ciclo 5, EX calcula: JMP target = R7 = 0x0100
         Pero predicción fue 0x0C, 0x10, 0x14...
         → MISMATCH DETECTADO

         FLUSH!!!
         IF ← Fetch @ 0x0100
```

### Penalty: 2-3 Ciclos

```
Ciclo 5: Detect error, generar flush
Ciclo 6: Pipeline vacío (no pueden ejecutar)
Ciclo 7: Pipeline vacío
Ciclo 8: Primeras instrucciones correctas arriban a EX

Total: 2-3 ciclos desperdiciados
```

### Comparación: Branch Prediction Actual vs Posible

**Actual (Asume no-salto):**
- Penalty cuando sí salta: 2-3 ciclos
- Efectivo si saltos son raros o no se toman

**Alternativa (BTB - Branch Target Buffer):**
- Caché de saltos anteriores
- Si en BTB: 0 ciclos de penalty
- Si no en BTB: 2-3 ciclos como actual
- Requiere lógica extra

**Trade-off:** Simplicidad vs Performance

---

## 3. STRUCTURAL HAZARDS (Hazards Estructurales)

### Definición

Cuando múltiples instrucciones compiten por el mismo recurso hardware simultáneamente.

### Análisis en Nuestro CPU

**Recursos Compartidos:**

| Recurso | Acceso Simultáneo? | Solución |
|---|---|---|
| Banco de Registros (lectura) | Sí (2 puertos R) | Múltiples puertos |
| Banco de Registros (escritura) | No (1 puerto W) | Serializar en WB |
| ALU | No (1 ALU) | No conflict (1 instr/ciclo) |
| Memoria (IF + MEM) | No | Separate Inst/Data caches |
| Forwarding paths | Sí (múltiples) | Suficientes multiplexores |

**Conclusión:** NO hay hazards estructurales significativos en diseño actual

Sin embargo, si se añadiera:
- Múltiples ALUs → competencia
- Shared memory → necesita arbitración
- Caché unificada → banco conflict

---

## 4. PIPELINE VISUALIZATION - CICLO A CICLO

### Programa Ejemplo

```assembly
; Programa con hazards
ADD R2, R1, R3         ; 0x00: R2 ← R1 + R3
SUB R4, R2, R5         ; 0x04: R4 ← R2 - R5 (RAW hazard)
LDI R1, 0x1234         ; 0x08: R1 ← 0x1234
LOD R6, [R1]           ; 0x0C: R6 ← [R1]
ADD R7, R6, R1         ; 0x10: R7 ← R6 + R1 (LOD hazard)
```

### Timeline

```
Ciclo  IF         ID         EX         MEM        WB
─────────────────────────────────────────────────────
1      ADD        -          -          -          -
2      SUB        ADD        -          -          -
3      LDI        SUB        ADD        -          -
4      LOD        LDI        SUB(FWD)   ADD        -
5      ADD        LOD(STALL) LDI        SUB        ADD
6      ADD        ADD        LOD        LDI        SUB
7      -          ADD        ADD        LOD        LDI
8      -          -          ADD        ADD        LOD
9      -          -          -          ADD        ADD

Notas:
- Ciclo 4: SUB usa forwarding desde EX (ADD result)
- Ciclo 5: Stall en LOD (no puede leer R1 antes de LDI escribir)
- Ciclo 5-8: LOD hazard requiere esperar 1 ciclo
```

### Detalle Ciclo 4 (Forwarding Activo)

```
┌──────────────────────────────────┐
│ CICLO 4                          │
├──────────────────────────────────┤
│                                  │
│ IF:  Fetch LOD @ 0x0C            │
│      PC ← 0x10                   │
│                                  │
│ ID:  Decodifica LDI              │
│      RegA=1, Imm=0x1234          │
│                                  │
│ EX:  Ejecuta SUB R4, R2, R5      │
│      ┌──────────────────────┐    │
│      │ Detecta: Reg C de   │    │
│      │ instrucción anterior│    │
│      │ (ADD) es R2, y SUB  │    │
│      │ intenta leer R2     │    │
│      │ → Forward desde EX! │    │
│      └──────────────────────┘    │
│                                  │
│      ALU_A ← Output_ADD (en vez de Reg[2])
│      ALU_B ← Reg[5]              │
│      SUB: Output = ALU_A - ALU_B │
│                                  │
│ MEM: Escribe result ADD en WB    │
│                                  │
└──────────────────────────────────┘
```

### Detalle Ciclo 5 (Stalling para LOD)

```
┌──────────────────────────────────┐
│ CICLO 5                          │
├──────────────────────────────────┤
│                                  │
│ IF:  (Posible) Fetch siguiente   │
│      Pero puede bloquearse       │
│                                  │
│ ID:  Decodifica LOD R6, [R1]     │
│      Necesita R1, pero LDI aún  │
│      no lo escribió              │
│      → STALL DETECTADO           │
│                                  │
│      Hazard Unit:               │
│      if (LOD usa R1 &&           │
│          LDI escribe R1 &&      │
│          LDI aún en EX) {        │
│        insert_bubble();          │
│      }                           │
│                                  │
│ EX:  LDI ejecutando              │
│      R1 ← 0x1234 (en progress)  │
│                                  │
│ MEM: SUB guardando resultado     │
│                                  │
│ WB:  ADD escribiendo R2          │
│                                  │
└──────────────────────────────────┘

Acción: IF/ID signals no avanzan
        Pipeline bubble en ID stage
```

---

## 5. PERFORMANCE IMPACT

### Cálculo de CPI (Ciclos Por Instrucción)

**Ideal (sin hazards):** CPI = 1.0

**Con hazards:**

```
CPI = 1 + (stalls por hazards datos) + (penalización saltos)
    = 1 + Σ(stall_latency × frequency_hazard)
        + Σ(flush_penalty × frequency_misprediction)

Ejemplo:
  10% de instrucciones son LOD
    → 10% × 1 ciclo stall = 0.1 CPI extra

  5% de saltos con 50% misprediction
    → 5% × 50% × 3 ciclos = 0.075 CPI extra

  CPI_real ≈ 1.0 + 0.1 + 0.075 = 1.175
```

### Comparación de Estrategias

**Stalling:**
- Latencia: Estricta (espera siempre)
- CPI: 1 + (hazard_freq × latency)
- Simplicidad: Media
- Área: Pequeña

**Forwarding:**
- Latencia: Reducida (forwarding cuando posible)
- CPI: 1 + (LOD_freq × 1) + (otras penalizaciones)
- Simplicidad: Media-Alta
- Área: Aumentada (multiplexores, lógica detección)

**Out-of-Order Execution:**
- Latencia: Mínima (ejecuta otras instrucciones)
- CPI: 1 + mínimo
- Simplicidad: Muy alta
- Área: Muy grande (unidad dispatch, reorder buffer)

---

## 6. ESTRATEGIAS DE MITIGACIÓN

### En Tiempo de Compilación (Software)

```assembly
; Ineficiente (hazard sin resolver)
ADD R2, R1, R3
SUB R4, R2, R5

; Eficiente (insertar instrucción útil)
ADD R2, R1, R3
LDI R6, 0x1000    ; Instrucción no relacionada
SUB R4, R2, R5    ; R2 ya disponible
```

### En Tiempo de Ejecución (Hardware)

1. **Detección de hazards** - Lógica combinacional
2. **Insertion de burbujas** - Control del pipeline
3. **Forwarding logic** - Redirigir datos
4. **Prediction** - Anticipar resultados

---

## Resumen de Hazards en Nuestro CPU

| Tipo | Ocurrencia | Solución | Penalty |
|---|---|---|---|
| RAW (ADD→SUB) | Frecuente | Forwarding | 0 ciclos |
| RAW (LOD→ADD) | Frecuente | Stall | 1 ciclo |
| RAW (CAL→RET) | Raro | Forwarding | 0-1 ciclos |
| Control (JMP) | 5-10% | Flush | 2-3 ciclos |
| Structural | Ninguno | - | - |

---

**Análisis completo de hazards y sus soluciones en el pipeline de 5 etapas.**
