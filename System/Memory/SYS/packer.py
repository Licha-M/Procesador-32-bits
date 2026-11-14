"""
packer.py
======================
Genera una imagen de disco binaria (.bin) particionada con GPT y formateada
con "CustomFS" (FAT32 simplificado) a partir de una estructura de carpetas.

    MiDisco/
      Sistema/            <- carpeta de primer nivel = una partición
        _part.cfg         <- configuración de la partición (obligatorio)
        boot/kernel.bin
        readme.txt
      Datos/
        _part.cfg
        ...

Todas las estructuras binarias (GPT, BPB, FAT, Dirents) se empaquetan con el
módulo `struct` en Little Endian ("<").

Uso:
    python packer.py                      # abre la interfaz gráfica
    python packer.py -i MiDisco -o disco.bin --verify   # línea de comandos
    python packer.py -i MiDisco           # CLI: pregunta la salida

Formato de _part.cfg (clave = valor, '#' o ';' al inicio = comentario):
    label        = SISTEMA        # obligatorio (máx. 31 bytes UTF-8)
    size_mb      = 64             # obligatorio, tamaño de la partición en MB
    cluster_size = 512            # opcional, bytes (múltiplo de 512, pot. de 2)
    num_fats     = 1              # opcional, 1 ó 2
    fs           = customfs       # opcional: customfs (defecto) | fat32 (pendiente)
"""

import argparse
import math
import os
import struct
import queue
import sys
import threading
import traceback
import uuid
import zlib
from dataclasses import dataclass, field
from pathlib import Path

# ─── Importación opcional de tkinter (GUI) ───────────────────────────────────
try:
    import tkinter as tk
    from tkinter import filedialog, messagebox, scrolledtext
    HAS_TK = True
except ImportError:
    HAS_TK = False


# ─── Salida de mensajes: consola por defecto, reemplazable por la GUI ────────
def _console_sink(msg, tag=""):
    print(msg)


_sink = _console_sink


def set_log_sink(fn):
    global _sink
    _sink = fn


def log(msg, tag=""):
    _sink(msg, tag)


# ============================================================================
# Constantes globales (modificables)
# ============================================================================
SECTOR_SIZE = 512
ALIGN_SECTORS = 2048                 # 1 MB
RESERVED_SECTORS = 8                 # 8 x 512 B = 4 KB (una página de SSD)
DEFAULT_CLUSTER_BYTES = 512
DEFAULT_NUM_FATS = 1

CUSTOM_DIR_SRC = r"D:/Yo/Escritorio/Procesador-32-bits/System/Memory/NVM"
CUSTOM_DIR_DEST = r"D:/Yo/Escritorio/Procesador-32-bits/System/IO/NV_Memory/Memory.bin"

# GUID de tipo de partición de CustomFS. Variable global modificable por código
# (o con --type-guid). Siempre se lee en el momento de usarla.
CUSTOMFS_TYPE_GUID = "43757374-6F6D-4653-0000-000000000001"
BASIC_DATA_TYPE_GUID = "EBD0A0A2-B9E5-4433-87C0-68B6B72699C7"  # para FAT32 estándar

# FAT
ROOT_CLUSTER = 2
FAT_FREE = 0x00000000
FAT_EOF = 0xFFFFFFFF
FAT_BAD = 0xFFFFFFF7
FAT_MEDIA = 0xFFFFFFF8
MAX_CLUSTER_INDEX = 0xFFFFFFF6       # último índice utilizable (< FAT_BAD)

# Dirent
DIRENT_SIZE = 64
NAME_MAX_BYTES = 31                  # 32 bytes con terminador nulo
ATTR_READONLY = 0x01
ATTR_DIRECTORY = 0x02
ATTR_HIDDEN = 0x04

# GPT
GPT_SIGNATURE = b"EFI PART"
GPT_REVISION = 0x00010000
GPT_HEADER_SIZE = 92
GPT_ENTRY_COUNT = 128
GPT_ENTRY_SIZE = 128
GPT_ENTRIES_SECTORS = GPT_ENTRY_COUNT * GPT_ENTRY_SIZE // SECTOR_SIZE   # 32

CFG_NAME = "_part.cfg"
INCLUDE_CFG_IN_FS = False            # ¿copiar _part.cfg dentro de la partición?
COPY_CHUNK = 1 << 20

