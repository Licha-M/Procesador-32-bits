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
  [NUEVO]  Soporte de sintaxis LLVM y variables globales C (.data y .bss):
             • Directivas ignoradas: .file, .globl, .type, .size,
               .ident, .section ".note.GNU-stack"
             • Secciones .text, .rodata, .data y .bss
             • Directivas de datos y alineación: .p2align, .align, .long,
               .word, .short, .byte, .zero, .space, .skip, .comm
             • Expresiones de etiquetas con offset (ej: label+offset, label-offset)
             • Etiquetas locales LLVM (.LBBn_m, .Lfunc_endN, etc.)
             • Etiquetas entre comillas dobles (nombres mangled C++)
             • Pseudo-operadores %hi(label) y %lo(label)
  [NUEVO]  Modo de datos configurable: ROM (defecto) | RAM
             • Modo ROM: Datos iniciales de .data grabados en ROM, símbolos
               mapeados a RAM (0x04000000+), rutina .start inyectada para
               copiar .data de ROM a RAM antes de saltar a main.
             • Modo RAM: Secciones .data y .bss ensabladas de forma contigua
               en el mapa de direcciones ROM/RAM, salto directo a main.
  [NUEVO]  Modo multi-archivo .c → .s → ROM (sección 4 del spec)
  [NUEVO]  CLI extendido: --data-mode=rom|ram, --no-list, múltiples archivos .c
  [NUEVO]  GUI extendida: selector de Modo de Datos (ROM/RAM), selección múltiple .c/.C
  [ELIMINADO] Auto-expansión de saltos a etiqueta (ya la hace LLVM)
  [ELIMINADO] Auto-expansión de LDI de 32 bits (ya la hace LLVM)
  [MANTENIDO] Todo lo demás: opcodes, codificación, formato ROM, vector reset

  Uso:
    python assembler.py                              → GUI
    python assembler.py [--data-mode=rom|ram] programa.s [ROM] → ensambla .s/.asm/.txt
    python assembler.py [--data-mode=rom|ram] [--no-list] f1.c f2.c [ROM] → compila+ensambla .c
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

# [NUEVO] Comandos de compilación para C/C++ → LLVM IR → .s
# 1. Crear los .ll:  clang++ -O2 -fno-ms-volatile -S -emit-llvm archivo1.c -o archivo1.ll
# 2. Unir .ll:        llvm-link archivo1.ll archivo2.ll -S -o unido.ll
# 3. Pasar a .s:      llc -march=isa32_lm unido.ll -o final.s

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

def compute_hi_lo(address: int) -> tuple[int, int]:
    """
    Calcula los valores de %hi y %lo para una etiqueta o dirección.

    Si address < 0x01000000, se asume dirección de palabra en ROM
    (base 0xFFF00000; dirección de byte = (address * 4) | 0xFFF00000).
    Si address >= 0x01000000, se asume dirección física de byte (ej. RAM 0x04000000+).

    La compensación de signo es necesaria porque ADI hace sign-extend de low16.

    Devuelve (high16, low16) listos para codificarse en H LDI / SLT ADI.
    """
    if address >= 0x01000000:
        target_addr = address
    else:
        target_addr = (address * 4) | 0xFFF00000

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

# [NUEVO] Regex para detectar el inicio de secciones (.text, .rodata, .data, .bss)
_TEXT_SECTION_RE = re.compile(
    r'^\s*(?:\.section\s+)?\.text\b', re.IGNORECASE
)
_RODATA_SECTION_RE = re.compile(
    r'^\s*(?:\.section\s+)?\.rodata\b', re.IGNORECASE
)
_DATA_SECTION_RE = re.compile(
    r'^\s*(?:\.section\s+)?\.data\b', re.IGNORECASE
)
_BSS_SECTION_RE = re.compile(
    r'^\s*(?:\.section\s+)?\.bss\b', re.IGNORECASE
)
_P2ALIGN_RE = re.compile(
    r'^\s*\.(?:p2align|align)\s+(\d+)(?:\s*,\s*(?:0x[0-9a-fA-F]+|\d+))?\s*(?:;.*)?$', re.IGNORECASE
)
_LONG_RE = re.compile(
    r'^\s*\.(?:long|word)\s+(.+)$', re.IGNORECASE
)
_SHORT_RE = re.compile(
    r'^\s*\.short\s+(.+)$', re.IGNORECASE
)
_BYTE_RE = re.compile(
    r'^\s*\.byte\s+(.+)$', re.IGNORECASE
)
_ZERO_RE = re.compile(
    r'^\s*\.(?:zero|space|skip)\s+(\d+|0x[0-9a-fA-F]+)\s*(?:;.*)?$', re.IGNORECASE
)
_COMM_RE = re.compile(
    r'^\s*\.comm\s+([^,\s]+)\s*,\s*(\d+|0x[0-9a-fA-F]+)(?:\s*,\s*(\d+|0x[0-9a-fA-F]+))?\s*(?:;.*)?$', re.IGNORECASE
)

# [NUEVO] Regex para pseudo-operadores %hi(expr) y %lo(expr)
_PSEUDO_RE = re.compile(
    r'^%(hi|lo)\(("(?:[^"]*)"|\S+)\)$', re.IGNORECASE
)

