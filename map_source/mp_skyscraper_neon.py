"""Draws the rooftop neon billboard of mp_skyscraper and writes it as a CoD2 image and material.

Needs Pillow and numpy. Writes mp_skyscraper_neon.png to look at, and images/ and materials/ under
mp_skyscraper_assets/, which go into the map's iwd.
"""
import os
import sys

import numpy as np
from PIL import Image, ImageChops, ImageDraw, ImageFilter, ImageFont

from cod2_assets import write_iwi, write_material

NAME = "nl_skyscraper_neon"
W, H = 1024, 512
FONT = "/System/Library/Fonts/Supplemental/Futura.ttc"
# The billboard spans x -384..384 with the texture 768 units wide, so its edges fall mid-tile.
ROLL = W // 2
HORIZON = 343

PINK = (255, 41, 117)
CYAN = (0, 240, 255)
YELLOW = (255, 211, 25)
VIOLET = (140, 30, 255)


def gradient(stops, height):
    ys = np.linspace(0, 1, height)
    out = np.zeros((height, 3))
    for i in range(3):
        out[:, i] = np.interp(ys, [s[0] for s in stops], [s[1][i] for s in stops])
    return out


def glow(base, mask, color, radii=(2, 6, 14, 30), core=True):
    """Adds a neon tube: blurred colored halos around `mask` and a hot white core."""
    for r, strength in zip(radii, (1.0, 0.9, 0.7, 0.5)):
        halo = mask.filter(ImageFilter.GaussianBlur(r)).point(lambda v: min(255, int(v * strength * 1.6)))
        layer = Image.new("RGB", base.size, color)
        base = ImageChops.add(base, ImageChops.multiply(layer, Image.merge("RGB", (halo, halo, halo))))
    tinted = Image.new("RGB", base.size, tuple(min(255, c + 150) for c in color))
    base = Image.composite(tinted, base, mask)
    if core:
        thin = mask.filter(ImageFilter.MinFilter(3))
        base = Image.composite(Image.new("RGB", base.size, (255, 255, 255)), base, thin)
    return base


def draw_sky():
    sky = gradient([(0, (8, 3, 28)), (0.35, (40, 8, 82)), (0.62, (150, 20, 120)), (0.66, (255, 80, 140)),
                    (0.67, (20, 4, 40)), (1, (6, 2, 16))], H)
    img = np.repeat(sky[:, None, :], W, axis=1)
    rng = np.random.default_rng(3)
    for _ in range(140):
        x, y = rng.integers(0, W), rng.integers(0, int(H * 0.5))
        img[y, x] = np.minimum(255, img[y, x] + rng.integers(80, 200))
    return Image.fromarray(img.astype(np.uint8))


