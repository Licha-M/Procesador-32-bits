# Reporte Técnico de Revisión de Diseño: Fallas Críticas de Hardware

**Referencia:** Análisis de viabilidad e implementación física basado en `Circuit_Design_Specs.md`.  
**Estado del Diseño:** No apto para síntesis RTL / Requiere correcciones obligatorias.

Este documento detalla los fallos de lógica combinacional, problemas de temporización, ambigüedades de conteo y riesgos de interbloqueo (*deadlock*) presentes en las especificaciones del sistema, excluyendo los subsistemas de memoria caché. Cada sección describe el problema técnico y la solución requerida para permitir un funcionamiento correcto en silicio real o simuladores estrictos.

---

## 1. Error Matemático en el Cálculo de Dirección Local (Circuito 1: MMIO)

* **Ubicación:** Lógica interna de decodificación del direccionamiento MMIO.
* **Descripción del Fallo:** La especificación establece la ecuación `LOCAL_ADDR = ADDR_BUS XOR BAR_BASE_activo` afirmando que es equivalente a un enmascaramiento o rebanado de bits (`ADDR_BUS[OFFSET_BITS-1:0]`). Esta premisa es matemáticamente falsa en el diseño general de hardware. La operación `XOR` solo emula una máscara o una resta si y solo si la dirección base (`BAR_BASE`) está perfectamente alineada a una potencia de 2 exacta y todos sus bits inferiores son estrictamente cero. Si el firmware o la BIOS asigna dinámicamente un BAR con algún bit desalineado, el `XOR` invertirá los bits del bus en lugar de limpiarlos, enviando una dirección distorsionada e incorrecta al periférico.
* **Solución Exigida:** Reemplazar la compuerta `XOR` por una operación de rebanado de bits indexada en hardware (`ADDR_BUS[OFFSET_BITS-1:0]`) o, en su defecto, una resta aritmética real (`ADDR_BUS - BAR_BASE_activo`).

---

## 2. Contradicción Crítica en el Contador del DMA (`BEAT_COUNT`) (Circuito 2: DMA)

* **Ubicación:** Máquina de Estados Finitos (FSM) del Controlador DMA.
* **Descripción del Fallo:** Durante el estado de transferencia activa, la FSM ejecuta en paralelo las operaciones `CURRENT_ADDR += 4` (avance de palabra de 32 bits) y `BEAT_COUNT -= 1` en cada ciclo donde `RAM_READY` está en alto. Sin embargo, el registro origen `DMA_LEN` se define de forma ambigua como "Número de bytes/palabras". En los sistemas operativos y controladores reales (como NVMe), las longitudes de transferencia se configuran obligatoriamente en **bytes**. Si el software del sistema operativo define la longitud en bytes, restar de uno en uno mientras la dirección avanza de a cuatro causará que el DMA transfiera **cuatro veces más memoria de la solicitada**, desbordando el búfer físico y corrompiendo datos adyacentes en la RAM.
* **Solución Exigida:** Modificar la especificación para forzar que `DMA_LEN` se mida estrictamente en *número de palabras (words)* de 32 bits, o modificar la lógica de la FSM para que reste el ancho de banda del bus en cada ciclo (`BEAT_COUNT -= 4`).

---

## 3. Pérdida de Interrupciones por Ausencia de Buffers en la IRU (Circuito 3: MSI)

* **Ubicación:** Unidad de Enrutamiento de Interrupciones (IRU) / Captura de MSI.
* **Descripción del Fallo:** El circuito utiliza una lógica de captura combinacional (`MSI_CAPTURE`) para atrapar las escrituras de mensajes MSI en el bus y luego requiere de 1 a 2 ciclos secuenciales para consultar la tabla de enrutamiento, validar la seguridad y despacharla al LAPIC. El diseño carece por completo de almacenamiento intermedio (búfer). Dado que el sistema cuenta con múltiples dispositivos de alta velocidad concurrentes (GPU y NVMe conectados al controlador PCIe General), las escrituras MSI se procesarán como transacciones rápidas sin bloqueo. Si ambos periféricos disparan una interrupción en ciclos consecutivos o simultáneos, la IRU descartará la segunda solicitud por estar ocupada procesando la primera (*dropped interrupt*), provocando que los controladores del sistema operativo se congelen al no recibir jamás el evento.
* **Solución Exigida:** Implementar obligatoriamente una cola **FIFO de entrada** en la IRU que almacene los mensajes MSI entrantes del bus, permitiendo procesarlos secuencialmente sin pérdida de eventos eléctricos.

---

## 4. Peligro de Interbloqueo (*Deadlock*) por `CPU_STALL` Total (Circuito 2: DMA)

* **Ubicación:** Árbitro de Bus y línea de control hacia el procesador.
* **Descripción del Fallo:** Para asegurar que el DMA tenga exclusividad sobre el bus de memoria, el árbitro genera una señal `CPU_STALL = '1'` que se conecta directamente al pipeline de la CPU para congelar su ejecución de forma masiva. Detener el pipeline completo por hardware es una falla microarquitectónica grave: detiene incluso las instrucciones internas que se ejecutan puramente en los registros o en la caché de instrucciones (I-Cache) y que no requieren el bus de datos. Esto impide que la CPU atienda excepciones críticas o alertas de emergencia durante la ráfaga del DMA. Peor aún, si el hardware del DMA experimenta un error y requiere una acción de recuperación de la CPU para liberar el bus, el sistema entrará en un **interbloqueo permanente (Deadlock)**.
* **Solución Exigida:** Eliminar el control de congelamiento directo del pipeline. El árbitro debe denegar el acceso al bus reteniendo la señal deacknowledgement o retardo (`READY = '0'`) **únicamente cuando la CPU intente ejecutar una instrucción de lectura/escritura en memoria (Load/Store)** que colisione con el uso del bus por parte del DMA.

---

## 5. Violación de Tiempos de Propagación por Árboles MUX Planos (Circuito 1: MMIO)

* **Ubicación:** Red de interconexión y multiplexación del decodificador central.
* **Descripción del Fallo:** El documento propone utilizar árboles de multiplexores puramente combinacionales para enrutar los datos y resolver el protocolo de handshake (`READY`) de "cientos de periféricos". Aunque evita el uso de buses *tri-state* (lo cual es correcto para silicio moderno), estructurar esta red de forma plana y combinacional crea un **camino crítico de temporización (*critical path*) devastador**. La señal `READY` de un periférico lento situado en el extremo del puente tendría que propagarse a través de múltiples niveles de compuertas lógicas hasta el decodificador central dentro del mismo ciclo de reloj, provocando retrasos excesivos, *glitches* eléctricos y desplomando la frecuencia máxima de operación ($F_{max}$) de todo el procesador.
* **Solución Exigida:** Segmentar la red de interconexión mediante el uso de registros intermedios (*pipelined / registered interconnect*), introduciendo flip-flops en los nodos de multiplexación para romper los caminos combinacionales largos, emulando la arquitectura de protocolos industriales como AXI o TileLink.