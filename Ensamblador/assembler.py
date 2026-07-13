#!/usr/bin/env python3
"""
=============================================================================
  Ensamblador — Procesador 32 bits
=============================================================================
  Convierte un archivo fuente .txt/.asm en un archivo de imagen de ROM
  compatible con Logisim (formato: v3.0 hex words addressed).

  Formato de instrucción (32 bits fijos):
    [31:29]  Tipo        (3 bits)   — modo de acceso a memoria o 000
    [28:24]  OpCode      (5 bits)   — código de operación
    [23:0]   Operandos   (24 bits)  — registros, inmediatos, condición

  Soporte de etiquetas:
    - Declaración:   mi_etiqueta:
    - Uso en saltos: JMP mi_etiqueta  /  BRH =, mi_etiqueta  /  CAL mi_etiqueta
    - El ensamblador expande automáticamente cada salto a etiqueta en
      6 instrucciones usando R14 (scratch bajo/shift) y R15 (scratch alto/dest):

        LDI  R15, <high16>      ; parte alta de la dirección de 32 bits
        LDI  R14, 16            ; cantidad de shift
        LSH  R15, R14, R15      ; mueve parte alta a [31:16]
        LDI  R14, <low16>       ; parte baja de la dirección
        ADD  R15, R14, R15      ; R15 = dirección completa de 32 bits
        JMP/BRH/CAL R15         ; salto efectivo

  Uso:
    python assembler.py                  → abre selector de archivo gráfico
    python assembler.py programa.txt     → ensamblado por CLI
=============================================================================
"""

import sys
import os
import re

# ─── Importación opcional de tkinter (GUI) ───────────────────────────────────
try:
    import tkinter as tk
    from tkinter import filedialog, scrolledtext
    HAS_TK = True
except ImportError:
    HAS_TK = False


# =============================================================================
#  CONFIGURACIÓN
# =============================================================================

# Ruta de salida por defecto (imagen ROM de Logisim)
ROM_OUTPUT_PATH = r"d:\Yo\Escritorio\Procesador-32-bits\System\Memory\ROM-Memory\ROM"

# Registros scratch reservados para expansión de etiquetas.
# ¡No usar R14 ni R15 para otros propósitos cuando se usan etiquetas!
SCRATCH_HIGH  = 15   # R15: guarda la parte alta desplazada / dirección final
SCRATCH_LOW   = 14   # R14: guarda la parte baja / cantidad de shift (temporal)


# =============================================================================
#  TABLA DE INSTRUCCIONES (ISA)
# =============================================================================

# OpCodes de 5 bits
OPCODES: dict[str, int] = {
    'NOP': 0b00000,   #  0 — No operación
    'HLT': 0b00001,   #  1 — Detiene el núcleo (kernel)
    'ADD': 0b00010,   #  2 — A + B → C            [flags]
    'SUB': 0b00011,   #  3 — A − B → C            [flags]
    'MUL': 0b00100,   #  4 — A × B → C            [flags]
    'DIV': 0b00101,   #  5 — A ÷ B → C            [flags]
    'NOR': 0b00110,   #  6 — NOR(A, B) → C        [flags]
    'AND': 0b00111,   #  7 — A AND B → C          [flags]
    'XOR': 0b01000,   #  8 — A XOR B → C          [flags]
    'RSH': 0b01001,   #  9 — A >> B → C           [flags]
    'LSH': 0b01010,   # 10 — A << B → C           [flags]
    'GOF': 0b01011,   # 11 — Recibe overflow/carry en RA
    'LDI': 0b01100,   # 12 — Carga inmediato en RA
    'ADI': 0b01101,   # 13 — Suma inmediato a RA   [kernel, flags]
    'JMP': 0b01110,   # 14 — Salto incondicional al valor de RB
    'BRH': 0b01111,   # 15 — Salto condicional al valor de RB
    'CAL': 0b10000,   # 16 — Llama subrutina en RB
    'RET': 0b10001,   # 17 — Vuelve al punto anterior + 1
    'LOD': 0b10010,   # 18 — RAM[RA + Offset] → RB
    'STR': 0b10011,   # 19 — RB → RAM[RA + Offset]
    'CYE': 0b10100,   # 20 — Registro especial → normal
    'CYR': 0b10101,   # 21 — Registro normal → especial  [kernel]
    'SCL': 0b10110,   # 22 — Llama al SO
    'SRT': 0b10111,   # 23 — Vuelve al SO (dirección en EPC) [kernel]
}