def draw_sun(img):
    cx, cy, r = W // 2, 262, 128
    sun = Image.new("RGB", (W, H))
    colors = gradient([(0, YELLOW), (0.55, (255, 120, 60)), (1, PINK)], 2 * r)
    d = ImageDraw.Draw(sun)
    for i in range(2 * r):
        d.line([(cx - r, cy - r + i), (cx + r, cy - r + i)], fill=tuple(int(c) for c in colors[i]))
    mask = Image.new("L", (W, H))
    md = ImageDraw.Draw(mask)
    md.ellipse([cx - r, cy - r, cx + r, cy + r], fill=255)
    y, gap = cy - 10, 3
    while y < cy + r:
        md.rectangle([cx - r, y, cx + r, y + gap], fill=0)
        y += 14 + gap
        gap += 2
    ImageDraw.Draw(mask).rectangle([0, HORIZON, W, H], fill=0)
    halo = mask.filter(ImageFilter.GaussianBlur(40))
    img = ImageChops.add(img, ImageChops.multiply(Image.new("RGB", (W, H), PINK), Image.merge("RGB", (halo,) * 3)))
    img = Image.composite(sun, img, mask)
    reflection = mask.transpose(Image.FLIP_TOP_BOTTOM).crop((0, H - 2 * HORIZON, W, 2 * H - 2 * HORIZON))
    reflection = reflection.filter(ImageFilter.GaussianBlur(3)).point(lambda v: v // 4)
    return Image.composite(sun.transpose(Image.FLIP_TOP_BOTTOM).crop((0, H - 2 * HORIZON, W, 2 * H - 2 * HORIZON)), img, reflection)


def draw_grid(img):
    horizon = HORIZON
    lines = Image.new("L", (W, H))
    d = ImageDraw.Draw(lines)
    for i in range(-24, 25):
        d.line([(W // 2 + i * 14, horizon), (W // 2 + i * 120, H)], fill=255, width=2)
    step = 4.0
    y = horizon + step
    while y < H:
        d.line([(0, int(y)), (W, int(y))], fill=255, width=2)
        step *= 1.38
        y += step
    floor = Image.new("L", (W, H))
    ImageDraw.Draw(floor).rectangle([0, horizon, W, H], fill=255)
    lines = ImageChops.multiply(lines, floor)
    return glow(img, lines, CYAN, radii=(2, 5, 10, 18), core=False)


def draw_skyline(img):
    rng = np.random.default_rng(11)
    sil = Image.new("L", (W, H))
    win = Image.new("L", (W, H))
    d, wd = ImageDraw.Draw(sil), ImageDraw.Draw(win)
    base = HORIZON + 2
    x = 0
    while x < W:
        w = int(rng.integers(30, 70))
        h = int(rng.integers(30, 110))
        if abs(x + w / 2 - W / 2) < 170:
            h = int(h * 0.35)
        d.rectangle([x, base - h, x + w, base], fill=255)
        for wy in range(base - h + 6, base - 4, 9):
            for wx in range(x + 4, x + w - 4, 8):
                if rng.random() < 0.35:
                    wd.rectangle([wx, wy, wx + 2, wy + 3], fill=255)
        x += w + int(rng.integers(0, 6))
    tx0, tx1, top = W // 2 - 40, W // 2 + 40, 215
    d.rectangle([tx0, top, tx1, base], fill=255)
    d.rectangle([tx0 + 14, top - 26, tx1 - 14, top], fill=255)
    d.rectangle([W // 2 - 3, top - 44, W // 2 + 3, top - 26], fill=255)
    for wy in range(top + 10, base - 6, 13):
        for wx in range(tx0 + 8, tx1 - 8, 12):
            if rng.random() < 0.6:
                wd.rectangle([wx, wy, wx + 5, wy + 6], fill=255)
    img = Image.composite(Image.new("RGB", (W, H), (14, 4, 28)), img, sil)
    edge = ImageChops.subtract(sil.filter(ImageFilter.MaxFilter(3)), sil)
    img = glow(img, edge, VIOLET, radii=(2, 6), core=False)
    img = Image.composite(Image.new("RGB", (W, H), (255, 190, 90)), img, win)
    beacon = Image.new("L", (W, H))
    ImageDraw.Draw(beacon).ellipse([W // 2 - 5, top - 52, W // 2 + 5, top - 42], fill=255)
    return glow(img, beacon, (255, 40, 40), radii=(3, 10, 24))


def draw_title(img):
    font = ImageFont.truetype(FONT, 118, index=4)
    text = "SKYSCRAPER"
    mask = Image.new("L", (W, H))
    d = ImageDraw.Draw(mask)
    bbox = d.textbbox((0, 0), text, font=font)
    x = (W - (bbox[2] - bbox[0])) // 2 - bbox[0]
    y = 28 - bbox[1]
    d.text((x, y), text, font=font, fill=255)
    outline = ImageChops.subtract(mask.filter(ImageFilter.MaxFilter(7)), mask.filter(ImageFilter.MinFilter(3)))
    shadow = ImageChops.offset(outline, 5, 4)
    img = glow(img, shadow, PINK, radii=(2, 8, 20, 40))
    img = glow(img, outline, CYAN, radii=(2, 6, 14, 30))

    small = ImageFont.truetype(FONT, 30, index=4)
    sub = "nL  ZOMBIES  -  LAST  STAND  ON  THE  ROOF"
    smask = Image.new("L", (W, H))
    sd = ImageDraw.Draw(smask)
    sb = sd.textbbox((0, 0), sub, font=small)
    sd.text(((W - (sb[2] - sb[0])) // 2 - sb[0], 160 - sb[1]), sub, font=small, fill=255)
    return glow(img, smask, PINK, radii=(2, 5, 12))


def draw_frame(img):
    tube = Image.new("L", (W, H))
    d = ImageDraw.Draw(tube)
    d.rounded_rectangle([14, 14, W - 15, H - 15], radius=18, outline=255, width=4)
    img = glow(img, tube, PINK, radii=(2, 6, 14))
    bulbs = Image.new("L", (W, H))
    bd = ImageDraw.Draw(bulbs)
    for x in range(34, W - 30, 28):
        for y in (5, H - 6):
            bd.ellipse([x - 3, y - 3, x + 3, y + 3], fill=255)
    for y in range(34, H - 30, 28):
        for x in (5, W - 6):
            bd.ellipse([x - 3, y - 3, x + 3, y + 3], fill=255)
    return glow(img, bulbs, YELLOW, radii=(2, 5, 10))


def draw():
    img = draw_sky()
    img = draw_sun(img)
    img = draw_grid(img)
    img = draw_skyline(img)
    img = draw_title(img)
    return draw_frame(img)


if __name__ == "__main__":
    here = os.path.dirname(os.path.abspath(__file__))
    template = sys.argv[1]
    img = draw()
    img.save(os.path.join(here, "mp_skyscraper_neon.png"))
    assets = os.path.join(here, "mp_skyscraper_assets")
    os.makedirs(os.path.join(assets, "images"), exist_ok=True)
    os.makedirs(os.path.join(assets, "materials"), exist_ok=True)
    rolled = Image.fromarray(np.roll(np.array(img), ROLL, axis=1))
    write_iwi(rolled, os.path.join(assets, "images", NAME + ".iwi"), alpha=True)
    write_material(template, os.path.join(assets, "materials", NAME), NAME, W, H)
