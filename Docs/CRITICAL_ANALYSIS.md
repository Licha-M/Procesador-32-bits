# 🔬 Análisis Crítico de la Arquitectura

## Evaluación General

El diseño documentado representa una arquitectura de procesador de 32 bits altamente sofisticada para ser implementada en Logisim-Evolution. Implementar un pipeline de 5 etapas con bypassing, una MMU con TLB de política LRU, y un LAPIC con priorización combinacional es un desafío técnico de gran envergadura. El sistema mantiene rigurosamente un espacio de direccionamiento físico de 32 bits para el acceso a memoria, garantizando coherencia en el bus principal.

---

## Tabla de Análisis por Componente

### Pipeline y Hazards

**Fortalezas:**
- Excelente gestión de dependencias RAW mediante la red de **Bypass/Forwarding**. Evita paradas innecesarias en la mayoría de los casos, mejorando enormemente el IPC.
- La reutilización del mecanismo de `Flush` tanto para saltos como para excepciones es elegante y simplifica la lógica de control.

**Debilidades y cuellos de botella:**
- El esquema de **predicción estática de "no salto"** es el más simple posible. Cada salto tomado implica una penalización de 2–3 ciclos de pipeline vacíos (burbujas). En código con muchos bucles condicionales, esto impacta significativamente el IPC.
- Las instrucciones `LOD` consecutivas con dependencia RAW fuerzan obligatoriamente un stall de 1 ciclo que no puede ser evitado por el Bypass (el dato de RAM llega demasiado tarde).

**Soluciones propuestas:**
- Implementar un **Branch Target Buffer (BTB)**: una pequeña caché que recuerda si un salto fue tomado o no la última vez, permitiendo una predicción dinámica simple. Para bucles, la mejora sería significativa.
- Como alternativa más simple, una **predicción estática direccional**: saltos hacia atrás (bucles) siempre tomados; saltos hacia adelante (ifs) nunca tomados.

---

### Unidad de Control (PLA/ROM)

**Fortalezas:**
- La ROM/PLA combinacional permite una decodificación en un único ciclo sin lógica secuencial.
- La compartición de Control Words entre instrucciones ALU (`ADD`, `SUB`, `MUL`, `DIV`, `NOR`, `AND`, `XOR`, `RSH`, `LSH`) es eficiente: la selección final es delegada a la ALU mediante el OpCode, reduciendo la complejidad de la ROM.

**Debilidades:**
- Con solo 5 bits de OpCode (32 combinaciones), el espacio de instrucciones está casi completo (24 de 32 usados). Agregar nuevas instrucciones requeriría expandir el campo OpCode.
- Las correcciones detectadas en la Control Word de `SCL`/`SRT` respecto a la documentación previa sugieren que la ROM debe ser verificada cuidadosamente contra la planilla `Inst.xlsx`.

---

### Subsistema de Memoria (MMU y TLB)

**Fortalezas:**
- La implementación exacta de **LRU** garantiza que nunca se expulsen páginas útiles prematuramente, ofreciendo el comportamiento de caché óptimo teórico.
- El lookup **combinacional** del TLB evita latencias adicionales en el pipeline para el caso común (TLB hit), que debería ser la mayoría de los accesos en programas con buena localidad.
- La separación clara entre accesos de `Kernel` y `Usuario` a través del flag `Kernel` de la Control Word, verificado por la MMU en cada acceso, provee protección robusta.

**Debilidades y cuellos de botella:**
- **LRU exacto con 64 entradas:** Actualizar los campos de "edad" de todas las entradas en paralelo en cada hit requiere lógica proporcional a $O(N^2)$ en área. Para 64 entradas, esto genera un árbol de comparadores grande que puede limitar la frecuencia máxima en una implementación FPGA real.
- Un TLB miss requiere el **Page Walker** que realiza múltiples accesos a RAM, introduciendo stalls de varios ciclos. La frecuencia de misses depende críticamente del tamaño del conjunto de trabajo del programa.

**Soluciones propuestas:**
- Reducir las entradas del TLB a **16 o 32** para bajar el costo del LRU exacto.
- Reemplazar LRU exacto por **Pseudo-LRU** (árbol binario de bits de estado): con solo $log_2(N)$ bits de estado por entradas en lugar de $log_2(N)$ bits de edad, reduce el área de hardware aproximadamente a la mitad, con mínima degradación del rendimiento.
- Este es el estándar de la industria en procesadores reales (ARM Cortex-A, MIPS).

---