# ============================================================================
# Estructuras binarias (struct, Little Endian)
# ============================================================================
# Cabecera de volumen (BPB simplificado, sin código de arranque)
BPB = struct.Struct("<8sHHBBHQQIIIIII32s")
#   magic, version, bytes_per_sector, sectors_per_cluster, num_fats,
#   reserved_sectors, part_start_lba, total_sectors, fat_sectors, root_cluster,
#   total_clusters, free_clusters, next_free_hint, volume_id, label
BPB_MAGIC = b"CUSTOMFS"
BPB_VERSION = 1

# Dirent de 64 bytes
DIRENT = struct.Struct("<32sB3sIII16s")
#   name[32], attributes, reserved[3], first_cluster, file_size, mod_time, pad[16]
assert DIRENT.size == DIRENT_SIZE

# GPT
GPT_HEADER = struct.Struct("<8sIIIIQQQQ16sQIII")
GPT_ENTRY = struct.Struct("<16s16sQQQ72s")
assert GPT_HEADER.size == GPT_HEADER_SIZE
assert GPT_ENTRY.size == GPT_ENTRY_SIZE


# ============================================================================
# Configuración de partición
# ============================================================================
@dataclass
class PartConfig:
    label: str
    size_mb: int
    fs: str = "customfs"
    cluster_bytes: int = DEFAULT_CLUSTER_BYTES
    num_fats: int = DEFAULT_NUM_FATS
    folder: Path = None

    @property
    def total_sectors(self):
        return self.size_mb * 1024 * 1024 // SECTOR_SIZE

    @property
    def sectors_per_cluster(self):
        return self.cluster_bytes // SECTOR_SIZE


def _parse_size(text):
    t = text.strip().lower()
    mult = 1
    for suf, m in (("kb", 1024), ("k", 1024), ("b", 1)):
        if t.endswith(suf):
            t, mult = t[: -len(suf)].strip(), m
            break
    return int(t, 0) * mult


def parse_cfg(folder: Path) -> PartConfig:
    path = folder / CFG_NAME
    if not path.is_file():
        raise ValueError(f"Falta {CFG_NAME} en '{folder}'")
    raw = {}
    for n, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = line.strip()
        if not line or line[0] in "#;[":
            continue
        if "=" not in line:
            raise ValueError(f"{path}:{n}: línea inválida (se esperaba clave = valor)")
        k, v = line.split("=", 1)
        raw[k.strip().lower()] = v.strip()

    aliases = {"name": "label", "size": "size_mb", "cluster_bytes": "cluster_size",
               "fats": "num_fats"}
    cfg = {aliases.get(k, k): v for k, v in raw.items()}
    for k in cfg:
        if k not in ("label", "size_mb", "cluster_size", "num_fats", "fs"):
            log(f"[aviso] {path}: clave desconocida '{k}' ignorada", "lbl")

    if not cfg.get("label"):
        raise ValueError(f"{path}: 'label' es obligatorio")
    if "size_mb" not in cfg:
        raise ValueError(f"{path}: 'size_mb' es obligatorio")

    pc = PartConfig(label=cfg["label"], size_mb=int(cfg["size_mb"], 0),
                    fs=cfg.get("fs", "customfs").lower(), folder=folder)
    if "cluster_size" in cfg:
        pc.cluster_bytes = _parse_size(cfg["cluster_size"])
    if "num_fats" in cfg:
        pc.num_fats = int(cfg["num_fats"], 0)

    if len(pc.label.encode("utf-8")) > 31:
        raise ValueError(f"{path}: 'label' supera 31 bytes UTF-8")
    if pc.size_mb <= 0:
        raise ValueError(f"{path}: size_mb debe ser > 0")
    cb = pc.cluster_bytes
    if cb < SECTOR_SIZE or cb % SECTOR_SIZE or (cb & (cb - 1)):
        raise ValueError(f"{path}: cluster_size debe ser potencia de 2 y múltiplo de {SECTOR_SIZE}")
    if pc.num_fats not in (1, 2):
        raise ValueError(f"{path}: num_fats debe ser 1 ó 2")
    return pc


# ============================================================================
# Árbol de archivos local
# ============================================================================
@dataclass
class Node:
    name: str
    path: Path
    is_dir: bool
    size: int = 0
    mtime: int = 0
    attrs: int = 0
    children: list = field(default_factory=list)


