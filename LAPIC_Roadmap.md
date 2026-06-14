# 🚀 Roadmap de Desarrollo: Módulo LAPIC

Basado en tus notas (`LAPIC_Notes.txt`) y la documentación del hardware (`INTERRUPTS_AND_EXCEPTIONS.md`), aquí tienes una lista detallada, lógica y secuencial de los puntos que debes completar para diseñar e implementar el módulo **LAPIC** (Local Advanced Programmable Interrupt Controller).

---

## FASE 1: Definición de la Interfaz (I/O)
Lo primero es definir la entidad/módulo con todos sus puertos físicos según la arquitectura descrita.

- [ ] **Puertos de Interfaz de Bus (MMIO)**
  - `Addr [31:0]`: Dirección para seleccionar registros internos (IRR, TPR, ISR, etc.).
  - `Data_In [31:0]`: Bus de entrada de datos (para escrituras del Kernel).
  - `Data_Out [31:0]`: Bus de salida de datos (para lecturas del Kernel).
  - `Write_Enable`: Señal de control que viene de la etapa `MEM` para confirmar escritura.
- [ ] **Puertos de Señales de Interrupción Entrantes**
  - `IRQ_Lines [N:0]`: Pines de hardware para periféricos externos / I/O APIC (SPI).
  - `Timer_Event`: Entrada del timer local del LAPIC para ticks del SO.
  - `SGI_In`: Señal para interrupciones generadas por software (IPI).
- [ ] **Puertos de Sincronización**
  - `Clock (CLK)` y `Reset (RST)`.
- [ ] **Puertos de Salida hacia el Núcleo (Pipeline/Exception Generator)**
  - `Interrupt_Request (IRQ)`: Señal de 1 bit que indica al hardware que debe inyectar el `SCL` e interrumpir el flujo.
  - `Interrupt_Vector [X:0]`: Identificador del evento (ID).
  - `Cause_Bit_31`: (Opcional si se rutea aquí) Señal que fuerza el Bit 31 del registro *Cause* a `1` para indicar asincronía.
- [ ] **Puertos de Handshake de Retorno**
  - `EOI_Ack`: Señal para notificar al periférico / IO APIC que finalizó la rutina.

---

## FASE 2: Implementación de Registros Internos
El estado del LAPIC está gobernado por tres registros fundamentales que debes instanciar.

- [ ] **Implementar IRR (Interrupt Request Register)**
  - Captura y almacena como `1` las interrupciones que han llegado (por `IRQ_Lines`, `Timer_Event`, etc.) pero que la CPU aún no atiende.
- [ ] **Implementar ISR (In-Service Register)**
  - Almacena cuál interrupción se está procesando *actualmente* en el procesador.
- [ ] **Implementar TPR (Task Priority Register)**
  - Registro de umbral escrito por software. Actúa como filtro principal.

---

## FASE 3: Lógica de MMIO (Memory-Mapped I/O)
El Kernel debe poder leer y escribir en los registros del LAPIC como si fueran direcciones de memoria.

- [ ] **Decodificador de Direcciones (`Addr`)**
  - Asignar una dirección base y offsets para IRR, ISR y TPR.
- [ ] **Lógica de Escritura (`Write_Enable = 1`)**
  - Permitir al procesador escribir en `TPR` (para cambiar prioridad).
  - Permitir escribir en un registro virtual/físico de **EOI (End of Interrupt)**.
- [ ] **Lógica de Lectura**
  - Multiplexar `Data_Out` para que, según el `Addr`, devuelva el contenido de IRR, ISR o TPR al procesador.

---

## FASE 4: Unidad de Priorización y Arbitraje (El Cerebro)
Esta es la lógica combinacional/secuencial que decide qué interrupción pasa al procesador.

- [ ] **Filtro de Prioridad (IRR vs TPR)**
  - Comparar las interrupciones pendientes en el `IRR` con el umbral configurado en el `TPR`. Ignorar las que tengan prioridad menor o igual.
- [ ] **Prevención de Anidamiento Inválido (IRR vs ISR)**
  - Asegurar que la nueva interrupción tenga **mayor prioridad** que la interrupción que está actualmente marcada en el `ISR`.
- [ ] **Resolución de Empates (Arbitraje)**
  - Si hay múltiples interrupciones válidas en `IRR`, seleccionar la de mayor prioridad.

---

## FASE 5: Sincronización con el Pipeline (Generador de Excepciones)
El LAPIC debe comunicarse correctamente con tu `Exception_Generator`.

- [ ] **Disparo de `Interrupt_Request`**
  - Cuando la lógica de arbitraje elige una interrupción válida, levantar la señal `Interrupt_Request` hacia el generador.
- [ ] **Envío de Vector e Identificación de Asincronía**
  - Colocar el ID correspondiente en `Interrupt_Vector`.
  - **Punto Crítico:** Asegurar que, de alguna forma, el registro `Cause` tome el **Bit 31 = 1**. Como indica la doc, esto es vital para que el `Exception_Generator` entienda que es una interrupción *asincrónica* y guarde el `EPC` apuntando a la *siguiente* instrucción (+4 o la misma, dependiendo de tu diseño) al inyectar el `SCL` simulado.

---

## FASE 6: Ciclo de Vida de la Interrupción (Acknowledge & EOI)
El LAPIC debe manejar la transición de estados una vez que la CPU atiende la interrupción.

- [ ] **Transición de IRR a ISR (Acknowledge)**
  - Cuando el `Exception_Generator` acepta la interrupción (inyecta el SCL), el LAPIC debe recibir un *Ack* interno, borrar el bit ganador del `IRR` y encender el bit correspondiente en el `ISR`.
- [ ] **Lógica de Fin de Interrupción (EOI)**
  - Cuando el Kernel (SO) termina su rutina, escribirá en el registro EOI vía MMIO.
  - Al recibir esta escritura:
    1. Borrar el bit de mayor prioridad activo en el `ISR`.
    2. Emitir un pulso por `EOI_Ack` hacia el exterior para liberar la línea de hardware física original.

---

## FASE 7: Verificación (Testbench)
Puntos clave para probar tu diseño en simulación.

- [ ] **Prueba de Reseteo:** Comprobar que IRR, ISR y TPR inician en 0.
- [ ] **Prueba de Disparo Simple:** Inyectar señal en `IRQ_Lines`, ver cómo pasa al IRR y dispara `Interrupt_Request`.
- [ ] **Prueba de Enmascaramiento:** Subir el `TPR` y comprobar que una interrupción de baja prioridad en IRR **no** dispara `Interrupt_Request`.
- [ ] **Prueba de EOI:** Simular la escritura vía bus en EOI, comprobar que el `ISR` se limpia y se emite `EOI_Ack`.

> [!IMPORTANT]
> **Interacción con el Bit 31 de Cause:** Revisa detenidamente con tu controlador central de excepciones cómo se conectarán el LAPIC y los eventos del datapath. Tu documentación dice que el bit 31 distingue excepciones de interrupciones asíncronas. El LAPIC debe ser el que dicte que este bit sea `1`.