# [NUEVO] Regex para expresiones de etiquetas con offset opcional: label+4, label-8, "label"+4
_LABEL_EXPR_RE = re.compile(
    r'^("?[^"+-]+"?)\s*([+-])\s*(\d+|0x[0-9a-fA-F]+)$'
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


# [NUEVO] Evalúa una expresión de etiqueta (ej: main, "main", g_t08_args+4, buf-2)
def eval_label_expr(token: str, label_map: dict[str, int]) -> int:
    """
    Evalúa una expresión de etiqueta que puede ser un nombre de etiqueta
    simple ('main', '"main"', '.LBB1_1') o con offset ('g_t08_args+4', 'buf-2').
    Devuelve la dirección final calculada.
    """
    token = token.strip()
    m = _LABEL_EXPR_RE.match(token)
    if m:
        raw_name = m.group(1).strip()
        sign = m.group(2)
        offset_str = m.group(3)
        base_name = normalize_label(raw_name)
        if base_name is None or base_name not in label_map:
            raise AssemblerError(f"Etiqueta base no definida en expresión '{token}': '{raw_name}'.")
        offset = int(offset_str, 16) if offset_str.lower().startswith('0x') else int(offset_str)
        base_addr = label_map[base_name]
        return (base_addr + offset) if sign == '+' else (base_addr - offset)

    base_name = normalize_label(token)
    if base_name is None or base_name not in label_map:
        raise AssemblerError(f"Etiqueta no definida: '{token}'.")
    return label_map[base_name]


# [NUEVO] Resuelve un operando inmediato que puede ser:
#   • Un literal numérico normal (decimal/hex/bin)
#   • Un pseudo-operador %hi(expr) o %lo(expr)
#   • Una expresión de etiqueta (ej: g_t01_add, g_t08_args+4) usada como %hi/%lo
def _resolve_imm_or_pseudo(token: str, line_num: int,
                            label_map: dict[str, int] | None,
                            pseudo_kind: str | None,
                            bits: int = 16,
                            signed: bool = False) -> int:
    """
    Intenta resolver token como:
    1. Pseudo-operador %hi(expr) o %lo(expr) explícito.
    2. Expresión de etiqueta directa (tratada como %hi/%lo según pseudo_kind).
    3. Valor numérico directo.
    """
    token = token.strip()

    # ── %hi(label) o %lo(label) ──────────────────────────────────────────────
    m = _PSEUDO_RE.match(token)
    if m:
        kind  = m.group(1).lower()   # 'hi' o 'lo'
        expr = m.group(2)
        if label_map is None:
            return 0   # Placeholder para primera pasada
        try:
            target_addr = eval_label_expr(expr, label_map)
        except AssemblerError as e:
            e.line_number = line_num
            raise e
        hi16, lo16 = compute_hi_lo(target_addr)
        return (hi16 if kind == 'hi' else lo16) & 0xFFFF

    # ── Expresión de etiqueta directa usada como %hi o %lo ────────────────────
    if pseudo_kind is not None:
        if label_map is None:
            return 0   # Placeholder
        try:
            target_addr = eval_label_expr(token, label_map)
            hi16, lo16 = compute_hi_lo(target_addr)
            return (hi16 if pseudo_kind == 'hi' else lo16) & 0xFFFF
        except AssemblerError:
            pass   # Si no es etiqueta válida, intentar parsear como número directo abajo

    # Intentar resolver como etiqueta sin contexto si no es un número explícito
    if label_map is not None and not (token.startswith(('0x', '0b', '0X', '0B')) or token.lstrip('-+').isdigit()):
        try:
            target_addr = eval_label_expr(token, label_map)
            kind = pseudo_kind if pseudo_kind else 'hi'
            hi16, lo16 = compute_hi_lo(target_addr)
            return (hi16 if kind == 'hi' else lo16) & 0xFFFF
        except AssemblerError:
            pass

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
    [NUEVO] Determina si la instrucción contiene pseudo-operadores (%hi/%lo),
    etiquetas entre comillas o referencias a símbolos/expresiones que
    necesitan resolución diferida en la segunda pasada.
    """
    for t in tokens:
        if _PSEUDO_RE.match(t):
            return True
        if _LABEL_QUOTED_RE.match(t):
            return True
        t_clean = t.strip()
        if t_clean.startswith('%'):
            return True
        if _LABEL_EXPR_RE.match(t_clean):
            return True
        if normalize_label(t_clean) is not None and not (t_clean.startswith(('0x', '0b', '0X', '0B')) or t_clean.lstrip('-+').isdigit()):
            if not re.fullmatch(r'R(1[0-5]|[0-9])', t_clean.upper()):
                return True
    return False


def first_pass(lines: list[str], data_mode: str = 'rom') -> tuple[dict[str, int], list[PendingInstruction], list[str], int | None]:
    """
    PRIMER PASE: detecta etiquetas, directivas y construye la lista de
    instrucciones pendientes y mapa de etiquetas.

    [MODIFICADO]
    - Soporta secciones .text, .rodata, .data y .bss.
    - Soporta data_mode='rom' (separación ROM/RAM con rutina .start) y
      data_mode='ram' (mapa contiguo de direcciones).
    - Soporta directivas .p2align, .align, .long, .word, .short, .byte,
      .zero, .space, .skip, .comm.
    - Rastrea explícitamente la dirección de la primera instrucción/palabra
      emitida en la sección .text (text_start_word).

    Devuelve: (label_map, pending_list, errors, text_start_word)
    """
    mode = data_mode.lower()
    label_map: dict[str, int] = {}
    pending:   list[PendingInstruction] = []
    errors:    list[str] = []

    current_section = 'text'  # 'text', 'rodata', 'data', 'bss'

    # Dirección de palabra en ROM (para .text, .rodata y para la imagen ROM)
    rom_address = 0
    text_start_word: int | None = None  # Dirección de inicio real de la sección .text

    def _mark_text_start():
        nonlocal text_start_word
        if current_section == 'text' and text_start_word is None:
            text_start_word = rom_address

    # Rastreos de offset en RAM para MODO ROM (base RAM = 0x04000000)
    RAM_BASE = 0x04000000
    rom_data_bytes: list[int] = []  # Bytes crudos de .data para guardar en ROM
    ram_data_offset = 0            # Offset en RAM para .data (en bytes)
    ram_bss_offset = 0             # Offset en RAM para .bss (en bytes, relativo a fin de .data)

    def _parse_int_val(val_str: str, line_num: int) -> int | None:
        val_str = val_str.strip()
        try:
            if val_str.lower().startswith('0x'):
                return int(val_str, 16)
            elif val_str.lower().startswith('0b'):
                return int(val_str, 2)
            else:
                return int(val_str)
        except ValueError:
            errors.append(f"[Línea {line_num}] Valor numérico inválido: '{val_str}'.")
            return None

    for line_num, raw_line in enumerate(lines, start=1):
        code_line = raw_line.split(';')[0].strip()
        if not code_line:
            continue

        # ── Detectar cambio de sección ──────────────────────────────────────
        if _TEXT_SECTION_RE.match(code_line):
            current_section = 'text'
            continue
        if _RODATA_SECTION_RE.match(code_line):
            current_section = 'rodata'
            continue
        if _DATA_SECTION_RE.match(code_line):
            current_section = 'data'
            continue
        if _BSS_SECTION_RE.match(code_line):
            current_section = 'bss'
            continue

        # ── Directivas de sección .comm (suele estar en .bss) ────────────────
        mcomm = _COMM_RE.match(code_line)
        if mcomm:
            sym_raw = mcomm.group(1).strip()
            size_val = _parse_int_val(mcomm.group(2), line_num)
            align_val = _parse_int_val(mcomm.group(3), line_num) if mcomm.group(3) else 1
            if size_val is not None:
                sym_name = normalize_label(sym_raw)
                if sym_name is None:
                    errors.append(f"[Línea {line_num}] Nombre de símbolo .comm inválido: '{sym_raw}'.")
                    continue
                if sym_name in label_map:
                    errors.append(f"[Línea {line_num}] Símbolo duplicado: '{sym_name}'.")
                    continue

                if mode == 'rom':
                    # Aplicar alineación en RAM para bss
                    align_bytes = align_val if align_val > 0 else 1
                    ram_bss_start = (ram_data_offset + 3) & ~3
                    curr_ram_addr = RAM_BASE + ram_bss_start + ram_bss_offset
                    pad = (align_bytes - (curr_ram_addr % align_bytes)) % align_bytes
                    ram_bss_offset += pad
                    label_map[sym_name] = RAM_BASE + ram_bss_start + ram_bss_offset
                    ram_bss_offset += size_val
                else: # mode == 'ram'
                    align_words = max(1, align_val // 4)
                    if align_words > 1:
                        remainder = rom_address % align_words
                        if remainder != 0:
                            pad_words = align_words - remainder
                            for _ in range(pad_words):
                                pending.append(PendingInstruction(is_raw_word=True, raw_value=0, src_line=line_num))
                            rom_address += pad_words
                    label_map[sym_name] = rom_address
                    words_needed = (size_val + 3) // 4
                    for _ in range(words_needed):
                        pending.append(PendingInstruction(is_raw_word=True, raw_value=0, src_line=line_num))
                    rom_address += words_needed
            continue

        # ── Directivas de alineación (.p2align / .align) ────────────────────
        mp2 = _P2ALIGN_RE.match(code_line)
        if mp2:
            n = int(mp2.group(1))
            align_bytes = 1 << n  # 2^N bytes
            if current_section in ('text', 'rodata') or (current_section in ('data', 'bss') and mode == 'ram'):
                align_words = max(1, align_bytes // 4)
                if align_words > 1:
                    remainder = rom_address % align_words
                    if remainder != 0:
                        pad = align_words - remainder
                        _mark_text_start()
                        for _ in range(pad):
                            pending.append(PendingInstruction(is_raw_word=True, raw_value=0, src_line=line_num))
                        rom_address += pad
            elif mode == 'rom':
                if current_section == 'data':
                    pad = (align_bytes - (ram_data_offset % align_bytes)) % align_bytes
                    ram_data_offset += pad
                    rom_data_bytes.extend([0] * pad)
                elif current_section == 'bss':
                    ram_bss_start = (ram_data_offset + 3) & ~3
                    curr_ram_addr = RAM_BASE + ram_bss_start + ram_bss_offset
                    pad = (align_bytes - (curr_ram_addr % align_bytes)) % align_bytes
                    ram_bss_offset += pad
            continue

        # ── Directiva .long / .word ──────────────────────────────────────────
        mlong = _LONG_RE.match(code_line)
        if mlong:
            val_expr_str = mlong.group(1).strip()
            vals_raw = [v.strip() for v in val_expr_str.split(',') if v.strip()]
            for v_str in vals_raw:
                val = _parse_int_val(v_str, line_num)
                if val is None:
                    val = 0
                val = val & 0xFFFFFFFF
                if current_section in ('text', 'rodata') or (current_section in ('data', 'bss') and mode == 'ram'):
                    _mark_text_start()
                    pending.append(PendingInstruction(is_raw_word=True, raw_value=val, src_line=line_num))
                    rom_address += 1
                elif mode == 'rom':
                    if current_section == 'data':
                        pad = (4 - (ram_data_offset % 4)) % 4
                        if pad > 0:
                            ram_data_offset += pad
                            rom_data_bytes.extend([0] * pad)
                        b0 = (val >> 24) & 0xFF
                        b1 = (val >> 16) & 0xFF
                        b2 = (val >> 8) & 0xFF
                        b3 = val & 0xFF
                        rom_data_bytes.extend([b0, b1, b2, b3])
                        ram_data_offset += 4
                    elif current_section == 'bss':
                        pad = (4 - ((ram_data_offset + ram_bss_offset) % 4)) % 4
                        ram_bss_offset += pad + 4
            continue

        # ── Directiva .short ─────────────────────────────────────────────────
        mshort = _SHORT_RE.match(code_line)
        if mshort:
            val_expr_str = mshort.group(1).strip()
            vals_raw = [v.strip() for v in val_expr_str.split(',') if v.strip()]
            for v_str in vals_raw:
                val = _parse_int_val(v_str, line_num)
                if val is None:
                    val = 0
                val = val & 0xFFFF
                if mode == 'rom' and current_section == 'data':
                    pad = (2 - (ram_data_offset % 2)) % 2
                    if pad > 0:
                        ram_data_offset += pad
                        rom_data_bytes.extend([0] * pad)
                    b0 = (val >> 8) & 0xFF
                    b1 = val & 0xFF
                    rom_data_bytes.extend([b0, b1])
                    ram_data_offset += 2
                elif mode == 'rom' and current_section == 'bss':
                    pad = (2 - ((ram_data_offset + ram_bss_offset) % 2)) % 2
                    ram_bss_offset += pad + 2
                else:
                    _mark_text_start()
                    pending.append(PendingInstruction(is_raw_word=True, raw_value=val, src_line=line_num))
                    rom_address += 1
            continue

        # ── Directiva .byte ──────────────────────────────────────────────────
        mbyte = _BYTE_RE.match(code_line)
        if mbyte:
            val_expr_str = mbyte.group(1).strip()
            vals_raw = [v.strip() for v in val_expr_str.split(',') if v.strip()]
            for v_str in vals_raw:
                val = _parse_int_val(v_str, line_num)
                if val is None:
                    val = 0
                val = val & 0xFF
                if mode == 'rom' and current_section == 'data':
                    rom_data_bytes.append(val)
                    ram_data_offset += 1
                elif mode == 'rom' and current_section == 'bss':
                    ram_bss_offset += 1
                else:
                    _mark_text_start()
                    pending.append(PendingInstruction(is_raw_word=True, raw_value=val, src_line=line_num))
                    rom_address += 1
            continue

        # ── Directiva .zero / .space / .skip ─────────────────────────────────
        mzero = _ZERO_RE.match(code_line)
        if mzero:
            n_bytes = _parse_int_val(mzero.group(1), line_num)
            if n_bytes is not None and n_bytes > 0:
                if mode == 'rom' and current_section == 'data':
                    rom_data_bytes.extend([0] * n_bytes)
                    ram_data_offset += n_bytes
                elif mode == 'rom' and current_section == 'bss':
                    ram_bss_offset += n_bytes
                else:
                    n_words = (n_bytes + 3) // 4
                    _mark_text_start()
                    for _ in range(n_words):
                        pending.append(PendingInstruction(is_raw_word=True, raw_value=0, src_line=line_num))
                    rom_address += n_words
            continue

        tokens = tokenize_line(code_line)
        if not tokens:
            continue

        # ── Detectar definición de etiqueta ─────────────────────────────────
        label_token = tokens[0]
        if label_token.endswith(':'):
            raw_name = label_token[:-1]
            name = normalize_label(raw_name)
            if name is None:
                errors.append(f"[Línea {line_num}] Nombre de etiqueta inválido: '{raw_name}'.")
                continue
            if name in label_map:
                errors.append(f"[Línea {line_num}] Etiqueta duplicada: '{name}'.")
                continue

            # Asignar dirección según sección y modo
            if mode == 'rom':
                if current_section == 'data':
                    label_map[name] = RAM_BASE + ram_data_offset
                elif current_section == 'bss':
                    ram_bss_start = (ram_data_offset + 3) & ~3
                    label_map[name] = RAM_BASE + ram_bss_start + ram_bss_offset
                else:
                    label_map[name] = rom_address
            else: # mode == 'ram'
                label_map[name] = rom_address

            tokens = tokens[1:]
            if not tokens:
                continue   # Línea solo con etiqueta

        # ── Detectar y descartar directivas LLVM ────────────────────────────
        first_tok = tokens[0].lower()
        if first_tok in _IGNORED_DIRECTIVES:
            continue
        if first_tok.startswith('.') and first_tok not in ('.long', '.word', '.short', '.byte', '.p2align', '.align', '.zero', '.space', '.skip', '.comm'):
            continue

        # ── Instrucción normal (.text) ───────────────────────────────────────
        _mark_text_start()
        if _tokens_need_second_pass(tokens):
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
                ))

        rom_address += 1

    # ── [NUEVO MODO ROM] Inyección de datos crudos de .data y rutina .start ──
    if mode == 'rom' and (len(rom_data_bytes) > 0 or ram_bss_offset > 0):
        num_data_words = 0
        if len(rom_data_bytes) > 0:
            pad = (4 - (len(rom_data_bytes) % 4)) % 4
            if pad > 0:
                rom_data_bytes.extend([0] * pad)

            num_data_words = len(rom_data_bytes) // 4
            rom_data_start_word = rom_address

            # 1. Escribir las palabras crudas de .data en la imagen ROM
            for i in range(num_data_words):
                b0 = rom_data_bytes[i*4 + 0]
                b1 = rom_data_bytes[i*4 + 1]
                b2 = rom_data_bytes[i*4 + 2]
                b3 = rom_data_bytes[i*4 + 3]
                word_val = (b0 << 24) | (b1 << 16) | (b2 << 8) | b3
                pending.append(PendingInstruction(is_raw_word=True, raw_value=word_val, src_line=0))
                rom_address += 1

        # 2. Generar etiqueta y rutina .start
        start_word_addr = rom_address
        label_map['.start'] = start_word_addr

        # ── Parte 1: Copiar .data de ROM a RAM (si hay variables en .data) ──
        if num_data_words > 0:
            # R0: Dirección ROM origen de .data (base: rom_data_start_word)
            hi_rom, lo_rom = compute_hi_lo(rom_data_start_word)
            # H LDI R0, hi_rom
            pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['LDI'], (0 << 20) | hi_rom)], src_line=0))
            # SLT ADI R0, lo_rom
            pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['ADI'], (0 << 20) | lo_rom)], src_line=0))

            # R1: Dirección RAM destino (0x04000000)
            # H LDI R1, 0x0400
            pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['LDI'], (1 << 20) | 0x0400)], src_line=0))
            # SLT ADI R1, 0x0000
            pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['ADI'], (1 << 20) | 0x0000)], src_line=0))

            # Copiar cada palabra con LOD (leer ROM a R2) + STR (escribir R2 a RAM)
            for i in range(num_data_words):
                offset = i * 4
                # INT LOD R0, R2, offset  -> ra=0, rb=2, tipo=0b010 (INT)
                w_lod = build_word(0b010, OPCODES['LOD'], (0 << 20) | (2 << 16) | (offset & 0xFFFF))
                # INT STR R1, R2, offset  -> ra=1, rb=2, tipo=0b010 (INT)
                w_str = build_word(0b010, OPCODES['STR'], (1 << 20) | (2 << 16) | (offset & 0xFFFF))
                pending.append(PendingInstruction(words=[w_lod], src_line=0))
                pending.append(PendingInstruction(words=[w_str], src_line=0))

        # ── Parte 2: Zero-inicializar .bss en RAM (si hay variables en .bss) ──
        num_bss_words = (ram_bss_offset + 3) // 4
        if num_bss_words > 0:
            ram_bss_start = (ram_data_offset + 3) & ~3
            ram_bss_base = RAM_BASE + ram_bss_start

            # Reusamos R1 para almacenar la dirección base de .bss en RAM.
            # R1 ya finalizó su función como puntero de destino para .data arriba,
            # por lo que recalcularlo para la base de .bss es seguro y no requiere
            # gastar ningún registro scratch adicional.
            hi_bss, lo_bss = compute_hi_lo(ram_bss_base)
            # H LDI R1, hi_bss
            pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['LDI'], (1 << 20) | hi_bss)], src_line=0))
            # SLT ADI R1, lo_bss
            pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['ADI'], (1 << 20) | lo_bss)], src_line=0))

            # Escribir 0x00000000 en cada palabra de .bss usando R0 como fuente.
            # En la ISA32_LM el registro R0 está fijado a 0 por hardware,
            # por lo que INT STR R1, R0, offset escribe 0 directo a RAM[R1 + offset].
            for i in range(num_bss_words):
                offset = i * 4
                # INT STR R1, R0, offset  -> ra=1, rb=0, tipo=0b010 (INT)
                w_zero = build_word(0b010, OPCODES['STR'], (1 << 20) | (0 << 16) | (offset & 0xFFFF))
                pending.append(PendingInstruction(words=[w_zero], src_line=0))

        # ── Parte 3: Saltar a main o a la primera instrucción de .text ─────
        main_entry = None
        for candidate in ('main', '"main"'):
            if candidate in label_map:
                main_entry = candidate
                break

        if main_entry:
            pending.append(PendingInstruction(pending_tokens=['H', 'LDI', 'R0', f'%hi({main_entry})'], src_line=0))
            pending.append(PendingInstruction(pending_tokens=['SLT', 'ADI', 'R0', f'%lo({main_entry})'], src_line=0))
        else:
            # Si no existe 'main', el programa arranca en la primera instrucción de .text por diseño (no hay una función de entrada dedicada).
            if text_start_word is not None:
                hi_text, lo_text = compute_hi_lo(text_start_word)
                pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['LDI'], (0 << 20) | hi_text)], src_line=0))
                pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['ADI'], (0 << 20) | lo_text)], src_line=0))
            else:
                errors.append("[ERROR] No se pudo generar la rutina .start: no existe función 'main' ni contenido en la sección .text al que saltar.")
                hi_zero, lo_zero = compute_hi_lo(0)
                pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['LDI'], (0 << 20) | hi_zero)], src_line=0))
                pending.append(PendingInstruction(words=[build_word(0b100, OPCODES['ADI'], (0 << 20) | lo_zero)], src_line=0))

        pending.append(PendingInstruction(words=[build_word(0b000, OPCODES['JMP'], 0 << 16)], src_line=0))

    return label_map, pending, errors, text_start_word


def second_pass(label_map: dict[str, int],
                pending: list[PendingInstruction],
                data_mode: str = 'rom'
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


def assemble_source(source_path: str,
                    data_mode: str = 'rom'
                    ) -> tuple[list[tuple[int,int,int]], list[str], dict[str,int], int | None]:
    """
    Pipeline completo de ensamblado de un único archivo .s/.asm/.txt.
    Devuelve: (instructions, errors, label_map, text_start_word)
    """
    try:
        with open(source_path, 'r', encoding='utf-8', errors='replace') as f:
            lines = f.readlines()
    except OSError as e:
        return [], [f"No se pudo abrir el archivo: {e}"], {}, None

    return assemble_lines(lines, data_mode=data_mode)


def assemble_lines(lines: list[str],
                   data_mode: str = 'rom'
                   ) -> tuple[list[tuple[int,int,int]], list[str], dict[str,int], int | None]:
    """
    Pipeline completo de ensamblado a partir de una lista de líneas.
    Devuelve: (instructions, errors, label_map, text_start_word)

    [MODIFICADO] Siempre se ejecutan ambas pasadas para que los errores de
    primera pasada (etiquetas duplicadas, sintaxis) y los de segunda pasada
    (%hi/%lo no resueltos) se acumulen y reporten correctamente.
    Los errores de primera pasada se notifican al final sin detener la 2ª.
    """
    label_map, pending, errors1, text_start_word = first_pass(lines, data_mode=data_mode)
    instructions, errors2 = second_pass(label_map, pending, data_mode=data_mode)
    return instructions, errors1 + errors2, label_map, text_start_word


# =============================================================================
#  ESCRITURA DEL ARCHIVO ROM (Logisim v3.0 hex words addressed) — igual
# =============================================================================

def write_rom_logisim(instructions: list[tuple[int,int,int]],
                      output_path: str,
                      label_map: dict[str, int] | None = None,
                      data_mode: str = 'rom',
                      text_start_word: int | None = None) -> None:
    """
    Escribe la imagen de ROM en formato Logisim:
        v3.0 hex words addressed

    Cada instrucción de 32 bits se almacena como 4 bytes en orden big-endian.
    La dirección en el archivo es de bytes: addr_byte = addr_word * 4.

    Las filas vacías (solo ceros) se omiten.
    Al final se agrega el vector de reset/boot en 0xFFFF0:
        H LDI  R0, %hi(main/.start)   → carga parte alta de la dirección objetivo
        SLT ADI R0, %lo(main/.start)  → suma parte baja (con signo)
        JMP R0                        → salta a main, .start o inicio de .text
        NOP                           → relleno
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

    # ── Vector de reset: salto a .start (si existe en modo ROM) o a main / inicio de .text ───────
    reset_target_addr = None
    if label_map:
        if data_mode.lower() == 'rom' and '.start' in label_map:
            reset_target_addr = label_map['.start']
        else:
            for candidate in ('main', '"main"'):
                if candidate in label_map:
                    reset_target_addr = label_map[candidate]
                    break

    if reset_target_addr is None:
        # Si no existe 'main', el programa arranca en la primera instrucción de .text por diseño (no hay una función de entrada dedicada).
        if text_start_word is not None:
            reset_target_addr = text_start_word
        elif instructions:
            reset_target_addr = instructions[0][1]
        else:
            print("[ERROR] No se pudo generar el vector de reset: no existe función 'main' ni contenido en la sección .text al que saltar.")
            reset_target_addr = 0

    hi16, lo16 = compute_hi_lo(reset_target_addr)

    # H LDI R15, hi16  → tipo=0b100, op=LDI(0b01100), ra=15, imm=hi16
    # Formato: [31:29]=tipo [28:24]=op [23:20]=ra [19:16]=0 [15:0]=imm
    word_ldi  = build_word(0b100, OPCODES['LDI'], (15 << 20) | hi16)
    # SLT ADI R15, lo16 → tipo=0b100, op=ADI(0b01101), ra=15, imm=lo16
    word_adi  = build_word(0b100, OPCODES['ADI'], (15 << 20) | lo16)
    # JMP R15          → tipo=0b000, op=JMP(0b01110), rb=15
    word_jmp  = build_word(0b000, OPCODES['JMP'], 15 << 16)
    # NOP
    word_nop  = build_word(0b000, OPCODES['NOP'], 0)

    def _word_to_bytes(w: int) -> list[int]:
        return [
            (w >> 24) & 0xFF,
            (w >> 16) & 0xFF,
            (w >>  8) & 0xFF,
             w        & 0xFF,
        ]

    reset_bytes = (
        _word_to_bytes(word_ldi) +
        _word_to_bytes(word_adi) +
        _word_to_bytes(word_jmp) +
        _word_to_bytes(word_nop)
    )
    reset_hex = ' '.join(f"{b:02x}" for b in reset_bytes)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("v3.0 hex words addressed\n")

        row = 0
        while row <= last_row:
            row_bytes = [byte_map.get(row + i, 0) for i in range(BYTES_PER_ROW)]
            if any(b != 0 for b in row_bytes):
                hex_bytes = ' '.join(f"{b:02x}" for b in row_bytes)
                f.write(f"{row:05x}: {hex_bytes}\n")
            row += BYTES_PER_ROW

        # Escribir vector de reset con salto a main
        f.write(f"ffff0: {reset_hex}\n")


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

def compile_c_to_ll(c_path: str, ll_path: str, opt_level: str = "-O0", log_fn=None) -> list[str]:
    """
    Compila un archivo .c/.C a .ll usando clang:
      clang <opt_level> -fno-ms-volatile -target arm-none-eabi -S -emit-llvm archivo1.c -o archivo1.ll
    """
    opt = opt_level.upper() if opt_level.startswith('-') else f"-{opt_level.upper()}"
    cmd = f'clang {opt} -fno-ms-volatile -target arm-none-eabi -S -emit-llvm "{c_path}" -o "{ll_path}"'
    if log_fn:
        log_fn(f"  Generando .ll: {os.path.basename(c_path)} ({opt})", 'info')
        log_fn(f"  $ {cmd}", 'info')

    try:
        result = subprocess.run(
            cmd, shell=True, capture_output=True, text=True
        )
    except Exception as e:
        return [f"Error al invocar clang++: {e}"]

    errors = []
    if result.returncode != 0:
        errors.append(f"Error compilando '{c_path}':")
        for line in (result.stderr or result.stdout).splitlines():
            errors.append(f"  {line}")
    return errors


def link_ll_files(ll_paths: list[str], output_ll_path: str, log_fn=None) -> list[str]:
    """
    Une múltiples archivos .ll en uno solo usando llvm-link:
      llvm-link archivo1.ll archivo2.ll -S -o unido.ll
    """
    if len(ll_paths) == 1:
        try:
            shutil.copyfile(ll_paths[0], output_ll_path)
            return []
        except Exception as e:
            return [f"Error al copiar archivo .ll: {e}"]

    inputs_str = " ".join(f'"{p}"' for p in ll_paths)
    cmd = f'llvm-link {inputs_str} -S -o "{output_ll_path}"'
    if log_fn:
        log_fn(f"  Uniendo {len(ll_paths)} archivos .ll con llvm-link...", 'info')
        log_fn(f"  $ {cmd}", 'info')

    try:
        result = subprocess.run(
            cmd, shell=True, capture_output=True, text=True
        )
    except Exception as e:
        return [f"Error al invocar llvm-link: {e}"]

    errors = []
    if result.returncode != 0:
        errors.append("Error al unir archivos .ll con llvm-link:")
        for line in (result.stderr or result.stdout).splitlines():
            errors.append(f"  {line}")
    return errors


def compile_ll_to_s(ll_path: str, s_path: str, log_fn=None) -> list[str]:
    """
    Convierte el archivo .ll a ensamblador .s usando llc:
      llc -march=isa32_lm unido.ll -o final.s
    """
    cmd = f'llc -march=isa32_lm "{ll_path}" -o "{s_path}"'
    if log_fn:
        log_fn(f"  Generando .s con llc...", 'info')
        log_fn(f"  $ {cmd}", 'info')

    try:
        result = subprocess.run(
            cmd, shell=True, capture_output=True, text=True
        )
    except Exception as e:
        return [f"Error al invocar llc: {e}"]

    errors = []
    if result.returncode != 0:
        errors.append("Error generando .s con llc:")
        for line in (result.stderr or result.stdout).splitlines():
            errors.append(f"  {line}")
    return errors


def compile_c_to_s(c_path: str, s_path: str, opt_level: str = "-O0", log_fn=None) -> list[str]:
    """
    Compila un único archivo .c/.C a .s usando clang y llc.
    """
    tmp_dir = tempfile.mkdtemp(prefix="isa32_asm_")
    try:
        base = os.path.splitext(os.path.basename(c_path))[0]
        ll_path = os.path.join(tmp_dir, base + ".ll")
        errs = compile_c_to_ll(c_path, ll_path, opt_level=opt_level, log_fn=log_fn)
        if errs:
            return errs
        return compile_ll_to_s(ll_path, s_path, log_fn=log_fn)
    finally:
        shutil.rmtree(tmp_dir, ignore_errors=True)


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
                          opt_level: str = "-O0",
                          generate_listing: bool = True,
                          generate_ll: bool = False,
                          log_fn=None,
                          data_mode: str = 'rom'
                          ) -> tuple[list[tuple[int,int,int]], list[str], dict[str,int], int | None]:
    """
    [NUEVO] Pipeline completo: .c → .ll → (llvm-link) → .s → ROM.

    1. Compila cada .c a .ll con clang <opt_level> -fno-ms-volatile -S -emit-llvm <archivo.c> -o <archivo.ll>.
    2. Si son más de uno, une los .ll con llvm-link <ll1> <ll2> -S -o unido.ll.
    3. Convierte el .ll unido a .s con llc -march=isa32_lm unido.ll -o final.s.
    4. Ensambla el .s final.

    Devuelve: (instructions, errors, label_map, text_start_word)
    """
    errors = []
    tmp_dir = tempfile.mkdtemp(prefix="isa32_asm_")

    try:
        # 1. Crear los .ll por cada .c
        ll_paths = []
        for c_path in c_paths:
            base = os.path.splitext(os.path.basename(c_path))[0]
            ll_path = os.path.join(tmp_dir, base + ".ll")
            errs = compile_c_to_ll(c_path, ll_path, opt_level=opt_level, log_fn=log_fn)
            if errs:
                errors.extend(errs)
            else:
                ll_paths.append(ll_path)

        if errors:
            return [], errors, {}, None

        # 2. Unir archivos .ll cuando son más de uno
        unido_ll = os.path.join(tmp_dir, "unido.ll")
        errs = link_ll_files(ll_paths, unido_ll, log_fn=log_fn)
        if errs:
            return [], errs, {}, None

        # 3. Pasar a .s con llc
        first_dir = os.path.dirname(os.path.abspath(c_paths[0]))
        first_base = os.path.splitext(os.path.basename(c_paths[0]))[0]
        final_s = os.path.join(first_dir, first_base + COMBINED_ASM_SUFFIX)

        if generate_ll:
            final_ll = os.path.join(first_dir, first_base + "_combined.ll")
            shutil.copyfile(unido_ll, final_ll)
            if log_fn:
                log_fn(f"  Archivo .ll generado: {final_ll}", 'ok')

        errs = compile_ll_to_s(unido_ll, final_s, log_fn=log_fn)
        if errs:
            return [], errs, {}, None

        if log_fn:
            log_fn(f"  Archivo .s generado: {final_s}", 'ok')

        # 4. Ensamblar .s a ROM
        return assemble_source(final_s, data_mode=data_mode)

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

        self.ll_var = tk.BooleanVar(value=False)
        tk.Checkbutton(opt_frame, text="Generar IR de LLVM (.ll)",
                       variable=self.ll_var).pack(side='left')

        tk.Label(opt_frame, text="   Optimización:").pack(side='left', padx=(15, 2))
        self.opt_var = tk.StringVar(value="-O0")
        self.opt_menu = tk.OptionMenu(opt_frame, self.opt_var, "-O0", "-O1", "-O2", "-O3")
        self.opt_menu.pack(side='left')

        tk.Label(opt_frame, text="   Modo de datos:").pack(side='left', padx=(15, 2))
        self.data_mode_var = tk.StringVar(value="ROM")
        self.data_mode_menu = tk.OptionMenu(opt_frame, self.data_mode_var, "ROM", "RAM")
        self.data_mode_menu.pack(side='left')

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
        generate_ll = self.ll_var.get()
        opt_level = self.opt_var.get()
        data_mode = self.data_mode_var.get().lower()

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
            self._log(f"  Compilando {len(c_files)} archivo(s) C → ROM ({opt_level}, Modo datos: {data_mode.upper()})", 'head')
            self._log("══════════════════════════════════════════", 'head')
            instructions, errors, label_map, text_start_word = compile_and_assemble(
                c_files, rom_path,
                opt_level=opt_level,
                generate_listing=generate_listing,
                generate_ll=generate_ll,
                log_fn=self._log,
                data_mode=data_mode
            )
        elif len(files) == 1 and not c_files:
            # Modo ensamblado directo
            self._log(f"  Ensamblando: {os.path.basename(files[0])} (Modo datos: {data_mode.upper()})", 'head')
            self._log("══════════════════════════════════════════", 'head')
            instructions, errors, label_map, text_start_word = assemble_source(files[0], data_mode=data_mode)
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
        write_rom_logisim(instructions, rom_path, label_map=label_map, data_mode=data_mode, text_start_word=text_start_word)
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
        # [NUEVO] Parseo de --data-mode=rom|ram
        data_mode = "rom"
        for a in list(args):
            if a.lower().startswith('--data-mode='):
                data_mode = a.split('=', 1)[1].lower()
                args.remove(a)
            elif a.lower() == '--data-mode':
                idx = args.index(a)
                if idx + 1 < len(args):
                    data_mode = args[idx+1].lower()
                    args.pop(idx+1)
                args.pop(idx)

        # [NUEVO] Parseo de --no-list y --ll
        generate_listing = True
        if '--no-list' in args:
            generate_listing = False
            args = [a for a in args if a != '--no-list']

        generate_ll = False
        if '--ll' in args:
            generate_ll = True
            args = [a for a in args if a != '--ll']

        opt_level = "-O0"
        for a in list(args):
            if a.lower() in ('-o0', '-o1', '-o2', '-o3'):
                opt_level = a.upper()
                args.remove(a)

        if not args:
            print("[ERROR] No se especificaron archivos de entrada.")
            sys.exit(1)

        print("=" * 62)
        print(f"  Ensamblador — Procesador 32 bits (LLVM) [Modo datos: {data_mode.upper()}]")
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

            instructions, errors, label_map, text_start_word = compile_and_assemble(
                c_files, rom_path,
                opt_level=opt_level,
                generate_listing=generate_listing,
                generate_ll=generate_ll,
                log_fn=cli_log,
                data_mode=data_mode
            )

        elif len(asm_files) == 1 and not c_files:
            source_path = asm_files[0]
            if not os.path.isfile(source_path):
                print(f"[ERROR] Archivo no encontrado: {source_path}")
                sys.exit(1)
            instructions, errors, label_map, text_start_word = assemble_source(source_path, data_mode=data_mode)

        else:
            print("[ERROR] Especifica solo archivos .c o un único .s/.asm/.txt.")
            print("  Uso:")
            print("    python assembler.py [--data-mode=rom|ram] [--no-list] [--ll] archivo.s [ROM]")
            print("    python assembler.py [--data-mode=rom|ram] [--no-list] [--ll] f1.c f2.c [ROM]")
            sys.exit(1)

        if errors:
            print(f"[ERROR] {len(errors)} error(es):\n")
            for e in errors:
                print(f"  {e}")
            sys.exit(1)

        write_rom_logisim(instructions, rom_path, label_map=label_map, data_mode=data_mode, text_start_word=text_start_word)
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