def _check_name(name, where):
    enc = name.encode("utf-8")
    if not enc or len(enc) > NAME_MAX_BYTES:
        raise ValueError(f"Nombre inválido o > {NAME_MAX_BYTES} bytes: '{name}' en {where}")
    if enc[0] in (0x00, 0xE5):
        raise ValueError(f"Nombre con primer byte reservado: '{name}' en {where}")


def build_tree(path: Path, is_root=False) -> Node:
    st = path.stat()
    node = Node(name=path.name, path=path, is_dir=True, mtime=int(st.st_mtime) & 0xFFFFFFFF)
    with os.scandir(path) as it:
        entries = sorted(it, key=lambda e: e.name.casefold())
    for e in entries:
        if is_root and e.name == CFG_NAME and not INCLUDE_CFG_IN_FS:
            continue
        _check_name(e.name, path)
        st = e.stat()
        attrs = 0
        if not os.access(e.path, os.W_OK):
            attrs |= ATTR_READONLY
        if e.name.startswith("."):
            attrs |= ATTR_HIDDEN
        if e.is_dir(follow_symlinks=False):
            child = build_tree(Path(e.path))
            child.attrs = attrs | ATTR_DIRECTORY
            node.children.append(child)
        elif e.is_file(follow_symlinks=False):
            if st.st_size > 0xFFFFFFFF:
                raise ValueError(f"Archivo > 4 GiB no soportado (uint32): {e.path}")
            node.children.append(Node(e.name, Path(e.path), False, st.st_size,
                                      int(st.st_mtime) & 0xFFFFFFFF, attrs))
        else:
            log(f"[aviso] se omite (no es archivo/carpeta regular): {e.path}", "lbl")
    return node


# ============================================================================
# Geometría
# ============================================================================
@dataclass
class Geometry:
    total_sectors: int
    reserved: int
    fat_sectors: int
    num_fats: int
    spc: int
    total_clusters: int

    @property
    def data_start(self):
        """Sector (relativo a la partición) donde empieza la zona de datos."""
        return self.reserved + self.fat_sectors * self.num_fats


def compute_geometry(total_sectors, spc, num_fats) -> Geometry:
    avail = total_sectors - RESERVED_SECTORS
    if avail <= 0:
        raise ValueError("Partición demasiado pequeña")
    # Cota superior de clústeres -> tamaño de FAT suficiente (sin oscilaciones)
    upper = avail // spc
    fat_sectors = math.ceil((upper + 2) * 4 / SECTOR_SIZE)
    clusters = (avail - num_fats * fat_sectors) // spc
    clusters = min(clusters, MAX_CLUSTER_INDEX - 1)
    if clusters < 1:
        raise ValueError("Partición demasiado pequeña para al menos 1 clúster")
    return Geometry(total_sectors, RESERVED_SECTORS, fat_sectors, num_fats, spc, clusters)


# ============================================================================
# Formateador CustomFS
# ============================================================================
def pack_dirent(name, attrs, first_cluster, size, mtime):
    nm = name.encode("utf-8")
    return DIRENT.pack(nm.ljust(32, b"\x00"), attrs, b"\x00\x00\x00",
                       first_cluster, size, mtime, b"\x00" * 16)


