# Mapa de Memoria Físico y Virtual (Arquitectura 32-bits)

Este mapa de memoria está diseñado en base a las especificaciones del **MMIO Controller** y el **Low Velocity Controller (LVC)**, cubriendo un espacio de direcciones de 32 bits (4 GB totales).

---

## 1. Mapa de Memoria Físico (4 GB)

El **MMIO Controller** es responsable de enrutar las peticiones basándose en estas direcciones físicas. Las direcciones que no caen en RAM o ROM se derivan al bus de periféricos.

| Rango de Direcciones Físicas | Tamaño | Componente / Región | Administrador / Enrutador |
| :--- | :--- | :--- | :--- |
| `0x00000000` - `0x7FFFFFFF` | 2 GB | **Memoria RAM** | MMIO Controller $\rightarrow$ RAM |
| `0x80000000` - `0xBFFFFFFF` | 1 GB | **MMIO Periféricos Rápidos (BARs)**<br>*(GPU, NVMe, etc.)* | MMIO Controller $\rightarrow$ Bus Periféricos $\rightarrow$ PCIe Endpoints |
| `0xC0000000` - `0xCFFFFFFF` | 256 MB | **Espacio ECAM (Configuración PCIe)**<br>*(Buses, Devices, Functions)* | MMIO Controller $\rightarrow$ Bus Periféricos $\rightarrow$ PCIe Endpoints |
| `0xD0000000` - `0xD00FFFFF` | 1 MB | **Low Velocity Controller (LVC)**<br>*(Hub de periféricos: UART, GPIO, Timer, USB, SATA, Audio, PS/2)*<br>*El LVC actúa como un switch PCIe simplificado: centraliza la decodificación de direcciones, arbitraje DMA y distribución de interrupciones MSI para todos sus dispositivos conectados.* | MMIO Controller $\rightarrow$ Bus Periféricos $\rightarrow$ **LVC** |
| $\rightarrow$ `0xD0000000` - `0xD0000FFF` | *4 KB* | *DEV0: UART* | *LVC* $\rightarrow$ *UART* |
| $\rightarrow$ `0xD0001000` - `0xD0001FFF` | *4 KB* | *DEV1: GPIO* | *LVC* $\rightarrow$ *GPIO* |
| $\rightarrow$ `0xD0002000` - `0xD0002FFF` | *4 KB* | *DEV2: Timer* | *LVC* $\rightarrow$ *Timer* |
| $\rightarrow$ `0xD0003000` - `0xD0003FFF` | *4 KB* | *DEV3: USB Controller* | *LVC* $\rightarrow$ *USB* |
| $\rightarrow$ `0xD0004000` - `0xD0004FFF` | *4 KB* | *DEV4: SATA Controller* | *LVC* $\rightarrow$ *SATA* |
| $\rightarrow$ `0xD0005000` - `0xD0005FFF` | *4 KB* | *DEV5: Audio Controller* | *LVC* $\rightarrow$ *Audio* |
| $\rightarrow$ `0xD0006000` - `0xD0006FFF` | *4 KB* | *DEV6: PS/2 (Teclado / Ratón)* | *LVC* $\rightarrow$ *PS/2* |
| $\rightarrow$ `0xD0007000` - `0xD007FFFF` | *476 KB* | *DEV7: Expansión futura* | *-* |
| $\rightarrow$ `0xD0080000` - `0xD0087FFF` | *32 KB* | ***LVC-ECAM** — Configuración por dispositivo*<br>*(Vectores MSI, habilitación DMA-MSI, ID de dispositivo)* | *LVC Interno (banco de registros)* |
| $\rightarrow$ `0xD0088000` - `0xD00FFFFF` | *480 KB* | *Reservado* | *-* |
| `0xD0100000` - `0xFEDFFFFF` | ~750 MB | **Espacio Reservado** | *Libre para expansión futura* |
| `0xFEE00000` - `0xFEE00FFF` | 4 KB | **LAPIC (Local APIC)**<br>*(Contiene el registro IRR para las MSI)* | CPU Interno / Bus Local |
| `0xFF000000` - `0xFFFFFFFF` | 16 MB | **Memoria ROM**<br>*(Bootloader / BIOS)* | MMIO Controller $\rightarrow$ ROM |

