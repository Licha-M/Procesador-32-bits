# ⚡ Flujo de Excepciones e Interrupciones (Ciclo de Vida Completo)

Este documento describe el ciclo de vida completo de un error, excepción de memoria o interrupción de hardware: desde su detección física en el datapath hasta su resolución por el software del Kernel del Sistema Operativo.

---

## Decisiones Clave de Diseño en Hardware

- **Enrutamiento centralizado:** Todos los errores (Page Faults, OpCodes inválidos) e interrupciones de pines externos convergen hacia un único **`Excp Gen` (Controlador de Excepciones)** unificado en hardware.
- **Sin IDTR en hardware:** El registro `IDTR` fue eliminado del diseño. El cálculo vectorial para localizar las rutinas específicas de interrupción se realiza **completamente por software** una vez que el control es delegado al kernel. La "tabla de IDT" es, a todos los efectos, una tabla gestionada por el SO que usa la fórmula vectorizada conocida por el software.
- **Captura del EPC desde la etapa MEM:** Al ocurrir un fallo, el hardware siempre captura el *Exception Program Counter* (`EPC`) desde la etapa `MEM` en el momento del fallo. El Kernel es responsable de decidir si debe incrementarse en `+4` (para avanzar a la siguiente instrucción tras el fallo) o mantenerse igual (para reintentar la instrucción fallida), según la naturaleza del error.
- **Inyección dinámica de `SCL`:** Como respuesta inmediata a cualquier fallo o excepción detectada, el hardware **no genera señales caóticas**: en su lugar, **inyecta dinámicamente la instrucción `SCL` en el pipeline**. Esto fuerza una transición de modo segura y estructurada hacia el Kernel, limpiando el pipeline de instrucciones de usuario en vuelo.

---

## Vectores de Excepción (IDT por Software)

| Vector | Nombre | Tipo | Disparador de Hardware | Comportamiento del Sistema |
| :---: | :--- | :--- | :--- | :--- |
| **0** | **NOP (Sin Excepción)** | — | Estado de reposo o `SCL` intencional del usuario. | El registro `Cause` queda en `00`. El Kernel interpreta que fue una Syscall limpia del usuario. |
| **1** | **Page Fault LOD / Fetch** | Excepción | La MMU detecta `Present=0` o `KernelOnly=1` durante un `LOD` o `FETCH` de instrucción. | La dirección virtual fallida se guarda en `CR2`. El Kernel puede cargar la página y reintentar (EPC sin incrementar). |
| **2** | **Page Fault STR** | Excepción | La MMU detecta `Present=0`, `KernelOnly=1` o `ReadOnly=1` durante un `STR`. | Clave para `Copy-on-Write`. El Kernel decide si duplicar la página o terminar el proceso. |
| **3** | **General Protection Fault** | Excepción | Ejecución de instrucción privilegiada (`CYE`, `CYR`, `SCL`, `SRT`, acceso a `REGE`) con el flag de estado `Kernel = 0`. | Flush inmediato del programa de usuario. Evita la vulneración del espacio de memoria protegido. |
| **4** | **Invalid Opcode** | Excepción | El Decoder lee un patrón de bits de `OpCode` que no está asignado en la PLA/ROM. | Detiene la ejecución de binarios corruptos. El Decoder inyecta `SCL` con `Cause = 4`. |
| **5** | **Double Fault** | Excepción crítica | Una excepción ocurre mientras el hardware ya procesaba y limpiaba un fallo previo activo en el ISR. | "Freno de mano" del sistema: el SO debe abortar el proceso de forma inmediata para evitar *Triple Fault* (reset físico del procesador). |
| **6** | **Alignment Fault** | Excepción | La ALU o el controlador de memoria detecta que los bits `[1:0]` de una dirección de `LOD`/`STR`/salto no son `00`. | Se dispara en la etapa `MEM` (para `LOD`/`STR`) o en `IF` (para saltos mal alineados). |
| **7–15** | *(Reservados)* | — | Sin asignar. | Disponibles para extensiones futuras del hardware o el SO. |
| **16–127** | **Interrupciones externas** | Interrupción | Señales de hardware externas recibidas por el LAPIC (I/O APIC, Timer). | El LAPIC resuelve la prioridad y coloca el vector en `Cause` con el bit 31 en `1`. |

> 📌 **Distinción entre Syscalls, Excepciones e Interrupciones:**
>
> Cuando ocurre un salto al Kernel por `SCL` o por inyección del hardware, el Kernel examina el registro `Cause`:
> 1. Si `Cause == 0x00000000`, fue una **Syscall voluntaria**. El Kernel lee `R1` para determinar la función solicitada.
> 2. Si `Cause != 0` y **bit 31 = `0`**: es una **excepción síncrona** (las del ID 1–6 de la tabla). El Kernel ejecuta el manejador de excepción correspondiente.
> 3. Si `Cause != 0` y **bit 31 = `1`**: es una **interrupción externa asíncrona** (Timer, teclado, disco, etc.). El Kernel redirige al manejador de interrupción vectorizado por software.