# Prefijos de tipo de acceso a memoria (3 bits → campo Tipo [31:29])
MEM_TYPES: dict[str, int] = {
    'CHAR':  0b000,   # 8 bits
    'SHORT': 0b001,   # 16 bits
    'INT':   0b010,   # 32 bits
}

# Instrucciones que REQUIEREN prefijo de tipo de memoria
MEM_INSTRUCTIONS = {'LOD', 'STR'}

# Instrucciones de salto que pueden recibir etiqueta como operando
JUMP_INSTRUCTIONS = {'JMP', 'BRH', 'CAL'}

# ── Condiciones para BRH (4 bits en [23:20]) ─────────────────────────────────
# Orden especificado: =  !=  >  <  >=  <=  OV  NOV  (empezando en 0)
CONDITIONS: dict[str, int] = {
    '=':   0b0000,   # 0 — Igual         (Zero flag activo)
    'EQ':  0b0000,   #     Alias de =
    '!=':  0b0001,   # 1 — Distinto      (Zero flag inactivo)
    'NE':  0b0001,   #     Alias de !=
    '>':   0b0010,   # 2 — Mayor que     (con signo)
    'GT':  0b0010,   #     Alias de >
    '<':   0b0011,   # 3 — Menor que     (con signo)
    'LT':  0b0011,   #     Alias de <
    '>=':  0b0100,   # 4 — Mayor o igual (con signo)
    'GE':  0b0100,   #     Alias de >=
    '<=':  0b0101,   # 5 — Menor o igual (con signo)
    'LE':  0b0101,   #     Alias de <=
    'OV':  0b0110,   # 6 — Overflow activo
    'NOV': 0b0111,   # 7 — Sin overflow
}


# =============================================================================
#  ERRORES
# =============================================================================

class AssemblerError(Exception):
    """Error de ensamblado con número de línea fuente."""
    def __init__(self, message: str, line_number: int | None = None):
        self.line_number = line_number
        prefix = f"[Línea {line_number}] " if line_number is not None else ""
        super().__init__(f"{prefix}{message}")


# =============================================================================
#  PARSING AUXILIAR
# =============================================================================

def parse_register(token: str, line_num: int) -> int:
    """Parsea R0–R15, devuelve el número 0–15."""
    token = token.strip().upper()
    if not re.fullmatch(r'R(1[0-5]|[0-9])', token):
        raise AssemblerError(
            f"Registro inválido: '{token}'. Use R0–R15.", line_num
        )
    return int(token[1:])


def parse_immediate(token: str, line_num: int, bits: int = 16,
                    signed: bool = False) -> int:
    """
    Parsea un valor inmediato (decimal, 0xHEX, 0bBIN).
    Soporta negativos si signed=True (convierte a complemento a dos).
    Máximo de bits configurable.
    """
    token = token.strip()
    try:
        if token.lower().startswith('0x'):
            value = int(token, 16)
        elif token.lower().startswith('0b'):
            value = int(token, 2)
        else:
            value = int(token)
    except ValueError:
        raise AssemblerError(
            f"Inmediato inválido: '{token}'. "
            f"Use decimal (123), hexadecimal (0xFF) o binario (0b1010).",
            line_num
        )

    if signed:
        min_v = -(1 << (bits - 1))
        max_v = (1 << bits) - 1
        if not (min_v <= value <= max_v):
            raise AssemblerError(
                f"Inmediato {value} fuera de rango [{min_v}, {max_v}] "
                f"para {bits} bits con signo.", line_num
            )
        if value < 0:
            value = value & ((1 << bits) - 1)   # Complemento a dos
    else:
        max_v = (1 << bits) - 1
        if not (0 <= value <= max_v):
            raise AssemblerError(
                f"Inmediato {value} fuera de rango [0, {max_v}] "
                f"para {bits} bits.", line_num
            )
    return value


def is_label_name(token: str) -> bool:
    """Verifica si el token es un nombre de etiqueta válido (no número ni registro)."""
    # Etiqueta: empieza con letra o _, solo letras/dígitos/_
    return bool(re.fullmatch(r'[A-Za-z_][A-Za-z0-9_]*', token))


# =============================================================================
#  CONSTRUCCIÓN DE PALABRAS
# =============================================================================

def build_word(tipo: int, opcode: int, operands: int) -> int:
    """
    Ensambla una palabra de 32 bits.
    [31:29] tipo (3b) | [28:24] opcode (5b) | [23:0] operands (24b)
    """
    return (tipo << 29) | (opcode << 24) | (operands & 0xFFFFFF)