class CustomFSFormatter:
    """Escribe una partición CustomFS en `out` (archivo abierto 'r+b')."""

    def __init__(self, out, part_start_lba, cfg: PartConfig):
        self.out = out
        self.part_start_lba = part_start_lba
        self.cfg = cfg
        self.geo = compute_geometry(cfg.total_sectors, cfg.sectors_per_cluster, cfg.num_fats)
        self.cb = cfg.cluster_bytes
        self.part_off = part_start_lba * SECTOR_SIZE
        n = self.geo.total_clusters + 2
        self.fat = [FAT_FREE] * n
        self.fat[0] = FAT_MEDIA
        self.fat[1] = FAT_EOF
        self.next_free = ROOT_CLUSTER

    # --- direcciones -------------------------------------------------------
    def cluster_lba(self, n):
        """LBA absoluto del clúster N (N >= 2)."""
        data_start = self.part_start_lba + self.geo.data_start
        return data_start + (n - 2) * self.geo.spc

    def _cluster_off(self, n):
        return self.cluster_lba(n) * SECTOR_SIZE

    # --- asignación --------------------------------------------------------
    def _alloc(self, count):
        """Reserva `count` clústeres contiguos y enlaza la cadena en la FAT."""
        first = self.next_free
        last = first + count - 1
        if last > self.geo.total_clusters + 1:
            raise RuntimeError(f"Partición '{self.cfg.label}' llena: aumentá size_mb")
        for c in range(first, last):
            self.fat[c] = c + 1
        self.fat[last] = FAT_EOF
        self.next_free = last + 1
        return first

    # --- serialización -----------------------------------------------------
    def _write_file(self, node: Node) -> int:
        if node.size == 0:
            return 0                              # archivo vacío: sin cadena
        first = self._alloc(math.ceil(node.size / self.cb))
        self.out.seek(self._cluster_off(first))
        remaining = node.size
        with open(node.path, "rb") as f:
            while remaining:
                chunk = f.read(min(COPY_CHUNK, remaining))
                if not chunk:
                    raise IOError(f"El archivo cambió durante la copia: {node.path}")
                self.out.write(chunk)
                remaining -= len(chunk)
        return first

    def _write_dir(self, node: Node, parent_cluster: int, is_root=False) -> int:
        n_entries = len(node.children) + (0 if is_root else 2)
        n_clusters = max(1, math.ceil(n_entries * DIRENT_SIZE / self.cb))
        first = self._alloc(n_clusters)           # la cadena del dir se reserva primero
        if is_root and first != ROOT_CLUSTER:
            raise AssertionError("La raíz debe estar en el clúster 2")

        dirents = []
        if not is_root:
            dirents.append(pack_dirent(".", ATTR_DIRECTORY, first, 0, node.mtime))
            dirents.append(pack_dirent("..", ATTR_DIRECTORY, parent_cluster, 0, node.mtime))
        for ch in node.children:
            if ch.is_dir:
                c = self._write_dir(ch, first)
                dirents.append(pack_dirent(ch.name, ch.attrs, c, 0, ch.mtime))
            else:
                c = self._write_file(ch)
                dirents.append(pack_dirent(ch.name, ch.attrs, c, ch.size, ch.mtime))

        blob = b"".join(dirents).ljust(n_clusters * self.cb, b"\x00")  # name[0]==0 => fin
        self.out.seek(self._cluster_off(first))
        self.out.write(blob)
        return first

    def _pack_fat(self) -> bytes:
        parts = []
        step = 1 << 16
        for i in range(0, len(self.fat), step):
            chunk = self.fat[i:i + step]
            parts.append(struct.pack(f"<{len(chunk)}I", *chunk))
        raw = b"".join(parts)
        return raw.ljust(self.geo.fat_sectors * SECTOR_SIZE, b"\x00")

    def _pack_bpb(self) -> bytes:
        g = self.geo
        used = self.next_free - ROOT_CLUSTER
        label = self.cfg.label.encode("utf-8")
        hdr = BPB.pack(BPB_MAGIC, BPB_VERSION, SECTOR_SIZE, g.spc, g.num_fats,
                       g.reserved, self.part_start_lba, g.total_sectors, g.fat_sectors,
                       ROOT_CLUSTER, g.total_clusters, g.total_clusters - used,
                       self.next_free, zlib.crc32(label) & 0xFFFFFFFF, label.ljust(32, b"\x00"))
        return hdr.ljust(g.reserved * SECTOR_SIZE, b"\x00")   # sin código de arranque

    def format(self, root: Node):
        self._write_dir(root, ROOT_CLUSTER, is_root=True)
        self.out.seek(self.part_off)
        self.out.write(self._pack_bpb())
        fat_raw = self._pack_fat()
        for i in range(self.geo.num_fats):
            self.out.seek(self.part_off + (self.geo.reserved + i * self.geo.fat_sectors) * SECTOR_SIZE)
            self.out.write(fat_raw)
        used = self.next_free - ROOT_CLUSTER
        return used


# Registro de formateadores (punto de extensión para FAT32 estándar, etc.)
def _fat32_not_implemented(*_a, **_k):
    raise NotImplementedError("fs=fat32 todavía no está implementado (solo customfs).")


FORMATTERS = {"customfs": CustomFSFormatter, "fat32": _fat32_not_implemented}


def type_guid_for(fs) -> uuid.UUID:
    # Se lee la global en el momento de la llamada => modificable por código
    return uuid.UUID(BASIC_DATA_TYPE_GUID if fs == "fat32" else CUSTOMFS_TYPE_GUID)


# ============================================================================
# GPT
# ============================================================================
@dataclass
class PartPlacement:
    cfg: PartConfig
    start_lba: int
    end_lba: int            # inclusivo
    unique_guid: uuid.UUID = None