---

## Diagrama de Flujo Completo (Hardware → Software)

```
┌─────────────────────────────────────────────────────────────────┐
│                     DETECCIÓN DEL EVENTO                         │
└─────────────────────────────────────────────────────────────────┘
          │                    │                    │
   Instrucción           Acceso a              Señal externa
   inválida / GPF        Memoria               (LAPIC IRQ)
          │                    │                    │
          ▼                    ▼                    │
  Decoder inyecta      MMU → Excp Gen              │
  SCL con Cause=4     escribe Cause (1/2/6)        │
          │                    │                    │
          └──────────┬─────────┘                    │
                     ▼                              ▼
          ┌──────────────────────┐    ┌─────────────────────────┐
          │  Excp Gen (Hardware) │    │  LAPIC escribe Cause    │
          │  - Flush del pipeline│    │  con bit31=1 (IRQ)      │
          │  - Guarda EPC        │    └──────────┬──────────────┘
          │  - Guarda Cause      │               │
          │  - Activa Kernel=1   │◄──────────────┘
          │  - Salta a SyS-JMP   │
          └──────────┬───────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│                    MODO KERNEL (SOFTWARE)                         │
│                                                                   │
│  El kernel lee Cause:                                             │
│                                                                   │
│   Cause == 0 ──────────────────▶ Resolver Syscall (R1)           │
│                                                                   │
│   Cause != 0, bit31 = 0 ───────▶ Manejador de Excepción          │
│      Vector 1: Page Fault LOD   (recargar página / matar proceso) │
│      Vector 2: Page Fault STR   (CoW / matar proceso)             │
│      Vector 3: GPF              (matar proceso)                   │
│      Vector 4: Invalid Opcode   (matar proceso)                   │
│      Vector 5: Double Fault     (Kernel Panic / abortar proceso)  │
│      Vector 6: Alignment Fault  (matar proceso)                   │
│                                                                   │
│   Cause != 0, bit31 = 1 ───────▶ Manejador de Interrupción       │
│      Fórmula vectorizada por SO  (EOI al final)                   │
│                                                                   │
│  Al finalizar: emitir SRT ────▶ Restaura PC desde EPC             │
└─────────────────────────────────────────────────────────────────┘
```

---

## Rutina Automática de Hardware al Detectar un Evento

Cuando el `Excp Gen` recibe una señal de excepción o el LAPIC activa `IRQ`:

1. **Inyección de `SCL`:** El hardware inserta la instrucción `SCL` en el pipeline (reemplazando la instrucción en vuelo que causó el error o la instrucción que seguía).
2. **Guardado del `EPC`:** Se captura la dirección de la instrucción problemática (etapa `MEM`) y se escribe en el registro especial `EPC` (`R1` en modo kernel).
3. **Guardado del `Cause`:** El identificador del vector de excepción/interrupción se escribe en el registro especial `Cause` (`R7` en modo kernel).
4. **Flush del pipeline:** Se invalidan (convierten en `NOP`) todas las instrucciones de usuario en vuelo en las etapas `IF`, `ID` y `EX`.
5. **Transición a Modo Kernel:** Se modifica el flip-flop de estado `Kernel` a `1`, activando las protecciones de acceso a `REGE`.
6. **Salto a `SyS-JMP`:** El `PC` es forzado a la dirección almacenada en el registro especial `SyS-JMP` (`R12`), que es el punto de entrada del manejador del kernel.

---

## Manejo del EPC por el Kernel

El hardware **siempre** guarda el `EPC` apuntando a la instrucción en la etapa `MEM` en el momento del fallo (la instrucción que causó el problema). El Kernel es responsable de:

| Tipo de fallo | Acción sobre EPC |
| :--- | :--- |
| **Page Fault (Vector 1/2)** | **Mantener EPC igual** para reintentar el `LOD`/`STR` tras cargar la página. |
| **Syscall (Vector 0)** | **Incrementar EPC en +4** para que `SRT` retorne a la instrucción siguiente al `SCL`. |
| **GPF / Invalid Opcode** | Normalmente el proceso se termina; el EPC indica la instrucción culpable para depuración. |
| **Interrupción externa** | **Mantener EPC igual** para retomar el programa de usuario exactamente donde fue interrumpido. |

---

## El Double Fault (`#DF`) — Vector 5

Si ocurre una **excepción síncrona** (bit 31 de `Cause` = 0) mientras ya hay una excepción activa en el ISR del LAPIC, y el sistema no puede guardar el nuevo contexto (por ejemplo, `SP` inválido o fallo de la MMU al acceder a la pila del kernel), el hardware detecta que el bit "en servicio" ya estaba activo para un evento crítico y dispara el **Vector 5 — Double Fault**.

En este caso, el SO debe optar por:
- **Abortar el proceso** afectado de forma inmediata.
- **Emitir un Kernel Panic** si el doble fallo ocurre dentro del propio kernel, para evitar entrar en un estado inconsistente o en un *Triple Fault* (que causaría un reset físico del procesador).