def expand_label_address(address: int, jump_mnemonic: str,
                          cond: int | None, src_line: int) -> list[int]:
    """
    Expande un salto a etiqueta en 6 palabras de 32 bits.

    Para la dirección de 32 bits:
      1) LDI  R15, <high16>      → parte alta
      2) LDI  R14, 16            → cantidad de shift
      3) LSH  R15, R14, R15      → R15 = high16 << 16
      4) LDI  R14, <low16>       → parte baja
      5) ADD  R15, R14, R15      → R15 = dirección completa
      6) JMP/BRH/CAL  R15        → salto efectivo

    Por qué siempre 6 instrucciones:
      Mantener tamaño fijo permite que el ensamblador resuelva
      correctamente las referencias hacia adelante (forward references)
      sin iteraciones adicionales, ya que el tamaño de cada bloque
      es conocido desde el primer pase.
    """
    hi = SCRATCH_HIGH
    lo = SCRATCH_LOW

    high16 = (address >> 16) & 0xFFFF
    low16  =  address        & 0xFFFF

    # 1: LDI R15, high16
    w1 = build_word(0, OPCODES['LDI'], (hi << 20) | high16)
    # 2: LDI R14, 16
    w2 = build_word(0, OPCODES['LDI'], (lo << 20) | 16)
    # 3: LSH R15, R14, R15  → [23:20]=R15, [19:16]=R14, [15:12]=R15
    w3 = build_word(0, OPCODES['LSH'], (hi << 20) | (lo << 16) | (hi << 12))
    # 4: LDI R14, low16
    w4 = build_word(0, OPCODES['LDI'], (lo << 20) | low16)
    # 5: ADD R15, R14, R15
    w5 = build_word(0, OPCODES['ADD'], (hi << 20) | (lo << 16) | (hi << 12))

    # 6: instrucción de salto efectiva usando R15
    if jump_mnemonic == 'JMP':
        w6 = build_word(0, OPCODES['JMP'], hi << 16)
    elif jump_mnemonic == 'CAL':
        w6 = build_word(0, OPCODES['CAL'], hi << 16)
    elif jump_mnemonic == 'BRH':
        # cond en [23:20], R15 en [19:16]
        w6 = build_word(0, OPCODES['BRH'], (cond << 20) | (hi << 16))
    else:
        raise AssemblerError(
            f"Instrucción de salto desconocida: '{jump_mnemonic}'", src_line
        )

    return [w1, w2, w3, w4, w5, w6]


# =============================================================================
#  CODIFICACIÓN DE INSTRUCCIÓN SIMPLE
# =============================================================================

def _require_argc(args: list, expected: int, mnemonic: str,
                  line_num: int, hint: str = "") -> None:
    if len(args) != expected:
        hint_str = f" Ej: {hint}" if hint else ""
        raise AssemblerError(
            f"'{mnemonic}' espera {expected} operando(s), "
            f"se recibieron {len(args)}.{hint_str}", line_num
        )


