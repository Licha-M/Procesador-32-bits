#!/usr/bin/env python3
"""
=============================================================================
  Ensamblador — Procesador 32 bits  (compatible con salida LLVM / ISA32_LM)
=============================================================================
  Convierte un archivo fuente .txt/.asm/.s en un archivo de imagen de ROM
  compatible con Logisim (formato: v3.0 hex words addressed).

  También puede compilar uno o más archivos .c/.C invocando el backend
  LLVM/clang configurado en COMPILER_CMD_TEMPLATE y luego ensamblando
  el .s combinado resultante.

  Formato de instrucción (32 bits fijos):
    [31:29]  Tipo        (3 bits)   — modo de acceso a memoria o prefijo
    [28:24]  OpCode      (5 bits)   — código de operación
    [23:0]   Operandos   (24 bits)  — registros, inmediatos, condición

  CAMBIOS respecto al ensamblador original:
  ─────────────────────────────────────────
  [NUEVO]  Soporte de sintaxis LLVM:
             • Directivas ignoradas: .file, .text, .globl, .type, .size,
               .ident, .section ".note.GNU-stack"
             • Sección .rodata + directivas .p2align y .long
             • Etiquetas locales LLVM (.LBBn_m, .Lfunc_endN, etc.)
             • Etiquetas entre comillas dobles (nombres mangled C++)
             • Pseudo-operadores %hi(label) y %lo(label)
  [NUEVO]  Modo multi-archivo .c → .s → ROM (sección 4 del spec)
  [NUEVO]  CLI extendido: --no-list, múltiples archivos .c
  [NUEVO]  GUI extendida: selección múltiple, acepta .c/.C
  [ELIMINADO] Auto-expansión de saltos a etiqueta (ya la hace LLVM)
  [ELIMINADO] Auto-expansión de LDI de 32 bits (ya la hace LLVM)
  [MANTENIDO] Todo lo demás: opcodes, codificación, formato ROM, vector reset

  Uso:
    python assembler.py                              → GUI
    python assembler.py programa.s [ROM]             → ensambla .s/.asm/.txt
    python assembler.py [--no-list] f1.c f2.c [ROM] → compila+ensambla .c
=============================================================================
"""

import sys
import os
import re
import subprocess
import shutil
import tempfile

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

# [NUEVO] Plantilla de comando para compilar .c → .s con el backend LLVM/clang.
# Usar {input} para el archivo de entrada y {output} para el .s de salida.
# Ejemplo (ajusta flags, triple y CPU a tu instalación):
#   clang -target ISA32_LM --mtriple=ISA32_LM -S -o {output} {input}
# Si dejas la variable vacía ("") el modo de compilación C quedará deshabilitado.
COMPILER_CMD_TEMPLATE = ""  # <-- COMPLETAR con el comando exacto de tu clang

# [NUEVO] Nombre del .s combinado cuando se compilan varios .c (relativo al
# directorio del primer .c si no se indica ruta de salida).
COMBINED_ASM_SUFFIX = "_combined.s"


# =============================================================================
#  TABLA DE INSTRUCCIONES (ISA) — copiar exacta del original
# =============================================================================

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

MEM_TYPES: dict[str, int] = {
    'CHAR':  0b000,   # 8 bits
    'SHORT': 0b001,   # 16 bits
    'INT':   0b010,   # 32 bits
}

MEM_INSTRUCTIONS = {'LOD', 'STR'}

