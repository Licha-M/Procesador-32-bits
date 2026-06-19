# Especificación del Sistema MMIO Simplificado

## Descripción General

El sistema utiliza una arquitectura MMIO (Memory Mapped Input/Output) simplificada, diseñada para minimizar la cantidad de lógica intermedia entre el procesador y los dispositivos periféricos. El objetivo principal es reducir la latencia de acceso a dispositivos de alta velocidad manteniendo una implementación relativamente sencilla.

A diferencia de una arquitectura jerárquica tradicional basada en múltiples niveles de decodificación, este diseño utiliza una distribución directa de direcciones hacia los dispositivos principales, delegando la decodificación detallada únicamente a los controladores de periféricos lentos.

---

# Objetivos de Diseño

- Minimizar la latencia de acceso MMIO.
- Reducir la cantidad de lógica de enrutamiento.
- Permitir acceso directo a dispositivos críticos.
- Mantener compatibilidad con DMA.
- Simplificar el manejo de interrupciones.
- Reducir la carga de diseño del controlador MMIO.
- Facilitar la implementación en hardware personalizado.

---

# Arquitectura General

## Componentes Principales

### CPU

Procesador principal encargado de ejecutar instrucciones y generar accesos MMIO.

### Memory Controller

Controlador central de memoria.

#### Responsabilidades

- Gestionar accesos a RAM.
- Arbitrar solicitudes DMA.
- Resolver conflictos de acceso al bus.
- Coordinar transferencias entre dispositivos y memoria.

### MMIO Controller

Controlador MMIO simplificado.

#### Responsabilidades

- Determinar si una dirección corresponde a RAM.
- Permitir el acceso directo al resto de dispositivos.

A diferencia de arquitecturas convencionales, no realiza una decodificación completa del espacio MMIO.

### LAPIC

Controlador local de interrupciones.

#### Responsabilidades

- Mantener el registro IRR (Interrupt Request Register).
- Mantener el registro ISR (In Service Register).
- Gestionar prioridades de interrupción.
- Entregar interrupciones al procesador.

### ROM

Memoria de solo lectura utilizada durante el arranque y para firmware.

### GPU

Dispositivo gráfico de alta velocidad.

#### Características

- Acceso MMIO directo.
- Motor DMA propio.
- Generación de interrupciones mediante escritura directa al LAPIC.

### NVMe

Controlador de almacenamiento de alta velocidad.

#### Características

- Acceso MMIO directo.
- Motor DMA propio.
- Generación de interrupciones mediante escritura directa al LAPIC.

### Low Velocity Controller

Controlador concentrador para periféricos lentos.

#### Ejemplos de dispositivos

- UART
- GPIO
- Timers
- Controladores simples

#### Responsabilidades

- Decodificación interna de direcciones.
- Gestión de DMA para periféricos lentos.
- Arbitraje entre dispositivos.
- Enrutamiento local de señales.

---

# Topología del Sistema

```text
CPU
 │
 ├── Memory Controller
 │
 ├── LAPIC
 │
 ├── ROM
 │
 ├── GPU
 │
 ├── NVMe
 │
 └── Low Velocity Controller
         │
         ├── UART
         ├── GPIO
         ├── Timers
         └── Otros periféricos
```

---

# Sistema de Direccionamiento

## Dispositivos de Alta Velocidad

Las direcciones se distribuyen directamente hacia:

- LAPIC
- ROM
- GPU
- NVMe
- Low Velocity Controller

### Ventajas

- Reduce la latencia de decodificación.
- Elimina niveles innecesarios de enrutamiento.
- Simplifica el camino crítico del sistema.

---

## Dispositivos de Baja Velocidad

Los periféricos lentos no reciben directamente las direcciones del sistema.

### Funcionamiento

1. La dirección llega al Low Velocity Controller.
2. El controlador realiza una decodificación local.
3. El acceso se enruta al periférico correspondiente.

### Ventajas

- Menor fan-out del bus principal.
- Menor complejidad de cableado.
- Mejor escalabilidad para periféricos lentos.

---

# Sistema de Interrupciones

## Concepto General

No existe un controlador MSI dedicado.

Las interrupciones son generadas directamente por los dispositivos mediante escrituras MMIO dirigidas al LAPIC.

---

## IRR como Destino de las Interrupciones

Cada dispositivo posee un vector de interrupción asignado.

Cuando ocurre un evento:

