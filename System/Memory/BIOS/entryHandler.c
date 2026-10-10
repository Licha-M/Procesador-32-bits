#include "functions.h"
#include "inter_IRQs.h"

#define MAX_IRQS 128 // Se usa 128 para darle un tamaño de 127 y poder usar 127

// ============================================================
// Structs definitions
// ============================================================

// Estructura de la tabla de IRQs donde cada espacio es un puntero a función
typedef struct {
  IRQHandler handlers[MAX_IRQS];
} IRQTable;

static IRQTable irq_table;

// Registros LAPIC
typedef struct {
  volatile uint32_t BaseAddr;
  volatile uint32_t ID;
  volatile uint32_t LAPIC_Config;
  volatile uint32_t TPR;
  volatile uint32_t EOI;
  volatile uint32_t Timmer_Config;
  volatile uint32_t Timmer_Limit;
  volatile uint32_t IRR[4];
  volatile uint32_t MSI;
} LAPIC_Registers;

// Definimos la estructura de registros del LAPIC
volatile LAPIC_Registers *Registros =
    (volatile LAPIC_Registers *)(LAPIC_BASE_ADDR);

// ============================================================
// Intern functions
// ============================================================

// Manejador por defecto para IRQs no registradas
static uint32_t defaultIRQHandler(uint32_t eflags, uint32_t epc,
                                  uint32_t cause) {
  (void)eflags;
  irqOff();
  if (cause < MAX_IRQS)
    biosWrite("Fatal Error: Unhandled IRQ", 0);
  else
    biosWrite("Fatal Error: Over Limit IRQ", 0);
  __asm__ volatile("HLT");
  return epc;
}

// Routeo principal de IRQs / excepciones / syscalls.
void mainHandler(uint32_t *regs) {

  uint32_t epc;    // SR1  - EPC: dirección de retorno
  uint32_t eflags; // SR8  - EFlags: modo kernel/usuario + estado de INTs
  uint32_t flags;  // SR9  - Flags: estado de la ALU
  uint32_t carry;  // SR10 - Carry: overflow de la operación previa
  uint32_t cause;  // SR7  - Cause: motivo de la excepción / 0 si es SCL

  // ------------------------------------------------------------------
  // Guardado del estado especial
  // ------------------------------------------------------------------
  __asm__ __volatile__("CYE SR1, %0" : "=r"(epc));
  __asm__ __volatile__("CYE SR8, %0" : "=r"(eflags));
  __asm__ __volatile__("CYE SR9, %0" : "=r"(flags));
  __asm__ __volatile__("CYE SR10, %0" : "=r"(carry));
  __asm__ __volatile__("CYE SR7, %0" : "=r"(cause));

  // Si las interrupciones estaban habilitadas antes de entrar acá,
  // las volvemos a habilitar (permite anidar IRQs/excepciones).
  uint32_t eflags_off = eflags & ~EFLAGS_EN_INTS_MASK;
  if (eflags & EFLAGS_PREV_INTS_MASK) {
    uint32_t eflags_on = eflags_off | EFLAGS_EN_INTS_MASK;
    __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_on));
  }

  // ------------------------------------------------------------------
  // Despacho
  // ------------------------------------------------------------------
  if (cause != 0) {
    // Excepción / IRQ de hardware
    if (cause < MAX_IRQS && irq_table.handlers[cause] != NULL) {
      epc = irq_table.handlers[cause](eflags, epc);
    } else {
      epc = defaultIRQHandler(eflags, epc, cause);
    }
  } else {
    // Llamada al sistema (SCL)
    // Pasamos los registros para que la syscall pueda leer sus argumentos
    epc = syscallsHandler(regs, eflags, epc);
  }

  // ------------------------------------------------------------------
  // Restauración del estado especial
  // ------------------------------------------------------------------
  __asm__ __volatile__("CYR %0, SR8" : : "r"(eflags_off));

  __asm__ __volatile__("CYR %0, SR1" : : "r"(epc));
  __asm__ __volatile__("CYR %0, SR9" : : "r"(flags));
  __asm__ __volatile__("CYR %0, SR10" : : "r"(carry));

  // Solo enviar EOI al LAPIC si fue una interrupción externa de hardware
  if (cause >= 16) {
    Registros->EOI = 1; // Marcamos la IRQ de hardware como finalizada
  }
}

