# 💾 Subsistema de Memoria: MMU, TLB, Paginación y MMIO

## Visión General

El subsistema de memoria implementa **memoria virtual paginada**, esencial para ejecutar sistemas operativos modernos con aislamiento entre procesos. Cada acceso a memoria generado por el datapath (`LOD`, `STR`, o el `FETCH` de instrucciones) pasa obligatoriamente por la **MMU** (`MEM.circ`), la cual traduce la dirección virtual de 32 bits a una dirección física de 32 bits antes de llegar a la RAM.

```
Dirección Virtual (32 bits)
         │
         ▼
┌─────────────────┐    Hit      Dirección Física (32 bits)
│       TLB       │────────────────────────────────────────▶ RAM / MMIO
│  (64 entradas)  │
│     LRU Policy  │    Miss
└─────────────────┘──────────▶ Page Walker ──▶ Tabla de Páginas (CR3)
                                    │
                                    │  Página no presente
                                    ▼
                            Excp Gen (Page Fault)
```

## Unidad de Gestión de Memoria (MMU)

El módulo `MMU.circ` (junto con `MMU_Controler`) intercepta **todos** los accesos a memoria. Sus puertos principales, visibles en el diagrama del núcleo, son:

| Puerto | Rol |
| :--- | :--- |
| `Kernel` | Indica si el acceso proviene del Modo Kernel o Usuario (controla permisos de página). |
| `IF` | Acceso de tipo *Instruction Fetch* (lectura de instrucción desde el PC). |
| `MEM` | Acceso de tipo datos (`LOD`/`STR`). |
| `RAM` | Bus de datos bidireccional hacia la memoria física. |
| `Ctrl` | Señales de control recibidas de la Control Word (`RoW`, `En_Write`). |
| `RegE` | Bus para acceder/escribir registros especiales relacionados con la MMU (`CR0`, `CR2`, `CR3`, `PCID`). |
| `Excp` | Salida de excepción: activa cuando la MMU detecta una violación de acceso o fallo de página. |
| `Stall` | Señal que detiene el pipeline mientras se resuelve un TLB miss o un acceso a memoria lenta. |
| `RAM_Ready` | Señal que indica que la RAM externa completó el acceso (elimina el Stall). |
| `En_Write` | Habilita la escritura efectiva en RAM (viene de `RoW=11`). |

### Flujo de Traducción de Dirección

1. La ALU genera una **dirección virtual** de 32 bits.
2. La MMU consulta el **TLB** con los bits superiores de la dirección virtual (número de página).
3. **TLB Hit:** La traducción está en caché. La MMU combina la dirección física de marco (`PFN`) con el offset de la dirección virtual y emite la dirección física en el mismo ciclo.
4. **TLB Miss:** La MMU congela el pipeline (señal `Stall`) y activa el **Page Walker** para recorrer la tabla de páginas en memoria física (apuntada por `CR3`). Al encontrar la entrada, la carga en el TLB y reintenta el acceso.
5. **Página No Presente / Protección violada:** El Page Walker (o el TLB directamente al validar los flags) genera una señal hacia `Excp Gen`, que dispara el vector de excepción correspondiente.

### Verificación de Protección

La MMU verifica las siguientes condiciones sobre los **flags de página** (ver [CONTROL_UNIT.md](./CONTROL_UNIT.md)):

| Condición | Vector disparado |
| :--- | :--- |
| `Present = 0` en un `LOD` o `FETCH` | Vector 1 — Page Fault LOD/Fetch |
| `Present = 0` en un `STR` | Vector 2 — Page Fault STR |
| `KernelOnly = 1` y `Kernel = 0` (acceso de usuario a página del kernel) | Vector 1 o 2 según tipo |
| `ReadOnly = 1` y se intenta un `STR` | Vector 2 — Page Fault STR |
| Instrucción privilegiada ejecutada con `Kernel = 0` | Vector 3 — General Protection Fault |
| Bits `[1:0]` de la dirección distintos de `00` | Vector 6 — Alignment Fault |

---

## TLB (Translation Lookaside Buffer)

El TLB es una **caché de traducciones** de dirección virtual → física, diseñado para evitar el costoso recorrido de la tabla de páginas en cada acceso.

### Especificaciones

| Parámetro | Valor |
| :--- | :--- |
| Número de entradas | **64** |
| Política de reemplazo | **LRU (Least Recently Used)** exacto |
| Tipo de búsqueda | **Combinacional (asíncrona)** |
| Ancho de etiqueta | Número de página virtual (32 - offset bits) |
| Ancho de dato | `PFN` (Page Frame Number) + Flags de página |