### Sistema de Excepciones e Interrupciones

**Fortalezas:**
- El aislamiento preciso entre fallos lógicos (Invalid Opcode en el Decoder) y fallos de hardware (Page Faults en la MMU), ambos delegados a un único `Excp Gen`, simplifica el control y asegura que el `Cause` siempre llegue correctamente al kernel.
- La inyección dinámica de `SCL` como respuesta a cualquier excepción es una solución elegante que reutiliza la infraestructura de syscalls existente, manteniendo un único punto de entrada al kernel.
- El manejo del `ISR` del LAPIC como "pila de prioridades" soporta correctamente el anidamiento de interrupciones.

**Debilidades:**
- La ausencia de `IDTR` en hardware implica que el SO no puede usar una tabla de descriptores de interrupción estándar. El vector de IDT debe ser calculado enteramente por software, lo que introduce latencia en el manejador del kernel (más instrucciones antes de saltar al manejador real).
- Si el `SP` es inválido en el momento de una excepción (por ejemplo, un proceso corrompió su propio stack pointer), el guardado de contexto fallará y se disparará un **Double Fault**, siendo difícil de recuperar sin un stack alternativo de emergencia.

**Soluciones propuestas:**
- Implementar un **IST (Interrupt Stack Table)**: una tabla adicional (ya referenciada en `TR`/`R11`) con stacks de emergencia alternativos para manejadores de doble fault u otras excepciones críticas, independientes del `SP` del proceso.
- Considerar agregar un registro `EPSW` que el hardware guarde automáticamente al ingresar al modo kernel, para proteger los `Eflags` y permitir manejadores de hoja que usen la ALU sin corromper el estado del usuario.

---

### LAPIC y Gestión de Prioridad

**Fortalezas:**
- Uso brillante de lógica combinacional (`Pri_Encoder`) para resolver la prioridad en un único paso sin lógica secuencial compleja.
- Soporte para hasta **128 vectores de interrupción** mediante los dos puertos `IO_APIC` de 64 líneas cada uno.
- El `TPR` permite al SO enmascarar grupos completos de interrupciones por prioridad en un solo registro, simplificando el manejo de secciones críticas.

**Debilidades:**
- El `Pri_Encoder` con buses de 128 bits implementado como un `for` combinacional puede generar problemas graves de *fan-in/fan-out* si se traslada a un FPGA real o ASIC.

**Soluciones propuestas:**
- Dividir la codificación de prioridad en un **árbol balanceado** de comparadores de 4 bits o 8 bits, formando un árbol de profundidad $log_2(128) = 7$ niveles. Esto convierte el problema de fan-in lineal en uno logarítmico, siendo estándar en la industria.

---

## Tabla Resumen de Fortalezas y Cuellos de Botella

| Componente | Fortaleza Principal | Cuello de Botella / Limitación | Solución Propuesta |
| :--- | :--- | :--- | :--- |
| **Pipeline + Bypass** | Excelente resolución de RAW, sin stalls en la mayoría de casos. | Predicción estática: penalización de 2–3 ciclos por salto tomado. | Branch Target Buffer (BTB) o predicción direccional. |
| **PLA/ROM de Control** | Decodificación en 1 ciclo, compartición eficiente de Control Words. | OpCode de 5 bits: solo 8 códigos libres para extensiones futuras. | Ampliar OpCode a 6 bits en una versión futura. |
| **MMU + TLB** | LRU exacto, lookup combinacional (cero latencia en hit). | LRU de 64 entradas: alto costo en área de hardware. | Pseudo-LRU o reducción a 16/32 entradas. |
| **Excepciones + SCL** | Unificación elegante vía inyección de `SCL`. | Sin IDTR: despacho de vector 100% por software (latencia extra). | Implementar registro `IDTR` o tabla de salto acelerada. |
| **LAPIC + Pri_Encoder** | Priorización en 1 ciclo combinacional para 128 vectores. | Fan-in de 128 bits en un solo paso puede no cerrar en FPGA. | Árbol balanceado de comparadores. |

---

## Plan de Pruebas del Sistema

### 1. Pruebas Unitarias de ALU y Bypass (RAW Test)

**Objetivo:** Verificar que el Bypass/Forwarding funciona correctamente para todos los tipos de dependencias RAW.

