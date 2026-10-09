"""Writes CoD2 images (IWI version 5, DXT1 or DXT5) and materials cloned from a stock material."""
import struct

import numpy as np
from PIL import Image

DXT1, DXT5 = 0x0B, 0x0D


def color_blocks(blocks):
    """Range-fit DXT colour blocks: endpoints at the block's brightest and darkest pixel."""
    rgb = blocks[:, :, :3]
    lum = rgb @ np.array([0.299, 0.587, 0.114])
    rows = np.arange(len(rgb))
    hi, lo = rgb[rows, lum.argmax(axis=1)], rgb[rows, lum.argmin(axis=1)]

    def pack(c):
        c = np.clip(np.rint(c), 0, 255).astype(np.uint32)
        return ((c[:, 0] >> 3) << 11) | ((c[:, 1] >> 2) << 5) | (c[:, 2] >> 3)

    def unpack(v):
        return np.stack([((v >> 11) & 31) * 255 / 31, ((v >> 5) & 63) * 255 / 63, (v & 31) * 255 / 31], axis=1)

    c0, c1 = pack(hi), pack(lo)
    swap = c0 < c1
    c0, c1 = np.where(swap, c1, c0), np.where(swap, c0, c1)
    e0, e1 = unpack(c0), unpack(c1)
    palette = np.stack([e0, e1, (2 * e0 + e1) / 3, (e0 + 2 * e1) / 3], axis=1)
    idx = ((rgb[:, :, None, :] - palette[:, None, :, :]) ** 2).sum(axis=3).argmin(axis=2).astype(np.uint32)
    idx = np.where((c0 == c1)[:, None], 0, idx)
    bits = np.zeros(len(rgb), dtype=np.uint32)
    for i in range(16):
        bits |= idx[:, i] << np.uint32(2 * i)
    out = np.zeros((len(rgb), 8), dtype=np.uint8)
    out[:, 0], out[:, 1], out[:, 2], out[:, 3] = c0 & 0xFF, c0 >> 8, c1 & 0xFF, c1 >> 8
    for i in range(4):
        out[:, 4 + i] = (bits >> np.uint32(8 * i)) & 0xFF
    return out


def alpha_blocks(blocks):
    alpha = blocks[:, :, 3]
    a0, a1 = alpha.max(axis=1), alpha.min(axis=1)
    t = np.clip(np.rint((a0[:, None] - alpha) / np.maximum(a0 - a1, 1)[:, None] * 7), 0, 7).astype(np.uint64)
    codes = np.where(t == 0, 0, np.where(t == 7, 1, t + 1))
    codes = np.where((a0 == a1)[:, None], 0, codes)
    bits = np.zeros(len(alpha), dtype=np.uint64)
    for i in range(16):
        bits |= codes[:, i] << np.uint64(3 * i)
    out = np.zeros((len(alpha), 8), dtype=np.uint8)
    out[:, 0], out[:, 1] = a0, a1
    for i in range(6):
        out[:, 2 + i] = ((bits >> np.uint64(8 * i)) & np.uint64(0xFF)).astype(np.uint8)
    return out


def encode(rgba, alpha):
    h, w = rgba.shape[:2]
    blocks = rgba.reshape(h // 4, 4, w // 4, 4, 4).transpose(0, 2, 1, 3, 4).reshape(-1, 16, 4).astype(np.float64)
    color = color_blocks(blocks)
    return (np.concatenate([alpha_blocks(blocks), color], axis=1) if alpha else color).tobytes()


def write_iwi(img, path, alpha=False):
    """IWI version 5: 28-byte header, then every mip down to 1x1, smallest first."""
    mips = []
    level = img.convert("RGBA")
    while True:
        a = np.array(level)
        if a.shape[0] < 4 or a.shape[1] < 4:
            padded = np.zeros((max(4, a.shape[0]), max(4, a.shape[1]), 4), dtype=np.uint8)
            padded[:a.shape[0], :a.shape[1]] = a
            a = padded
        mips.append(encode(a, alpha))
        if level.size == (1, 1):
            break
        level = level.resize((max(1, level.size[0] // 2), max(1, level.size[1] // 2)), Image.LANCZOS)
    data = b"".join(reversed(mips))
    ends = []
    end = 28 + len(data)
    for m in mips[:4]:
        ends.append(end)
        end -= len(m)
    header = b"IWi" + bytes([5, DXT5 if alpha else DXT1, 0]) + struct.pack("<HHH", img.size[0], img.size[1], 1)
    with open(path, "wb") as f:
        f.write(header + struct.pack("<4I", *ends) + data)


def write_material(template, path, name, width, height):
    """Clones a stock material: same techset, surface type and samplers, our name and colour map."""
    src = open(template, "rb").read()

    def string(offset):
        return src[offset:src.index(b"\0", offset)]

    techset_at = struct.unpack_from("<I", src, 0x38)[0]
    count, table = struct.unpack_from("<II", src, 0x34)[0], struct.unpack_from("<I", src, 0x3C)[0]
    head = bytearray(src[:techset_at])
    strings = bytearray()

    def put(value):
        offset = techset_at + len(strings)
        strings.extend(value + b"\0")
        return offset

    put(string(techset_at))
    struct.pack_into("<I", head, 0x00, put(name.encode()))
    image_at = put(name.encode())
    struct.pack_into("<I", head, 0x04, image_at)
    struct.pack_into("<HH", head, 0x1C, width, height)
    for i in range(count):
        entry = table + 12 * i
        sampler, _, image = struct.unpack_from("<III", src, entry)
        sampler_name = string(sampler)
        struct.pack_into("<I", head, entry, put(sampler_name))
        struct.pack_into("<I", head, entry + 8, image_at if sampler_name == b"colorMap" else put(string(image)))
    with open(path, "wb") as f:
        f.write(bytes(head) + bytes(strings))