def plan_layout(cfgs):
    if len(cfgs) > GPT_ENTRY_COUNT:
        raise ValueError(f"Máximo {GPT_ENTRY_COUNT} particiones")
    cursor = ALIGN_SECTORS               # 1 MB para MBR vacío + GPT primaria
    placements = []
    for c in cfgs:
        size = c.total_sectors
        if size % ALIGN_SECTORS:
            raise ValueError(f"'{c.label}': el tamaño debe ser múltiplo de 1 MB")
        placements.append(PartPlacement(c, cursor, cursor + size - 1))
        cursor += size
    total = cursor + GPT_ENTRIES_SECTORS + 1   # GPT secundaria: entradas + cabecera
    return placements, total


def build_gpt(placements, total_sectors, disk_guid):
    first_usable = ALIGN_SECTORS
    last_usable = total_sectors - GPT_ENTRIES_SECTORS - 2
    entries = bytearray()
    for p in placements:
        name = p.cfg.label[:36].encode("utf-16-le").ljust(72, b"\x00")
        entries += GPT_ENTRY.pack(type_guid_for(p.cfg.fs).bytes_le, p.unique_guid.bytes_le,
                                  p.start_lba, p.end_lba, 0, name)
    entries = bytes(entries).ljust(GPT_ENTRY_COUNT * GPT_ENTRY_SIZE, b"\x00")
    entries_crc = zlib.crc32(entries) & 0xFFFFFFFF

    def header(cur, bak, entries_lba):
        h = GPT_HEADER.pack(GPT_SIGNATURE, GPT_REVISION, GPT_HEADER_SIZE, 0, 0, cur, bak,
                            first_usable, last_usable, disk_guid.bytes_le, entries_lba,
                            GPT_ENTRY_COUNT, GPT_ENTRY_SIZE, entries_crc)
        crc = zlib.crc32(h) & 0xFFFFFFFF
        h = h[:16] + struct.pack("<I", crc) + h[20:]
        return h.ljust(SECTOR_SIZE, b"\x00")

    primary = header(1, total_sectors - 1, 2)
    backup = header(total_sectors - 1, 1, total_sectors - 1 - GPT_ENTRIES_SECTORS)
    return primary, backup, entries


# ============================================================================
# Orquestación
# ============================================================================
def create_image(input_dir: Path, output: Path):
    folders = sorted((p for p in input_dir.iterdir() if p.is_dir()), key=lambda p: p.name.casefold())
    for f in input_dir.iterdir():
        if f.is_file():
            log(f"[aviso] se ignora archivo suelto en la raíz: {f.name}", "lbl")
    if not folders:
        raise ValueError(f"'{input_dir}' no contiene carpetas (particiones)")

    cfgs = [parse_cfg(f) for f in folders]
    for c in cfgs:
        if c.fs not in FORMATTERS:
            raise ValueError(f"fs desconocido '{c.fs}' en {c.folder}")

    placements, total = plan_layout(cfgs)
    disk_guid = uuid.uuid5(uuid.NAMESPACE_URL, "customfs-disk:" + "|".join(
        f"{c.label}:{c.size_mb}" for c in cfgs))
    for i, p in enumerate(placements):
        p.unique_guid = uuid.uuid5(disk_guid, f"{i}:{p.cfg.label}")

    primary, backup, entries = build_gpt(placements, total, disk_guid)

    log(f"Imagen: {total} sectores ({total * SECTOR_SIZE / 1048576:.2f} MB) -> {output}", "info")
    output.parent.mkdir(parents=True, exist_ok=True)
    with open(output, "w+b") as out:
        out.truncate(total * SECTOR_SIZE)
        # LBA 0: sin MBR protector (por especificación) -> ceros
        out.seek(1 * SECTOR_SIZE); out.write(primary)                  # GPT header primario
        out.seek(2 * SECTOR_SIZE); out.write(entries)                  # tabla de particiones
        for p in placements:
            c = p.cfg
            tree = build_tree(c.folder, is_root=True)
            fmt = FORMATTERS[c.fs](out, p.start_lba, c)
            used = fmt.format(tree)
            g = fmt.geo
            log(f"  [{c.label}] LBA {p.start_lba}-{p.end_lba} | cluster {c.cluster_bytes} B | "
                  f"FATs {g.num_fats} x {g.fat_sectors} sect | {g.total_clusters} clústeres "
                  f"({used} usados)", "ok")
        out.seek((total - 1 - GPT_ENTRIES_SECTORS) * SECTOR_SIZE); out.write(entries)  # backup
        out.seek((total - 1) * SECTOR_SIZE); out.write(backup)