```asm
; Test 1: RAW entre instrucciones consecutivas
ADD  R3, R1, R2    ; R3 = R1 + R2  (escribe R3 en EX)
SUB  R4, R3, R5   ; R4 = R3 - R5  (debe leer R3 por Bypass, no del banco)

; Test 2: RAW con instrucción intermedia
MUL  R1, R2, R3
NOP
ADD  R4, R1, R5   ; Sin bypass, puede leer R1 desde WB normal

; Test 3: LOD consecutivos con dependencia (stall obligatorio de 1 ciclo)
LOD  R3, R1, #0   ; R3 = Mem[R1+0]
LOD  R4, R3, #0   ; R4 = Mem[R3+0]  → debe insertar 1 burbuja
```

**Criterio de éxito:** Los valores calculados deben ser correctos sin necesidad de insertar `NOP` manualmente (salvo el stall obligatorio de `LOD`→`LOD`).

---

### 2. Pruebas de Saltos y Pipeline Flush

**Objetivo:** Verificar que el Flush invalida correctamente las instrucciones especulativas y que no producen efectos secundarios en el estado del procesador.

```asm
; Test: Bucle con BRH
LDI  R1, #10      ; contador = 10
LDI  R2, #0       ; acumulador = 0
LOOP:
  ADD  R2, R2, R1  ; acumulador += contador
  ADI  R1, R1, #-1 ; contador--
  LDI  R3, #0      ; cargar cero para comparar
  BRH  NE, R_LOOP  ; si contador != 0, saltar a LOOP
```

**Criterio de éxito:** Las instrucciones que ingresaron especulativamente detrás del `BRH` no deben alterar ningún registro ni escribir en memoria cuando el salto se toma. El acumulador `R2` debe resultar en `55` (suma de 1 a 10).

---

### 3. Pruebas de la MMU (Page Fault y TLB LRU)

**Test de Page Fault STR (Vector 2):**
```asm
LDI  R1, #0xDEAD   ; dirección de una página no presente
LDI  R2, #42
STR  R1, R2, #0    ; debe disparar Vector 2 — Page Fault STR
```
**Criterio de éxito:** El procesador aborta la escritura, hace Flush, guarda `EPC` (instrucción `STR`) y salta al manejador del kernel con `Cause = 2`. El manejador puede incrementar `EPC` en `+4` para saltear el `STR` o terminar el proceso.

**Test de LRU con 65 páginas distintas:**
- Realizar accesos rotativos a 65 páginas distintas (una más que la capacidad del TLB).
- **Criterio de éxito:** La entrada desalojada en cada reemplazo debe ser matemáticamente la de `Age = 0` (la menos recientemente usada), verificando la correctitud del algoritmo LRU exacto.

---

### 4. Pruebas de Estrés de Interrupciones (LAPIC)

**Test de priorización:**
```
Disparar simultáneamente:
  - Interrupción de baja prioridad (ej. Timer, vector 16)
  - Interrupción de alta prioridad (ej. I/O crítico, vector 64)
```
**Criterio de éxito:** El `Pri_Encoder` debe activar `IRQ` con `Cause` apuntando al vector 64 (mayor prioridad). Tras el `EOI` del manejador del vector 64, el LAPIC debe despachar el vector 16.

**Test de anidamiento de interrupciones:**
- Mientras se procesa Int A (prioridad media), forzar la llegada de Int B (prioridad alta).
- **Criterio de éxito:** El ISR debe tener dos bits activos durante el procesamiento de Int B. Tras el EOI de Int B, el procesador retoma Int A exactamente donde fue interrumpida. Tras el EOI de Int A, el procesador retoma el programa de usuario.

---

### 5. Pruebas de Syscall y Cambio de Privilegio

```asm
; En modo usuario:
LDI  R1, #1        ; número de syscall
LDI  R2, #0x42    ; parámetro 1
SCL                 ; debe saltar a SyS-JMP con Kernel=1
; ... manejador en kernel ...
SRT                 ; debe retornar aquí con Kernel=0
```

**Criterio de éxito:** `EPC` debe apuntar a la instrucción siguiente al `SCL`. `SRT` debe restaurar el modo usuario (`Kernel = 0`) y reanudar desde `EPC`. Los registros de usuario `R0`–`R12` deben estar preservados tras el retorno (el kernel los guardó/restauró correctamente).

---

### 6. Pruebas de General Protection Fault (Vector 3)

```asm
; En modo usuario (Kernel=0):
CYR  R1, RE_REGE  ; intento de escribir un registro especial → debe disparar GPF
```

**Criterio de éxito:** La instrucción se aborta antes de escribir el registro especial, se dispara el Vector 3 con `Cause = 3`, y el kernel termina el proceso del usuario.
