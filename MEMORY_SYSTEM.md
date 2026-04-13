# 💾 Memory System - Arquitectura de Memoria y MMU

Este documento describe el sistema de memoria virtual, la unidad de gestión de memoria (MMU), y el plan para implementar paginación en la etapa IF.

---

## 1. VISIÓN GENERAL DE MEMORIA

### Espacio de Direcciones

```
┌─────────────────────────────────────────────┐
│         32-bit Address Space                │
│           (0x00000000 - 0xFFFFFFFF)         │
│                    4 GB                     │
├─────────────────────────────────────────────┤
│                                             │
│     User Space (0x00000000 - 0x7FFFFFFF)   │ 2 GB
│     - Código de aplicación                 │
│     - Heap (datos dinámicos)               │
│     - Datos estáticos                      │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│     Kernel Space (0x80000000 - 0xFFFFFFFF) │ 2 GB
│     - Código del kernel                    │
│     - Tablas de páginas                    │
│     - Buffers de I/O                       │
│     - Interrupts                           │
│                                             │
└─────────────────────────────────────────────┘
```

### Memoria Física

```
┌──────────────────────────────────────────────┐
│       Memoria Física                         │
│    (Tamaño variable: 256MB - 2GB+)          │
│                                              │
│  ┌────────────────────────────────────────┐ │
│  │  Frame 0 (4KB) ← Puede ser cualquier   │ │
│  │  Frame 1 (4KB)   página virtual        │ │
│  │  ...                                   │ │
│  │  Frame N (4KB)                         │ │
│  └────────────────────────────────────────┘ │
└──────────────────────────────────────────────┘
```

### Paginación 4KB

```
Dirección Virtual (32 bits):
┌─────────────────────┬──────────────┐
│   VPN (20 bits)     │ Offset (12 bits)
│  Virtual Page #     │ Dentro página
│ (bits 31-12)        │ (bits 11-0)
└─────────────────────┴──────────────┘
       ↓                     │
   (Traslación)             │
       ↓                     │
┌─────────────────────┬──────────────┐
│   PFN (20 bits)     │ Offset (12 bits)
│  Physical Frame #   │ Igual
│ (bits 31-12)        │ (bits 11-0)
└─────────────────────┴──────────────┘

Tamaño página: 2^12 = 4096 bytes = 4 KB
Número de páginas por proceso: 2^20 = ~1 millón páginas
```

### Ejemplo de Traslación

```
Dirección virtual: 0x12345678
  VPN: 0x12345 (página 74565)
  Offset: 0x678

Lookup tabla de páginas[0x12345]:
  → PFN: 0x00A47

Dirección física: (0x00A47 << 12) | 0x678
                = 0x00A47000 | 0x678
                = 0x00A47678
```

---

## 2. TABLA DE PÁGINAS

### Estructura

```
Tabla de Páginas (en memoria):
┌─────────────────────────────────────────┐
│  Entrada 0: VPN 0 → PFN 0x00100, flags │
│  Entrada 1: VPN 1 → PFN 0x00101, flags │
│  ...                                    │
│  Entrada N: VPN N → PFN 0xXXXXX, flags │
├─────────────────────────────────────────┤
│  Total: 1M entradas × 4 bytes = 4 MB   │
│  (por proceso)                          │
└─────────────────────────────────────────┘

Ubicación: Señalada por CR3 (Page Directory Base)
           Típicamente: 0x80001000 (primer 4MB de kernel)
```

### Estructura de Entrada de Página

```
Bits 31-12:  PFN (Physical Frame Number)
Bits 11-3:   Reserved
Bit 2:       Dirty (D) - página fue modificada
Bit 1:       Writable (W) - 1=lectura/escritura, 0=solo lectura
Bit 0:       Present (P) - 1=en RAM, 0=en swap/no existe

Ejemplo:
  0x00A47007
  │└─ Present = 1 (página existe)
  │└─ Writable = 1 (se puede escribir)
  │└─ Dirty = 0 (no modificada)
  └─ PFN = 0x00A47 (frame físico)
```

### Tipos de Page Faults

```
1. Page Not Present
   Dirección accedida pero página no en RAM
   Kernel: Carga página desde swap/disk
   Reintenta instrucción

2. Write to Read-Only Page
   Intento escribir página read-only
   Kernel: COW (Copy-on-Write) o error
   Reintenta o exception

3. Invalid Virtual Address
   Dirección no mapeada (nunca asignada)
   Kernel: Segmentation Fault
   Termina proceso
```