def encode_single(tokens: list[str], line_num: int) -> int:
    """
    Codifica una sola instrucción (sin expandir etiquetas).
    Solo se llama con instrucciones que NO requieren expansión de etiqueta.
    """
    first = tokens[0].upper()

    # Detectar prefijo de tipo de memoria
    tipo = 0b000
    if first in MEM_TYPES:
        tipo = MEM_TYPES[first]
        tokens = tokens[1:]
        if not tokens:
            raise AssemblerError(
                f"Se esperaba nemotécnico después de '{first}'.", line_num
            )
        first = tokens[0].upper()
    elif first in MEM_INSTRUCTIONS:
        raise AssemblerError(
            f"'{first}' requiere prefijo de tipo: char, short o int.", line_num
        )

    mnemonic = first
    args     = tokens[1:]

    if mnemonic not in OPCODES:
        raise AssemblerError(
            f"Nemotécnico desconocido: '{mnemonic}'. "
            f"Válidos: {', '.join(sorted(OPCODES.keys()))}", line_num
        )
    if tipo != 0b000 and mnemonic not in MEM_INSTRUCTIONS:
        raise AssemblerError(
            f"El prefijo de tipo de memoria no aplica a '{mnemonic}'.", line_num
        )

    op = OPCODES[mnemonic]

    # ── Sin operandos ────────────────────────────────────────────────────────
    if mnemonic in ('NOP', 'HLT', 'RET', 'SCL', 'SRT'):
        _require_argc(args, 0, mnemonic, line_num)
        return build_word(0, op, 0)

    # ── Tres registros: ADD SUB MUL DIV NOR AND XOR RSH LSH ─────────────────
    #    [23:20]=RA  [19:16]=RB  [15:12]=RC
    elif mnemonic in ('ADD','SUB','MUL','DIV','NOR','AND','XOR','RSH','LSH'):
        _require_argc(args, 3, mnemonic, line_num,
                      hint=f"{mnemonic} R0, R1, R2")
        ra = parse_register(args[0], line_num)
        rb = parse_register(args[1], line_num)
        rc = parse_register(args[2], line_num)
        return build_word(0, op, (ra << 20) | (rb << 16) | (rc << 12))

    # ── GOF — [23:20]=RA ────────────────────────────────────────────────────
    elif mnemonic == 'GOF':
        _require_argc(args, 1, 'GOF', line_num, hint="GOF R0")
        ra = parse_register(args[0], line_num)
        return build_word(0, op, ra << 20)

    # ── LDI — [23:20]=RA  [15:0]=IMM16 ─────────────────────────────────────
    elif mnemonic == 'LDI':
        _require_argc(args, 2, 'LDI', line_num, hint="LDI R0, 1000")
        ra  = parse_register(args[0], line_num)
        imm = parse_immediate(args[1], line_num, bits=16, signed=False)
        return build_word(0, op, (ra << 20) | imm)

    # ── ADI — [23:20]=RA  [15:0]=IMM16 (con signo) ──────────────────────────
    elif mnemonic == 'ADI':
        _require_argc(args, 2, 'ADI', line_num, hint="ADI R0, -5")
        ra  = parse_register(args[0], line_num)
        imm = parse_immediate(args[1], line_num, bits=16, signed=True)
        return build_word(0, op, (ra << 20) | imm)

    # ── JMP — [19:16]=RB ────────────────────────────────────────────────────
    elif mnemonic == 'JMP':
        _require_argc(args, 1, 'JMP', line_num, hint="JMP R1  ó  JMP etiqueta")
        rb = parse_register(args[0], line_num)
        return build_word(0, op, rb << 16)

    # ── BRH — [23:20]=COND  [19:16]=RB ─────────────────────────────────────
    elif mnemonic == 'BRH':
        _require_argc(args, 2, 'BRH', line_num, hint="BRH =, R1  ó  BRH !=, etiqueta")
        cond_tok = args[0].strip()
        if cond_tok.upper() in CONDITIONS:
            cond = CONDITIONS[cond_tok.upper()]
        elif cond_tok in CONDITIONS:
            cond = CONDITIONS[cond_tok]
        else:
            valid = '  '.join(CONDITIONS.keys())
            raise AssemblerError(
                f"Condición inválida: '{cond_tok}'. Válidas: {valid}", line_num
            )
        rb = parse_register(args[1], line_num)
        return build_word(0, op, (cond << 20) | (rb << 16))

    # ── CAL — [19:16]=RB ────────────────────────────────────────────────────
    elif mnemonic == 'CAL':
        _require_argc(args, 1, 'CAL', line_num, hint="CAL R1  ó  CAL subrutina")
        rb = parse_register(args[0], line_num)
        return build_word(0, op, rb << 16)

    # ── LOD — [31:29]=Tipo  [23:20]=RA  [19:16]=RB  [15:0]=Offset ──────────
    elif mnemonic == 'LOD':
        _require_argc(args, 3, 'LOD', line_num,
                      hint="int LOD R0, R1, 100")
        ra     = parse_register(args[0], line_num)
        rb     = parse_register(args[1], line_num)
        offset = parse_immediate(args[2], line_num, bits=16, signed=True)
        return build_word(tipo, op, (ra << 20) | (rb << 16) | offset)

    # ── STR — [31:29]=Tipo  [23:20]=RA  [19:16]=RB  [15:0]=Offset ──────────
    elif mnemonic == 'STR':
        _require_argc(args, 3, 'STR', line_num,
                      hint="int STR R0, R1, 0")
        ra     = parse_register(args[0], line_num)
        rb     = parse_register(args[1], line_num)
        offset = parse_immediate(args[2], line_num, bits=16, signed=True)
        return build_word(tipo, op, (ra << 20) | (rb << 16) | offset)

    # ── CYE — [23:20]=RC (especial)  [19:16]=RA (normal) ───────────────────
    elif mnemonic == 'CYE':
        _require_argc(args, 2, 'CYE', line_num, hint="CYE R0, R1")
        rc = parse_register(args[0], line_num)
        ra = parse_register(args[1], line_num)
        return build_word(0, op, (rc << 20) | (ra << 16))

    # ── CYR — [23:20]=RA (normal → especial) ────────────────────────────────
    elif mnemonic == 'CYR':
        _require_argc(args, 1, 'CYR', line_num, hint="CYR R0")
        ra = parse_register(args[0], line_num)
        return build_word(0, op, ra << 20)

    else:
        raise AssemblerError(
            f"Instrucción sin codificador: '{mnemonic}'.", line_num
        )


