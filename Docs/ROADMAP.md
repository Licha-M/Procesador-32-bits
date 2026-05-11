# 🗺️ Roadmap del Procesador de 32 bits

Este documento describe los próximos pasos lógicos y secuenciales para llevar el diseño de la CPU desde su estado actual (paginación básica en MEM) hasta un procesador completamente funcional con soporte real de memoria virtual y sistema operativo básico.

---

## FASE 1: Hardware Core - MMU Unificada y Fetching
*El objetivo de esta fase es lograr que el procesador pueda leer instrucciones de memoria virtual de forma segura y sin corromper el pipeline.*

### 1.1. Lógica de Arbitraje de la MMU (`MEM.circ`)
- [x] Implementar un multiplexor en la entrada de la MMU que seleccione entre el `PC` (IF Stage) y la dirección calculada (MEM Stage).
- [x] Dar prioridad de acceso a la etapa MEM para resolver dependencias de datos más rápido.
- [x] Añadir el Flip-Flop `Serving_IF` que capture si la transacción actual pertenece al Fetcher.

### 1.2. Señalización Segura (`IF_Ready`)
- [x] Modificar la máquina de estados de la MMU (el PLA interno) para que exponga señales indicando si está en estado de Pagewalk (`PDE`/`PTE`) o en el acceso final (`Addr`/`HIT`).
- [x] Construir la compuerta lógica para `IF_Ready`: `RAM_Ready AND Serving_IF AND (State == Addr OR State == HIT)`.

### 1.3. Bypass de la MMU (Modo Real)
- [x] Implementar un multiplexor para la señal de `Stall` que sale hacia el pipeline.
- [x] Si `CR0.PG == 0`, enrutar directamente la señal `NOT RAM_Ready` ignorando la lógica interna de la MMU.

### 1.4. Integración en el Datapath (`Pipeline.circ` / `Control_FLush.circ`)
- [x] Conectar `IF_Ready` al pin `En_Write` del `Instruction_Fetcher`.
- [x] Reemplazar la conexión directa del `PC` a la RAM/ROM por la conexión a través del puerto de la MMU unificada.

---

## FASE 2: Privilegios y Seguridad
*El objetivo es implementar la distinción por hardware entre el código del sistema operativo y los programas de usuario.*

### 2.1. Flip-Flop de Estado Kernel
- [ ] Añadir un registro de 1 bit en la etapa ID (o dentro del bloque `Registros.circ`) que almacene el nivel de privilegio actual.
- [ ] Configurar el seteo (1) de este bit cuando el PLA decodifique la instrucción `SCL` (Syscall).
- [ ] Configurar el reseteo (0) cuando se ejecute la instrucción `SRT` (Return from Trap).

### 2.2. Aplicación de Permisos
- [ ] Propagar la salida del bit `Kernel` hacia la MMU.
- [ ] Modificar el chequeo de permisos de la tabla de páginas para que aborte (Page Fault) si un programa de usuario (Kernel=0) intenta acceder a una página restringida.
- [ ] Conectar el bit `Kernel` a la lógica de escritura de los Registros Especiales (`SPR`) para evitar modificaciones no autorizadas (ej: alterar el `CR3` o `EPC`).

---

## FASE 3: Aceleración y Optimización
*Reducir los ciclos desperdiciados mejorando el hardware de la memoria.*

### 3.1. Integración de la TLB (`TLB_LRU.vhd`)
- [x] Depurar el error de simulación de Logisim (las señales en rojo/flotantes "E" en las entradas del componente VHDL).
- [x] Integrar el bloque TLB en la ruta de la MMU para almacenar en caché las últimas 32 (u otra cantidad) traducciones.
- [x] Implementar la lógica de *Hit* (1 ciclo de latencia) y *Miss* (fallback al Pagewalker lento).

### 3.2. Refinamiento del Flush y Hazards
- [ ] Evaluar si la inserción de la MMU en el IF stage requiere ajustes en la cantidad de ciclos de penalización durante un *Flush* por saltos mal predichos.

---

## FASE 4: Software y Validación Total
*Probar que todo el hardware funciona en conjunto mediante programas.*

### 4.1. Simulador y Ensamblador
- [ ] Crear un pequeño ensamblador (puede ser un script de Python) que convierta mnemónicos (ej: `ADD R1, R2`) a código de máquina (hexadecimal) compatible con la ROM de Logisim, eliminando la dependencia de ensamblado a mano.

### 4.2. Pruebas Unitarias de Arquitectura
- [ ] **Test de Modo Real**: Ejecutar un bucle infinito que verifique que, con `CR0.PG=0`, la CPU funciona sin penalizaciones de traducción.
- [ ] **Test de Paginación**: Escribir un programa que configure un Page Directory, habilite `CR0.PG=1` y salte exitosamente de la memoria física a una dirección virtual mapeada.
- [ ] **Test de Excepciones**: Forzar intencionalmente un acceso indebido (ej: escribir en una página de solo lectura) y verificar que el `PC` se guarde en `EPC` (RE1) y el control pase al manejador del Kernel.

---

## FASE 5: Expansiones Futuras (Opcionales)
- Caché L1 de Instrucciones (I-Cache).
- Controlador de Interrupciones Avanzado (LAPIC con prioridades reales).
- Soporte para Entrada/Salida mapeada en memoria (MMIO) para conectar pantallas o teclados en Logisim.
