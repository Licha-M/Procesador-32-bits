# Anotaciones de Diseño: Circuitos para el Sistema de Interconexión

> **Fecha:** 2026-06-16  
> **Referencia:** Basado en las notas del árbitro/NoC y el flujo NVMe/DMA/MSI.

A continuación se detallan las especificaciones de diseño para los tres circuitos que deben construirse: el **Controlador MMIO**, el **Sistema DMA** y el **Sistema MSI**. Cada circuito especifica sus entradas, salidas, destino de cada señal y la lógica interna que debe implementar.

---

## Índice

1. [Circuito 1 — Controlador MMIO](#circuito-1--controlador-mmio-address-decoder)
2. [Circuito 2 — Controlador y Sistema DMA](#circuito-2--controlador-y-sistema-dma-bus-master)
3. [Circuito 3 — Sistema de Conexión para Mensajes MSI](#circuito-3--sistema-de-conexión-para-mensajes-msi-iru)
4. [Integración Global](#integración-de-los-tres-circuitos-en-el-sistema-global)

---

## Circuito 1 — Controlador MMIO (Address Decoder)

### Propósito

Actuar como el **"router de memoria"**. Intercepta **toda** transacción de memoria que venga del pipeline del CPU, decodifica la dirección física y decide si el acceso va a RAM, ROM, LAPIC, I/O-APIC o a un periférico (NVMe, etc.). También bloquea el bypass de caché para accesos a rangos MMIO.

> **Escalabilidad y Jerarquías:** Para soportar cientos de periféricos sin requerir cientos de salidas individuales, este controlador no se conecta directamente a cada dispositivo final. En su lugar, sus salidas `CS_PERIFn` se conectan a **Concentradores (como un PCIe Root Complex** para dispositivos rápidos) o a **Puentes/Bridges (ej. AXI-to-APB** para múltiples dispositivos lentos). El puente se encarga de la sub-decodificación, de modo que decenas de dispositivos le cuestan al MMIO central un único puerto de salida.

---

### Entradas

| ID | Señal | Ancho | Origen | Descripción |
|----|-------|-------|--------|-------------|
| E1 | `ADDR_BUS` | 32 bits | Salida de la MMU (dirección física post-traducción) | Dirección física objetivo del acceso. Es la señal principal que el decodificador de rangos analiza para decidir el destino. |
| E2 | `WDATA` | 32 bits | Registro de fuente del pipeline (etapa MEM) | El dato que el CPU quiere escribir. Viaja en paralelo con la dirección pero solo se propaga al esclavo seleccionado. |
| E3 | `WEN` | 1 bit | Unidad de Control del pipeline | Write Enable. `'1'` indica operación de escritura. |
| E4 | `REN` | 1 bit | Unidad de Control del pipeline | Read Enable. `'1'` indica operación de lectura. |
| E5 | `BYTE_SEL[3:0]` | 4 bits (strobe) | Unidad de Control / decodificador de instrucción | Indica cuáles bytes del bus de 32 bits son válidos (soporta LB, LH, LW). |
| E6 | `VALID_REQ` | 1 bit | Pipeline (etapa MEM, handshake) | El pipeline indica que `ADDR_BUS` y las señales de control son estables y representan una petición real. Parte del protocolo VALID/READY. |
| E7 | `BAR_BASE_n[31:12]` × N | 20 bits × N | Firmware/BIOS durante el arranque (vía PMIO o ECAM) | Registros internos que guardan las bases de cada región MMIO asignada. No son entradas de bus externo; se cargan en boot. |

---

### Salidas

| ID | Señal | Ancho | Destino | Descripción |
|----|-------|-------|---------|-------------|
| S1 | `CS_RAM` | 1 bit | Controlador de Memoria DRAM (DMC) | Chip Select para la RAM. Activo cuando `ADDR_BUS` cae en el rango principal (ej. `0x00000000`–`0x3FFFFFFF`). |
| S2 | `CS_ROM` | 1 bit | Módulo Flash / Boot ROM | Chip Select para la ROM. Activo en el vector de reset (ej. `0xFFFF0000`–`0xFFFFFFFF`). Solo lectura. |
| S3 | `CS_LAPIC` | 1 bit | Módulo LAPIC | Chip Select para el LAPIC local. Activo en `0xFEE00000`–`0xFEE00FFF`. |
| S4 | `CS_IOAPIC` | 1 bit | Módulo I/O-APIC | Chip Select para el I/O-APIC. Activo en `0xFEC00000`–`0xFEC00FFF`. |
| S5 | `CS_PERIFn` | 1 bit × N | Puerto del periférico n en el bus PCIe / NoC | Un Chip Select por cada slot de periférico registrado en los BARs. Solo uno activo a la vez. |
| S6 | `LOCAL_ADDR[19:0]` | 20 bits | El esclavo activo | Bits bajos de `ADDR_BUS` tras enmascarar la base: el offset dentro del espacio del esclavo seleccionado. |
| S7 | `WDATA_OUT[31:0]` | 32 bits | El esclavo activo (vía árbol MUX) | Dato de escritura propagado al esclavo correcto. |
| S8 | `WEN_OUT` / `REN_OUT` | 1 bit c/u | El esclavo activo | Señales de control de escritura/lectura redirigidas al módulo esclavo seleccionado. |
| S9 | `RDATA_OUT[31:0]` | 32 bits | Registro de destino del pipeline (etapa WB) | Dato devuelto por el esclavo. El árbol de MUX selecciona la salida del esclavo activo. |
| S10 | `READY` | 1 bit | Pipeline (stall / handshake READY) | Indica que la transacción se completó. `'0'` = stall si el esclavo es lento; `'1'` cuando el esclavo confirma. |
| S11 | `IS_MMIO` | 1 bit | Pipeline (etapa EX/MEM) y Caché L1-D | Bandera que indica acceso MMIO (no RAM). La caché **no** cachea el acceso; el pipeline no usa valores obsoletos. |

---

### Lógica Interna

#### Paso 1 — Decodificación de Rangos *(Combinacional)*

Para cada transacción con `VALID_REQ='1'`, se evalúan comparadores de rango sobre `ADDR_BUS[31:12]` en paralelo:

```
if   ADDR_BUS in [RAM_BASE,  RAM_TOP]     -> activa CS_RAM
elif ADDR_BUS in [ROM_BASE,  ROM_TOP]     -> activa CS_ROM
elif ADDR_BUS == 0xFEE00xxx               -> activa CS_LAPIC
elif ADDR_BUS == 0xFEC00xxx               -> activa CS_IOAPIC
elif ADDR_BUS in [BAR_BASE_0, BAR_TOP_0]  -> activa CS_PERIF0
elif ADDR_BUS in [BAR_BASE_1, BAR_TOP_1]  -> activa CS_PERIF1
...
else -> ERROR / acceso inválido (genera excepción de bus)
```

> Solo **un** CS se activa a la vez (exclusión mutua garantizada por la estructura if-elif).

#### Paso 2 — Cálculo de Dirección Local

```
LOCAL_ADDR = ADDR_BUS XOR BAR_BASE_activo
             (equivalente: LOCAL_ADDR = ADDR_BUS[OFFSET_BITS-1:0])
```

Permite que el esclavo indexe su propia memoria interna desde `0`.

#### Paso 3 — Árbol de Multiplexores *(Enrutamiento de datos)*

- **Escritura:** `WDATA` se pasa al bus de entrada del esclavo activo. Los demás no reciben el dato (no se les activa `WEN`).
- **Lectura:** Las salidas de todos los esclavos alimentan un gran MUX controlado por los bits CS. Solo la salida del esclavo activo llega a `RDATA_OUT`.

> ⚠️ **Multiplexación vs. Tri-State:** En silicio moderno, el uso de cables eléctricos compartidos (*tri-state*) está prohibido por problemas de capacitancia y colisiones. En su lugar, se utilizan **árboles de multiplexores combinacionales**. Esto permite que las señales de cientos de periféricos se vayan "filtrando" en niveles sucesivos. El área física del circuito crece de forma logarítmica (en profundidad de niveles lógicos) y garantiza aislamiento eléctrico.

#### Paso 4 — Handshake READY/VALID

`READY` se genera combinacionalmente si el esclavo es síncrono (ROM de 1 ciclo) o con lógica secuencial (contador de espera) si el esclavo tiene latencia variable (DRAM, PCIe). El pipeline permanece en stall hasta recibir `READY='1'`.

#### Paso 5 — Flag IS_MMIO

```
IS_MMIO = NOT(CS_RAM OR CS_ROM)
```

Se envía al pipeline y al controlador de caché para suprimir el cacheado. Garantiza que cada `STR`/`LOD` a un periférico genera un acceso físico real.

---

## Circuito 2 — Controlador y Sistema DMA (Bus Master)

### Propósito

Permitir que un periférico (NVMe, GPU, tarjeta de red) lea y escriba datos directamente en la RAM sin intervención del CPU, liberando al pipeline de transferencias masivas. El DMA actúa como un **segundo maestro de bus** que compite con el CPU por el acceso al árbitro de interconexión.

> **Nota de diseño:** Se asume un DMA integrado en el NoC (estilo SoC), no un controlador externo tipo 8237. Cada periférico puede tener su propio motor DMA, o puede haber un DMA centralizado con múltiples canales.

---

### Entradas

| ID | Señal | Ancho | Origen | Descripción |
|----|-------|-------|--------|-------------|
| E1 | `DMA_REQ` | 1 bit × canal | El periférico (NVMe, GPU) | El periférico levanta esta línea para pedir permiso al árbitro del bus. Equivale al `DREQ` clásico o al *burst request* de AXI. |
| E2 | `DMA_ADDR[31:0]` | 32 bits | Registro de configuración del canal (escrito por CPU vía MMIO) | Dirección física de inicio en RAM donde el DMA debe leer/escribir. El CPU la configura antes de iniciar. |
| E3 | `DMA_LEN[19:0]` | 20 bits | Registro de configuración del canal | Número de bytes/palabras a transferir. El DMA cuenta internamente y para al llegar a cero. |
| E4 | `DMA_DIR` | 1 bit | Registro de configuración del canal | `'0'` = Periférico → RAM (NVMe deposita datos). `'1'` = RAM → Periférico (NVMe lee comandos). |
| E5 | `DMA_DATA_IN[31:0]` | 32 bits | El periférico (cuando `DMA_DIR='0'`) | Datos que el periférico quiere depositar en la RAM. |
| E6 | `BUS_GRANT` | 1 bit | Árbitro de bus (lógica de prioridad del NoC) | El árbitro confirma al DMA que puede usar el bus en este ciclo. |
| E7 | `RAM_READY` | 1 bit | Controlador de Memoria DRAM (DMC) | Handshake de la DRAM: indica que completó la operación; el DMA puede avanzar al siguiente beat. |
| E8 | `CPU_REQ` | 1 bit | Pipeline del CPU | El árbitro lo usa para saber si el CPU también quiere el bus (resolución de prioridad CPU vs DMA). |

---

### Salidas

| ID | Señal | Ancho | Destino | Descripción |
|----|-------|-------|---------|-------------|
| S1 | `DMA_ACK` | 1 bit × canal | El periférico solicitante | Confirma que la solicitud fue aceptada; el periférico puede comenzar a enviar/recibir datos. |
| S2 | `BUS_REQ` | 1 bit | Árbitro central del NoC | El controlador DMA pide el bus al árbitro central. Equivalente al `HOLD` de los DMA clásicos. |
| S3 | `RAM_ADDR[31:0]` | 32 bits | Controlador de Memoria DRAM (vía NoC) | Dirección en RAM para el siguiente acceso. Avanza automáticamente en cada beat de la ráfaga. |
| S4 | `RAM_WDATA[31:0]` | 32 bits | Controlador de Memoria DRAM | Dato a escribir en RAM (viene de `DMA_DATA_IN` cuando el periférico envía hacia RAM). |
| S5 | `RAM_WEN` | 1 bit | Controlador de Memoria DRAM | Write Enable hacia la DRAM, controlado por el DMA según `DMA_DIR`. |
| S6 | `DMA_DATA_OUT[31:0]` | 32 bits | El periférico (cuando `DMA_DIR='1'`) | Datos leídos de la RAM y entregados al periférico. |
| S7 | `DMA_DONE` | 1 bit × canal | Periférico y/o Sistema MSI | Se pulsa al terminar la transferencia completa (`DMA_LEN` llega a cero). Puede disparar una escritura MSI automática. |
| S8 | `CPU_STALL` | 1 bit | Pipeline del CPU | Se activa cuando el DMA tiene el bus y el CPU también lo necesita. El pipeline se congela hasta que el DMA lo libera. |
| S9 | `CACHE_INVALIDATE_ADDR[31:0]` | 32 bits | Controlador de caché L1-D / L2 | Cuando el DMA escribe en RAM, informa al sistema de caché para invalidar las líneas afectadas (protocolo MESI). |

---

### Lógica Interna

#### Bloque A — Árbitro de Prioridad *(Bus Arbiter)*

El DMA compite con el CPU por el bus. Política recomendada:

- **DMA tiene prioridad alta** cuando está en medio de una ráfaga (evita underrun/overrun en streaming).
- Fuera de ráfaga, el CPU tiene prioridad normal.

```
if DMA_REQ AND (BURST_IN_PROGRESS OR DMA_PRIORITY_HIGH):
    BUS_GRANT = DMA
    CPU_STALL = '1'
else if CPU_REQ:
    BUS_GRANT = CPU
    CPU_STALL = '0'
```

> Esta lógica vive dentro del NoC central y se conecta al DMA mediante `BUS_REQ` / `BUS_GRANT`.

#### Bloque B — FSM del Canal DMA *(Secuencial)*

```
┌─────────────────────────────────────────────────────────────────────┐
│  IDLE          ──► WAIT_GRANT    ──► ACTIVE_TRANSFER    ──► DONE   │
│                                                                     │
│  IDLE:                                                              │
│    Espera DMA_REQ. Al llegar:                                       │
│      CURRENT_ADDR ← DMA_ADDR                                        │
│      BEAT_COUNT   ← DMA_LEN                                         │
│      Levanta BUS_REQ                                                │
│                                                                     │
│  WAIT_GRANT:                                                        │
│    Espera BUS_GRANT='1'. El periférico aún no recibe ACK.           │
│                                                                     │
│  ACTIVE_TRANSFER:                                                   │
│    Pone CURRENT_ADDR en RAM_ADDR.                                   │
│    Si DMA_DIR='0' (Periférico→RAM):                                 │
│      activa RAM_WEN, propaga DMA_DATA_IN a RAM_WDATA.               │
│    Si DMA_DIR='1' (RAM→Periférico):                                 │
│      desactiva RAM_WEN, lee RAM y propaga dato a DMA_DATA_OUT.      │
│    En cada RAM_READY:                                               │
│      CURRENT_ADDR += 4                                              │
│      BEAT_COUNT   -= 1                                              │
│                                                                     │
│  DONE (cuando BEAT_COUNT == 0):                                     │
│    Pulsa DMA_DONE.                                                  │
│    Libera BUS_REQ (devuelve el bus).                                │
│    Pulsa CACHE_INVALIDATE_ADDR si DMA_DIR='0'.                      │
│    Vuelve a IDLE.                                                   │
└─────────────────────────────────────────────────────────────────────┘
```

#### Bloque C — Coherencia de Caché

En cada beat donde el DMA escribe en RAM (`DMA_DIR='0'`), `CURRENT_ADDR` se envía al controlador de caché como `CACHE_INVALIDATE_ADDR`. El controlador compara con las etiquetas de sus líneas y, si hay coincidencia, marca la línea como **INVALID** (protocolo MESI). Garantiza que la próxima lectura del CPU vaya a la RAM (datos frescos del DMA) y no a la caché (datos obsoletos).

---

## Circuito 3 — Sistema de Conexión para Mensajes MSI (IRU)

*MSI Translation / Interrupt Routing Unit*

### Propósito

Interceptar escrituras de memoria que son técnicamente **MSI** (*Message Signaled Interrupts*) y redirigirlas al controlador de interrupciones correcto (LAPIC del núcleo destino) en lugar de dejarlas ir a la RAM.

> Una MSI es simplemente una **escritura estándar de 32 bits** hacia la dirección `0xFEE00000` (x86) con un valor de vector especial. Este circuito es el que distingue esa escritura de una escritura RAM normal.

---

### Entradas

| ID | Señal | Ancho | Origen | Descripción |
|----|-------|-------|--------|-------------|
| E1 | `MSI_WRITE_ADDR[31:0]` | 32 bits | Árbitro/NoC central | Dirección de destino de cualquier transacción de escritura en el bus (CPU o DMA/periférico). Si cae en `0xFEE00000`–`0xFEEFFFFF`, la transacción es capturada. |
| E2 | `MSI_WRITE_DATA[31:0]` | 32 bits | El periférico/maestro de bus que genera la MSI | El "Vector de Interrupción" codificado como dato de memoria estándar. Incluye número de vector IRQ y bits de control (Edge/Level, Delivery Mode, etc.). |
| E3 | `MSI_WRITE_VALID` | 1 bit | Árbitro/NoC (handshake del canal de escritura) | Indica que `MSI_WRITE_ADDR` y `MSI_WRITE_DATA` son válidos y representan una transacción real. |
| E4 | `DEVICE_ID[N:0]` | N+1 bits (sideband) | Hardware del bus (PCIe Root Complex / NoC fabric) | Identifica **de forma inviolable** qué dispositivo generó la transacción. En PCIe se deriva del BDF (Bus:Device:Function). No puede ser falsificado por software. |
| E5 | `MSI_TABLE_ENTRY[DeviceID]` | Tabla interna | SO durante la inicialización del driver | Tabla RAM pequeña interna. Cada entrada almacena: `MSI_TARGET_LAPIC_ID`, `MSI_VECTOR`, `MSI_DELIVERY_MODE`, `MSI_MASKED`. El SO la configura vía MMIO. |

---

### Salidas

| ID | Señal | Ancho | Destino | Descripción |
|----|-------|-------|---------|-------------|
| S1 | `MSI_CAPTURE` | 1 bit | Árbitro/NoC central | Se activa cuando el módulo detecta una MSI válida. Le dice al NoC que **no** envíe esta escritura a la RAM; el módulo la ha capturado (*snoop hit*). |
| S2 | `LAPIC_INT_REQ` | 1 bit × LAPIC | Puerto de interrupción del LAPIC del núcleo destino | Inyecta la interrupción en el LAPIC correcto. El LAPIC destino se determina desde `MSI_TARGET_LAPIC_ID` de la tabla interna. |
| S3 | `LAPIC_VECTOR[7:0]` | 8 bits | LAPIC del núcleo destino | Número de vector de interrupción (0–255) que el LAPIC presentará al pipeline. Extraído de `MSI_WRITE_DATA` o de la tabla interna. |
| S4 | `LAPIC_DELIVERY_MODE[2:0]` | 3 bits | LAPIC | Modo de entrega: Fixed, SMI, NMI, INIT, ExtINT. Viene de la tabla MSI interna. |
| S5 | `MSI_ACK` | 1 bit | Periférico / maestro de bus que generó la MSI | Confirma al periférico que la MSI fue recibida y procesada. El periférico puede liberar su buffer de mensaje. |
| S6 | `MSI_ERROR` | 1 bit | Unidad de Control / registro de estado del sistema | Se activa si la escritura MSI no coincide con ninguna entrada válida o si el `DEVICE_ID` no tiene permiso para ese vector. Puede disparar una excepción al SO. |

---

### Lógica Interna

#### Paso 1 — Vigilancia del Bus *(Snoop Combinacional)*

El módulo monitorea continuamente `MSI_WRITE_ADDR` en el bus:

```
if MSI_WRITE_ADDR[31:20] == 0xFEE   // rango MSI de x86
   AND MSI_WRITE_VALID == '1':
    MSI_CAPTURE = '1'
    // El árbitro/NoC NO rutea esta escritura a la RAM
```

#### Paso 2 — Lookup en Tabla MSI *(Secuencial, 1–2 ciclos)*

Usando `DEVICE_ID` como índice:

```
TARGET_LAPIC = MSI_TABLE_ENTRY[DEVICE_ID].MSI_TARGET_LAPIC_ID
VECTOR       = MSI_TABLE_ENTRY[DEVICE_ID].MSI_VECTOR
DELIVERY     = MSI_TABLE_ENTRY[DEVICE_ID].MSI_DELIVERY_MODE
MASKED       = MSI_TABLE_ENTRY[DEVICE_ID].MSI_MASKED

if MASKED == '1':
    // Interrupción enmascarada; guardar como "pending"
    // No se propaga hasta que se desenmascara
```

#### Paso 3 — Validación de Seguridad

Se verifica que:
- `DEVICE_ID` exista en la tabla (entrada válida).
- El vector en `MSI_WRITE_DATA` coincida con el esperado en la tabla.  
  *(Evita que un dispositivo "secuestre" el vector de otro).*

```
if NOT(entry_valid) OR (MSI_WRITE_DATA.vector != VECTOR):
    MSI_ERROR = '1'
    // No se genera interrupción
```

#### Paso 4 — Despacho al LAPIC *(Secuencial)*

Con `TARGET_LAPIC` determinado, el módulo:
1. Activa `LAPIC_INT_REQ` del núcleo destino.
2. Presenta `LAPIC_VECTOR` y `LAPIC_DELIVERY_MODE` en el bus del LAPIC.
3. La FSM espera el ACK del LAPIC antes de emitir `MSI_ACK` al periférico.

#### Paso 5 — Handshake de Completado

```
// Una vez que el LAPIC confirma recepción:
MSI_ACK = '1'  // pulso de 1 ciclo
```

Esto cierra el ciclo de escritura del periférico. El periférico sabe que su interrupción fue entregada al sistema y libera su buffer MSI.

---

## Integración de los Tres Circuitos en el Sistema Global

```
[CPU Pipeline]
     │  ADDR_BUS, WDATA, WEN, REN, VALID_REQ
     ▼
[CONTROLADOR MMIO] ──────────► CS_RAM    ──► [DRAM Controller]
     │               ─────────► CS_ROM    ──► [Boot ROM]
     │               ─────────► CS_LAPIC  ──► [LAPIC]
     │               ─────────► CS_IOAPIC ──► [I/O-APIC]
     │               ─────────► CS_PERIFn ──► [NVMe / GPU / etc.]
     │  READY, RDATA_OUT ◄───── (respuestas de esclavos vía MUX)
     │  IS_MMIO ──────────────► [Caché L1-D]  (suprime caching)
     │
     ▼
[ÁRBITRO DE BUS / NoC]
     ▲              ▲
     │              │
[CPU Pipeline]  [CONTROLADOR DMA] ◄─── DMA_REQ, Config (de CPU vía MMIO)
                     │
                     ├── RAM_ADDR, RAM_WEN, RAM_WDATA ──► [DRAM Controller]
                     ├── CACHE_INVALIDATE_ADDR ─────────► [Caché L1-D]
                     ├── DMA_DONE ───────────────────────► [Sistema MSI]  (trigger)
                     └── CPU_STALL ──────────────────────► [CPU Pipeline]
                     │
              (Al terminar, NVMe genera escritura MSI)
                     │
                     ▼
[SISTEMA MSI / IRU]
     ├── MSI_CAPTURE ──────► [NoC]                  (bloquea escritura a RAM)
     ├── LAPIC_INT_REQ ────► [LAPIC del núcleo destino]
     ├── LAPIC_VECTOR ─────► [LAPIC]
     ├── MSI_ACK ──────────► [NVMe / periférico]
     └── MSI_ERROR ────────► [Registro de estado / excepción del SO]
```

### Árbitro de Bus (NoC) y Controlador de Memoria (DMC)

El Árbitro o Red en Chip (NoC) resuelve el problema de tener múltiples maestros y cientos de dispositivos interactuando simultáneamente:
- **Canales Compartidos y Arbitraje:** Los dispositivos no requieren conexiones físicas paralelas dedicadas para cada uno. Comparten los mismos cables del bus central divididos en canales multiplexados en el tiempo. El flujo se ordena mediante señales de *handshake* (`VALID`/`READY`) en cada ciclo de reloj.
- **El DMC como embudo final:** El Controlador de Memoria (DRAM) sí es un punto de congestión, pero no por el número de cables, sino por el ancho de banda. Toda la multitud de periféricos y DMA ya ha sido arbitrada y filtrada por el NoC antes de llegar al DMC. Por ende, el DMC no necesita miles de pines de entrada; solo ve una única cola ordenada de peticiones de alta velocidad.

### Flujo completo de una operación NVMe (resumen de integración)

| Paso | Quién actúa | Qué hace | Circuito involucrado |
|------|-------------|----------|----------------------|
| 1 | CPU | Escribe en el *Doorbell* del NVMe | **MMIO** → `CS_PERIFn` |
| 2 | NVMe | Pide el bus y lee el comando de la RAM por DMA | **DMA** → `BUS_REQ` / `BUS_GRANT` |
| 3 | NVMe | Busca datos en NAND y los escribe en RAM por DMA | **DMA** → `RAM_ADDR`, `RAM_WEN` |
| 4 | DMA | Invalida líneas de caché afectadas | **DMA** → `CACHE_INVALIDATE_ADDR` |
| 5 | NVMe | Escribe estado en cola de finalización por DMA | **DMA** → `DMA_DONE` |
| 6 | NVMe | Genera escritura MSI hacia `0xFEE00000` | **MSI/IRU** → `MSI_CAPTURE` → `LAPIC_INT_REQ` |
| 7 | LAPIC | Lanza la interrupción al pipeline del CPU | Pipeline atiende el *handler* del SO |

---

## Circuito 4 — Puente de Periféricos Lentos (Peripheral Bridge)

### Propósito

Implementar de forma práctica la jerarquía de buses descrita en el Controlador MMIO. Un puente (*Bridge*) recibe un único Chip Select desde el MMIO principal y realiza una **sub-decodificación** para controlar múltiples periféricos de baja velocidad (UART, Timers, GPIO) sin sobrecargar de puertos al árbitro central. Actúa como un sub-árbitro o embudo para dispositivos pequeños.

---

### Entradas (desde el MMIO Controller)

| Señal | Ancho | Descripción |
|-------|-------|-------------|
| `CS_BRIDGE` | 1 bit | El Chip Select principal asignado a este puente (ej. la salida `CS_PERIF0` del MMIO). |
| `LOCAL_ADDR[19:0]`| 20 bits | Offset enviado por el MMIO. El puente usará los bits superiores de este offset (ej. `[19:16]`) para seleccionar qué sub-periférico activar. |
| `WDATA_IN`, `WEN`, `REN` | 32 y 1 bit | Señales de escritura/lectura y datos que provienen del MMIO y se propagarán al sub-periférico activo. |
| `RDATA_Px`, `READY_Px` | 32 y 1 bit | Datos y handshake de respuesta provenientes de cada uno de los sub-periféricos conectados (UART, Timer, etc.). |

---

### Salidas (hacia sub-periféricos y MMIO)

| Señal | Ancho | Descripción |
|-------|-------|-------------|
| `CS_UART`, `CS_TIMER`, etc. | 1 bit c/u | Chip Selects locales para cada sub-periférico. Se activan solo si `CS_BRIDGE` es '1' y los bits de sub-decodificación coinciden. |
| `SUB_ADDR[15:0]` | 16 bits | Offset local propagado al sub-periférico (bits bajos de `LOCAL_ADDR`). |
| `RDATA_BRIDGE` | 32 bits | Retorno hacia el MUX principal del MMIO. Proviene del árbol de MUX interno del puente. |
| `READY_BRIDGE` | 1 bit | Retorno hacia el MMIO indicando que el sub-periférico lento terminó su operación. |

---

### Lógica Interna

1. **Sub-decodificación Combinacional:** 
   Se inspeccionan los bits `LOCAL_ADDR[19:16]`. 
   - Si `0000` -> activa `CS_UART` (condicionado por `CS_BRIDGE == 1`)
   - Si `0001` -> activa `CS_TIMER` (condicionado por `CS_BRIDGE == 1`)
2. **Árbol MUX Secundario:** 
   Las salidas `RDATA` de los periféricos lentos entran a un MUX local de menor escala controlado por los `CS` locales. Su salida unificada alimenta la señal `RDATA_BRIDGE` que vuelve al MMIO.
   
> **Conclusión en Hardware:** Este cuarto circuito demuestra físicamente cómo el sistema no crece de forma lineal y cómo el diseño modular permite conectar decenas de dispositivos de I/O ocupando tan solo **un** puerto en el MMIO central.