CONDITIONS: dict[str, int] = {
    '=':   0b0000,
    'EQ':  0b0000,
    '!=':  0b0001,
    'NE':  0b0001,
    'N':   0b0010,
    'NEG': 0b0010,
    'NN':  0b0011,
    'POS': 0b0011,
    'C':   0b0100,
    'CS':  0b0100,
    'NC':  0b0101,
    'CC':  0b0101,
    'OV':  0b0110,
    'NOV': 0b0111,
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


# [NUEVO] Regex para nombres de etiqueta válidos en el nuevo ensamblador.
# Acepta:
#   - Etiquetas clásicas:       [A-Za-z_][A-Za-z0-9_]*
#   - Etiquetas locales LLVM:   .[A-Za-z_][A-Za-z0-9_.$]*
#   - Etiquetas entre comillas: "cualquier cosa" (se quitan las comillas)
_LABEL_PLAIN_RE  = re.compile(r'^[A-Za-z_][A-Za-z0-9_]*$')
_LABEL_LOCAL_RE  = re.compile(r'^\.[A-Za-z_][A-Za-z0-9_.@$]*$')
_LABEL_QUOTED_RE = re.compile(r'^"([^"]*)"$')

def normalize_label(raw: str) -> str | None:
    """
    Normaliza un nombre de etiqueta (quita comillas si las tiene).
    Devuelve el nombre normalizado, o None si no es una etiqueta válida.
    """
    raw = raw.strip()
    m = _LABEL_QUOTED_RE.match(raw)
    if m:
        return m.group(1)   # Contenido sin comillas
    if _LABEL_PLAIN_RE.match(raw) or _LABEL_LOCAL_RE.match(raw):
        return raw
    return None


def is_valid_label_name(token: str) -> bool:
    return normalize_label(token) is not None


# =============================================================================
#  CONSTRUCCIÓN DE PALABRAS — copiar exacta del original
# =============================================================================

def build_word(tipo: int, opcode: int, operands: int) -> int:
    """
    Ensambla una palabra de 32 bits.
    [31:29] tipo (3b) | [28:24] opcode (5b) | [23:0] operands (24b)
    """
    return (tipo << 29) | (opcode << 24) | (operands & 0xFFFFFF)


# =============================================================================
#  CÁLCULO DE %hi / %lo  — fórmula exacta del original (expand_label_address)
#  [NUEVO] Ahora expuesta como función pública para ser usada por el parser
#          de pseudo-operadores, en lugar de expandir instrucciones completas.
# =============================================================================

def compute_hi_lo(word_address: int) -> tuple[int, int]:
    """
    Calcula los valores de %hi y %lo para una etiqueta cuya dirección de
    palabra (en la ROM) es word_address.

    La base de la ROM es 0xFFF00000; la dirección de byte es word_address * 4.
    La compensación de signo es necesaria porque ADI hace sign-extend de low16.

    Devuelve (high16, low16) listos para codificarse en H LDI / SLT ADI.
    """
    target_addr = (word_address * 4) | 0xFFF00000
    high16 = (target_addr >> 16) & 0xFFFF
    low16  =  target_addr        & 0xFFFF

    # Compensación: si low16 >= 0x8000, ADI lo sign-extenderá negativamente,
    # por lo que hay que sumar 1 a high16 de antemano.
    if low16 >= 0x8000:
        high16 = (high16 + 1) & 0xFFFF

    return high16, low16


# =============================================================================
#  TOKENIZADOR EXTENDIDO
# =============================================================================

# [NUEVO] Directivas que se reconocen y descartan silenciosamente.
_IGNORED_DIRECTIVES = {
    '.file', '.text', '.globl', '.type', '.size',
    '.ident', '.section',
}

# [NUEVO] Regex para detectar el inicio de una sección .rodata
_RODATA_SECTION_RE = re.compile(
    r'^\s*\.section\s+\.rodata\b', re.IGNORECASE
)
_TEXT_SECTION_RE = re.compile(
    r'^\s*\.text\b', re.IGNORECASE
)
_P2ALIGN_RE = re.compile(
    r'^\s*\.p2align\s+(\d+)(?:\s*,\s*0x[0-9a-fA-F]+)?\s*(?:;.*)?$'
)
_LONG_RE = re.compile(
    r'^\s*\.long\s+(-?\d+|0x[0-9a-fA-F]+)\s*(?:;.*)?$', re.IGNORECASE
)

# [NUEVO] Regex para pseudo-operadores %hi(label) y %lo(label)
#  El nombre de etiqueta puede ir opcionalmente entre comillas.
_PSEUDO_RE = re.compile(
    r'^%(hi|lo)\(("(?:[^"]*)"|\S+)\)$', re.IGNORECASE
)


def tokenize_line(raw_line: str) -> list[str]:
    """
    Elimina comentarios (;) y divide la línea en tokens.
    Separadores: espacios, tabs, comas.

    [NUEVO] Maneja etiquetas entre comillas como un token único,
    sin partirlas por espacios/comas internas.
    """
    # Quitar comentario ';'
    # Pero hay que tener cuidado con comillas que contienen ';'
    # En la práctica el .s de LLVM no tiene ';' dentro de los strings,
    # así que la heurística simple de split(';')[0] es suficiente.
    code = raw_line.split(';')[0].strip()
    if not code:
        return []

    # [NUEVO] Tokenizador que respeta las comillas dobles como un bloque.
    tokens: list[str] = []
    i = 0
    buf = ""
    while i < len(code):
        ch = code[i]
        if ch == '"':
            # Leer hasta la comilla de cierre
            j = code.find('"', i + 1)
            if j == -1:
                buf += code[i:]
                i = len(code)
            else:
                buf += code[i:j+1]
                i = j + 1
        elif ch in (' ', '\t', ','):
            if buf:
                tokens.append(buf)
                buf = ""
            i += 1
        else:
            buf += ch
            i += 1
    if buf:
        tokens.append(buf)

    return tokens


# =============================================================================
#  CODIFICACIÓN DE INSTRUCCIÓN SIMPLE — igual que el original
# =============================================================================

def _require_argc(args: list, expected: int, mnemonic: str,
                  line_num: int, hint: str = "") -> None:
    if len(args) != expected:
        hint_str = f" Ej: {hint}" if hint else ""
        raise AssemblerError(
            f"'{mnemonic}' espera {expected} operando(s), "
            f"se recibieron {len(args)}.{hint_str}", line_num
        )


def encode_single(tokens: list[str], line_num: int,
                  label_map: dict[str, int] | None = None,
                  current_address: int = 0) -> int:
    """
    Codifica una sola instrucción (sin expandir etiquetas).

    [NUEVO] Recibe label_map y current_address para poder resolver
    pseudo-operadores %hi()/%lo() en la segunda pasada.
    """
    first = tokens[0].upper()

    # Detectar prefijo de tipo de memoria o silencioso
    tipo = 0b000
    is_mem_prefix = False
    is_hl_prefix  = False

    if first == 'SLT':
        tipo = 0b100
        tokens = tokens[1:]
        if not tokens:
            raise AssemblerError(
                f"Se esperaba nemotécnico después de 'SLT'.", line_num
            )
        first = tokens[0].upper()
    elif first in ('H', 'L'):
        tipo = 0b100 if first == 'H' else 0b000
        is_hl_prefix = True
        tokens = tokens[1:]
        if not tokens:
            raise AssemblerError(
                f"Se esperaba nemotécnico después de '{first}'.", line_num
            )
        first = tokens[0].upper()
    elif first in MEM_TYPES:
        tipo = MEM_TYPES[first]
        is_mem_prefix = True
        tokens = tokens[1:]
        if not tokens:
            raise AssemblerError(
                f"Se esperaba nemotécnico después del prefijo de tipo.", line_num
            )
        first = tokens[0].upper()
    elif first in MEM_INSTRUCTIONS:
        raise AssemblerError(
            f"'{first}' requiere prefijo de tipo: CHAR, SHORT o INT.", line_num
        )

    mnemonic = first
    args     = tokens[1:]

    if mnemonic not in OPCODES:
        raise AssemblerError(
            f"Nemotécnico desconocido: '{mnemonic}'. "
            f"Válidos: {', '.join(sorted(OPCODES.keys()))}", line_num
        )
    if is_mem_prefix and mnemonic not in MEM_INSTRUCTIONS:
        raise AssemblerError(
            f"El prefijo de tipo de memoria no aplica a '{mnemonic}'.", line_num
        )
    if is_hl_prefix and mnemonic != 'LDI':
        raise AssemblerError(
            f"El prefijo '{'H' if tipo == 0b100 else 'L'}' solo aplica a 'LDI'.", line_num
        )
    if not is_hl_prefix and tipo == 0b100 and mnemonic not in (
            'ADD','SUB','MUL','DIV','NOR','AND','XOR','RSH','LSH','ADI'):
        raise AssemblerError(
            f"El prefijo SLT solo aplica a operaciones aritméticas (incluyendo ADI).", line_num
        )

    op = OPCODES[mnemonic]

    # ── Sin operandos ────────────────────────────────────────────────────────
    if mnemonic in ('NOP', 'HLT', 'RET', 'SCL', 'SRT'):
        _require_argc(args, 0, mnemonic, line_num)
        return build_word(0, op, 0)

    # ── Tres registros: ADD SUB MUL DIV NOR AND XOR RSH LSH ─────────────────
    elif mnemonic in ('ADD','SUB','MUL','DIV','NOR','AND','XOR','RSH','LSH'):
        _require_argc(args, 3, mnemonic, line_num,
                      hint=f"{mnemonic} R0, R1, R2")
        ra = parse_register(args[0], line_num)
        rb = parse_register(args[1], line_num)
        rc = parse_register(args[2], line_num)
        return build_word(tipo, op, (ra << 20) | (rb << 16) | (rc << 12))

    # ── GOF — [23:20]=RA ────────────────────────────────────────────────────
    elif mnemonic == 'GOF':
        _require_argc(args, 1, 'GOF', line_num, hint="GOF R0")
        ra = parse_register(args[0], line_num)
        return build_word(0, op, ra << 20)

    # ── LDI — [23:20]=RA  [15:0]=IMM16 ─────────────────────────────────────
    # [NUEVO] El segundo operando puede ser %hi(label) o una etiqueta entre
    # comillas (en cuyo caso se trata como %hi de la etiqueta misma si es
    # H LDI, o %lo si es SLT precedente — pero en la práctica el .s de LLVM
    # siempre usa la sintaxis explícita %hi/%lo, así que aquí solo cubrimos
    # el caso de etiqueta entre comillas como referencia directa a %hi).
    elif mnemonic == 'LDI':
        _require_argc(args, 2, 'LDI', line_num, hint="LDI R0, 1000")
        ra  = parse_register(args[0], line_num)
        imm = _resolve_imm_or_pseudo(args[1], line_num, label_map,
                                     pseudo_kind='hi' if is_hl_prefix else None,
                                     bits=16, signed=False)
        return build_word(tipo, op, (ra << 20) | imm)

    # ── ADI — [23:20]=RA  [15:0]=IMM16 (con signo) ──────────────────────────
    elif mnemonic == 'ADI':
        _require_argc(args, 2, 'ADI', line_num, hint="ADI R0, -5")
        ra  = parse_register(args[0], line_num)
        # [NUEVO] SLT ADI Rx, %lo(label) → pseudo-operador %lo
        imm = _resolve_imm_or_pseudo(args[1], line_num, label_map,
                                     pseudo_kind='lo' if tipo == 0b100 else None,
                                     bits=16, signed=True)
        return build_word(tipo, op, (ra << 20) | imm)

    # ── JMP — [19:16]=RB ────────────────────────────────────────────────────
    elif mnemonic == 'JMP':
        _require_argc(args, 1, 'JMP', line_num, hint="JMP R1")
        rb = parse_register(args[0], line_num)
        return build_word(0, op, rb << 16)

    # ── BRH — [23:20]=COND  [19:16]=RB ─────────────────────────────────────
    elif mnemonic == 'BRH':
        _require_argc(args, 2, 'BRH', line_num, hint="BRH =, R1")
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
        _require_argc(args, 1, 'CAL', line_num, hint="CAL R1")
        rb = parse_register(args[0], line_num)
        return build_word(0, op, rb << 16)

    # ── LOD — [31:29]=Tipo  [23:20]=RA  [19:16]=RB  [15:0]=Offset ──────────
    elif mnemonic == 'LOD':
        _require_argc(args, 3, 'LOD', line_num,
                      hint="INT LOD R0, R1, 100")
        ra     = parse_register(args[0], line_num)
        rb     = parse_register(args[1], line_num)
        offset = parse_immediate(args[2], line_num, bits=16, signed=True)
        return build_word(tipo, op, (ra << 20) | (rb << 16) | offset)

    # ── STR — [31:29]=Tipo  [23:20]=RA  [19:16]=RB  [15:0]=Offset ──────────
    elif mnemonic == 'STR':
        _require_argc(args, 3, 'STR', line_num,
                      hint="INT STR R0, R1, 0")
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

    # ── CYR — [23:20]=RA (normal) [19:16]=RC (especial) ────────────────────
    elif mnemonic == 'CYR':
        _require_argc(args, 2, 'CYR', line_num, hint="CYR R0, R1")
        ra = parse_register(args[0], line_num)
        rc = parse_register(args[1], line_num)
        return build_word(0, op, (ra << 20) | (rc << 16))

    else:
        raise AssemblerError(
            f"Instrucción sin codificador: '{mnemonic}'.", line_num
        )


# [NUEVO] Resuelve un operando inmediato que puede ser:
#   • Un literal numérico normal (decimal/hex/bin)
#   • Un pseudo-operador %hi(label) o %lo(label)
#   • Una etiqueta entre comillas usada como %hi o %lo según pseudo_kind
def _resolve_imm_or_pseudo(token: str, line_num: int,
                            label_map: dict[str, int] | None,
                            pseudo_kind: str | None,
                            bits: int = 16,
                            signed: bool = False) -> int:
    """
    Intenta resolver token como:
    1. Pseudo-operador %hi(x) o %lo(x) explícito.
    2. Etiqueta entre comillas (tratada como %hi/%lo según pseudo_kind).
    3. Valor numérico directo.

    label_map puede ser None en la primera pasada; en ese caso los pseudo-
    operadores y referencias a etiqueta retornan 0 como placeholder
    (serán resueltos en la segunda pasada).
    """
    token = token.strip()

    # ── %hi(label) o %lo(label) ──────────────────────────────────────────────
    m = _PSEUDO_RE.match(token)
    if m:
        kind  = m.group(1).lower()   # 'hi' o 'lo'
        lname_raw = m.group(2)
        lname = normalize_label(lname_raw)
        if lname is None:
            raise AssemblerError(
                f"Nombre de etiqueta inválido en {token}: '{lname_raw}'.", line_num
            )
        if label_map is None:
            return 0   # Placeholder para primera pasada
        if lname not in label_map:
            raise AssemblerError(
                f"Etiqueta no definida: '{lname}' (referenciada en {token}).", line_num
            )
        hi16, lo16 = compute_hi_lo(label_map[lname])
        val = hi16 if kind == 'hi' else lo16
        # El valor ya está en rango 0–0xFFFF; lo devolvemos como 16 bits.
        return val & 0xFFFF

    # ── Etiqueta entre comillas usada como %hi o %lo directo ─────────────────
    # Ejemplo: H LDI R2, ".L__const...." → %hi(".L__const....")
    #          SLT ADI R2, ".L__const...." → %lo(".L__const....")
    m2 = _LABEL_QUOTED_RE.match(token)
    if m2:
        lname = m2.group(1)
        if pseudo_kind is None:
            raise AssemblerError(
                f"Referencia a etiqueta '{lname}' sin contexto H/SLT.", line_num
            )
        if label_map is None:
            return 0   # Placeholder
        if lname not in label_map:
            raise AssemblerError(
                f"Etiqueta no definida: '{lname}'.", line_num
            )
        hi16, lo16 = compute_hi_lo(label_map[lname])
        return (hi16 if pseudo_kind == 'hi' else lo16) & 0xFFFF

    # ── Valor numérico normal ─────────────────────────────────────────────────
    return parse_immediate(token, line_num, bits=bits, signed=signed)


# =============================================================================
#  ENSAMBLADOR EN DOS PASOS
# =============================================================================

class PendingInstruction:
    """
    Instrucción pendiente de codificación completa.

    [MODIFICADO respecto al original]
    Ya no existe el campo label_target ni la expansión automática en 3
    instrucciones.  Ahora hay dos tipos de pendientes:
      • words != None  → instrucción ya codificada (resultado final)
      • pending_tokens != None → instrucción que contiene %hi/%lo o etiquetas
                                  entre comillas y necesita resolverse en la
                                  segunda pasada con el label_map completo.
    Ambos casos tienen size=1.

    Además, el campo is_raw_word indica una palabra de datos (.long) que se
    escribe directamente en la ROM sin decodificación de opcode.
    """
    def __init__(self,
                 words: list[int] | None = None,
                 pending_tokens: list[str] | None = None,
                 src_line: int = 0,
                 is_raw_word: bool = False,
                 raw_value: int = 0):
        self.words          = words           # Palabra(s) ya codificadas
        self.pending_tokens = pending_tokens  # Tokens a resolver en 2ª pasada
        self.src_line       = src_line
        self.is_raw_word    = is_raw_word     # [NUEVO] Dato crudo (.long)
        self.raw_value      = raw_value       # Valor del .long
        self.size           = 1


def _tokens_need_second_pass(tokens: list[str]) -> bool:
    """
    [NUEVO] Determina si la instrucción contiene pseudo-operadores (%hi/%lo)
    o referencias a etiqueta entre comillas que necesitan resolución diferida.
    """
    for t in tokens:
        if _PSEUDO_RE.match(t):
            return True
        if _LABEL_QUOTED_RE.match(t):
            return True
    return False


def first_pass(lines: list[str]) -> tuple[dict[str, int], list[PendingInstruction], list[str]]:
    """
    PRIMER PASE: detecta etiquetas, directivas y construye la lista de
    instrucciones pendientes.

    [MODIFICADO respecto al original]
    - Reconoce y descarta directivas LLVM.
    - Acepta etiquetas locales (punto) y entre comillas.
    - Soporta sección .rodata, .p2align y .long.
    - [ELIMINADO] Auto-expansión de saltos a etiqueta.
    - [ELIMINADO] Auto-expansión de LDI de 32 bits.
    - Las instrucciones con %hi/%lo se marcan como pending_tokens para
      resolverse en la segunda pasada.

    Devuelve: (label_map, pending_list, errors)
    """
    label_map: dict[str, int] = {}
    pending:   list[PendingInstruction] = []
    errors:    list[str] = []
    address = 0
    in_rodata = False   # [NUEVO] ¿Estamos en sección .rodata?

    for line_num, raw_line in enumerate(lines, start=1):

        # ── [NUEVO] Detectar cambio de sección ──────────────────────────────
        if _RODATA_SECTION_RE.match(raw_line):
            in_rodata = True
            continue
        if _TEXT_SECTION_RE.match(raw_line):
            in_rodata = False
            continue

        # ── [NUEVO] .p2align dentro de .rodata ──────────────────────────────
        mp2 = _P2ALIGN_RE.match(raw_line)
        if mp2:
            n = int(mp2.group(1))
            align_bytes = 1 << n   # 2^N bytes
            align_words = align_bytes // 4  # En palabras de 32 bits
            if align_words > 1:
                # Alinear dirección actual al múltiplo de align_words
                remainder = address % align_words
                if remainder != 0:
                    pad = align_words - remainder
                    for _ in range(pad):
                        pending.append(PendingInstruction(
                            is_raw_word=True, raw_value=0, src_line=line_num
                        ))
                    address += pad
            continue

        # ── [NUEVO] .long dentro de .rodata ─────────────────────────────────
        mlong = _LONG_RE.match(raw_line)
        if mlong:
            raw_val_str = mlong.group(1)
            try:
                if raw_val_str.startswith('0x') or raw_val_str.startswith('0X'):
                    raw_val = int(raw_val_str, 16)
                else:
                    raw_val = int(raw_val_str)
            except ValueError:
                errors.append(f"[Línea {line_num}] Valor inválido en .long: '{raw_val_str}'.")
                continue
            raw_val = raw_val & 0xFFFFFFFF   # 32 bits
            pending.append(PendingInstruction(
                is_raw_word=True, raw_value=raw_val, src_line=line_num
            ))
            address += 1
            continue

        tokens = tokenize_line(raw_line)
        if not tokens:
            continue

        # ── [NUEVO] Detectar definición de etiqueta (extendida) ─────────────
        # IMPORTANTE: debe ir ANTES del filtro de directivas porque las
        # etiquetas locales LLVM (.LBBn_m:) también empiezan con punto.
        label_token = tokens[0]
        if label_token.endswith(':'):
            raw_name = label_token[:-1]
            name = normalize_label(raw_name)
            if name is None:
                errors.append(
                    f"[Línea {line_num}] Nombre de etiqueta inválido: '{raw_name}'."
                )
                continue
            if name in label_map:
                errors.append(
                    f"[Línea {line_num}] Etiqueta duplicada: '{name}' "
                    f"(ya definida en dirección {label_map[name]:08X})."
                )
                continue
            label_map[name] = address
            tokens = tokens[1:]
            if not tokens:
                continue   # Línea solo con etiqueta

        # ── [NUEVO] Detectar y descartar directivas LLVM ────────────────────
        # (Solo si el primer token no era una etiqueta — ya procesada arriba)
        first_tok = tokens[0].lower()
        if first_tok in _IGNORED_DIRECTIVES:
            continue
        # Ignorar cualquier otra directiva que empiece con punto
        # (excepto .long y .p2align que ya se manejan antes de tokenizar)
        if first_tok.startswith('.') and first_tok not in ('.long', '.p2align'):
            continue

        # ── Instrucción normal ───────────────────────────────────────────────
        # [MODIFICADO] Ya no hay detección de salto a etiqueta con expansión.
        # Si la instrucción contiene %hi/%lo la marcamos para segunda pasada;
        # si no, la codificamos directamente.
        if _tokens_need_second_pass(tokens):
            # Guardar tokens tal cual para resolver en segunda pasada
            pending.append(PendingInstruction(
                pending_tokens=tokens,
                src_line=line_num,
            ))
        else:
            try:
                word = encode_single(tokens, line_num)
                pending.append(PendingInstruction(
                    words=[word],
                    src_line=line_num,
                ))
            except AssemblerError as e:
                errors.append(str(e))
                pending.append(PendingInstruction(
                    words=[0],
                    src_line=line_num,
                ))   # Placeholder para no perder la dirección

        address += 1

    return label_map, pending, errors


def second_pass(label_map: dict[str, int],
                pending: list[PendingInstruction]
                ) -> tuple[list[tuple[int, int, int]], list[str]]:
    """
    SEGUNDO PASE: resuelve los pseudo-operadores %hi/%lo con el label_map
    completo y genera las palabras finales.

    [MODIFICADO respecto al original]
    Ya no expande saltos a etiqueta (3 palabras). Ahora solo resuelve
    instrucciones con pending_tokens (que contienen %hi/%lo) y copia
    directamente las que ya tenían words codificados.

    Devuelve: ([(src_line, address, word), ...], errors)
    """
    result:  list[tuple[int, int, int]] = []
    errors:  list[str] = []
    address = 0

    for instr in pending:
        if instr.is_raw_word:
            # [NUEVO] Dato crudo (.long): escribir tal cual
            result.append((instr.src_line, address, instr.raw_value))
            address += 1
        elif instr.pending_tokens is not None:
            # Instrucción con %hi/%lo: codificar ahora con label_map completo
            try:
                word = encode_single(instr.pending_tokens, instr.src_line,
                                     label_map=label_map,
                                     current_address=address)
                result.append((instr.src_line, address, word))
            except AssemblerError as e:
                errors.append(str(e))
                result.append((instr.src_line, address, 0))
            address += 1
        else:
            # Instrucción ya codificada
            for w in instr.words:
                result.append((instr.src_line, address, w))
                address += 1

    return result, errors


def assemble_source(source_path: str
                    ) -> tuple[list[tuple[int,int,int]], list[str], dict[str,int]]:
    """
    Pipeline completo de ensamblado de un único archivo .s/.asm/.txt.
    Devuelve: (instructions, errors, label_map)
    """
    try:
        with open(source_path, 'r', encoding='utf-8', errors='replace') as f:
            lines = f.readlines()
    except OSError as e:
        return [], [f"No se pudo abrir el archivo: {e}"], {}

    return assemble_lines(lines)


def assemble_lines(lines: list[str]
                   ) -> tuple[list[tuple[int,int,int]], list[str], dict[str,int]]:
    """
    Pipeline completo de ensamblado a partir de una lista de líneas.
    Devuelve: (instructions, errors, label_map)

    [MODIFICADO] Siempre se ejecutan ambas pasadas para que los errores de
    primera pasada (etiquetas duplicadas, sintaxis) y los de segunda pasada
    (%hi/%lo no resueltos) se acumulen y reporten correctamente.
    Los errores de primera pasada se notifican al final sin detener la 2ª.
    """
    label_map, pending, errors1 = first_pass(lines)
    # [MODIFICADO] No se sale anticipadamente: siempre correr segunda pasada
    # para resolver %hi/%lo con el label_map completo.
    instructions, errors2 = second_pass(label_map, pending)
    return instructions, errors1 + errors2, label_map


# =============================================================================
#  ESCRITURA DEL ARCHIVO ROM (Logisim v3.0 hex words addressed) — igual
# =============================================================================

def write_rom_logisim(instructions: list[tuple[int,int,int]],
                      output_path: str) -> None:
    """
    Escribe la imagen de ROM en formato Logisim:
        v3.0 hex words addressed

    Cada instrucción de 32 bits se almacena como 4 bytes en orden big-endian.
    La dirección en el archivo es de bytes: addr_byte = addr_word * 4.

    Las filas vacías (solo ceros) se omiten.
    Al final se agrega siempre el vector de reset/boot (no recalcular):
        ffff0: 8c f0 ff f0 8d f0 00 00 0e 0f 00 00 00 00 00 00
    """
    byte_map: dict[int, int] = {}
    for _, word_addr, word in instructions:
        byte_addr = word_addr * 4
        byte_map[byte_addr + 0] = (word >> 24) & 0xFF
        byte_map[byte_addr + 1] = (word >> 16) & 0xFF
        byte_map[byte_addr + 2] = (word >>  8) & 0xFF
        byte_map[byte_addr + 3] =  word        & 0xFF

    if not byte_map:
        return

    max_byte_addr = max(byte_map.keys())
    BYTES_PER_ROW = 16
    last_row = (max_byte_addr // BYTES_PER_ROW) * BYTES_PER_ROW

    parent = os.path.dirname(output_path)
    if parent:
        os.makedirs(parent, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("v3.0 hex words addressed\n")

        row = 0
        while row <= last_row:
            row_bytes = [byte_map.get(row + i, 0) for i in range(BYTES_PER_ROW)]
            if any(b != 0 for b in row_bytes):
                hex_bytes = ' '.join(f"{b:02x}" for b in row_bytes)
                f.write(f"{row:05x}: {hex_bytes}\n")
            row += BYTES_PER_ROW

        # Vector de reset — fijo, no regenerar
        f.write("ffff0: 8c f0 ff f0 8d f0 00 00 0e 0f 00 00 00 00 00 00\n")


def write_annotated_hex(instructions: list[tuple[int,int,int]],
                        label_map: dict[str, int],
                        output_path: str) -> None:
    """
    Escribe un archivo .hex anotado (depuración / referencia humana).
    """
    addr_to_label = {v: k for k, v in label_map.items()}

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("; =====================================================\n")
        f.write(";  Listado anotado — Procesador 32 bits\n")
        f.write(f";  Instrucciones: {len(instructions)}\n")
        f.write(";\n")
        f.write(";  WADDR BADDR    HEX       BINARIO (Tipo|Op | Operandos)\n")
        f.write("; =====================================================\n")

        for src_line, waddr, word in instructions:
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
#  [NUEVO] PIPELINE MULTI-ARCHIVO: .c → .s → ROM
# =============================================================================

def compile_c_to_s(c_path: str, s_path: str, log_fn=None) -> list[str]:
    """
    Compila un archivo .c/.C a .s usando COMPILER_CMD_TEMPLATE.
    Devuelve lista de errores (vacía si OK).
    """
    if not COMPILER_CMD_TEMPLATE:
        return [
            f"COMPILER_CMD_TEMPLATE no configurado. "
            f"Edita la variable al inicio de assembler.py con el comando "
            f"exacto de tu clang para compilar .c → .s."
        ]

    cmd = COMPILER_CMD_TEMPLATE.format(input=c_path, output=s_path)
    if log_fn:
        log_fn(f"  Compilando: {os.path.basename(c_path)}", 'info')
        log_fn(f"  $ {cmd}", 'info')

    try:
        result = subprocess.run(
            cmd, shell=True, capture_output=True, text=True
        )
    except Exception as e:
        return [f"Error al invocar el compilador: {e}"]

    errors = []
    if result.returncode != 0:
        errors.append(f"Error compilando '{c_path}':")
        for line in (result.stderr or result.stdout).splitlines():
            errors.append(f"  {line}")
    return errors


def _rename_local_labels_in_lines(lines: list[str], prefix: str) -> list[str]:
    """
    [NUEVO] Renombra etiquetas locales (las que empiezan con '.')
    agregando `prefix` inmediatamente después del punto inicial.
    Ejemplo: .LBB1_3  →  .f0_LBB1_3

    Opera sobre el texto crudo de las líneas (no sobre tokens), para
    preservar el formato del archivo. Usa regex con cuidado de no tocar
    cosas dentro de comillas dobles (las etiquetas entre comillas son
    globales y no se renombran).
    """
    # Patrón de etiqueta local: punto seguido de identificador
    local_pat = re.compile(r'(?<!")(\.[A-Za-z_][A-Za-z0-9_.@$]*)(?!")')

    renamed = []
    for line in lines:
        # Dividir la línea en segmentos: entre comillas y fuera de comillas
        result = ""
        i = 0
        while i < len(line):
            if line[i] == '"':
                # Segmento entre comillas: no modificar
                j = line.find('"', i + 1)
                if j == -1:
                    result += line[i:]
                    i = len(line)
                else:
                    result += line[i:j+1]
                    i = j + 1
            elif line[i] == ';':
                # Comentario: no modificar el resto de la línea
                result += line[i:]
                break
            else:
                # Segmento normal: aplicar renombrado
                # Buscar próxima comilla o fin de línea
                next_quote = line.find('"', i)
                next_comment = line.find(';', i)
                end = len(line)
                if next_quote != -1:
                    end = min(end, next_quote)
                if next_comment != -1:
                    end = min(end, next_comment)
                segment = line[i:end]
                segment = local_pat.sub(
                    lambda m: f".{prefix}_{m.group(1)[1:]}", segment
                )
                result += segment
                i = end
        renamed.append(result)

    return renamed


def merge_asm_files(s_paths: list[str],
                    output_s_path: str,
                    log_fn=None) -> list[str]:
    """
    [NUEVO] Fusiona varios archivos .s en uno solo.

    Pasos:
    1. Leer cada archivo y renombrar sus etiquetas locales.
    2. Detectar colisiones de símbolos globales.
    3. Separar secciones .text y .rodata de cada archivo.
    4. Concatenar: todos los .text, luego todos los .rodata.
    5. Escribir el .s combinado.

    Devuelve lista de errores.
    """
    errors = []
    all_text_lines:   list[str] = []
    all_rodata_lines: list[str] = []
    global_symbols:   dict[str, str] = {}   # nombre → archivo origen

    for idx, s_path in enumerate(s_paths):
        prefix = f"f{idx}"
        try:
            with open(s_path, 'r', encoding='utf-8', errors='replace') as f:
                raw_lines = f.readlines()
        except OSError as e:
            errors.append(f"No se pudo leer '{s_path}': {e}")
            continue

        # Renombrar etiquetas locales
        lines = _rename_local_labels_in_lines(raw_lines, prefix)

        # Detectar símbolos globales declarados con .globl
        for line in lines:
            m = re.match(r'^\s*\.globl\s+(.+)$', line, re.IGNORECASE)
            if m:
                sym_raw = m.group(1).strip()
                sym = normalize_label(sym_raw)
                if sym is None:
                    sym = sym_raw
                if sym in global_symbols:
                    errors.append(
                        f"Colisión de símbolo global '{sym}': "
                        f"definido en '{global_symbols[sym]}' y en '{s_path}'."
                    )
                else:
                    global_symbols[sym] = s_path

        # Separar secciones .text y .rodata
        in_rodata_section = False
        for line in lines:
            if _RODATA_SECTION_RE.match(line):
                in_rodata_section = True
                all_rodata_lines.append(line)
                continue
            if _TEXT_SECTION_RE.match(line):
                in_rodata_section = False
                continue   # No repetir la directiva .text en el combinado
            if in_rodata_section:
                all_rodata_lines.append(line)
            else:
                all_text_lines.append(line)

        if log_fn:
            log_fn(f"  Fusionado: {os.path.basename(s_path)}", 'info')

    if errors:
        return errors

    # Escribir .s combinado
    try:
        with open(output_s_path, 'w', encoding='utf-8') as f:
            f.write("\t.text\n")
            for line in all_text_lines:
                f.write(line)
            if all_rodata_lines:
                f.write("\n")
                for line in all_rodata_lines:
                    f.write(line)
    except OSError as e:
        errors.append(f"No se pudo escribir el .s combinado: {e}")

    return errors


def compile_and_assemble(c_paths: list[str],
                          rom_path: str,
                          generate_listing: bool = True,
                          log_fn=None
                          ) -> tuple[list[tuple[int,int,int]], list[str], dict[str,int]]:
    """
    [NUEVO] Pipeline completo: .c → .s → ROM.

    1. Compila cada .c a .s en un directorio temporal.
    2. Fusiona los .s en uno solo junto al primer .c.
    3. Ensambla el .s combinado.

    Devuelve: (instructions, errors, label_map)
    """
    errors = []
    tmp_dir = tempfile.mkdtemp(prefix="isa32_asm_")
    s_paths = []

    try:
        for c_path in c_paths:
            base = os.path.splitext(os.path.basename(c_path))[0]
            s_path = os.path.join(tmp_dir, base + ".s")
            errs = compile_c_to_s(c_path, s_path, log_fn=log_fn)
            if errs:
                errors.extend(errs)
            else:
                s_paths.append(s_path)

        if errors:
            return [], errors, {}

        # Determinar ruta del .s combinado
        first_dir = os.path.dirname(os.path.abspath(c_paths[0]))
        first_base = os.path.splitext(os.path.basename(c_paths[0]))[0]
        combined_s = os.path.join(first_dir, first_base + COMBINED_ASM_SUFFIX)

        errs = merge_asm_files(s_paths, combined_s, log_fn=log_fn)
        if errs:
            return [], errs, {}

        if log_fn:
            log_fn(f"  Archivo .s combinado: {combined_s}", 'ok')

        return assemble_source(combined_s)

    finally:
        shutil.rmtree(tmp_dir, ignore_errors=True)


# =============================================================================
#  INTERFAZ GRÁFICA (tkinter) — mantenida y extendida
# =============================================================================

class AssemblerGUI:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("Ensamblador — Procesador 32 bits (LLVM)")
        self.root.geometry("920x620")
        self.root.resizable(True, True)
        self._selected_files: list[str] = []
        self._build_ui()

    def _build_ui(self):
        # ── Barra superior ────────────────────────────────────────────────────
        top = tk.Frame(self.root, pady=8, padx=12)
        top.pack(fill='x')

        tk.Label(top, text="Fuente:").pack(side='left')
        self.path_var = tk.StringVar()
        tk.Entry(top, textvariable=self.path_var, width=52).pack(side='left', padx=5)
        # [NUEVO] Botón Examinar acepta múltiples archivos y .c/.C
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

        # ── Opciones ──────────────────────────────────────────────────────────
        opt_frame = tk.Frame(self.root, padx=12, pady=2)
        opt_frame.pack(fill='x')
        self.listing_var = tk.BooleanVar(value=True)
        tk.Checkbutton(opt_frame, text="Generar listado anotado (.hex)",
                       variable=self.listing_var).pack(side='left')

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
        # [NUEVO] Selección múltiple, acepta .c/.C y .s/.asm/.txt
        files = filedialog.askopenfilenames(
            title="Seleccionar archivo(s) fuente",
            filetypes=[
                ("Fuentes C/ASM", "*.c *.C *.s *.asm *.txt"),
                ("C/C++",         "*.c *.C"),
                ("Ensamblador",   "*.s *.asm *.txt"),
                ("Todos",         "*.*"),
            ]
        )
        if files:
            self._selected_files = list(files)
            if len(files) == 1:
                self.path_var.set(files[0])
            else:
                self.path_var.set(f"[{len(files)} archivos] " +
                                  ", ".join(os.path.basename(f) for f in files))

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
        rom_path = self.rom_var.get().strip()
        generate_listing = self.listing_var.get()

        # Determinar archivos a procesar
        files = self._selected_files
        if not files:
            source = self.path_var.get().strip()
            if source:
                files = [source]

        if not files:
            self._log("⚠  Selecciona primero un archivo fuente.", 'error')
            return

        for f in files:
            if not os.path.isfile(f):
                self._log(f"✗  Archivo no encontrado: {f}", 'error')
                return

        self._log("══════════════════════════════════════════", 'head')
        # [NUEVO] Distinguir modo .c y modo .s
        c_files = [f for f in files if f.lower().endswith(('.c', '.C'.lower()))]

        if c_files and len(c_files) == len(files):
            # Modo compilación C
            self._log(f"  Compilando {len(c_files)} archivo(s) C → ROM", 'head')
            self._log("══════════════════════════════════════════", 'head')
            instructions, errors, label_map = compile_and_assemble(
                c_files, rom_path,
                generate_listing=generate_listing,
                log_fn=self._log
            )
        elif len(files) == 1 and not c_files:
            # Modo ensamblado directo
            self._log(f"  Ensamblando: {os.path.basename(files[0])}", 'head')
            self._log("══════════════════════════════════════════", 'head')
            instructions, errors, label_map = assemble_source(files[0])
        else:
            self._log("✗  Mezcla de .c y .s no soportada. "
                      "Usa solo .c o solo .s.", 'error')
            return

        if errors:
            self._log(f"\n✗  {len(errors)} error(es):\n", 'error')
            for e in errors:
                self._log(f"  {e}", 'error')
            return

        # Escribir ROM
        write_rom_logisim(instructions, rom_path)
        self._log(f"\n✓  {len(instructions)} palabra(s) ensamblada(s).\n", 'ok')
        self._log(f"  ROM Logisim : {rom_path}", 'ok')

        # Listado anotado
        if generate_listing:
            if c_files:
                base_path = os.path.splitext(c_files[0])[0]
            else:
                base_path = os.path.splitext(files[0])[0]
            ann_path = base_path + "_listado.hex"
            write_annotated_hex(instructions, label_map, ann_path)
            self._log(f"  Listado     : {ann_path}", 'ok')

        # Mostrar etiquetas
        if label_map:
            self._log("\n  Etiquetas definidas:", 'lbl')
            for name, addr in sorted(label_map.items(), key=lambda x: x[1]):
                self._log(f"    {name:<30} → word {addr:05X}  byte {addr*4:06X}", 'lbl')

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
    args = sys.argv[1:]

    # ── Modo CLI ──────────────────────────────────────────────────────────────
    if args:
        # [NUEVO] Parseo de --no-list
        generate_listing = True
        if '--no-list' in args:
            generate_listing = False
            args = [a for a in args if a != '--no-list']

        if not args:
            print("[ERROR] No se especificaron archivos de entrada.")
            sys.exit(1)

        print("=" * 62)
        print("  Ensamblador — Procesador 32 bits (compatible LLVM)")
        print("=" * 62)

        # Determinar si es modo .c o modo .s/.asm/.txt
        c_files  = [a for a in args if a.lower().endswith(('.c',))]
        asm_files = [a for a in args if not a.lower().endswith(('.c',))]

        # Detectar ruta de ROM de salida (último argumento si no es .c ni .s/.asm/.txt)
        _source_exts = ('.c', '.s', '.asm', '.txt', '.C')
        rom_path = ROM_OUTPUT_PATH
        if args and not args[-1].lower().endswith(_source_exts):
            rom_path = args[-1]
            args     = args[:-1]
            c_files  = [a for a in args if a.lower().endswith(('.c',))]
            asm_files = [a for a in args if not a.lower().endswith(('.c',))]

        # [NUEVO] Modo multi-archivo .c
        if c_files and not asm_files:
            for f in c_files:
                if not os.path.isfile(f):
                    print(f"[ERROR] Archivo no encontrado: {f}")
                    sys.exit(1)

            def cli_log(msg, tag=''):
                print(msg)

            instructions, errors, label_map = compile_and_assemble(
                c_files, rom_path,
                generate_listing=generate_listing,
                log_fn=cli_log
            )

        elif len(asm_files) == 1 and not c_files:
            source_path = asm_files[0]
            if not os.path.isfile(source_path):
                print(f"[ERROR] Archivo no encontrado: {source_path}")
                sys.exit(1)
            instructions, errors, label_map = assemble_source(source_path)

        else:
            print("[ERROR] Especifica solo archivos .c o un único .s/.asm/.txt.")
            print("  Uso:")
            print("    python assembler.py [--no-list] archivo.s [ROM]")
            print("    python assembler.py [--no-list] f1.c f2.c [ROM]")
            sys.exit(1)

        if errors:
            print(f"[ERROR] {len(errors)} error(es):\n")
            for e in errors:
                print(f"  {e}")
            sys.exit(1)

        write_rom_logisim(instructions, rom_path)
        print(f"[OK] {len(instructions)} palabra(s) ensamblada(s).")
        print(f"[OK] ROM Logisim : {rom_path}")

        if generate_listing:
            if c_files:
                ann_path = os.path.splitext(c_files[0])[0] + "_listado.hex"
            else:
                ann_path = os.path.splitext(asm_files[0])[0] + "_listado.hex"
            write_annotated_hex(instructions, label_map, ann_path)
            print(f"[OK] Listado     : {ann_path}")

        if label_map:
            print("\n[Etiquetas]")
            for name, addr in sorted(label_map.items(), key=lambda x: x[1]):
                print(f"  {name:<30} -> word 0x{addr:05X}  byte 0x{addr*4:06X}")
        sys.exit(0)

    # ── Modo GUI ──────────────────────────────────────────────────────────────
    if not HAS_TK:
        print("[ERROR] tkinter no está disponible.")
        print("  Uso: python assembler.py fuente.s [salida_ROM]")
        sys.exit(1)

    root = tk.Tk()
    AssemblerGUI(root)
    root.mainloop()


if __name__ == '__main__':
    main()