1. El dispositivo genera una escritura MMIO.
2. El destino es el espacio MMIO del LAPIC.
3. La escritura modifica directamente el IRR.

---

## Representación Interna del IRR

El IRR se modela como un vector de bits.

```text
Bit 0   -> Timer
Bit 1   -> UART
Bit 2   -> GPIO
Bit 3   -> NVMe
Bit 4   -> GPU
...
```

Cuando varios dispositivos generan interrupciones simultáneamente:

```text
GPU  = 00010000
NVMe = 00001000

Resultado OR:

00011000
```

Ambas interrupciones permanecen registradas y pendientes de atención.

### Ventajas

- No requiere un controlador MSI separado.
- Menor cantidad de lógica.
- Menor latencia.
- Implementación sencilla.

---

# Sistema DMA

## DMA para Dispositivos de Alta Velocidad

### GPU

Posee motor DMA propio.

#### Capacidades

- Leer RAM.
- Escribir RAM.
- Solicitar control del bus.

### NVMe

Posee motor DMA propio.

#### Capacidades

- Transferir bloques completos.
- Acceder directamente a memoria principal.
- Operar sin intervención continua del CPU.

---

## DMA para Dispositivos de Baja Velocidad

Los dispositivos lentos no poseen motores DMA individuales.

El DMA es proporcionado por el Low Velocity Controller.

### Funcionamiento

1. El periférico solicita una transferencia.
2. El controlador evalúa la solicitud.
3. Si obtiene permiso:
   - Genera DMA_REQ.
   - Solicita acceso al Memory Controller.
4. Una vez concedido:
   - Realiza la transferencia.

---

## Arbitraje DMA

El Low Velocity Controller utiliza un algoritmo Round Robin.

### Características

- Implementación sencilla.
- Equidad entre dispositivos.
- Prevención de starvation.

### Ejemplo

```text
UART
 ↓
GPIO
 ↓
TIMER
 ↓
SPI
 ↓
UART
```

---

# Arbitraje del Bus

El Memory Controller es el árbitro principal del sistema.

Gestiona solicitudes provenientes de:

- CPU
- GPU DMA
- NVMe DMA
- Low Velocity Controller DMA

### Responsabilidades

- Resolver conflictos.
- Asignar acceso al bus.
- Mantener coherencia temporal.

---

# Prevención de Contención

El sistema evita el uso de buffers tri-state.

En su lugar utiliza:

- Multiplexores.
- Decodificación explícita.
- Selección única de origen de datos.

### Ventajas

- Mayor estabilidad.
- Comportamiento determinista.
- Compatibilidad con implementaciones modernas.

---

# Consideraciones sobre Caché

El diseño asume que el sistema no posee cachés.

### Consecuencias

- No se requieren regiones Uncacheable.
- No se necesitan atributos especiales de memoria.
- No existe riesgo de lecturas obsoletas causadas por caché.

Por lo tanto, mecanismos como:

- Device-nGnRnE
- Strong Uncacheable
- Cache Inhibit

no son necesarios para el funcionamiento correcto del sistema.

---

# Ventajas del Diseño

## Simplicidad

- Menor cantidad de controladores.
- Menor cantidad de lógica de enrutamiento.
- Menor complejidad de implementación.

## Baja Latencia

Los dispositivos críticos reciben direcciones directamente desde el sistema.

## Escalabilidad Moderada

Los periféricos lentos se agrupan bajo un único controlador.

## DMA Distribuido

Los dispositivos de alto rendimiento no dependen de un controlador DMA central.

## Interrupciones Simplificadas

Las interrupciones se implementan mediante escrituras directas al LAPIC.

---

# Resumen Arquitectónico

La arquitectura resultante puede considerarse una interconexión MMIO plana con jerarquía parcial.

### Características Principales

- Los dispositivos críticos se conectan directamente al sistema.
- Los dispositivos lentos se agrupan bajo un controlador secundario.
- El LAPIC recibe interrupciones mediante escrituras MMIO directas.
- GPU y NVMe poseen DMA autónomo.
- El Low Velocity Controller proporciona DMA compartido para periféricos simples.
- El Memory Controller actúa como árbitro global del sistema.

### Resultado

El resultado es un sistema orientado a minimizar la latencia y la complejidad de implementación, manteniendo un modelo de comunicación eficiente entre CPU, memoria y periféricos sin necesidad de una infraestructura compleja similar a AXI o PCIe completo.