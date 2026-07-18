# Registro de Pruebas — CPU RISC 32-bit (Logisim)

Documento vivo para llevar el seguimiento de las pruebas de hardware, kernel y MMU del procesador. Se actualiza el **Estado** y **Resultado/Notas** de cada prueba a medida que se van ejecutando en Logisim.

**Leyenda:** ✅ Aprobada · 🔄 Creada / pendiente de ejecutar · ❌ Falló · ⬜ No iniciada

---

## 1. Pruebas preliminares (smoke tests)

Ya ejecutadas, en este orden, y las 3 aprobaron:

| # | Programa | Instrucciones / registros ejercitados | Estado |
|---|----------|----------------------------------------|--------|
| 1 | `Fibonacci.txt` | `LDI`, `ADD` (usando R0 como pasarela), `ADI`, `BRH !=` (bucle) | ✅ Aprobada |
| 2 | `Arreglo.txt` | `LDI`, `int STR` / `int LOD` con offset, `ADD`, `ADI`, `BRH !=` | ✅ Aprobada |
| 3 | `Subrutinas_CAL_RET.txt` | `LDI`, `CAL`, `RET`, `LSH` | ✅ Aprobada |

**Qué validaron:** ALU básica (`ADD`), carga de inmediatos, decremento de contador y salto condicional en bucle (Fibonacci); escritura/lectura en RAM con prefijo `int` en direcciones alineadas y acumulación en bucle (Arreglo); llamada/retorno de subrutina y shift lógico izquierdo (Subrutinas).

> Nota: estas 3 pruebas no siguen el plan formal de `Pruebas.txt` punto por punto, pero funcionan como línea base funcional (ALU, memoria, control de flujo) antes de entrar a las pruebas estructuradas de Fase 1–3 de abajo.

---

## 2. Plan formal de pruebas

### Fase 1 — Hardware Base (sin Kernel)

#### Prueba 1 — Lógica y Desplazamiento (compuertas de la ALU)
- **Estado:** 🔄 Creada y validada contra `assembler.py` (0 errores, 8 palabras), pendiente de ejecutar en Logisim
- **Motivo:** verificar `AND`, `NOR`, `XOR`, `RSH` con valores conocidos antes de introducir saltos complejos.
- **Qué probar:** ejecutar las 4 operaciones con valores conocidos y verificar los resultados en los registros normales.
- **Registros especiales:** ninguno (solo banco normal).
- **Resultado/Notas:** _(completar tras ejecutar)_

#### Prueba 2 — Banderas y Saltos Complejos (Eflags)
- **Estado:** 🔄 Creada y validada contra `assembler.py` (0 errores, 20 palabras — cada `BRH` con etiqueta se expande a 3 palabras usando R15/R14), pendiente de ejecutar en Logisim
- **Motivo:** comprobar que la ALU actualiza el registro de estado tras operaciones aritméticas y que el control de flujo responde a él.
- **Qué probar:** forzar una suma que desborde (overflow) y una resta que dé negativo. Validar que `BRH OV` y `BRH N` se ejecuten.
- **Registros especiales:** RE9 (Eflags) — el hardware debe actualizarlo automáticamente tras cada instrucción.
- **Resultado/Notas:** _(completar tras ejecutar)_

#### Prueba 3 — Captura de Acarreo y Ejecución Silenciosa
- **Estado:** 🔄 Creada y validada contra `assembler.py` (0 errores, 8 palabras — se confirmó bit a bit que `SLT ADD` codifica Tipo=100), pendiente de ejecutar en Logisim
- **Motivo:** asegurar que el bit 31 (prefijo `SLT`) evita que se modifiquen las banderas, y que el procesador puede recuperar un acarreo de una operación previa.
- **Qué probar:** suma normal que genere acarreo → `SLT ADD` (silenciosa) → `GOF` para volcar el acarreo a un registro normal.
- **Registros especiales:** RE10 (Carry) guarda el acarreo temporalmente; `GOF` lee de RE10; el prefijo `SLT` debe impedir que RE9 y RE10 se sobrescriban.
- **Resultado/Notas:** _(completar tras ejecutar)_