# =============================================================================
#  TOKENIZADOR
# =============================================================================

def tokenize_line(raw_line: str) -> list[str]:
    """
    Elimina comentarios (;) y divide la línea en tokens.
    Separadores: espacios, tabs, comas.
    """
    code = raw_line.split(';')[0].strip()
    if not code:
        return []
    return [t for t in re.split(r'[\s,]+', code) if t]


# =============================================================================
#  ENSAMBLADOR EN DOS PASOS
# =============================================================================

# Representa una instrucción antes de la resolución de etiquetas
class PendingInstruction:
    """
    Instrucción que puede necesitar expansión de etiqueta.
    
    Si 'label_target' no es None, esta instrucción es un salto a etiqueta
    y se expandirá en 6 palabras durante el segundo pase.
    Si es None, 'words' ya tiene la palabra final codificada.
    """
    def __init__(self, words: list[int] | None = None,
                 label_target: str | None = None,
                 jump_mnemonic: str | None = None,
                 cond: int | None = None,
                 src_line: int = 0,
                 size: int = 1):
        self.words         = words          # Palabras ya codificadas
        self.label_target  = label_target   # Nombre de etiqueta a resolver
        self.jump_mnemonic = jump_mnemonic  # JMP / BRH / CAL
        self.cond          = cond           # Condición para BRH (o None)
        self.src_line      = src_line       # Número de línea fuente
        self.size          = size           # Cuántas palabras ocupa (1 o 6)


def first_pass(lines: list[str]) -> tuple[dict[str, int], list[PendingInstruction], list[str]]:
    """
    PRIMER PASE: detecta etiquetas y construye la lista de instrucciones pendientes.

    - Las instrucciones simples se codifican en este pase.
    - Los saltos a etiqueta se marcan como PendingInstruction(size=6)
      para que la dirección de cada etiqueta sea correcta aunque
      la etiqueta esté definida más adelante (forward reference).
    - Las etiquetas se almacenan en 'label_map' con su dirección
      (en palabras, no bytes).

    Devuelve: (label_map, pending_list, errors)
    """
    label_map: dict[str, int] = {}
    pending:   list[PendingInstruction] = []
    errors:    list[str] = []
    address = 0   # Dirección actual en palabras de 32 bits

    for line_num, raw_line in enumerate(lines, start=1):
        tokens = tokenize_line(raw_line)
        if not tokens:
            continue

        # ── Detectar definición de etiqueta ──────────────────────────────────
        # Puede ser solo "mi_etiqueta:" o "mi_etiqueta: INSTRUCCION operandos"
        label_token = tokens[0]
        if label_token.endswith(':'):
            name = label_token[:-1]
            if not re.fullmatch(r'[A-Za-z_][A-Za-z0-9_]*', name):
                errors.append(f"[Línea {line_num}] Nombre de etiqueta inválido: '{name}'.")
                continue
            if name in label_map:
                errors.append(
                    f"[Línea {line_num}] Etiqueta duplicada: '{name}' "
                    f"(ya definida en dirección {label_map[name]:08X})."
                )
                continue
            label_map[name] = address
            tokens = tokens[1:]   # Remover el token de etiqueta
            if not tokens:
                continue          # Línea solo con etiqueta

        # ── Detectar salto a etiqueta ─────────────────────────────────────────
        # Detectar prefijo de tipo de memoria (no aplica a saltos, pero avanzamos)
        first = tokens[0].upper()
        mem_prefix = None
        if first in MEM_TYPES:
            mem_prefix = first
            if len(tokens) > 1:
                first = tokens[1].upper()

        mnemonic = first

        # ¿Es un salto que podría tener etiqueta como destino?
        if mnemonic in JUMP_INSTRUCTIONS:
            # Determinar cuál token es el posible destino
            args = tokens[1:]   # Operandos del nemotécnico

            # BRH tiene condición como primer operando: BRH =, destino
            if mnemonic == 'BRH':
                if len(args) >= 2:
                    dest_tok = args[1].strip()
                else:
                    dest_tok = None
            else:
                # JMP / CAL: un solo operando = destino
                dest_tok = args[0].strip() if args else None

            # ¿El destino es una etiqueta (no un registro)?
            if dest_tok and is_label_name(dest_tok) and not re.fullmatch(r'R(1[0-5]|[0-9])', dest_tok.upper()):
                # Reservar 6 posiciones (expansión de dirección de 32 bits)
                cond = None
                if mnemonic == 'BRH':
                    cond_tok = args[0].strip()
                    if cond_tok.upper() in CONDITIONS:
                        cond = CONDITIONS[cond_tok.upper()]
                    elif cond_tok in CONDITIONS:
                        cond = CONDITIONS[cond_tok]
                    else:
                        errors.append(
                            f"[Línea {line_num}] Condición inválida: '{cond_tok}'."
                        )
                        continue

                pending.append(PendingInstruction(
                    label_target  = dest_tok,
                    jump_mnemonic = mnemonic,
                    cond          = cond,
                    src_line      = line_num,
                    size          = 6,   # Siempre 6 palabras por diseño
                ))
                address += 6
                continue

        # ── Instrucción normal (codificación directa) ─────────────────────────
        try:
            word = encode_single(tokens, line_num)
            pending.append(PendingInstruction(
                words    = [word],
                src_line = line_num,
                size     = 1,
            ))
            address += 1
        except AssemblerError as e:
            errors.append(str(e))

    return label_map, pending, errors