# ============================================================================
# Verificación (relee la imagen y recorre el FS)
# ============================================================================
def verify_image(path: Path):
    with open(path, "rb") as f:
        data = f.read()

    def sec(lba, n=1):
        return data[lba * SECTOR_SIZE:(lba + n) * SECTOR_SIZE]

    h = sec(1)[:GPT_HEADER_SIZE]
    fields = GPT_HEADER.unpack(h)
    assert fields[0] == GPT_SIGNATURE, "firma GPT inválida"
    crc = fields[3]
    assert zlib.crc32(h[:16] + b"\0\0\0\0" + h[20:]) & 0xFFFFFFFF == crc, "CRC cabecera GPT"
    entries = sec(fields[10], GPT_ENTRIES_SECTORS)
    assert zlib.crc32(entries) & 0xFFFFFFFF == fields[13], "CRC entradas GPT"
    log("GPT OK", "ok")

    for i in range(fields[11]):
        e = GPT_ENTRY.unpack_from(entries, i * GPT_ENTRY_SIZE)
        if e[0] == b"\0" * 16:
            continue
        name = e[5].decode("utf-16-le").rstrip("\0")
        start, end = e[2], e[3]
        log(f"Partición {i}: '{name}' LBA {start}-{end} tipo {uuid.UUID(bytes_le=e[0])}", "head")
        if uuid.UUID(bytes_le=e[0]) != uuid.UUID(CUSTOMFS_TYPE_GUID):
            continue
        b = BPB.unpack_from(sec(start), 0)
        assert b[0] == BPB_MAGIC, "magic BPB"
        _, _, bps, spc, nfats, resv, pstart, tsec, fsec, root, ncl, free, _, _, _ = b
        assert pstart == start and bps == SECTOR_SIZE
        fat_raw = sec(start + resv, fsec)
        fat = struct.unpack(f"<{ncl + 2}I", fat_raw[:(ncl + 2) * 4])
        dstart = start + resv + fsec * nfats
        cb = spc * SECTOR_SIZE

        def chain(c):
            out = []
            while c != FAT_EOF:
                assert 2 <= c <= ncl + 1, f"clúster fuera de rango {c}"
                out.append(c)
                c = fat[c]
                assert len(out) <= ncl, "ciclo en cadena FAT"
            return out

        def read_chain(c, size=None):
            buf = b"".join(sec(dstart + (x - 2) * spc, spc) for x in chain(c))
            return buf if size is None else buf[:size]

        def walk(cluster, depth):
            raw = read_chain(cluster)
            for off in range(0, len(raw), DIRENT_SIZE):
                nm, at, _, fc, sz, mt, _ = DIRENT.unpack_from(raw, off)
                if nm[0] == 0:
                    break
                nm = nm.rstrip(b"\0").decode("utf-8")
                if nm in (".", ".."):
                    continue
                kind = "<DIR>" if at & ATTR_DIRECTORY else f"{sz} B"
                log(f"{'  ' * depth}  {nm}  {kind}  (cluster {fc}, attr {at:#x})",
                    "info" if at & ATTR_DIRECTORY else "")
                if at & ATTR_DIRECTORY:
                    walk(fc, depth + 1)
                elif sz:
                    assert len(chain(fc)) == math.ceil(sz / cb), f"cadena incorrecta: {nm}"

        walk(root, 1)
        log(f"  libres: {free} / {ncl}", "info")
    log("✓ Verificación OK", "ok")