---

## 3. MMU - MEMORY MANAGEMENT UNIT

### Componentes

```
┌────────────────────────────────────────────┐
│      MMU (Memory Management Unit)          │
│                                            │
│  ┌──────────────────────────────────────┐ │
│  │   TLB (Translation Lookaside Buffer) │ │ ← TODO: Implementar
│  │   (Caché de traducciones)            │ │
│  │   Reduce latencia de accesos         │ │
│  └──────────────────────────────────────┘ │
│                                            │
│  ┌──────────────────────────────────────┐ │
│  │   Page Table Walker                  │ │
│  │   (Camina tabla de páginas)          │ │
│  │   Si TLB miss → Busca tabla          │ │
│  └──────────────────────────────────────┘ │
│                                            │
│  ┌──────────────────────────────────────┐ │
│  │   Access Controller                  │ │
│  │   Verifica permisos (R, W, X)        │ │
│  └──────────────────────────────────────┘ │
│                                            │
└────────────────────────────────────────────┘
```

### Registros de Control

```
CR0 - Control Register 0 (MMU Control)
  Bit 0:  PG (Paging Enable) = 1 para habilitar paginación
  Bit 1:  WP (Write Protect) = 1 para proteger kernel
  Bit 2-31: Reserved

CR3 - Page Directory Base
  Dirección física de tabla de páginas
  Típicamente: 0x80001000
  Cambiar CR3 = cambiar context/proceso

CR2 - Page Fault Linear Address
  Dirección que causó page fault
  Kernel lee esto para saber dónde ocurrió
  
CR6 - MMU Status
  Flags de estado, página actual
```

### Flujo de Traducción (Actual - MEM stage)

```
Instrucción LOD: virtual_addr ← Reg[A] + Offset

MEM Stage:
  1. virtual_addr = Reg[A] + Offset (32 bits)
  2. VPN = virtual_addr[31:12]  (20 bits)
  3. Offset = virtual_addr[11:0] (12 bits)
  
  4. Acceso tabla de páginas:
     PT_base ← CR3
     PT_entry ← PT[VPN]
     
  5. Verificar Present bit:
     if (PT_entry[0] == 0):
       → PAGE_FAULT exception
       CR2 ← virtual_addr (para kernel)
       PC ← exception_handler
       return
     
  6. Extraer PFN:
     PFN ← PT_entry[31:12]
     
  7. Verificar permisos:
     if (write && !PT_entry[1]):
       → PROTECTION_FAULT
       return
     
  8. Construir dirección física:
     physical_addr ← (PFN << 12) | Offset
     
  9. Acceso RAM:
     if (write):
       RAM[physical_addr] ← data
       PT_entry[2] ← 1  (marcar como modificada)
     else:
       data ← RAM[physical_addr]
```

### Latencia Actual

```
Sin paginación (direct addressing):
  LOD latencia: 1 ciclo (acceso RAM)

Con paginación (actualizado):
  LOD latencia: 2 ciclos
    Ciclo 1: Traslación (tabla → PFN)
    Ciclo 2: Acceso RAM físico

Con página no presente:
  LOD latencia: Variable
    Varios ciclos de exception handling
    Kernel carga página
    Reintentar instrucción
```

---

## 4. ESTADO ACTUAL: LIMITACIONES

### ✅ Implementado
- Tabla de páginas en memoria
- Traslación virtual → física
- Verificación de permisos
- Manejo de page faults
- CR0, CR3, CR2 registros

### ⚠️ Limitaciones

**1. IF Stage No Usa Paginación**

```
Actual:
┌─────────┐
│ IF      │
│ PC      │ ← Dirección física
│ Fetch   │
└────┬────┘
     │
     ▼
   ROM/RAM (acceso directo)

Problema:
  - PC es dirección VIRTUAL, pero tratada como FÍSICA
  - Si programa en memoria virtual @ 0x00000000
    pero mapeado a físico @ 0x80000000 → Error
  - No soporta memoria virtual para instrucciones
```

**2. Sin TLB (Translation Lookaside Buffer)**

