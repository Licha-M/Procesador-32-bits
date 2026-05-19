# 💻 Procesador RISC de 32 bits — Arquitectura Custom en Logisim-Evolution

![Estado](https://img.shields.io/badge/Estado-En%20Desarrollo-orange)
![Plataforma](https://img.shields.io/badge/Plataforma-Logisim--Evolution%203.9.0-blue)
![Pipeline](https://img.shields.io/badge/Pipeline-5%20Etapas-green)
![ISA](https://img.shields.io/badge/ISA-24%20instrucciones-purple)

Este repositorio contiene el diseño completo e implementación de una **arquitectura de procesador RISC de 32 bits personalizada**, construida en **Logisim-Evolution v3.9.0**. El procesador implementa un pipeline de 5 etapas, una unidad de control basada en PLA, un sistema de memoria virtual con MMU, y un robusto soporte para interrupciones, excepciones y llamadas al sistema (Syscalls) con anillos de privilegio (Kernel/User).

---

## 📊 Especificaciones Técnicas

| Característica             | Especificación                                           |
|----------------------------|----------------------------------------------------------|
| **Ancho de instrucción**   | 32 bits (longitud fija)                                  |
| **Ancho de datos**         | 32 bits                                                  |
| **Pipeline**               | 5 etapas: IF → ID → EX → MEM → WB                       |
| **Registros**              | 15 de propósito general (R1-R15), mapeo ABI para Sistema |
| **Unidad de Control**      | PLA de 24 entradas × 16 bits de Control Word             |
| **Conjunto (ISA)**         | 24 instrucciones (ALU, Lógica, Flujo, Memoria, Sistema)  |
| **Excepciones**            | Controlador centralizado por hardware (sin IDTR físico)  |
| **Privilegios**            | Modo Usuario y Modo Kernel (anillo 0) protegido          |

---

## 📁 Estructura del Proyecto

El hardware está dividido en módulos independientes instanciados en un núcleo central:

- `Pipeline.circ`: Núcleo integrado que conecta todos los módulos y los registros inter-etapa.
- `Unidad_Aritmetica.circ`: ALU paralela y evaluador de condiciones de salto (Branch).
- `Registros.circ`: Banco de registros generales y registros de sistema (Shadow Registers).
- `LAPIC.circ`: Controlador de interrupciones local (IRR, TPR, ISR) con priorización.
- `MEM.circ`: Paginación por hardware (MMU), TLB, chequeo de protección y generador de excepciones.
- `Control_FLush.circ`: Decodificador de instrucciones, bypass de hazards, PC y buffer prefetch.

---

## 📚 Documentación Técnica

La documentación detallada ha sido reestructurada en la carpeta `Docs/`:

- [ARCHITECTURE.md](./Docs/ARCHITECTURE.md): Diseño del datapath, etapas del pipeline y manejo de hazards.
- [ISA_REFERENCE.md](./Docs/ISA_REFERENCE.md): Especificación del conjunto de instrucciones de 32 bits.
- [CONTROL_UNIT.md](./Docs/CONTROL_UNIT.md): Matriz de señales de control y decodificación.
- [MEMORY_AND_ABI.md](./Docs/MEMORY_AND_ABI.md): Paginación de memoria virtual y convención de registros de la ABI.
- [INTERRUPTS_AND_EXCEPTIONS.md](./Docs/INTERRUPTS_AND_EXCEPTIONS.md): Flujo de vida de fallos, hardware trap y Syscalls.
