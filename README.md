# 💻 Procesador RISC de 32 bits — Arquitectura Custom en Logisim-Evolution

![Estado](https://img.shields.io/badge/Estado-En%20Desarrollo-orange)
![Plataforma](https://img.shields.io/badge/Plataforma-Logisim--Evolution%203.9.0-blue)
![Pipeline](https://img.shields.io/badge/Pipeline-5%20Etapas-green)
![ISA](https://img.shields.io/badge/ISA-24%20instrucciones-purple)
![Datos](https://img.shields.io/badge/Datos-32%20bits-lightgrey)
![Memoria](https://img.shields.io/badge/Direcciones-32%20bits-lightgrey)

Este repositorio contiene el diseño completo de una **arquitectura de procesador RISC de 32 bits personalizada**, construida en **Logisim-Evolution v3.9.0**. La CPU implementa un pipeline clásico de 5 etapas, una unidad de control basada en PLA/ROM, un sistema de memoria virtual paginada con MMU y TLB, un controlador local de interrupciones (LAPIC) con priorización por hardware, y un mecanismo completo de excepciones, interrupciones y llamadas al sistema (Syscalls) con dos anillos de privilegio (Kernel / Usuario).

---

## 📊 Especificaciones Técnicas

| Característica            | Especificación                                                        |
|---------------------------|------------------------------------------------------------------------|
| **Ancho de instrucción**   | 32 bits (longitud fija)                                                |
| **Ancho de datos / bus**   | 32 bits                                                                |
| **Ancho de direcciones**   | 32 bits (espacio físico)                                               |
| **Pipeline**               | 5 etapas: `IF → ID → EX → MEM → WB`                                    |
| **Registros generales**    | 16 registros simétricos (`R0`–`R15`), con alias especiales bajo ABI    |
| **Unidad de Control**      | PLA/ROM combinacional de 24 entradas × 16 bits de *Control Word*       |
| **Conjunto de instrucciones (ISA)** | 24 instrucciones: ALU, Lógica, Shifts, Flujo, Memoria, Sistema |
| **Memoria virtual**        | Paginación con MMU + TLB de 64 entradas (política LRU)                 |
| **Excepciones**            | Controlador centralizado por hardware, sin `IDTR` físico                |
| **Interrupciones**         | LAPIC local con IRR / ISR / TPR, hasta 128 vectores priorizados         |
| **Privilegios**            | Modo Usuario y Modo Kernel (Anillo 0) protegido por hardware             |

---

## 📁 Estructura del Proyecto (Hardware)

El hardware está dividido en módulos independientes (`.circ`) instanciados en un núcleo central:

- **`Pipeline.circ`** — Núcleo integrado (`Pipeline 5x`): conecta todos los módulos, los registros inter-etapa y expone los buses externos hacia la Memoria/LAPIC.
- **`Control_FLush.circ`** — Decodificador de instrucciones (PLA), Program Counter, lógica de Bypass (hazards RAW), Branch Unit y lógica de Flush.
- **`Unidad_Aritmetica.circ`** — ALU paralela (suma/resta/lógica/shifts) y evaluador de condiciones de salto.
- **`Registros.circ`** — Banco de registros generales (`REG`/`REGN`) y registros especiales/sistema (`REGE`).
- **`MEM.circ`** — MMU, TLB (64 entradas LRU), Page Walker, generador de excepciones por violación de acceso.
- **`LAPIC.circ`** — Controlador local de interrupciones: IRR, ISR, TPR, Timer y puertos de I/O APIC externos.

---

## 📚 Índice de Documentación

La documentación se organiza por tema en los siguientes archivos:

- **[ARCHITECTURE.md](./ARCHITECTURE.md)** — Datapath, pipeline de 5 etapas, submódulos, hazards y resolución de saltos.
- **[ISA_REFERENCE.md](./ISA_REFERENCE.md)** — Formato de instrucción de 32 bits y descripción funcional de las 24 instrucciones.
- **[CONTROL_UNIT.md](./CONTROL_UNIT.md)** — Definición bit a bit de la *Control Word* de 16 bits y la matriz de firmware completa (PLA).
- **[MEMORY_AND_ABI.md](./MEMORY_AND_ABI.md)** — Mapa de registros / ABI, convención del Stack Pointer, alineación de arrays y reglas de `CR0`.
- **[MEMORY_SYSTEM.md](./MEMORY_SYSTEM.md)** — Subsistema de memoria: MMU, TLB (LRU de 64 entradas), Page Walker, MMIO y tabla de páginas.
- **[INTERRUPTS_AND_EXCEPTIONS.md](./INTERRUPTS_AND_EXCEPTIONS.md)** — Ciclo de vida completo de excepciones, vectores del IDT por software y manejo de interrupciones anidadas.
- **[LAPIC.md](./LAPIC.md)** — Controlador local de interrupciones: IRR, ISR, TPR, priorización combinacional y EOI.
- **[CRITICAL_ANALYSIS.md](./CRITICAL_ANALYSIS.md)** — Análisis crítico de la arquitectura: fortalezas, cuellos de botella, soluciones propuestas y plan de pruebas.

> ⚠️ **Nota sobre las fuentes:** Esta documentación fue reconstruida a partir de la documentación previa del proyecto, las planillas de control (`Inst.xlsx`) y los diagramas de bloques (`Pipeline_Core.jpg`, `Core.jpg`, `Local_APIC.jpg`). Donde existían contradicciones entre fuentes, se priorizó la planilla de control `Inst.xlsx` (fuente de la ROM/PLA real) y el documento `Analisis_de_arquitectura.md`, ya que reflejan con mayor fidelidad el hardware implementado. Las discrepancias detectadas se señalan explícitamente en cada documento.