def second_pass(label_map: dict[str, int],
                pending: list[PendingInstruction]
                ) -> tuple[list[tuple[int, int, int]], list[str]]:
    """
    SEGUNDO PASE: resuelve las referencias a etiquetas y genera las palabras finales.

    Cada PendingInstruction con label_target se expande en 6 palabras
    usando la dirección registrada en label_map durante el primer pase.

    Devuelve: ([(src_line, address, word), ...], errors)
    """
    result: list[tuple[int, int, int]] = []
    errors: list[str] = []
    address = 0

    for instr in pending:
        if instr.label_target is not None:
            # Resolver etiqueta
            name = instr.label_target
            if name not in label_map:
                errors.append(
                    f"[Línea {instr.src_line}] Etiqueta no definida: '{name}'."
                )
                address += 6
                continue

            target_addr = label_map[name]
            words = expand_label_address(
                target_addr,
                instr.jump_mnemonic,
                instr.cond,
                instr.src_line,
            )
            for w in words:
                result.append((instr.src_line, address, w))
                address += 1
        else:
            for w in instr.words:
                result.append((instr.src_line, address, w))
                address += 1

    return result, errors


def assemble_source(source_path: str
                    ) -> tuple[list[tuple[int,int,int]], list[str], dict[str,int]]:
    """
    Pipeline completo de ensamblado.
    Devuelve: (instructions, errors, label_map)
    """
    try:
        with open(source_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except OSError as e:
        return [], [f"No se pudo abrir el archivo: {e}"], {}

    label_map, pending, errors1 = first_pass(lines)
    if errors1:
        return [], errors1, label_map

    instructions, errors2 = second_pass(label_map, pending)
    return instructions, errors2, label_map


# =============================================================================
#  ESCRITURA DEL ARCHIVO ROM (Logisim v3.0 hex words addressed)
# =============================================================================

def write_rom_logisim(instructions: list[tuple[int,int,int]],
                      output_path: str) -> None:
    """
    Escribe la imagen de ROM en formato Logisim:
        v3.0 hex words addressed

    Cada instrucción de 32 bits se almacena como 4 bytes en orden big-endian.
    La dirección en el archivo es de bytes: addr_byte = addr_word * 4.

    Formato de salida:
        v3.0 hex words addressed
        00000: BB BB BB BB BB BB BB BB BB BB BB BB BB BB BB BB
        00010: ...

    Las líneas tienen 16 bytes (4 instrucciones) por fila.
    Las filas vacías (solo ceros) se omiten para mantener el archivo compacto.
    """
    # Construir mapa de dirección de bytes → byte individual
    byte_map: dict[int, int] = {}
    for _, word_addr, word in instructions:
        byte_addr = word_addr * 4   # Cada instrucción = 4 bytes
        byte_map[byte_addr + 0] = (word >> 24) & 0xFF
        byte_map[byte_addr + 1] = (word >> 16) & 0xFF
        byte_map[byte_addr + 2] = (word >>  8) & 0xFF
        byte_map[byte_addr + 3] =  word        & 0xFF

    if not byte_map:
        return

    max_byte_addr = max(byte_map.keys())

    # Agrupar en filas de 16 bytes, empezando desde la primera fila con datos
    BYTES_PER_ROW = 16
    first_row = 0
    last_row  = (max_byte_addr // BYTES_PER_ROW) * BYTES_PER_ROW

    # Asegurar que el directorio padre existe
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("v3.0 hex words addressed\n")

        row = first_row
        while row <= last_row:
            row_bytes = [byte_map.get(row + i, 0) for i in range(BYTES_PER_ROW)]
            # Solo escribir filas que tengan al menos un byte no cero
            if any(b != 0 for b in row_bytes):
                hex_bytes = ' '.join(f"{b:02x}" for b in row_bytes)
                f.write(f"{row:05x}: {hex_bytes}\n")
            row += BYTES_PER_ROW


def write_annotated_hex(instructions: list[tuple[int,int,int]],
                        label_map: dict[str, int],
                        output_path: str) -> None:
    """
    Escribe un archivo .hex anotado (solo para depuración / referencia humana).
    No es para Logisim, sino para que el programador pueda inspeccionar el código.
    """
    # Mapa invertido de dirección → nombre de etiqueta
    addr_to_label = {v: k for k, v in label_map.items()}

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("; =====================================================\n")
        f.write(";  Listado anotado — Procesador 32 bits\n")
        f.write(f";  Instrucciones: {len(instructions)}\n")
        f.write(";\n")
        f.write(";  WADDR BADDR    HEX       BINARIO (Tipo|Op | Operandos)\n")
        f.write("; =====================================================\n")

        for src_line, waddr, word in instructions:
            # Mostrar etiqueta si corresponde
            if waddr in addr_to_label:
                f.write(f";\n; [{addr_to_label[waddr]}:]\n")

            baddr   = waddr * 4
            bin_str = f"{word:032b}"
            b       = [bin_str[i*8:(i+1)*8] for i in range(4)]
            f.write(
                f"{waddr:05X} {baddr:06X}  {word:08X}  "
                f"{b[0]} {b[1]} {b[2]} {b[3]}"
                f"  (L{src_line})\n"
            )


# =============================================================================
#  INTERFAZ GRÁFICA (tkinter)
# =============================================================================

class AssemblerGUI:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("Ensamblador — Procesador 32 bits")
        self.root.geometry("860x600")
        self.root.resizable(True, True)
        self._build_ui()

    def _build_ui(self):
        # ── Barra superior ────────────────────────────────────────────────────
        top = tk.Frame(self.root, pady=8, padx=12)
        top.pack(fill='x')

        tk.Label(top, text="Fuente:").pack(side='left')
        self.path_var = tk.StringVar()
        tk.Entry(top, textvariable=self.path_var, width=52).pack(side='left', padx=5)
        tk.Button(top, text="Examinar…",  command=self._browse).pack(side='left')
        tk.Button(top, text="Ensamblar ▶", command=self._run,
                  bg='#2a7ae2', fg='white', relief='flat',
                  padx=10).pack(side='left', padx=8)

        # ── ROM de salida ─────────────────────────────────────────────────────
        rom_frame = tk.Frame(self.root, padx=12)
        rom_frame.pack(fill='x')
        tk.Label(rom_frame, text="ROM salida:").pack(side='left')
        self.rom_var = tk.StringVar(value=ROM_OUTPUT_PATH)
        tk.Entry(rom_frame, textvariable=self.rom_var, width=65).pack(side='left', padx=5)
        tk.Button(rom_frame, text="…", command=self._browse_rom).pack(side='left')

        # ── Área de log ───────────────────────────────────────────────────────
        lf = tk.Frame(self.root, padx=12, pady=4)
        lf.pack(fill='both', expand=True)
        tk.Label(lf, text="Salida / Errores:", anchor='w').pack(fill='x')
        self.log = scrolledtext.ScrolledText(
            lf, font=('Consolas', 10), wrap='none',
            state='disabled', height=30
        )
        self.log.pack(fill='both', expand=True)
        self.log.tag_config('ok',    foreground='#22c55e')
        self.log.tag_config('error', foreground='#ef4444')
        self.log.tag_config('info',  foreground='#60a5fa')
        self.log.tag_config('head',  foreground='#facc15',
                            font=('Consolas', 10, 'bold'))
        self.log.tag_config('lbl',   foreground='#f97316')

    def _browse(self):
        p = filedialog.askopenfilename(
            title="Seleccionar archivo fuente",
            filetypes=[("Ensamblador", "*.txt *.asm"), ("Todos", "*.*")]
        )
        if p:
            self.path_var.set(p)

    def _browse_rom(self):
        p = filedialog.asksaveasfilename(
            title="Guardar ROM como…",
            initialfile="ROM",
            defaultextension="",
        )
        if p:
            self.rom_var.set(p)

    def _log(self, text: str, tag: str = ''):
        self.log.config(state='normal')
        self.log.insert('end', text + '\n', tag)
        self.log.see('end')
        self.log.config(state='disabled')

    def _clear(self):
        self.log.config(state='normal')
        self.log.delete('1.0', 'end')
        self.log.config(state='disabled')

    def _run(self):
        self._clear()
        source   = self.path_var.get().strip()
        rom_path = self.rom_var.get().strip()

        if not source:
            self._log("⚠  Selecciona primero un archivo fuente.", 'error')
            return
        if not os.path.isfile(source):
            self._log(f"✗  Archivo no encontrado: {source}", 'error')
            return

        self._log("══════════════════════════════════════════", 'head')
        self._log(f"  Ensamblando: {os.path.basename(source)}", 'head')
        self._log("══════════════════════════════════════════", 'head')

        instructions, errors, label_map = assemble_source(source)

        if errors:
            self._log(f"\n✗  {len(errors)} error(es):\n", 'error')
            for e in errors:
                self._log(f"  {e}", 'error')
            return

        # Escribir ROM
        write_rom_logisim(instructions, rom_path)
        # Escribir listado anotado junto al fuente
        ann_path = os.path.splitext(source)[0] + "_listado.hex"
        write_annotated_hex(instructions, label_map, ann_path)

        self._log(f"\n✓  {len(instructions)} palabra(s) ensamblada(s).\n", 'ok')
        self._log(f"  ROM Logisim : {rom_path}", 'ok')
        self._log(f"  Listado     : {ann_path}", 'ok')

        # Mostrar etiquetas
        if label_map:
            self._log("\n  Etiquetas definidas:", 'lbl')
            for name, addr in sorted(label_map.items(), key=lambda x: x[1]):
                self._log(f"    {name:<20} → word {addr:05X}  byte {addr*4:06X}", 'lbl')

        # Previsualización
        self._log("\n  WADDR BADDR    HEX       BINARIO", 'info')
        self._log("  ─────────────────────────────────────────────", 'info')
        addr_to_label = {v: k for k, v in label_map.items()}
        shown = 0
        for src_line, waddr, word in instructions:
            if waddr in addr_to_label:
                self._log(f"\n  [{addr_to_label[waddr]}:]", 'lbl')
            if shown < 40:
                b    = f"{word:032b}"
                bstr = f"{b[0:8]} {b[8:16]} {b[16:24]} {b[24:32]}"
                self._log(
                    f"  {waddr:05X} {waddr*4:06X}  {word:08X}  {bstr}  (L{src_line})"
                )
                shown += 1
        if len(instructions) > 40:
            self._log(f"\n  … y {len(instructions)-40} palabra(s) más.", 'info')


# =============================================================================
#  PUNTO DE ENTRADA
# =============================================================================

def main():
    if len(sys.argv) > 1:
        # ── Modo CLI ──────────────────────────────────────────────────────────
        source_path = sys.argv[1]
        rom_path    = sys.argv[2] if len(sys.argv) > 2 else ROM_OUTPUT_PATH

        print("=" * 62)
        print("  Ensamblador — Procesador 32 bits")
        print("=" * 62)

        if not os.path.isfile(source_path):
            print(f"[ERROR] Archivo no encontrado: {source_path}")
            sys.exit(1)

        instructions, errors, label_map = assemble_source(source_path)

        if errors:
            print(f"[ERROR] {len(errors)} error(es):\n")
            for e in errors:
                print(f"  {e}")
            sys.exit(1)

        write_rom_logisim(instructions, rom_path)
        ann_path = os.path.splitext(source_path)[0] + "_listado.hex"
        write_annotated_hex(instructions, label_map, ann_path)

        print(f"[OK] {len(instructions)} palabra(s) ensamblada(s).")
        print(f"[OK] ROM Logisim : {rom_path}")
        print(f"[OK] Listado     : {ann_path}")

        if label_map:
            print("\n[Etiquetas]")
            for name, addr in sorted(label_map.items(), key=lambda x: x[1]):
                print(f"  {name:<20} -> word 0x{addr:05X}  byte 0x{addr*4:06X}")
        sys.exit(0)

    # ── Modo GUI ──────────────────────────────────────────────────────────────
    if not HAS_TK:
        print("[ERROR] tkinter no está disponible.")
        print("  Uso: python assembler.py fuente.txt [salida_ROM]")
        sys.exit(1)

    root = tk.Tk()
    AssemblerGUI(root)
    root.mainloop()


if __name__ == '__main__':
    main()