```
Actual:
  Cada acceso LOD/STR → busca tabla de páginas
  Latencia: 2 ciclos mínimo

Óptimo (con TLB):
  ┌──────────┐
  │ Virtual  │
  │ Address  │
  └────┬─────┘
       │
    ┌──▼───┐
    │ TLB? │  ← Caché pequeño (32 entradas típico)
    └──┬───┘
       │
    Hit:    Latencia = 1 ciclo
    Miss:   Latencia = 3-4 ciclos (acceso tabla)
```

---

## 5. PLAN: IMPLEMENTAR MMU EN IF STAGE

### Objetivo

Permitir que Instruction Fetch traiga instrucciones desde espacio de memoria virtual, con paginación completa.

### Paso 1: Análisis de Requisitos

**Cambios necesarios:**

```
IF Stage (actual):
  PC ← 32 bits
  Instrucción ← ROM[PC]  ← Asume PC es dirección física

IF Stage (nuevo):
  PC_virtual ← 32 bits
  PC_physical ← MMU.translate(PC_virtual, FETCH)
  Instrucción ← ROM[PC_physical]
```

**Señales MMU para IF:**

```
Input:
  - virtual_addr (32 bits) = PC
  - access_type = FETCH
  - privilege_level = actual

Output:
  - physical_addr (32 bits)
  - valid (1 bit) - 1 si traducción éxitosa
  - fault (1 bit) - 1 si page fault

Ambos IF y MEM usan misma unidad MMU
(multiplexor de entrada)
```

### Paso 2: Diseño de Traslación en IF

```
Arquitectura Propuesta:

┌─────────┐
│  PC     │ (dirección virtual)
└────┬────┘
     │
     ▼
┌──────────────────────┐
│  Multiplexor          │
│  (IF o MEM request?)  │
└────┬─────────────────┘
     │
     ▼
┌──────────────────────┐
│  MMU                 │
│  1. Busca CR3        │
│  2. Accede PT        │
│  3. Verifica P bit   │
│  4. Calcula física   │
└────┬─────────────────┘
     │
     ├─ valid=0 → PAGE_FAULT
     │           Exception handler
     │
     └─ valid=1 → physical_addr
               ↓
            Fetch instrucción
```

### Paso 3: Manejo de IF Page Faults

```
IF page fault:
  1. Excepción generada
  2. PC guardado en EPC (RE1)
  3. Salta a handler
  4. Kernel carga página
  5. RET a instrucción original
  
  Nota: Más cuidado que MEM fault
        Debe asegurar coherencia de pipeline
```

### Paso 4: Optimización con TLB

Fase 2 (opcional):

```
TLB (pequeño caché de traducciones):
┌───────────────────────────────┐
│ VPN  │ PFN  │ Flags │ Valid   │
├──────┼──────┼───────┼─────────┤
│ 0x12 │0xA47 │  RWX  │  1      │ ← Hit
│ 0x34 │0x002 │  RX   │  1      │
│ 0x56 │  -   │  -    │  0      │ ← Miss
│ ...  │      │       │         │
└───────────────────────────────┘

Pseudocódigo:
  if TLB[VPN].valid:
    physical ← (TLB[VPN].PFN << 12) | offset
  else:
    physical ← table_walk(VPN)  ← Más lento
    TLB[VPN] ← resultado        ← Guardar
```

### Paso 5: Testing Plan

```
Test 1: IF sin paginación
  - Deshabilitar CR0.PG
  - IF trata PC como física
  - Debe funcionar igual que actual

Test 2: IF con paginación simple
  - Habilitar CR0.PG
  - Mapear 0x00000000 → 0x80000000
  - Programa @ 0x00000000
  - Debe ejecutar desde 0x80000000

Test 3: IF con múltiples páginas
  - Código distribuido en varias páginas
  - Verificar saltos entre páginas
  - Verificar fetch secuencial

Test 4: IF page fault
  - Acceder página no mapeada
  - Generar excepción
  - Handler retorna
  - Reintenta fetch
```

---

## 6. CICLO DE EJECUCIÓN CON PAGINACIÓN

### Sin Paginación (Actual)

```
Ciclo 1:  IF fetch @ física 0x1000
          MEM acceso RAM[0x2000]

Latencia: directa
```

### Con Paginación (Futuro)

```
Ciclo 1:  IF: virtual PC = 0x00001000
             Busca tabla de páginas (con TLB hit)
             Calcula física = 0x80001000
             Fetch instrucción

          MEM: virtual = 0x00002000
              Busca tabla de páginas
              Calcula física = 0x80002000
              Acceso RAM

Latencia: +1-2 ciclos por miss de TLB
```