#### Prueba 4 — Acceso a Memoria Natural
- **Estado:** 🔄 Creada y validado contra `assembler.py` (0 errores, 15 palabras, y verifiqué bit a bit que char/short/int codifican el campo Tipo correcto (000/001/010))
- **Motivo:** validar los multiplexores de tamaño de memoria al leer/escribir en RAM.
- **Qué probar:** `LOD`/`STR` con prefijos `char`, `short` e `int` en direcciones alineadas (terminadas en `00`), verificando que se lea/escriba la fracción correcta de la palabra.
- **Registros especiales:** ninguno.
- **Resultado/Notas:** _(pendiente de diseñar)_

### Fase 2 — Transición y Transferencia (requiere modo Kernel)

#### Prueba 5 — Lectura/Escritura del Banco Especial
- **Estado:** ⬜ No iniciada — **bloqueada por una discrepancia a resolver primero** (ver nota abajo)
- **Motivo:** validar las rutas de datos entre el banco de registros normales y el especial vía `CYR`/`CYE`.
- **Qué probar:** escribir valores arbitrarios en registros especiales inofensivos y leerlos de vuelta.
- **Registros especiales:** RE0 debe devolver siempre 0 (cableado a tierra); RE13–RE15 (RegE Kernel) deben poder usarse libremente por el SO.
- **⚠️ Discrepancia encontrada en `assembler.py`:** `CYE` codifica 2 registros (`CYE R_especial, R_normal` → RC=especial, RA=normal), pero `CYR` solo acepta **1** operando (`CYR R0`, hint del propio ensamblador), codificando solo `RA (normal) → bits[23:20]`, sin ningún campo para indicar a qué registro especial se escribe. Esto no coincide con la tabla de instrucciones (que muestra `CYR REG A, REG E`, 2 operandos). Antes de escribir esta prueba conviene confirmar con vos si: (a) el hardware de `CYR` realmente solo usa un campo (y el especial destino está implícito/fijo en otro lado), o (b) es un bug pendiente en `assembler.py` que hay que corregir para que acepte 2 operandos como `CYE`.
- **Resultado/Notas:** _(pendiente de diseñar, depende de resolver lo anterior)_

### Fase 3 — Kernel Mínimo (vectores y entorno)

#### Prueba 6 — Excepciones Básicas y Causa
- **Estado:** ⬜ No iniciada
- **Motivo:** asegurar que el hardware detecta instrucciones ilegales o fallos lógicos y salta al vector correcto de la IDT.
- **Qué probar:** forzar un "Invalid Opcode" (instrucción no definida) y un "Alignment Fault" (`int STR` en dirección terminada en `01`).
- **Registros especiales:** RE7 (Cause) guarda el motivo exacto del fallo; RE8 (Especial Flags) refleja el cambio de contexto (modo previo vs. actual); RE2 (SP) debe estar inicializado antes vía `CYR`.
- **Resultado/Notas:** _(pendiente de diseñar)_

#### Prueba 7 — Cambio de Contexto y Syscalls
- **Estado:** ⬜ No iniciada
- **Motivo:** comprobar el flujo completo de petición de servicios al SO, desde la llamada hasta el retorno seguro.
- **Qué probar:** ejecutar `SCL` con parámetros en R1–R6; el kernel lee los parámetros, hace una tarea y vuelve con `SRT`.
- **Registros especiales:** RE12 (SyS-JMP) debe apuntar a la subrutina del sistema antes del `SCL`; RE1 (EPC) guarda automáticamente la dirección de retorno; RE11 (TR) opcional para localizar info de tarea.
- **Resultado/Notas:** _(pendiente de diseñar)_

#### Prueba 8 — Protección General y MMU
- **Estado:** ⬜ No iniciada
- **Motivo:** validar los sistemas de seguridad del procesador y el mapeo de memoria virtual.
- **Qué probar:** activar paginación, pasar a modo usuario, e intentar ejecutar una instrucción privilegiada (`HLT`) o acceder a una página no mapeada, forzando un Page Fault o un General Protection Fault.
- **Registros especiales:** RE6 (CR0) enciende la MMU; RE4 (CR3) apunta al árbol de paginación; RE3 (PCID) identifica el proceso; RE5 (CR2) guarda la dirección virtual que causó el fallo.
- **Resultado/Notas:** _(pendiente de diseñar)_

---

## 3. Archivos de prueba generados

- `Prueba_01_Logica_Desplazamiento.txt`
- `Prueba_02_Banderas_Saltos.txt`
- `Prueba_03_Carry_Silent.txt`