### Comportamiento Asíncrono

La búsqueda (lookup) en el TLB es **puramente combinacional**: responde dentro del mismo ciclo de simulación sin insertar latencia en el pipeline cuando hay un *hit*. Esto es crítico para no degradar el IPC en el caso común (la mayoría de los accesos son hits en TLB).

### Política LRU Exacta

Cada entrada del TLB mantiene un campo de **"edad"** de 6 bits (rango `0`–`63`):

- **En un hit:** La entrada consultada se promueve a la más reciente (edad máxima). Solo se envejece a las entradas que previamente tenían una edad mayor, preservando el orden temporal exacto y evitando empates. Esto garantiza que siempre se desaloje la entrada menos recientemente usada.
- **En un miss con TLB lleno:** Se desaloja la entrada con `Age = 0` (la menos recientemente usada) y se carga la nueva traducción con la edad máxima.

> ⚠️ **Consideración de escalabilidad:** Actualizar las edades de todas las entradas en paralelo en cada hit implica un gran consumo de área lógica. En hardware físico real, se recomienda reducir a 16–32 entradas o reemplazar LRU exacto por **Pseudo-LRU** (árbol binario de bits de estado), que es el estándar de la industria.

### Invalidación del TLB

El TLB debe ser invalidado explícitamente por el kernel cuando:

- Se realiza un cambio de proceso (nuevo `PCID`/`CR3`).
- El kernel modifica una entrada de la tabla de páginas (mapeo, desmapeo, cambio de permisos).

Esto se realiza escribiendo los registros de control de la MMU vía instrucciones privilegiadas (`CYR` hacia `CR0`/`CR3`).

---

## Page Walker (Recorrido de la Tabla de Páginas)

El **Page Walker** es activado por la MMU en caso de TLB miss. Su función es recorrer la estructura de tabla de páginas en memoria física para encontrar el `PFN` correspondiente a la dirección virtual solicitada.

- El recorrido comienza desde la dirección apuntada por `CR3` (tabla de páginas raíz del proceso activo).
- Usa la dirección virtual como índice para navegar por los niveles de la tabla.
- Si encuentra una entrada válida (`Present = 1`), carga la traducción en el TLB y reanuda el pipeline (desactiva `Stall`).
- Si no encuentra una entrada válida (`Present = 0` o protección violada), señaliza a `Excp Gen` para disparar el Page Fault correspondiente.

---

## MMIO (Memory-Mapped I/O)

El `MMIO Controller` presente en el diagrama del LAPIC (`Local_APIC.jpg`) intercepta los accesos a ciertas **direcciones físicas reservadas** y los desvía hacia los periféricos en lugar de la RAM. Esta técnica permite al kernel configurar periféricos (timer, controlador de interrupciones, etc.) con instrucciones `LOD`/`STR` ordinarias dirigidas a las direcciones MMIO correspondientes.

El bus de datos en el MMIO soporta tanto accesos de **8 bits** (`char`) como de **32 bits** (`int`), controlados por el campo `Tipo` de la instrucción de memoria. Un extensor `0/64/32` adapta el ancho del bus cuando sea necesario.

### Dispositivos MMIO documentados

| Dispositivo | Descripción |
| :--- | :--- |
| **Timer** | Temporizador configurable vía MMIO, accesible desde el módulo LAPIC. |
| **IRR** | Interrupt Request Register del LAPIC (lee/configura interrupciones pendientes). |
| **TPR** | Task Priority Register del LAPIC (enmascara interrupciones por prioridad). |
| **ISR** | In-Service Register del LAPIC (estado de interrupciones activas). |
| **IO_APIC_1 / IO_APIC_2** | Puertos de entrada de 64 líneas de interrupción externas cada uno (total: 128 vectores). |

---

## Alineación y Restricciones de Acceso a Memoria

| Regla | Detalle |
| :--- | :--- |
| **Alineación de 4 bytes** | Todos los accesos (`LOD`, `STR`, saltos) deben apuntar a direcciones cuyos 2 bits menos significativos sean `00`. |
| **Arrays con longitud prefijada** | El primer word de cualquier array almacena la longitud del mismo; el puntero apunta a ese word. |
| **Espacio de direcciones** | 32 bits de espacio físico (4 GB direccionables). |
| **Ancho de acceso** | Soporta accesos de 32 bits (`int`) y 8 bits (`char`) según el campo `Tipo` de la instrucción. |