### Comparación de Performance

| Escenario | IF Latencia | MEM Latencia | Total |
|---|---|---|---|
| Sin paginación | 1 | 1-2 | 2-3 |
| Con paginación + TLB hit | 1-2 | 2-3 | 3-5 |
| Con paginación + TLB miss | 3-4 | 4-5 | 7-9 |

---

## 7. CÓDIGO LOGISIM (Pseudocódigo para Implementación)

### Traslador MMU

```verilog
// MMU Translator (dentro de MEM.circ)
// Entrada: virtual_addr (32 bits)
// Salida: physical_addr (32 bits), valid, fault

module MMU (
  input [31:0] virtual_addr,
  input we,  // write enable
  input [2:0] access_type,  // FETCH, READ, WRITE
  input privilege,  // 0=user, 1=kernel
  
  output [31:0] physical_addr,
  output valid,
  output fault
);

  wire [19:0] vpn = virtual_addr[31:12];
  wire [11:0] offset = virtual_addr[11:0];
  
  wire [31:0] pt_base = CR3;
  wire [31:0] pt_entry;
  
  // Leer entrada de tabla de páginas
  RAM_read #(.ADDR_WIDTH(20))
    page_table(
      .addr(vpn),
      .data_out(pt_entry),
      .base_addr(pt_base)
    );
  
  // Verificar bits
  wire present = pt_entry[0];
  wire writable = pt_entry[1];
  wire dirty = pt_entry[2];
  wire [19:0] pfn = pt_entry[31:12];
  
  // Lógica de faults
  assign fault = 
    !present ||  // Not present
    (we && !writable);  // Write to read-only
  
  // Calcular dirección física
  assign physical_addr = fault ? 32'hxxxxxxxx : {pfn, offset};
  assign valid = !fault && present;

endmodule
```

### Multiplexor IF/MEM a MMU

```verilog
// Selector de acceso MMU
// IF y MEM comparten MMU

always @(*) begin
  case (mmu_arbiter)
    2'b00: begin  // IF stage
      mmu_input = PC;
      mmu_we = 1'b0;  // Fetch is read-only
      mmu_access = ACCESS_FETCH;
    end
    2'b01: begin  // MEM stage
      mmu_input = calc_address;
      mmu_we = (STR) ? 1'b1 : 1'b0;
      mmu_access = (STR) ? ACCESS_WRITE : ACCESS_READ;
    end
    default: mmu_input = 32'h0;
  endcase
end
```

---

## 8. ESTRUCTURA FÍSICA DE MEMORIA (Ejemplo)

```
Espacio de direcciones:
0x00000000 - 0x7FFFFFFF  ← User space (2GB)
0x80000000 - 0xFFFFFFFF  ← Kernel space (2GB)

Mapeo físico (ejemplo):
Física 0x00000000 - 0x00001000: Tabla de páginas
Física 0x00001000 - 0x00100000: Código kernel
Física 0x00100000 - 0x01000000: Heap kernel + Buffers
Física 0x01000000 - 0xFFFFFFFF: RAM para apps

Tabla de páginas inicial (CR3=0x80000000):
[0x00000]:  PFN=0x01000  (virtual 0x00000 → física 0x01000)
[0x00001]:  PFN=0x01001  (virtual 0x01000 → física 0x01001)
[0x80000]:  PFN=0x00001  (kernel @ 0x80000 → física 0x00001)
```

---

## 9. CHECKLIST DE IMPLEMENTACIÓN

### Fase 1: IF Paginación Básica

- [ ] Copiar MMU logic del MEM stage
- [ ] Integrar traslador en IF stage
- [ ] Selector de acceso (IF vs MEM)
- [ ] Testing sin paginación (CR0.PG=0)
- [ ] Testing con paginación simple (identidad)
- [ ] Testing con saltos entre páginas

### Fase 2: Page Fault Handling en IF

- [ ] Exception generada en IF
- [ ] PC guardado correctamente
- [ ] Handler ejecuta y retorna
- [ ] Instrucción reintentada

### Fase 3: TLB (Opcional)

- [ ] Diseño de TLB (32 entradas)
- [ ] Hit/miss logic
- [ ] Invalidación en cambio de CR3
- [ ] Testing con patrón de acceso realista

---

**Plan completo para memoria virtual con paginación en IF stage. Implementar fase 1 antes de crear ejemplos de código.**