---

## 4. Notas de `assembler.py` (fuente de verdad)

Las Pruebas 1–3 se ensamblaron con el `assembler.py` real (modo CLI, 0 errores) y se verificó a mano la codificación en binario de las instrucciones clave (`BRH OV`, `BRH N`, `SLT ADD`). Cosas que el ensamblador deja más claras que las imágenes originales:

- **Condiciones completas de `BRH`** (campo de 4 bits): `=`/`EQ` (Zero), `!=`/`NE` (Not Zero), `N`/`NEG` (Negative), `NN`/`POS` (Not Negative), `C`/`CS` (Carry), `NC`/`CC` (Not Carry), `OV` (Overflow), `NOV` (Not Overflow). Antes solo teníamos confirmados `!=`, `OV` y `N` por los txt de ejemplo.
- **Prefijo `SLT`** (bit31=1, Tipo=100) solo es válido en: `ADD, SUB, MUL, DIV, NOR, AND, XOR, RSH, LSH, ADI`. Cualquier otro mnemónico con `SLT` da error de ensamblado.
- **Prefijos `H` / `L`** solo aplican a `LDI` (no a otras instrucciones) y sirven para cargar la mitad alta o baja de una dirección de 32 bits — es el mecanismo real detrás del "Bit31 = Alta/Baja" de la tabla de instrucciones.
- **Saltos con etiqueta (`JMP`, `BRH`, `CAL`) se expanden automáticamente a 3 palabras** usando **R15** (dirección final) y **R14** (temporal) como registros scratch. ⚠️ Si un programa usa etiquetas en saltos, **no debe guardar datos vivos en R14 ni R15** justo antes del salto, porque se sobrescriben. Ninguna de las 3 pruebas actuales usa R14/R15, así que están a salvo.
- `LDI` (sin prefijo `H`/`L`) usa un inmediato de 16 bits **sin signo** (0–65535); `ADI` usa 16 bits **con signo**.

## 5. Referencia rápida

### Nomenclatura de registros especiales

| # | Normal | Especial | Uso |
|---|--------|----------|-----|
| 0 | R0 | RE0 | Siempre 0 |
| 1 | R1 | EPC | Motivo de syscall / retorno de SRT |
| 2 | R2 | SP | Stack pointer |
| 3 | R3 | PCID | ID de proceso |
| 4 | R4 | CR3 | Base de tabla de páginas |
| 5 | R5 | CR2 | Dirección virtual fallida |
| 6 | R6 | CR0 | Control de la MMU |
| 7 | R7 | Cause | Causa de la excepción |
| 8 | R8 | Especial Flags | Flags de núcleo (modo previo/actual) |
| 9 | R9 | Eflags | Estado de la ALU |
| 10 | R10 | Carry | Acarreo de la operación anterior |
| 11 | R11 | TR | Dirección al TSS |
| 12 | R12 | SyS-JMP | Destino automático de `SCL` |
| 13–15 | R13–R15 | RegE Kernel | Uso libre del kernel |

### Bits de control

**CR0:** bit2 `En_Interrup` · bit1 `En_TLB` · bit0 `En_MMU`
**Flags de página:** bit3 `Global` · bit2 `KernelOnly` · bit1 `ReadOnly` · bit0 `Present`
**Especial Flags:** bit3 `Previous En_INTs` · bit2 `En_INTs` · bit1 `Previous Mode` · bit0 `Actual Mode`

### Vectores de IDT

| # | Nombre |
|---|--------|
| 0 | NOP (no excepción) |
| 1 | Page Fault LOD |
| 2 | Page Fault STR |
| 3 | General Protection Fault |
| 4 | Invalid Opcode |
| 5 | Double Fault |
| 6 | Alignment Fault |

---

## 6. Cómo actualizar este documento

1. Al ejecutar una prueba, cambiar su **Estado** (🔄 → ✅ o ❌) y llenar **Resultado/Notas** con los valores obtenidos y cualquier desviación del comportamiento esperado.
2. Si una prueba falla, dejar la nota del fallo y no marcarla ✅ hasta corregir y re-ejecutar.
3. Al diseñar las Pruebas 4–8, agregar sus archivos `.txt` a la sección 3 y enlazarlos aquí.
