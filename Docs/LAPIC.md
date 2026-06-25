# 🔔 Subsistema de Interrupciones: Local APIC

## Visión General

El módulo `LAPIC.circ` es el **controlador local de interrupciones** del procesador. Gestiona hasta **128 vectores de interrupción** de forma priorizada mediante lógica combinacional, recibe señales de dispositivos externos a través de dos puertos `IO_APIC` (64 líneas cada uno), aloja un `Timer` interno programable, y expone hacia el pipeline central las señales `IRQ` (interrupción pendiente) y `Cause` (vector de la interrupción de mayor prioridad activa).

```
IO_APIC_1 (x64) ─┐
IO_APIC_2 (x64) ─┤
Timer interno     ├──▶  IRR  ──▶  TPR  ──▶  ISR  ──▶ IRQ + Cause ──▶ Pipeline
MMIO del núcleo  ─┘
```

---

## Componentes del LAPIC

### IRR — Interrupt Request Register

El `IRR` (*Interrupt Request Register*) es el registro de entrada del LAPIC. Almacena el **mapa de bits de todas las interrupciones que han llegado pero aún no han sido despachadas** al procesador. Cada bit corresponde a un vector de interrupción (0–127).

- Cuando un dispositivo externo eleva una línea de interrupción (`IO_APIC_1`, `IO_APIC_2`) o el `Timer` interno genera un tick, el bit correspondiente en el `IRR` se **pone en `1`**.
- El `IRR` también recibe la señal `LVT` (*Local Vector Table*) para la configuración interna del Timer.
- El `IRR` acepta entradas desde el bus `MMIO` del núcleo (para que el kernel pueda configurar las máscaras y la tabla vectorial).

### TPR — Task Priority Register

El `TPR` (*Task Priority Register*) permite al Sistema Operativo **enmascarar todas las interrupciones cuyo número de vector sea menor o igual a un umbral de prioridad**. Actúa como filtro entre el `IRR` y el `ISR`:

- Si la prioridad de una interrupción pendiente en el `IRR` es menor o igual al valor del `TPR`, esa interrupción **no se despacha** (se ignora hasta que el TPR sea bajado o la prioridad de la IRQ suba).
- El `TPR` es configurable por software desde el kernel vía MMIO (`CYR` hacia el espacio de registros del LAPIC) o directamente por hardware.
- El `TPR` expone una señal `Valid` que indica si hay alguna interrupción pendiente que supere el umbral actual.

### ISR — In-Service Register

El `ISR` (*In-Service Register*) lleva el **registro exacto de cuáles interrupciones están actualmente siendo procesadas** por el procesador. Funciona como una "pila de prioridades" de hardware:

- Cuando el LAPIC despacha una interrupción, **marca el bit correspondiente en el `ISR`** sin borrar el estado del `IRR` hasta que el manejador de software envíe el `EOI`.
- Si llega una interrupción de **mayor prioridad** mientras hay una activa, el LAPIC marca un **segundo bit en el `ISR`** sin borrar el primero.
- El LAPIC solo permite despachar al procesador la interrupción de mayor prioridad entre todas las marcadas en el `ISR`.
- La señal `EIO` (End of Interrupt Output) conecta la salida del `ISR` hacia el `IRR` para gestionar el ciclo de vida completo.

### Timer Interno

El `Timer` es un periférico interno del LAPIC que genera interrupciones periódicas o de un solo disparo:

- Se configura mediante escrituras MMIO a los registros de configuración del Timer (`Config`).
- Al expirar, inyecta una solicitud de interrupción en el `IRR`.
- El canal `Timmer` del diagrama lo conecta directamente al `IRR` para la generación del IRQ de timer.

---

## Lógica de Priorización Combinacional

### Codificador de Prioridad (`Pri_Encoder`)

El `Pri_Encoder` es el núcleo de la lógica de priorización del LAPIC. Opera sobre **dos vectores de 64 bits** (los 128 bits del `IRR` o del `ISR` divididos en dos puertos de 64 bits) y:

1. **Concatena** los dos vectores de 64 bits en un bus lógico de 128 bits.
2. De forma **puramente combinacional** (sin estados intermedios), encuentra el bit `1` más significativo activo.
3. Devuelve el **índice de ese bit** (rango `0`–`127`, representado en 7 bits), que corresponde al vector de la interrupción de mayor prioridad pendiente.

Este diseño evita lógica secuencial compleja y resuelve la prioridad en **un único ciclo combinacional**, sin importar cuántas interrupciones estén pendientes simultáneamente.

> ⚠️ **Consideración para FPGA real:** Los bucles `for` iterativos de 128 bits pueden causar problemas graves de *fan-in/fan-out* en silicio real. En una migración a hardware físico, se recomienda implementar el codificador de prioridad como un **árbol balanceado de comparadores** para reducir el *fan-in* y mejorar la frecuencia máxima.

### Decodificador de Prioridad (`Pri_Decoder`)

El `Pri_Decoder` realiza el proceso inverso al `Pri_Encoder`:

- Recibe un **índice de 7 bits** (0–127).
- Activa **un único bit** en el vector de 128 líneas de salida (dividido en dos puertos de 64 bits).
- Se usa principalmente para marcar interrupciones como "atendidas" en el `ISR` o en el `IRR` al recibir el `EOI`.

---

## Salidas del LAPIC hacia el Pipeline

| Señal | Ancho | Descripción |
| :--- | :---: | :--- |
| `IRQ` | 1 bit | Indica al pipeline central que hay al menos una interrupción pendiente que supera el umbral del TPR y está lista para ser despachada. |
| `Cause` | 32 bits | Contiene el vector de la interrupción de mayor prioridad activa. El bit 31 se pone en `1` para distinguirla de las excepciones síncronas (bit 31 = `0`). |
| `Data_Out` | 64 bits | Datos leídos de la RAM o de los registros MMIO del LAPIC, devueltos al pipeline. |

---

## Ciclo de Vida de una Interrupción en el LAPIC

```
1. Dispositivo externo eleva IO_APIC_1[n] o IO_APIC_2[n], o el Timer expira
         │
         ▼
2. IRR marca el bit [n] como pendiente
         │
         ▼
3. TPR verifica si la prioridad de [n] supera el umbral actual
   ├── NO: la interrupción espera en IRR hasta que el TPR baje
   └── SÍ:
         │
         ▼
4. ISR marca el bit [n] como "en servicio"
   (sin borrar bits anteriores si hay anidamiento)
         │
         ▼
5. LAPIC activa IRQ=1 y coloca el vector en Cause (bit31=1)
         │
         ▼
6. Pipeline detecta IRQ, el Excp Gen inyecta SCL
         │
         ▼
7. Kernel resuelve la interrupción (lee Cause, ejecuta manejador)
         │
         ▼
8. Kernel envía EOI al LAPIC (escritura MMIO)
         │
         ▼
9. LAPIC limpia SOLO el bit de mayor prioridad activo en ISR
   (el bit del vector anterior, si había anidamiento, permanece)
         │
         ▼
10. Si quedan bits activos en ISR → retomar la interrupción pendiente anterior
    Si ISR queda vacío → retornar al programa de usuario (SRT)
```

---

## Interfaz MMIO del LAPIC

El núcleo accede a los registros internos del LAPIC mediante lecturas/escrituras `LOD`/`STR` a direcciones físicas en el rango MMIO. Los registros accesibles incluyen:

| Registro MMIO | Tipo | Función |
| :--- | :---: | :--- |
| `IRR` (Read) | Lectura | Ver las interrupciones pendientes actualmente. |
| `ISR` (Read) | Lectura | Ver las interrupciones en servicio actualmente. |
| `TPR` (Read/Write) | R/W | Leer o modificar el umbral de prioridad de interrupciones. |
| `Timer Config` | Escritura | Configurar el período o modo del timer interno. |
| `EOI` | Escritura | Señalizar fin de la interrupción actual (limpia el bit más alto del ISR). |
| `LVT` | Escritura | Configurar la *Local Vector Table* (vector del timer, errores del LAPIC, etc.). |

> 📌 El `MMIO Controller` del LAPIC también desvía las lecturas/escrituras de datos normales hacia la `RAM` cuando la dirección no corresponde a ningún registro del LAPIC.
