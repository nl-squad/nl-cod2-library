"""Turns CC0 ambientCG materials into CoD2 images and materials for mp_skyscraper.

Usage: python mp_skyscraper_textures.py <ambientcg dir> <stock materials dir>
The ambientcg dir holds the extracted 1K-JPG maps (<id>_1K-JPG_Color.jpg, _AmbientOcclusion.jpg, _NormalGL.jpg),
from https://ambientcg.com/get?file=<id>_1K-JPG.zip. The stock materials dir holds materials/ from iw_13.iwd.
Needs Pillow and numpy. Writes into mp_skyscraper_assets/, which goes into the map's iwd.
"""
import os
import sys

import numpy as np
from PIL import Image

from cod2_assets import write_iwi, write_material

# name: (ambientCG id, size, stock material whose techset and surface type we clone)
TEXTURES = {
    "nl_sky_facade": ("Concrete036", 1024, "dawnville2_concrete01"),
    "nl_sky_asphalt": ("Asphalt031", 1024, "mtl_caen_road_asphalt_01"),
    "nl_sky_marble": ("Tiles074", 1024, "mtl_caen_floor_hexagontiles_01"),
    "nl_sky_paving": ("PavingStones128", 512, "dawnville2_concrete01"),
    "nl_sky_plaster": ("PaintedPlaster017", 512, "dawnville2_plaster_wall01"),
    "nl_sky_roof": ("Concrete032", 512, "dawnville2_concrete01"),
    "nl_sky_patch": ("Asphalt025C", 512, "mtl_caen_road_asphalt_01"),
}
PAINT = ("nl_sky_roadpaint", "Asphalt031", 256, "mtl_caen_road_asphalt_01")
# The game is given a flat normal map, so relief and occlusion are baked into the colour.
LIGHT = np.array([-0.4, 0.4, 0.82]) / np.linalg.norm([-0.4, 0.4, 0.82])
RELIEF = 0.35
GAIN = {"nl_sky_patch": 1.45}


def bake(source, asset_id, size, gain=1):
    def load(kind):
        path = os.path.join(source, "%s_1K-JPG_%s.jpg" % (asset_id, kind))
        return np.asarray(Image.open(path).convert("RGB").resize((size, size), Image.LANCZOS), dtype=np.float64) / 255

    color = load("Color")
    normal = load("NormalGL") * 2 - 1
    shade = 1 + RELIEF * ((normal * LIGHT).sum(axis=2) - LIGHT[2])
    color *= np.clip(shade, 0.5, 1.3)[:, :, None]
    if os.path.exists(os.path.join(source, "%s_1K-JPG_AmbientOcclusion.jpg" % asset_id)):
        color *= load("AmbientOcclusion")[:, :, :1] ** 0.7
    return Image.fromarray(np.clip(color * gain * 255, 0, 255).astype(np.uint8))


def road_paint(source, asset_id, size):
    """Worn white road paint: the asphalt's bright grains show through where the paint wore off."""
    asphalt = np.asarray(bake(source, asset_id, size), dtype=np.float64) / 255
    lum = asphalt.mean(axis=2)
    worn = np.clip((lum - lum.mean()) * 4 + 0.95, 0, 1)[:, :, None]
    paint = np.array([0.9, 0.89, 0.84]) * (0.85 + 0.15 * lum[:, :, None])
    return Image.fromarray(np.clip((paint * worn + asphalt * (1 - worn)) * 255, 0, 255).astype(np.uint8))


if __name__ == "__main__":
    source, stock = sys.argv[1], sys.argv[2]
    assets = os.path.join(os.path.dirname(os.path.abspath(__file__)), "mp_skyscraper_assets")
    os.makedirs(os.path.join(assets, "images"), exist_ok=True)
    os.makedirs(os.path.join(assets, "materials"), exist_ok=True)
    for name, (asset_id, size, template) in TEXTURES.items():
        img = bake(source, asset_id, size, GAIN.get(name, 1))
        write_iwi(img, os.path.join(assets, "images", name + ".iwi"))
        write_material(os.path.join(stock, "materials", template), os.path.join(assets, "materials", name), name, size, size)
        print(name, asset_id, size)
    name, asset_id, size, template = PAINT
    write_iwi(road_paint(source, asset_id, size), os.path.join(assets, "images", name + ".iwi"))
    write_material(os.path.join(stock, "materials", template), os.path.join(assets, "materials", name), name, size, size)
    print(name, asset_id, size)