### Detalles del Enrutamiento Físico:
1. **RAM y ROM:** El MMIO Controller filtra los rangos `0x00000000-0x7FFFFFFF` y `0xFF000000-0xFFFFFFFF` enviándolos a sus respectivos chips.
2. **Dispositivos PCIe:** Los rangos `0x80000000-0xCFFFFFFF` fluyen por el bus. Los dispositivos PCIe (GPU, NVMe) escuchan y decodifican estas direcciones utilizando sus propios comparadores (BARs y lógica ECAM).
3. **Dispositivos LVC (Hub):** Si ninguna tarjeta PCIe reclama la dirección y esta cae en la ventana `0xD0000000–0xD00FFFFF`, el **LVC** la intercepta. El LVC actúa como un router utilizando un protocolo **VALID/READY** y un bus compartido vectorial para todos sus dispositivos internos. Realiza **centralizadamente** la comparación de sub-rango (bits `[19:12]`) para determinar a qué dispositivo interno va dirigida la petición. El sub-rango `0xD0080000–0xD0087FFF` (LVC-ECAM) aloja el banco de registros del LVC, el cual se ha simplificado a la lectura de los IDs (`DEVICE_ID`) de los dispositivos conectados. Durante operaciones DMA, el LVC frena su arbitraje (Round-Robin) para otorgar el bloqueo del bus al dispositivo correspondiente, actuando de puente hacia el Memory Controller.
4. **Interrupciones MSI:** Cada dispositivo conectado al LVC lanza su propia interrupción MSI directamente al LAPIC, tanto para eventos regulares como para la finalización de transferencias DMA. El **LVC no genera MSIs**, su única función de control asíncrono es la gestión de las señales `DMA_REQ` y el bloqueo del bus de datos.

---

## 2. Mapa de Memoria Virtual (Sistema Operativo / Kernel)

Para gestionar los recursos del hardware de forma segura, el sistema operativo (Kernel) implementa memoria virtual mediante paginación (MMU). A continuación, se propone un modelo clásico de **división 3G / 1G**, típico en sistemas de 32 bits.

| Rango de Direcciones Virtuales | Tamaño | Uso / Región Lógica |
| :--- | :--- | :--- |
| `0x00000000` - `0xBFFFFFFF` | 3 GB | **Espacio de Usuario (User Space)**<br>Código de aplicaciones, Heap, Stack. Aislado del hardware directo. |
| `0xC0000000` - `0xFFFFFFFF` | 1 GB | **Espacio de Kernel (Kernel Space)**<br>Reservado exclusivamente para el SO. |

### Desglose del Espacio de Kernel (Virtual)
Dentro de ese Gigabyte reservado para el sistema operativo (`0xC0000000` a `0xFFFFFFFF`), el Kernel organiza la memoria de la siguiente manera:

| Rango Virtual (Dentro del Kernel) | Uso Específico | Descripción |
| :--- | :--- | :--- |
| `0xC0000000` - `0xDFFFFFFF` | 512 MB | **Mapeo Físico Directo de RAM** | El kernel mapea linealmente los primeros 512MB de la RAM física. Aquí reside el código del kernel, estructuras de datos y el motor de asignación de memoria (`kmalloc`). |
| `0xE0000000` - `0xEFFFFFFF` | 256 MB | **Área Vmalloc / Dinámica** | Memoria que es virtualmente contigua pero físicamente dispersa. Usada para buffers grandes que el kernel necesita dinámicamente. |
| `0xF0000000` - `0xFFFFFFFF` | 256 MB | **Mapeos I/O (I/O Mappings)** | El kernel utiliza funciones como `ioremap()` para acceder a los dispositivos. Por ejemplo, mapea virtualmente aquí los BARs de la GPU/NVMe, el rango del LVC (`0xD0000000` físico) y el espacio ECAM para poder leer y escribir registros de control sin saltarse la protección de la MMU. |

### Resumen del ciclo de acceso:
Cuando un driver del kernel quiere encender un LED usando el GPIO:
1. El kernel escribe en una dirección virtual (ej. `0xF0001000`).
2. La MMU de la CPU traduce esa dirección a la dirección física real del GPIO en el LVC (`0xD0001000`).
3. La señal sale de la CPU y llega al **MMIO Controller**.
4. El MMIO nota que no es ni RAM ni ROM, la deja pasar al bus de periféricos.
5. Los PCIe la ignoran. El **LVC** la detecta, asume el control y activa el pin del GPIO.