# ============================================================================
# INTERFAZ GRÁFICA (tkinter)
# ============================================================================
class CustomFSGUI:
    def __init__(self, root: "tk.Tk"):
        self.root = root
        self.root.title("Generador de imagen de disco — GPT + CustomFS")
        self.root.geometry("920x620")
        self.root.resizable(True, True)
        self._queue = queue.Queue()
        self._busy = False
        self._build_ui()
        self._poll()

    def _build_ui(self):
        # ── Barra superior ────────────────────────────────────────────────────
        top = tk.Frame(self.root, pady=8, padx=12)
        top.pack(fill="x")
        tk.Label(top, text="Carpeta origen:").pack(side="left")
        self.src_var = tk.StringVar(value=CUSTOM_DIR_SRC if Path(CUSTOM_DIR_SRC).is_dir() else ("MiDisco" if Path("MiDisco").is_dir() else ""))
        tk.Entry(top, textvariable=self.src_var, width=50).pack(side="left", padx=5)
        tk.Button(top, text="Carpeta…", command=self._browse_src).pack(side="left")
        self.run_btn = tk.Button(top, text="Generar imagen ▶", command=self._run,
                                 bg="#2a7ae2", fg="white", relief="flat", padx=10)
        self.run_btn.pack(side="left", padx=8)

        # ── Imagen de salida ──────────────────────────────────────────────────
        out_frame = tk.Frame(self.root, padx=12)
        out_frame.pack(fill="x")
        tk.Label(out_frame, text="Imagen salida:").pack(side="left")
        self.out_var = tk.StringVar(value=CUSTOM_DIR_DEST)
        tk.Entry(out_frame, textvariable=self.out_var, width=65).pack(side="left", padx=5)
        tk.Button(out_frame, text="…", command=self._browse_out).pack(side="left")

        # ── Opciones ──────────────────────────────────────────────────────────
        opt = tk.Frame(self.root, padx=12, pady=2)
        opt.pack(fill="x")
        self.verify_var = tk.BooleanVar(value=True)
        tk.Checkbutton(opt, text="Verificar imagen al terminar",
                       variable=self.verify_var).pack(side="left")
        self.cfg_var = tk.BooleanVar(value=INCLUDE_CFG_IN_FS)
        tk.Checkbutton(opt, text="Incluir _part.cfg dentro de la partición",
                       variable=self.cfg_var).pack(side="left")
        tk.Label(opt, text="   GUID de tipo:").pack(side="left", padx=(15, 2))
        self.guid_var = tk.StringVar(value=CUSTOMFS_TYPE_GUID)
        tk.Entry(opt, textvariable=self.guid_var, width=38).pack(side="left")

        # ── Área de log ───────────────────────────────────────────────────────
        lf = tk.Frame(self.root, padx=12, pady=4)
        lf.pack(fill="both", expand=True)
        tk.Label(lf, text="Salida / Errores:", anchor="w").pack(fill="x")
        self.log = scrolledtext.ScrolledText(lf, font=("Consolas", 10), wrap="none",
                                             state="disabled", height=30)
        self.log.pack(fill="both", expand=True)
        self.log.tag_config("ok", foreground="#22c55e")
        self.log.tag_config("error", foreground="#ef4444")
        self.log.tag_config("info", foreground="#60a5fa")
        self.log.tag_config("head", foreground="#facc15", font=("Consolas", 10, "bold"))
        self.log.tag_config("lbl", foreground="#f97316")

    # ── Diálogos ──────────────────────────────────────────────────────────────
    def _browse_src(self):
        folder = filedialog.askdirectory(title="Seleccionar carpeta MiDisco")
        if folder:
            self.src_var.set(folder)

    def _browse_out(self):
        initial_file = Path(CUSTOM_DIR_DEST).name if CUSTOM_DIR_DEST else "MiDisco.bin"
        initial_dir = str(Path(CUSTOM_DIR_DEST).parent) if CUSTOM_DIR_DEST else None
        p = filedialog.asksaveasfilename(title="Guardar imagen como…", initialfile=initial_file,
                                         initialdir=initial_dir,
                                         defaultextension=".bin",
                                         filetypes=[("Imagen de disco", "*.bin"), ("Todos", "*.*")])
        if p:
            self.out_var.set(p)

    # ── Log ───────────────────────────────────────────────────────────────────
    def _log(self, text, tag=""):
        self.log.config(state="normal")
        self.log.insert("end", text + "\n", tag)
        self.log.see("end")
        self.log.config(state="disabled")

    def _clear(self):
        self.log.config(state="normal")
        self.log.delete("1.0", "end")
        self.log.config(state="disabled")

    def _poll(self):
        try:
            while True:
                item = self._queue.get_nowait()
                if item[0] == "log":
                    self._log(item[1], item[2])
                else:  # "done"
                    self._busy = False
                    self.run_btn.config(state="normal")
        except queue.Empty:
            pass
        self.root.after(50, self._poll)

    # ── Ejecución ─────────────────────────────────────────────────────────────
    def _run(self):
        global CUSTOMFS_TYPE_GUID, INCLUDE_CFG_IN_FS
        if self._busy:
            return
        self._clear()

        src = Path(self.src_var.get().strip())
        out_text = self.out_var.get().strip()
        if not src.is_dir():
            self._log(f"✗  No existe la carpeta origen: {src}", "error")
            return
        if not out_text:
            self._log("⚠  Indicá la ubicación de la imagen de salida.", "error")
            return
        try:
            guid = str(uuid.UUID(self.guid_var.get().strip()))
        except ValueError:
            self._log("✗  GUID de tipo inválido.", "error")
            return

        out = Path(out_text).expanduser()
        if out.is_dir():
            default_name = Path(CUSTOM_DIR_DEST).name if CUSTOM_DIR_DEST else "MiDisco.bin"
            out = out / default_name
        if out.exists() and not messagebox.askyesno("Sobrescribir", f"'{out}' ya existe.\n¿Sobrescribir?"):
            return

        CUSTOMFS_TYPE_GUID = guid
        INCLUDE_CFG_IN_FS = self.cfg_var.get()

        self._busy = True
        self.run_btn.config(state="disabled")
        threading.Thread(target=self._worker, args=(src, out, self.verify_var.get()),
                         daemon=True).start()

    def _worker(self, src, out, verify):
        set_log_sink(lambda m, t="": self._queue.put(("log", m, t)))
        try:
            log("══════════════════════════════════════════", "head")
            log(f"  Generando imagen GPT + CustomFS desde '{src.name}'", "head")
            log("══════════════════════════════════════════", "head")
            create_image(src, out)
            if verify:
                log("")
                verify_image(out)
            log(f"\n✓  Imagen generada: {out}", "ok")
        except (ValueError, RuntimeError, NotImplementedError, OSError, AssertionError) as e:
            log(f"\n✗  Error: {e}", "error")
        except Exception:
            log("\n✗  Error inesperado:\n" + traceback.format_exc(), "error")
        finally:
            set_log_sink(_console_sink)
            self._queue.put(("done",))