// Entrada al router de IRQs.
__attribute__((naked)) void entryHandler(void) {
  __asm__ volatile(
      // Reservamos 14 words (R1..R13, R15) en la pila
      "SLT ADI R14, 56 \n"
      "INT STR R14, R1, -56 \n"
      "INT STR R14, R2, -52 \n"
      "INT STR R14, R3, -48 \n"
      "INT STR R14, R4, -44 \n"
      "INT STR R14, R5, -40 \n"
      "INT STR R14, R6, -36 \n"
      "INT STR R14, R7, -32 \n"
      "INT STR R14, R8, -28 \n"
      "INT STR R14, R9, -24 \n"
      "INT STR R14, R10, -20 \n"
      "INT STR R14, R11, -16 \n"
      "INT STR R14, R12, -12 \n"
      "INT STR R14, R13, -8 \n"
      "INT STR R14, R15, -4 \n"

      // PASAR EL PUNTERO A mainHandler
      // R1 es el primer argumento en C. Le pasamos (R14 - 56), que es donde
      // empieza R1
      "SLT ADD R14, R0, R1 \n" // R14 = R1
      "SLT ADI R1, -56 \n"     // R1 = R14 - 56

      // Saltamos a mainHandler
      "H LDI R15, %hi(mainHandler) \n"
      "SLT ADI R15, %lo(mainHandler) \n"
      "CAL R15 \n"

      // Restauramos R1..R13, R15
      "INT LOD R14, R1, -56 \n"
      "INT LOD R14, R2, -52 \n"
      "INT LOD R14, R3, -48 \n"
      "INT LOD R14, R4, -44 \n"
      "INT LOD R14, R5, -40 \n"
      "INT LOD R14, R6, -36 \n"
      "INT LOD R14, R7, -32 \n"
      "INT LOD R14, R8, -28 \n"
      "INT LOD R14, R9, -24 \n"
      "INT LOD R14, R10, -20 \n"
      "INT LOD R14, R11, -16 \n"
      "INT LOD R14, R12, -12 \n"
      "INT LOD R14, R13, -8 \n"
      "INT LOD R14, R15, -4 \n"
      "SLT ADI R14, -56 \n"
      "SRT \n");
}

// ============================================================
// Extern functions
// ============================================================

// Cambiamos el TPR para habilitar o deshabilitar ciertas IRQs
inline void setTPR(uint32_t level) { Registros->TPR = level; }

// Inicialización de MSI
void initMSI(uint32_t base, uint32_t irq_num, IRQHandler handler) {
  base = base + ECAM_R(base, 0x24); // Base es igual a la direccion 0 del CP

  if ((ECAM_R(base, 0x0) & 0xFF) == 0x5) {

    // MSI suported
    uint32_t msi_reg = ECAM_R(base, 0x0);

    int cantREQ = (msi_reg >> 17) &
                  0x7; // Extraemos la cantidad de IRQ requeridas (Bits 17-19)

    // Limpiamos los bits superiores (16-31) para quitar valores residuales
    msi_reg &= 0x0000FFFF;

    // Le damos las IRQ que necesite en la "Cantidad dada" (Bits 20-22)
    msi_reg |= (cantREQ << 20);

    // Habilitamos las MSI (Bit 16)
    msi_reg |= (0x1 << 16);

    ECAM_W(base, 0x4,
           LAPIC_BASE_ADDR +
               0x2C); // Le indicamos la direccion del registro MSI en LAPIC

    ECAM_W(base, 0x8, irq_num); // Indicamos el numero de vector

    // Asignamos vector
    if (irq_num < MAX_IRQS && handler != NULL) {
      irq_table.handlers[irq_num] = handler;
    }

    // Escribimos la configuracion final, pero solo los 16 bits superiores
    ECAM_W(base, 0x0, msi_reg >> 16);
  }
}

// Inicialización de LAPIC
void initLAPIC() {
  // Establecemos os handles de excepciones
  irq_table.handlers[1] = &pageFault;
  irq_table.handlers[2] = &alignamentFault;
  irq_table.handlers[3] = &generalProtectionFault;
  irq_table.handlers[4] = &invalidOpCode;
  irq_table.handlers[5] = &doubleFault;

  __asm__ __volatile__("CYR %0, SR12"
                       :
                       : "r"(&entryHandler)); // Escribimos el sysJMP

  // Inicializamos LAPIC con prioridad maxima
  Registros->BaseAddr = LAPIC_BASE_ADDR; // Base del LAPIC
  Registros->ID = 0;                     // ID del LAPIC

  // Habilitamos todas las IRQs
  setTPR(0);                   // Bajamos la prioridad al minimo posible.
  Registros->LAPIC_Config = 3; // Habilitamos todo tipo de IRQ

  // Habilitamos IRQs
  irqOn();
}
