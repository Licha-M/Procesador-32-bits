# ⚡ Flujo de Excepciones e Interrupciones (Ciclo de Vida)

Este documento describe el ciclo de vida completo de un error, excepción de memoria o interrupción de hardware, desde que es detectado físicamente por el datapath hasta que es resuelto por el software del Kernel del Sistema Operativo.

## Notas y Decisiones Claves de Hardware

* **Enrutamiento Centralizado:** Todos los errores (Page Faults, OP Codes Inválidos) e interrupciones de pines externos convergen hacia un único **Controlador de Excepciones** unificado en hardware.
* **Ausencia de Registro IDTR:** El registro `IDTR` se eliminó en el hardware. El cálculo vectorial para localizar las rutinas específicas de interrupción se realiza **completamente por software** tras delegar el control.
* **Gestión de Carga de EPC:** Al ocurrir un fallo, el Kernel es responsable de evaluar (leyendo la causa) si la dirección del *Exception Program Counter* (EPC) guardada debe incrementarse en +4 o mantenerse igual para un reintento. El hardware siempre captura el EPC desde la etapa MEM en el momento del fallo.
* **Inyección de `SCL` (Syscall):** Como respuesta inmediata a un fallo, el hardware no genera señales caóticas, sino que **inyecta dinámicamente la instrucción `SCL` en el pipeline**. Esto fuerza una interrupción de software estructurada, cambiando el privilegio y saltando al Kernel de forma segura y normalizada.

## Vectores y Excepciones por Hardware

| Vector / Cause | Tipo de Excepción | Disparador de Hardware (*Trigger*) | Comportamiento y Aislamiento del Sistema |
| :---: | :--- | :--- | :--- |
| **0** | **Page Fault** | La MMU despierta la señal al fallar en traducir una dirección. | Almacena la dirección fallida en `CR2` (R5). Transfiere control a la rutina de paginación/swapping del SO. El direccionamiento físico total es de 32 bits enteros. |
| **1** | **General Protection Fault** | Ejecución de instrucciones privilegiadas (`CYE`, `CYR`, `SRT`) con el bit de estado `Kernel = 0`. | Captura la instrucción infractora, genera un Flush en el programa de usuario y evita la vulneración del espacio de memoria protegido. |
| **2** | **Invalid Opcode** | La Unidad de Control lee un patrón de bits (OpCode) que no está asignado en la ROM PLA. | Mecanismo automático de protección (*fallback*) que detiene la ejecución errática de binarios corruptos antes de que el bus de datos sufra inconsistencias críticas. |
| **3** | **Double Fault** | Una excepción en cascada sucede mientras el hardware aún procesaba y limpiaba un fallo previo. | Captura fallos catastróficos. Forzará al Kernel a un volcado seguro o a la detención limpia de la máquina (Kernel Panic). |

## Diagrama de Flujo (Microarquitectura a Software)

```mermaid
graph TD
    %% Inicio del Flujo
    Inicio((Evento Detectado)) --> Evento{Tipo de Evento}
    
    %% Ramificaciones según el Origen
    Evento -->|Instrucción Inválida| Inv[Decoder inyecta SCL]
    Inv --> Inv2[Señal al manejador: Guardar Cause en MEM]
    Inv2 --> Enrutador
    
    Evento -->|Interrupción| Int[Controlador carga código de Int en Cause]
    Int --> Enrutador
    
    Evento -->|Error / Excepción General| Enrutador
    
    %% Controlador de Excepciones (Hardware)
    Enrutador[Controlador de Excepciones] --> AccionesHW
    
    subgraph Rutina Automática de Hardware
        AccionesHW[Inserta instrucción SCL] --> S1[Guarda registros EPC y Cause]
        S1 --> S2[Hace un Flush al programa de usuario]
        S2 --> S3[Cambia a Modo Kernel <br/> Modifica FlipFlop de Estado]
    end
    
    %% Transición a Software
    S3 --> SysJMP(((Salta a SyS-JMP)))
    
    %% Lógica del Sistema Operativo
    SysJMP --> OS{Resolución por Software}
    
    OS -->|Manejo de Excepción| ExOS[Controlador de Excepciones de Software]
    OS -->|Manejo de Interrupción| IntOS[Manejador de Interrupciones <br/> Fórmula IDTR vectorizada por SO]
    
    ExOS --> Fin((Resuelve Error y emite SRT))
    IntOS --> Fin
    
    %% Notas adicionales sobre el pipeline
    classDef nota fill:#f9f6e6,stroke:#d4c47d,stroke-width:2px;
    NotaPF>Si ocurre un fallo previo como PageFault, <br/>se borra la burbuja con el flush y se regenera el control]:::nota
    Inv2 -.-> NotaPF
```