# ============================================================================
# CLI
# ============================================================================
def main():
    global CUSTOMFS_TYPE_GUID
    ap = argparse.ArgumentParser(description="Generador de imagen GPT + CustomFS")
    default_src = CUSTOM_DIR_SRC if CUSTOM_DIR_SRC else "MiDisco"
    default_dest = CUSTOM_DIR_DEST if CUSTOM_DIR_DEST else "MiDisco.bin"
    ap.add_argument("-i", "--input", default=default_src, help=f"carpeta origen (defecto: {default_src})")
    ap.add_argument("-o", "--output", default=default_dest, help=f"ruta del .bin de salida (defecto: {default_dest})")
    ap.add_argument("--type-guid", help="GUID de tipo de partición de CustomFS")
    ap.add_argument("--force", action="store_true", help="sobrescribir sin preguntar")
    ap.add_argument("--verify", action="store_true", help="releer la imagen y listar su contenido")
    ap.add_argument("--gui", action="store_true", help="abrir la interfaz gráfica")
    args = ap.parse_args()

    # Sin argumentos (o con --gui) -> interfaz gráfica, si tkinter está disponible
    if args.gui or (len(sys.argv) == 1 and HAS_TK):
        if not HAS_TK:
            sys.exit("Error: tkinter no está disponible.")
        root = tk.Tk()
        CustomFSGUI(root)
        root.mainloop()
        return

    if args.type_guid:
        CUSTOMFS_TYPE_GUID = str(uuid.UUID(args.type_guid))

    src = Path(args.input)
    if not src.is_dir():
        sys.exit(f"Error: no existe la carpeta '{src}'")

    out_text = args.output
    if not out_text:
        out_text = input(f"Ubicación del archivo .bin de salida [{default_dest}]: ").strip() or default_dest
    out = Path(out_text).expanduser()
    if out.is_dir():
        default_name = Path(CUSTOM_DIR_DEST).name if CUSTOM_DIR_DEST else "MiDisco.bin"
        out = out / default_name
    if out.exists() and not args.force:
        if input(f"'{out}' ya existe. ¿Sobrescribir? [s/N]: ").strip().lower() not in ("s", "y"):
            sys.exit("Cancelado.")

    try:
        create_image(src, out)
        if args.verify:
            verify_image(out)
    except (ValueError, RuntimeError, NotImplementedError, OSError) as e:
        sys.exit(f"Error: {e}")
    log("Listo.")


if __name__ == "__main__":
    main()
