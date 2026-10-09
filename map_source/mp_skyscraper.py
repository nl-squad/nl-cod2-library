import math
import os
import random

LEVEL_H = 256
SLAB = 32
LEVELS = 5
ROOF = LEVELS * LEVEL_H
HALF = 384
WALL = 32
IN = HALF - WALL
STAIR_W = 128
STAIR_STEPS = 16
STAIR_RUN = 32
HOLE_START = 16
WORLD = 1792
SKY_TOP = 2048
BUILDINGS = 1408
SIDEWALK = HALF + 128
CITY_SIDEWALK = BUILDINGS - 160
ROAD_HALF = 192
ROAD_WALK = 304
ROAD_BLOCK = 704
ROAD_END = 3072
BARRICADE = 1560
WINDOWS = (-256, -96, 96, 256)
PILASTERS = (-176, 0, 176)

FACADE = "nl_sky_facade"
COLUMN = "duhoc_concrete_side"
PLINTH = "duhoc_stone_wall"
TRIM = "stalingradwinter_trim01"
CORNICE = TRIM
FRAME = "duhoc_metal_bunkertrim"
BROKEN = "egypt_concrete_broken_generic1"
REBAR = "egypt_metal_broken_generic1"
RUBBLE = ("egypt_concrete_broken_generic1", "egypt_sandstone_broken_generic1")
PLASTER = "nl_sky_plaster"
INTERIORS = (PLASTER,) * LEVELS
WAINSCOT = "egypt_wood_generic1"
WAINSCOT_CAP = "duhoc_wood_post1"
CEILING = "egypt_plaster_ceiling1"
BEAM = "duhoc_steel_beam"
FLOORS = ("nl_sky_marble", "mtl_caen_floor_int_01", "dawnville2_wood_floor01", "egypt_concrete_floor3", "mtl_caen_floor_int_01")
ROOF_TOP = "nl_sky_roof"
METAL = "stalingradwinter_metal_floor01"
RAIL = "stalingradwinter_metal_roof"
STEP = "egypt_concrete_bunkerstair_run"
STEP_RISE = "egypt_concrete_bunkerstair_rise"
ROAD = "nl_sky_asphalt"
PAVEMENT = "nl_sky_paving"
ROAD_PAINT = "nl_sky_roadpaint"
PATCH = "nl_sky_patch"
GUTTER = "dawnville2_concrete_floor01"
CURB = "stalingradwinter_concretetrim01"
CITY_FACADES = ("stalingradwinter_brick01", "stalingradwinter_brick02", "egypt_plaster_exteriorwall01",
                "egypt_plaster_exteriorwall02", "egypt_brick_red_generic1_1", "egypt_brick_yellow_generic1")
CITY_WINDOWS = ("stalingradwinter_window03", "toujane_window1", "v_window05")
CITY_DOOR = "v_door01"
CITY_WINDOW_W = 64
CITY_WINDOW_H = 96
SKY = "sky_downtown_sniper"
CLIP = "clip_player"
VOID = "mtl_caen_black"
NEON = "nl_skyscraper_neon"

SIZES = {
    ROAD: (192, 192), FACADE: (192, 192), PLASTER: (128, 128), "nl_sky_marble": (256, 256),
    ROOF_TOP: (128, 128), PAVEMENT: (192, 192), ROAD_PAINT: (64, 64), PATCH: (128, 128), GUTTER: (128, 128), PLINTH: (128, 128), METAL: (64, 64),
    "stalingradwinter_brick01": (128, 128), "stalingradwinter_brick02": (128, 128), "egypt_brick_red_generic1_1": (128, 128),
    "stalingradwinter_window03": (64, 96), "toujane_window1": (64, 96), "v_window05": (64, 96), "v_door01": (64, 128),
    NEON: (768, 384), TRIM: (64, 32), CURB: (128, 16), STEP: (128, 32), STEP_RISE: (128, 16), FRAME: (128, 16), BEAM: (512, 16),
    WAINSCOT: (128, 256), WAINSCOT_CAP: (64, 128), REBAR: (64, 64), COLUMN: (512, 512),
    "egypt_brick_yellow_generic1": (256, 128),
}

# Wall breaches: (level, side) -> (along from, along to, bottom, top above the level's floor, rubble inside)
BREACHES = {
    (1, "E"): (-330, -150, 30, 200, False),
    (2, "S"): (-150, 150, 20, 210, True),
    (3, "S"): (-340, -170, 40, 200, True),
    (4, "N"): (200, 352, 40, 224, True),
    (4, "E"): (200, 352, 60, 224, True),
}
BROKEN_PARAPET = {"N": (180, HALF), "E": (180, IN)}

rng = random.Random(7)
world = []
entities = []


def sub(a, b):
    return [a[i] - b[i] for i in range(3)]


def cross(a, b):
    return [a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0]]


def dot(a, b):
    return sum(a[i] * b[i] for i in range(3))


def fmt(p):
    return " ".join("%g" % round(v, 3) for v in p)


def face(a, b, c, normal, material):
    if dot(cross(sub(c, a), sub(b, a)), normal) < 0:
        b, c = c, b
    w, h = SIZES.get(material, (256, 256))
    return " ( %s ) ( %s ) ( %s ) %s %d %d 0 0 0 0 lightmap_gray 16384 16384 0 0 0 0" % (fmt(a), fmt(b), fmt(c), material, w, h)


def box(lo, hi, material, **sides):
    assert all(lo[i] < hi[i] for i in range(3)), (lo, hi)
    lines = []
    for axis, name in enumerate("xyz"):
        u, v = [a for a in range(3) if a != axis]
        for sign, suffix in ((-1, "n"), (1, "p")):
            d = hi[axis] if sign > 0 else lo[axis]
            pts = []
            for du, dv in ((0, 0), (64, 0), (0, 64)):
                p = [0, 0, 0]
                p[axis], p[u], p[v] = d, lo[u] + du, lo[v] + dv
                pts.append(p)
            normal = [0, 0, 0]
            normal[axis] = sign
            lines.append(face(pts[0], pts[1], pts[2], normal, sides.get(name + suffix, material)))
    return "{\n" + "\n".join(lines) + "\n}"


def add(lo, hi, material, **sides):
    world.append(box(lo, hi, material, **sides))


def entity(classname, **keys):
    entities.append((classname, keys))


def model(name, x, y, z, yaw=0):
    entity("misc_model", model="xmodel/" + name, origin="%d %d %d" % (x, y, z), angles="0 %d 0" % yaw)


def chunk(x, y, z, size, material=None):
    """An irregular block of rubble: a box with its top corners cut off at random."""
    material = material or rng.choice(RUBBLE)
    w, d, h = rng.uniform(0.6, 1) * size, rng.uniform(0.6, 1) * size, rng.uniform(0.3, 0.7) * size
    planes = [([w / 2, 0, 0], [1, 0, 0]), ([-w / 2, 0, 0], [-1, 0, 0]), ([0, d / 2, 0], [0, 1, 0]),
              ([0, -d / 2, 0], [0, -1, 0]), ([0, 0, h], [0, 0, 1]), ([0, 0, 0], [0, 0, -1])]
    for sx in (-1, 1):
        for sy in (-1, 1):
            if rng.random() < 0.25:
                continue
            corner = [sx * w / 2, sy * d / 2, h]
            p1 = [corner[0] - sx * rng.uniform(0.3, 0.7) * w, corner[1], h]
            p2 = [corner[0], corner[1] - sy * rng.uniform(0.3, 0.7) * d, h]
            p3 = [corner[0], corner[1], h - rng.uniform(0.3, 0.8) * h]
            n = cross(sub(p3, p1), sub(p2, p1))
            if dot(n, [sx, sy, 1]) < 0:
                n = [-v for v in n]
            planes.append((p1, n, (p1, p2, p3)))
    yaw = math.radians(rng.uniform(0, 90))
    cs, sn = math.cos(yaw), math.sin(yaw)

    def place(p):
        return [x + p[0] * cs - p[1] * sn, y + p[0] * sn + p[1] * cs, z + p[2]]

    lines = []
    for plane in planes:
        p, n = plane[0], plane[1]
        if len(plane) == 3:
            pts = plane[2]
        else:
            t1 = [n[1], n[2], n[0]] if n[2] == 0 else [1, 0, 0]
            t2 = cross(n, t1)
            pts = (p, [p[i] + t1[i] * 32 for i in range(3)], [p[i] + t2[i] * 32 for i in range(3)])
        rn = [n[0] * cs - n[1] * sn, n[0] * sn + n[1] * cs, n[2]]
        lines.append(face(place(pts[0]), place(pts[1]), place(pts[2]), rn, material))
    world.append("{\n" + "\n".join(lines) + "\n}")


def rubble_pile(x0, x1, y0, y1, z, count, size):
    for _ in range(count):
        chunk(rng.uniform(x0, x1), rng.uniform(y0, y1), z, rng.uniform(0.5, 1) * size)


# Tower sides in a local frame: `a` runs along the wall, `d` goes outward from the inner face.
SIDES = {"S": (0, 1, -1), "N": (0, 1, 1), "W": (1, 0, -1), "E": (1, 0, 1)}


def side_add(side, a0, a1, d0, d1, z0, z1, material, outer=None, inner=None):
    along, normal, sign = SIDES[side]
    lo, hi = [0, 0, z0], [0, 0, z1]
    lo[along], hi[along] = a0, a1
    lo[normal], hi[normal] = sorted((sign * (IN + d0), sign * (IN + d1)))
    axis = "xy"[normal]
    sides = {}
    if outer:
        sides[axis + ("p" if sign > 0 else "n")] = outer
    if inner:
        sides[axis + ("n" if sign > 0 else "p")] = inner
    add(lo, hi, material, **sides)


def side_point(side, a, d):
    along, normal, sign = SIDES[side]
    p = [0, 0]
    p[along], p[normal] = a, sign * (IN + d)
    return p


def span(side):
    return HALF if side in "SN" else IN


def openings(side, level):
    z = level * LEVEL_H
    breach = BREACHES.get((level, side))
    result = []
    for c in WINDOWS:
        if level == 0 and side in "SN" and abs(c) < 128:
            continue
        if breach and c + 56 > breach[0] and c - 56 < breach[1]:
            continue
        result.append((c - 48, c + 48, z + 48, z + 176, "window"))
    if level == 0 and side in "SN":
        result.append((-96, 96, z, z + 160, "door"))
    if breach:
        result.append((breach[0], breach[1], z + breach[2], z + breach[3], "breach"))
    return sorted(result)


def build_wall(side, level):
    z = level * LEVEL_H
    z0 = z - SLAB if level else 0
    z1 = z + LEVEL_H - SLAB
    inner = INTERIORS[level]
    a = -span(side)
    holes = openings(side, level)
    for a0, a1, za, zb, kind in holes:
        if a0 > a:
            side_add(side, a, a0, 0, WALL, z0, z1, FACADE, inner=inner)
        if za > z0:
            side_add(side, a0, a1, 0, WALL, z0, za, FACADE, inner=inner)
        if zb < z1:
            side_add(side, a0, a1, 0, WALL, zb, z1, FACADE, inner=inner)
        if kind == "window":
            build_window(side, a0, a1, za, zb)
        elif kind == "breach":
            build_breach(side, level, a0, a1, za, zb, z1)
        a = a1
    if a < span(side):
        side_add(side, a, span(side), 0, WALL, z0, z1, FACADE, inner=inner)

    build_pilasters(side, level, holes)
    build_wainscot(side, level, holes)


def build_window(side, a0, a1, za, zb):
    side_add(side, a0, a1, 12, 20, za, zb, CLIP)
    side_add(side, a0 - 8, a1 + 8, WALL, WALL + 8, za - 8, za, TRIM)
    side_add(side, a0 - 8, a1 + 8, WALL, WALL + 4, zb, zb + 12, TRIM)
    side_add(side, a0, a1, -6, 0, za - 4, za, WAINSCOT_CAP)
    side_add(side, a0, a0 + 4, 14, 18, za, zb, FRAME)
    side_add(side, a1 - 4, a1, 14, 18, za, zb, FRAME)
    side_add(side, a0 + 4, a1 - 4, 14, 18, za, za + 4, FRAME)
    side_add(side, a0 + 4, a1 - 4, 14, 18, zb - 4, zb, FRAME)
    if rng.random() < 0.7:
        c = (a0 + a1) // 2
        side_add(side, c - 2, c + 2, 14, 18, za + 4, zb - 4, FRAME)
        side_add(side, a0 + 4, c - 2, 14, 18, zb - 52, zb - 48, FRAME)
        side_add(side, c + 2, a1 - 4, 14, 18, zb - 52, zb - 48, FRAME)


def build_breach(side, level, a0, a1, za, zb, z1):
    side_add(side, a0, a1, 12, 20, za, zb, CLIP)
    a = a0
    while a < a1:
        w = min(rng.randint(12, 40), a1 - a)
        if zb < z1:
            drop = rng.randint(4, 44)
            side_add(side, a, a + w, rng.choice((0, 4, 10)), WALL - rng.choice((0, 6)), zb - drop, zb, BROKEN)
            if rng.random() < 0.3:
                bar = a + w // 2
                side_add(side, bar, bar + 2, 14, 16, zb - drop - rng.randint(16, 40), zb - drop, REBAR)
        rise = rng.randint(0, 28)
        if rise:
            side_add(side, a, a + w, rng.choice((0, 6)), WALL - rng.choice((0, 8)), za, za + rise, BROKEN)
        a += w
    z = za
    while z < zb:
        h = min(rng.randint(16, 48), zb - z)
        side_add(side, a0, a0 + rng.randint(4, 30), 0, WALL - rng.choice((0, 6)), z, z + h, BROKEN)
        side_add(side, a1 - rng.randint(4, 30), a1, rng.choice((0, 6)), WALL, z, z + h, BROKEN)
        z += h

    for _ in range(7):
        x, y = side_point(side, rng.uniform(a0 + 10, a1 - 10), rng.uniform(70, 260))
        chunk(x, y, 8, rng.uniform(18, 44))
    x, y = side_point(side, (a0 + a1) / 2, 120)
    model(rng.choice(("prop_redbrickpile_debris_01", "prop_redbrickpile_debris_02", "prop_rubble_rock_01")), x, y, 8, rng.randint(0, 359))
    if BREACHES[(level, side)][4]:
        for _ in range(6):
            x, y = side_point(side, rng.uniform(a0 + 16, a1 - 16), -rng.uniform(28, 70))
            chunk(x, y, level * LEVEL_H, rng.uniform(14, 34))
        occupied[level].append(rect_of(side, a0, a1, -90, 0))


def build_pilasters(side, level, holes):
    z = level * LEVEL_H
    z0 = 56 if level == 0 else z
    z1 = z + LEVEL_H - SLAB
    for c in PILASTERS:
        overlapping = [h for h in holes if h[0] < c + 16 and h[1] > c - 16]
        if any(h[4] == "breach" for h in overlapping):
            side_add(side, c - 16, c + 16, WALL, WALL + 12, z0, z0 + rng.randint(16, 56), BROKEN)
            side_add(side, c - 16, c + 16, WALL, WALL + 12, z1 - rng.randint(12, 40), z1, BROKEN)
        elif not overlapping:
            side_add(side, c - 16, c + 16, WALL, WALL + 12, z0, z1, COLUMN)


def build_wainscot(side, level, holes):
    z = level * LEVEL_H
    gaps = sorted((h[0], h[1]) for h in holes if h[2] < z + 52)
    a = -IN
    for g0, g1 in gaps + [(IN, IN)]:
        if g0 > a:
            side_add(side, a, g0, -4, 0, z, z + 48, WAINSCOT)
            side_add(side, a, g0, -6, 0, z + 48, z + 52, WAINSCOT_CAP)
        a = max(a, g1)


def build_facade_trim():
    for side in SIDES:
        s = span(side)
        ext = s + (16 if side in "SN" else 0)
        door = side in "SN"
        for a0, a1 in (((-s, -96), (96, s)) if door else ((-s, s),)):
            side_add(side, a0, a1, WALL, WALL + 14, 0, 48, PLINTH)
            side_add(side, a0, a1, WALL, WALL + 18, 48, 56, TRIM)
        for level in range(1, LEVELS + 1):
            z = level * LEVEL_H
            depth = 28 if level == LEVELS else 16
            breach = BREACHES.get((level, side))
            if breach:
                g0, g1 = breach[0] + rng.randint(16, 40), breach[1] - rng.randint(16, 40)
                side_add(side, -ext, g0, WALL, WALL + depth, z - SLAB, z, TRIM)
                side_add(side, g1, ext, WALL, WALL + depth, z - SLAB, z, TRIM)
                side_add(side, g0, g1, WALL, WALL + 6, z - SLAB, z - 12, BROKEN)
            else:
                side_add(side, -ext, ext, WALL, WALL + depth, z - SLAB, z, TRIM)
        if door:
            side_add(side, -136, 136, WALL, WALL + 112, 176, 192, METAL, outer=FRAME)
            side_add(side, -136, 136, WALL + 108, WALL + 112, 168, 176, FRAME)
            side_add(side, -104, -96, WALL, WALL + 6, 0, 168, TRIM)
            side_add(side, 96, 104, WALL, WALL + 6, 0, 168, TRIM)
            side_add(side, -96, 96, WALL, WALL + 6, 160, 168, TRIM)


def build_corner_columns():
    for sx in (-1, 1):
        for sy in (-1, 1):
            broken = sx > 0 and sy > 0
            top = ROOF + 8 if broken else ROOF + 96
            x0, x1 = sorted((sx * (HALF - 32), sx * (HALF + 24)))
            y0, y1 = sorted((sy * (HALF - 32), sy * (HALF + 24)))
            add((x0, y0, 0), (x1, y1, top), COLUMN)
            if broken:
                add((x0 + 8, y0 + 8, top), (x1 - 20, y1 - 4, top + 36), BROKEN)
                add((x0 + 20, y0 + 6, top + 36), (x1 - 24, y1 - 30, top + 58), BROKEN)
            else:
                add((x0 - 6, y0 - 6, top), (x1 + 6, y1 + 6, top + 12), CORNICE)


def build_parapet():
    z0, z1 = ROOF - SLAB, ROOF + 64
    for side in SIDES:
        s = span(side)
        broken = BROKEN_PARAPET.get(side)
        a1 = broken[0] if broken else s
        side_add(side, -s, a1, 0, WALL, z0, z1, FACADE, inner=CEILING)
        side_add(side, -s, a1, -8, WALL + 8, z1, z1 + 12, CORNICE)
        if broken:
            a = broken[0]
            while a < broken[1]:
                w = min(rng.randint(16, 56), broken[1] - a)
                side_add(side, a, a + w, rng.choice((0, 4)), WALL - rng.choice((0, 6)), z0, ROOF + rng.randint(4, 40), BROKEN)
                a += w
            side_add(side, broken[0], broken[1], 8, 24, ROOF, ROOF + 128, CLIP)


def ladder_hatch_dir(side):
    return {"S": "yp", "N": "yn", "W": "xp", "E": "xn"}[side]


# How each level reaches the next one. Every way up opens with the stage of the level it leads to.
CONNECTIONS = {
    0: [("stairs", (-IN, -IN + STAIR_W, -256, 256), "yp", "xp"),
        ("stairs", (IN - STAIR_W, IN, -256, 256), "yn", "xn")],
    1: [("stairs", (-216, 296, IN - STAIR_W, IN), "xp", "yn"),
        ("ladder", "E", -176), ("ladder", "S", 0)],
    2: [("elevator", (160, 288, -64, 64)),
        ("ladder", "W", -176)],
    3: [("ramp", (-320, 136, IN - STAIR_W, IN), -80),
        ("ladder", "S", 176)],
    4: [("ladder", "W", -176), ("ladder", "E", -176)],
}

holes = {level: [] for level in range(LEVELS + 1)}
occupied = {level: [] for level in range(LEVELS + 1)}


def rect_of(side, a0, a1, d0, d1):
    p0, p1 = side_point(side, a0, d0), side_point(side, a1, d1)
    return min(p0[0], p1[0]), max(p0[0], p1[0]), min(p0[1], p1[1]), max(p0[1], p1[1])


def open_edges(rect, closed):
    """Edges of a hole that need a railing: all but `closed` and those against the outer walls."""
    x0, x1, y0, y1 = rect
    walls = {"xn": x0 <= -IN, "xp": x1 >= IN, "yn": y0 <= -IN, "yp": y1 >= IN}
    return [e for e in ("xn", "xp", "yn", "yp") if e not in closed and not walls[e]]


def add_hole(level, rect, hatch, closed):
    holes[level].append((rect, hatch, open_edges(rect, closed)))


def build_stairs(level, rect, rise, hatch):
    x0, x1, y0, y1 = rect
    z = level * LEVEL_H
    step = STAIR_RUN
    along_x = rise[0] == "x"
    for i in range(STAIR_STEPS):
        top = z + (i + 1) * (LEVEL_H // STAIR_STEPS)
        if along_x:
            a0 = x0 + i * step if rise == "xp" else x1 - (i + 1) * step
            add((a0, y0, z), (a0 + step, y1, top), STEP, xn=STEP_RISE, xp=STEP_RISE, yn=COLUMN, yp=COLUMN)
        else:
            a0 = y0 + i * step if rise == "yp" else y1 - (i + 1) * step
            add((x0, a0, z), (x1, a0 + step, top), STEP, xn=COLUMN, xp=COLUMN, yn=STEP_RISE, yp=STEP_RISE)
    half = STAIR_STEPS * STAIR_RUN // 2 + HOLE_START
    hole = {"xp": (x1 - half, x1, y0, y1), "xn": (x0, x0 + half, y0, y1),
            "yp": (x0, x1, y1 - half, y1), "yn": (x0, x1, y0, y0 + half)}[rise]
    add_hole(level + 1, hole, hatch, [rise])
    occupied[level].append(rect)


def build_ladder(level, side, a):
    z0 = level * LEVEL_H
    z1 = z0 + LEVEL_H + 56
    side_add(side, a - 16, a + 16, -14, -6, z0, z1, "ladder")
    side_add(side, a - 16, a - 12, -12, -2, z0, z1, FRAME)
    side_add(side, a + 12, a + 16, -12, -2, z0, z1, FRAME)
    for z in range(z0 + 12, z1, 16):
        side_add(side, a - 12, a + 12, -9, -6, z, z + 2, FRAME)
    hole = rect_of(side, a - 32, a + 32, -64, 0)
    inner = {"S": "yp", "N": "yn", "W": "xp", "E": "xn"}[side]
    add_hole(level + 1, hole, ladder_hatch_dir(side), [inner])
    occupied[level].append(rect_of(side, a - 24, a + 24, -40, 0))


def build_elevator(level, rect):
    x0, x1, y0, y1 = rect
    z = level * LEVEL_H
    platform = box((x0, y0, z - 14), (x1, y1, z + 2), METAL, xn=FRAME, xp=FRAME, yn=FRAME, yp=FRAME)
    entity("script_brushmodel", targetname="elevator%d" % (level + 2), brush=platform)
    for px in (x0 - 8, x1):
        for py in (y0 - 8, y1):
            add((px, py, z), (px + 8, py + 8, z + LEVEL_H - SLAB), FRAME)
    add_hole(level + 1, rect, None, ["xn"])
    occupied[level].append((x0 - 8, x1 + 8, y0 - 8, y1 + 8))


def build_ramp(level, rect, hole_from):
    """A slab that broke off the floor above and now leans from this floor up to the next one."""
    x0, x1, y0, y1 = rect
    z0, z1 = level * LEVEL_H, (level + 1) * LEVEL_H
    slope = (z1 - z0) / (x1 - x0)

    def top(x):
        return z0 + (x - x0) * slope

    lines = [
        face([x0, y0, top(x0)], [x1, y0, top(x1)], [x0, y1, top(x0)], [-slope, 0, 1], BROKEN),
        face([x0, y0, top(x0) - 24], [x1, y0, top(x1) - 24], [x0, y1, top(x0) - 24], [slope, 0, -1], BROKEN),
        face([x0, y0, 0], [x1, y0, 0], [x0, y0, 64], [0, -1, 0], BROKEN),
        face([x0, y1, 0], [x1, y1, 0], [x0, y1, 64], [0, 1, 0], BROKEN),
        face([x0 - 40, y0, 0], [x0 - 40, y1, 0], [x0 - 40, y0, 64], [-1, 0, 0], BROKEN),
        face([x1, y0, 0], [x1, y1, 0], [x1, y0, 64], [1, 0, 0], BROKEN),
    ]
    world.append("{\n" + "\n".join(lines) + "\n}")
    for x in range(x0 + 40, x1 - 40, 72):
        side = rng.choice((y0 + 10, y1 - 10))
        chunk(x + rng.randint(-16, 16), side, top(x) - 4, rng.uniform(14, 24))
        if rng.random() < 0.5:
            add((x, y0 + 30, top(x) - 30), (x + 2, y0 + 32, top(x) + rng.randint(10, 30)), REBAR)
    a = hole_from
    while a < x1:
        w = min(rng.randint(12, 32), x1 - a)
        add((a, y0 - rng.randint(6, 20), z1 - SLAB - rng.randint(4, 14)), (a + w, y0 + 2, z1 - SLAB), BROKEN)
        a += w
    add_hole(level + 1, (hole_from, x1, y0, y1), "yn", ["xp"])
    occupied[level].append(rect)


def build_connections():
    for level, items in CONNECTIONS.items():
        for item in items:
            kind = item[0]
            if kind == "stairs":
                build_stairs(level, item[1], item[2], item[3])
            elif kind == "ladder":
                build_ladder(level, item[1], item[2])
            elif kind == "elevator":
                build_elevator(level, item[1])
            else:
                build_ramp(level, item[1], item[2])


def ring(outer, inner):
    return [
        ((-outer, -outer), (outer, -inner)),
        ((-outer, inner), (outer, outer)),
        ((-outer, -inner), (-inner, inner)),
        ((inner, -inner), (outer, inner)),
    ]


def cut(rects, x0, x1, y0, y1):
    """Rectangles minus the area x0..x1, y0..y1."""
    result = []
    for lo, hi in rects:
        if hi[0] <= x0 or lo[0] >= x1 or hi[1] <= y0 or lo[1] >= y1:
            result.append((lo, hi))
            continue
        mx0, mx1 = max(lo[0], x0), min(hi[0], x1)
        for piece in (((lo[0], lo[1]), (mx0, hi[1])), ((mx1, lo[1]), (hi[0], hi[1])),
                      ((mx0, lo[1]), (mx1, y0)), ((mx0, y1), (mx1, hi[1]))):
            if piece[0][0] < piece[1][0] and piece[0][1] < piece[1][1]:
                result.append(piece)
    return result


def build_ground():
    for lo, hi in cut(ring(WORLD, BUILDINGS), BUILDINGS, WORLD, -ROAD_WALK, ROAD_WALK):
        add((lo[0], lo[1], -64), (hi[0], hi[1], 0), PAVEMENT)
    for lo, hi in cut(ring(BUILDINGS, CITY_SIDEWALK), CITY_SIDEWALK, BUILDINGS, -ROAD_HALF, ROAD_HALF):
        add((lo[0], lo[1], -64), (hi[0], hi[1], 8), PAVEMENT, xn=CURB, xp=CURB, yn=CURB, yp=CURB)
    for lo, hi in ring(CITY_SIDEWALK, SIDEWALK):
        add((lo[0], lo[1], -64), (hi[0], hi[1], 0), ROAD)
    for lo, hi in ring(SIDEWALK, HALF):
        add((lo[0], lo[1], -64), (hi[0], hi[1], 8), PAVEMENT, xn=CURB, xp=CURB, yn=CURB, yp=CURB)
    for lo, hi in ring(HALF, IN):
        add((lo[0], lo[1], -64), (hi[0], hi[1], 0), PAVEMENT)
    add((-IN, -IN, -64), (IN, IN, 0), FLOORS[0])


def build_city_block(lo, hi, height, facade, bombed, street, visible=(-BUILDINGS, BUILDINGS)):
    """`street` is the face toward the tower: (along axis, normal axis, outward sign, plane coordinate)."""
    add((lo[0], lo[1], 0), (hi[0], hi[1], height), facade, zp=ROOF_TOP)
    add((lo[0] - 10, lo[1] - 10, 0), (hi[0] + 10, hi[1] + 10, 40), PLINTH)
    build_city_facade(lo, hi, height, bombed, street, visible)
    if bombed:
        horizontal = hi[0] - lo[0] > hi[1] - lo[1]
        p, end = (lo[0], hi[0]) if horizontal else (lo[1], hi[1])
        while p < end:
            w = min(rng.randint(32, 96), end - p)
            top = height + rng.randint(-8, 160)
            if top > height:
                if horizontal:
                    add((p, lo[1], height), (p + w, hi[1], top), facade, zp=BROKEN)
                else:
                    add((lo[0], p, height), (hi[0], p + w, top), facade, zp=BROKEN)
            p += w
        return
    add((lo[0] - 16, lo[1] - 16, height - 24), (hi[0] + 16, hi[1] + 16, height), CORNICE, zp=ROOF_TOP)
    for _ in range(rng.randint(0, 2)):
        cx = rng.uniform(lo[0] + 48, hi[0] - 48)
        cy = rng.uniform(lo[1] + 48, hi[1] - 48)
        add((cx - 32, cy - 24, height), (cx + 32, cy + 24, height + rng.choice((32, 48, 96))), RAIL, zp=METAL)


def build_city_facade(lo, hi, height, bombed, street, visible=(-BUILDINGS, BUILDINGS)):
    """Fake windows and doors snapped to their texture grid, so each shows one whole tile."""
    along, normal, sign, base = street

    def part(a0, a1, d0, d1, z0, z1, material):
        b0, b1 = [0, 0, z0], [0, 0, z1]
        b0[along], b1[along] = a0, a1
        b0[normal], b1[normal] = sorted((base + sign * d0, base + sign * d1))
        add(b0, b1, material)

    w, h = CITY_WINDOW_W, CITY_WINDOW_H
    window = rng.choice(CITY_WINDOWS)
    slots = list(range(max(lo[along], visible[0]) + 64, min(hi[along], visible[1]) - 64 - w + 1, 2 * w))
    doors = set(rng.sample(slots, min(len(slots), rng.randint(1, 2))))
    rows = [z for z in (288, 480, 672) if z + h + 48 <= height]
    for z in rows:
        part(lo[along] - 8, hi[along] + 8, 0, 8, z - 16, z - 4, TRIM)
    for a in slots:
        if a in doors:
            part(a, a + w, 0, 2, 0, 128, CITY_DOOR)
            part(a - 8, a, 0, 6, 0, 136, TRIM)
            part(a + w, a + w + 8, 0, 6, 0, 136, TRIM)
            part(a - 8, a + w + 8, 0, 6, 128, 136, TRIM)
            part(a - 12, a + w + 12, 0, 18, 0, 10, CURB)
        else:
            build_city_window(part, a, 96, window, bombed)
        for z in rows:
            build_city_window(part, a, z, window, bombed)


def build_city_window(part, a, z, window, bombed):
    w, h = CITY_WINDOW_W, CITY_WINDOW_H
    if bombed and rng.random() < 0.35:
        part(a, a + w, 0, 1, z, z + h, VOID)
        p = a
        while p < a + w:
            step = min(rng.randint(8, 20), a + w - p)
            part(p, p + step, 0, rng.randint(2, 6), z + h - rng.randint(4, 18), z + h + 4, BROKEN)
            part(p, p + step, 0, rng.randint(2, 6), z - 4, z + rng.randint(2, 14), BROKEN)
            p += step
        p = z
        while p < z + h:
            step = min(rng.randint(8, 20), z + h - p)
            part(a - 4, a + rng.randint(4, 16), 0, rng.randint(2, 6), p, p + step, BROKEN)
            part(a + w - rng.randint(4, 16), a + w + 4, 0, rng.randint(2, 6), p, p + step, BROKEN)
            p += step
        return
    part(a, a + w, 0, 2, z, z + h, window)
    part(a - 8, a, 0, 6, z - 4, z + h + 8, TRIM)
    part(a + w, a + w + 8, 0, 6, z - 4, z + h + 8, TRIM)
    part(a - 8, a + w + 8, 0, 6, z + h, z + h + 8, TRIM)
    part(a - 10, a + w + 10, 0, 10, z - 8, z, TRIM)


def build_city():
    for side in range(4):
        pos = -WORLD
        while pos < WORLD:
            width = min(rng.choice((384, 512, 640)), WORLD - pos)
            height = rng.choice((448, 576, 704, 832))
            facade = rng.choice(CITY_FACADES)
            if side == 0:
                lo, hi, street = (pos, -WORLD), (pos + width, -BUILDINGS), (0, 1, 1, -BUILDINGS)
            elif side == 1:
                lo, hi, street = (pos, BUILDINGS), (pos + width, WORLD), (0, 1, -1, BUILDINGS)
            elif side == 2:
                lo, hi, street = (-WORLD, max(pos, -BUILDINGS)), (-BUILDINGS, min(pos + width, BUILDINGS)), (1, 0, 1, -BUILDINGS)
            else:
                lo, hi, street = (BUILDINGS, max(pos, -BUILDINGS)), (WORLD, min(pos + width, BUILDINGS)), (1, 0, -1, BUILDINGS)
            bombed = rng.random() < 0.3
            if lo[0] < hi[0] and lo[1] < hi[1]:
                for plo, phi in (cut([(lo, hi)], BUILDINGS, WORLD, -ROAD_BLOCK, ROAD_BLOCK) if side == 3 else [(lo, hi)]):
                    build_city_block(plo, phi, height, facade, bombed, street)
            pos += width


def build_road():
    """A street leaving the square to the east, closed by a barricade and a building across its end."""
    add((CITY_SIDEWALK, -ROAD_HALF, -64), (ROAD_END, ROAD_HALF, 0), ROAD)
    for sy in (-1, 1):
        y0, y1 = sorted((sy * ROAD_HALF, sy * ROAD_WALK))
        add((BUILDINGS, y0, -64), (ROAD_END, y1, 8), PAVEMENT, yn=CURB, yp=CURB)
        y0, y1 = sorted((sy * ROAD_WALK, sy * ROAD_BLOCK))
        add((WORLD, y0, -64), (ROAD_END, y1, 0), PAVEMENT)

        pos = BUILDINGS
        while pos < ROAD_END - 256:
            width = min(rng.choice((384, 512, 640)), ROAD_END - 256 - pos)
            lo, hi = (pos, y0), (pos + width, y1)
            street = (0, 1, -sy, sy * ROAD_WALK)
            height = rng.choice((576, 704, 832))
            facade = rng.choice(CITY_FACADES)
            bombed = rng.random() < 0.3
            build_city_block(lo, hi, height, facade, bombed, street, (BUILDINGS, ROAD_END))
            if pos == BUILDINGS:
                build_city_facade(lo, hi, height, bombed, (1, 0, -1, BUILDINGS), (y0, y1))
            pos += width
    build_city_block((ROAD_END - 256, -ROAD_BLOCK), (ROAD_END, ROAD_BLOCK), 896, rng.choice(CITY_FACADES), False,
                     (1, 0, -1, ROAD_END - 256), (-ROAD_WALK, ROAD_WALK))

    add((BARRICADE, -ROAD_WALK, 0), (BARRICADE + 16, ROAD_WALK, 512), CLIP)
    barricade = [
        ("military_hedgehog", BARRICADE - 50, -140, 10), ("military_hedgehog", BARRICADE - 40, 0, 50),
        ("military_hedgehog", BARRICADE - 55, 140, 80),
        ("caen_barbedwire_1", BARRICADE - 90, -80, 90), ("caen_barbedwire_2", BARRICADE - 90, 90, 90),
        ("military_sandbag_longsection", BARRICADE + 40, -230, 90), ("military_sandbag_longsection", BARRICADE + 40, 230, 90),
        ("military_sandbag_shortsection", BARRICADE + 40, -90, 90), ("military_sandbag_shortsection", BARRICADE + 40, 70, 90),
        ("civiliancar_damaged_blue", BARRICADE + 160, -30, 80),
        ("vehicle_africa_jeep_crash_static", 2350, 70, 160), ("civiliancar_intact_blue", 2750, -110, 5),
        ("prop_wood_debris_big_burnt_02", 2050, -40, 20), ("prop_rubble_rock_04", 1950, 120, 0),
        ("prop_redbrickpile_debris_01", 2600, 240, 0),
    ]
    for name, x, y, yaw in barricade:
        model(name, x, y, 8 if abs(y) > ROAD_HALF else 0, yaw)
    for x in (1750, 2250, 2750):
        for sy in (-1, 1):
            model("prop_streetlamp_off", x, sy * 260, 8)
    rubble_pile(1900, 2200, -180, 180, 0, 10, 40)


def cylinder(cx, cy, z0, z1, radius, material, sides=12):
    corners = [(cx + radius * math.cos(2 * math.pi * i / sides), cy + radius * math.sin(2 * math.pi * i / sides)) for i in range(sides)]
    lines = [face([cx, cy, z1], [cx + 1, cy, z1], [cx, cy + 1, z1], [0, 0, 1], material),
             face([cx, cy, z0], [cx + 1, cy, z0], [cx, cy + 1, z0], [0, 0, -1], material)]
    for i in range(sides):
        (x0, y0), (x1, y1) = corners[i], corners[(i + 1) % sides]
        lines.append(face([x0, y0, z0], [x1, y1, z0], [x0, y0, z1], [y1 - y0, x0 - x1, 0], material))
    world.append("{\n" + "\n".join(lines) + "\n}")


def build_street():
    """Markings, gutters, patches and manholes, so the asphalt reads as streets instead of one flat sheet."""
    mid = (SIDEWALK + CITY_SIDEWALK) // 2
    inner, outer = SIDEWALK + 20, CITY_SIDEWALK - 20
    crossing = 104

    gutters = ring(inner, SIDEWALK) + cut(ring(CITY_SIDEWALK, outer), outer, CITY_SIDEWALK, -ROAD_HALF, ROAD_HALF)
    gutters += [((CITY_SIDEWALK, sy * ROAD_HALF - (20 if sy > 0 else 0)), (ROAD_END - 256, sy * ROAD_HALF + (0 if sy > 0 else 20)))
                for sy in (-1, 1)]
    for lo, hi in gutters:
        add((lo[0], lo[1], 0), (hi[0], hi[1], 1), GUTTER)

    for _ in range(16):
        side = rng.randrange(4)
        a = rng.randint(-outer + 120, outer - 120)
        d = rng.randint(inner + 30, outer - 150)
        w, h = rng.randint(48, 220), rng.randint(40, 120)
        x0, y0 = [(a, -d - h), (d, a), (a, d), (-d - h, a)][side]
        x1, y1 = (x0 + w, y0 + h) if side % 2 == 0 else (x0 + h, y0 + w)
        add((x0, y0, 0), (x1, y1, 1), PATCH)
    for x0 in (1650, 2150, 2480):
        add((x0, rng.randint(-170, 40), 0), (x0 + rng.randint(80, 200), rng.randint(60, 170), 1), PATCH)

    def paint(x0, y0, x1, y1):
        add((min(x0, x1), min(y0, y1), 0), (max(x0, x1), max(y0, y1), 2), ROAD_PAINT)

    def along(side, a0, a1, d0, d1):
        """A painted strip on one side of the ring road: `a` along it, `d` out from the tower."""
        if side == "S":
            paint(a0, -d0, a1, -d1)
        elif side == "N":
            paint(a0, d0, a1, d1)
        elif side == "W":
            paint(-d0, a0, -d1, a1)
        else:
            paint(d0, a0, d1, a1)

    for side in "SNWE":
        for a0, a1 in ((-mid, -crossing), (crossing, mid)):
            a = a0
            while a < a1:
                along(side, a, min(a + 64, a1), mid - 3, mid + 3)
                a += 128
        for d in (inner + 8, outer - 14):
            pieces = [(-d, -crossing), (crossing, d)]
            if side == "E" and d > mid:
                pieces = [(-d, -crossing - 120), (crossing + 120, d)]
            for a0, a1 in pieces:
                along(side, a0, a1, d, d + 6)
        for d in range(inner + 16, outer - 16, 64):
            along(side, -crossing + 12, crossing - 12, d, d + 32)

    x = CITY_SIDEWALK + 40
    while x < ROAD_END - 300:
        paint(x, -3, x + 64, 3)
        x += 128
    for sy in (-1, 1):
        paint(CITY_SIDEWALK + 120, sy * (ROAD_HALF - 28), ROAD_END - 256, sy * (ROAD_HALF - 34))

    for mx, my in ((300, -1060), (1060, 300), (-700, 1060), (-1060, -500), (640, -640), (2000, 100), (2600, -100)):
        cylinder(mx, my, 0, 2, 22, METAL)

    for name, x, y, yaw in (("civiliancar_intact_blue", -540, -1185, 90), ("civiliancar_damaged_blue", 560, 1185, 270),
                            ("civiliancar_intact_blue", -1185, 600, 0), ("civiliancar_intact_blue", 1185, -460, 180)):
        model(name, x, y, 0, yaw)


def build_sky():
    t = 32
    add((-WORLD - t, -WORLD - t, -64), (-WORLD, WORLD + t, SKY_TOP), SKY)
    add((WORLD, -WORLD - t, -64), (WORLD + t, -ROAD_BLOCK, SKY_TOP), SKY)
    add((WORLD, ROAD_BLOCK, -64), (WORLD + t, WORLD + t, SKY_TOP), SKY)
    add((WORLD, -ROAD_BLOCK - t, -64), (ROAD_END + t, -ROAD_BLOCK, SKY_TOP), SKY)
    add((WORLD, ROAD_BLOCK, -64), (ROAD_END + t, ROAD_BLOCK + t, SKY_TOP), SKY)
    add((ROAD_END, -ROAD_BLOCK, -64), (ROAD_END + t, ROAD_BLOCK, SKY_TOP), SKY)
    add((WORLD + t, -ROAD_BLOCK - t, SKY_TOP), (ROAD_END + t, ROAD_BLOCK + t, SKY_TOP + t), SKY)
    add((-WORLD, -WORLD - t, -64), (WORLD, -WORLD, SKY_TOP), SKY)
    add((-WORLD, WORLD, -64), (WORLD, WORLD + t, SKY_TOP), SKY)
    add((-WORLD - t, -WORLD - t, SKY_TOP), (WORLD + t, WORLD + t, SKY_TOP + t), SKY)


def build_slab(level):
    z = level * LEVEL_H
    top = ROOF_TOP if level == LEVELS else FLOORS[level]
    pieces = [((-IN, -IN), (IN, IN))]
    for (x0, x1, y0, y1), _, _ in holes[level]:
        pieces = cut(pieces, x0, x1, y0, y1)
    for lo, hi in pieces:
        add((lo[0], lo[1], z - SLAB), (hi[0], hi[1], z), top, zn=CEILING)

    for (x0, x1, y0, y1), hatch, rails in holes[level]:
        if hatch:
            entity("script_brushmodel", targetname="hatch%d_%s" % (level + 1, hatch),
                   brush=box((x0, y0, z - 18), (x1, y1, z - 2), METAL))
        for edge in rails:
            lo, hi = {"xn": ((x0 - 6, y0 - 6), (x0, y1 + 6)), "xp": ((x1, y0 - 6), (x1 + 6, y1 + 6)),
                      "yn": ((x0, y0 - 6), (x1, y0)), "yp": ((x0, y1), (x1, y1 + 6))}[edge]
            build_rail(lo, hi, z)
        occupied[level].append((x0 - 24, x1 + 24, y0 - 24, y1 + 24))


def build_rail(lo, hi, z):
    rail_h = 48
    add((lo[0], lo[1], z + rail_h - 4), (hi[0], hi[1], z + rail_h), RAIL)
    add((lo[0], lo[1], z + 16), (hi[0], hi[1], z + 18), RAIL)
    along_x = hi[0] - lo[0] > hi[1] - lo[1]
    length = (hi[0] - lo[0]) if along_x else (hi[1] - lo[1])
    posts = max(2, length // 32 + 1)
    for t in range(posts):
        if along_x:
            px = int(lo[0] + (hi[0] - lo[0] - 4) * t / (posts - 1))
            add((px, lo[1], z), (px + 4, hi[1], z + rail_h - 4), FRAME)
        else:
            py = int(lo[1] + (hi[1] - lo[1] - 4) * t / (posts - 1))
            add((lo[0], py, z), (hi[0], py + 4, z + rail_h - 4), FRAME)


def build_beams(level):
    z = (level + 1) * LEVEL_H - SLAB
    for y in (-176, 176):
        segments = [((-IN, y - 12), (IN, y + 12))]
        for (x0, x1, y0, y1), _, _ in holes[level + 1]:
            segments = cut(segments, x0, x1, y0, y1)
        for lo, hi in segments:
            add((lo[0], lo[1], z - 16), (hi[0], hi[1], z), BEAM)


def build_pillars(level):
    z = level * LEVEL_H
    top = z + LEVEL_H - SLAB
    for x in (-112, 112):
        occupied[level].append((x - 26, x + 26, -26, 26))
        add((x - 20, -20, z), (x + 20, 20, top), COLUMN)
        add((x - 26, -26, z), (x + 26, 26, z + 12), TRIM)
        add((x - 26, -26, top - 12), (x + 26, 26, top), TRIM)


def build_lights():
    for level in range(LEVELS):
        z = level * LEVEL_H + LEVEL_H - SLAB - 24
        for x in (-192, 192):
            for y in (-192, 192):
                entity("light", origin="%d %d %d" % (x, y, z), radius="420", _color="1 0.92 0.8")


def build_props():
    furniture = {
        0: [("furniture_armchair", -150, -320, 90), ("furniture_armchair", 150, -320, 90),
            ("furniture_bookshelvestall", -140, 330, 270), ("furniture_bookshelvestall", 140, 330, 270)],
        1: [("furniture_bookshelvestall", -150, -330, 90), ("furniture_armchair_d", 140, -300, 120),
            ("furniture_cabinet", -60, -330, 90)],
        2: [("furniture_cabinet", -130, 330, 270), ("furniture_bookshelves1_d", -250, 330, 270),
            ("furniture_armchair_d", 160, -150, 200), ("crate01", -60, 300, 15)],
        3: [("furniture_bookshelves1_d", 40, -330, 90), ("furniture_armchair", 250, 300, 230),
            ("furniture_bookshelveswide", 330, 200, 180), ("hill400_barrel_black", 280, -320, 0)],
        4: [("military_sandbag_longsection", -220, 300, 0), ("crate01", 100, -330, 30),
            ("crate02", 40, -320, 0), ("hill400_barrel_green", -160, -330, 0)],
        5: [("crate01", 120, 150, 10), ("crate02", 160, 200, 40), ("hill400_barrel_black", -120, 120, 0),
            ("military_sandbag_shortsection", 100, 230, 0)],
    }
    for level, items in furniture.items():
        for name, x, y, yaw in items:
            model(name, x, y, level * LEVEL_H, yaw)
            occupied[level].append((x - 48, x + 48, y - 48, y + 48))

    rubble_pile(220, 330, 220, 330, ROOF, 8, 40)
    add((230, -230, ROOF), (320, -150, ROOF + 48), RAIL, zp=METAL)
    add((200, -120, ROOF), (264, -60, ROOF + 32), RAIL, zp=METAL)
    add((-300, 300, ROOF), (-292, 308, ROOF + 320), FRAME)
    occupied[LEVELS] += [(200, 352, 200, 352), (200, 330, -240, -50), (-310, -280, 290, 320)]

    street = [
        ("civiliancar_damaged_blue", -640, -700, 30), ("civiliancar_intact_blue", 700, 640, 200),
        ("vehicle_africa_jeep_crash_static", -660, 620, 120), ("civiliancar_damaged_blue", 1180, -760, 95),
        ("military_hedgehog", 560, -640, 0), ("military_hedgehog", -560, 780, 40), ("military_hedgehog", 1220, 120, 15),
        ("military_sandbag_longsection", -200, -480, 0), ("military_sandbag_longsection", 200, -480, 0),
        ("military_sandbag_longsection", -200, 480, 180), ("military_sandbag_longsection", 200, 480, 180),
        ("crate01", -1220, -300, 20), ("crate02", -1200, -360, 0), ("hill400_barrel_black", -1230, -240, 0),
        ("hill400_barrel_green", 260, 1220, 0), ("crate01", 320, 1240, 40),
        ("prop_rubble_rock_02", -1250, 640, 0), ("prop_rubble_rock_03", 1260, 980, 70),
        ("prop_redbrickpile_debris_02", -900, 1260, 0), ("prop_wood_debris_big_burnt_01", 980, -1250, 30),
    ]
    for name, x, y, yaw in street:
        r = max(abs(x), abs(y))
        model(name, x, y, 8 if r > CITY_SIDEWALK or r < SIDEWALK else 0, yaw)
    for x, y in ((-470, -470), (470, -470), (-470, 470), (470, 470)):
        model("prop_streetlamp_off", x, y, 8)
    for p in range(-1024, 1025, 512):
        for x, y in ((p, -1300), (p, 1300), (-1300, p), (1300, p)):
            if x != 1300 or abs(y) > ROAD_WALK:
                model("prop_streetlamp_off", x, y, 8)
    rubble_pile(-1300, -1150, 500, 760, 0, 10, 48)
    rubble_pile(1000, 1250, 1150, 1300, 0, 8, 40)


def build_billboard():
    """The map's hallmark: a neon sign on steel legs at the south edge of the roof, facing the square."""
    z0, z1 = ROOF + 256, ROOF + 640
    y0, y1 = -308, -300
    back = y1 + 40
    add((-384, y0, z0), (384, y1, z1), METAL, yn=NEON)
    add((-392, y0 - 8, z0 - 8), (392, y1, z0), FRAME)
    add((-392, y0 - 8, z1), (392, y1, z1 + 8), FRAME)
    add((-392, y0 - 8, z0), (-384, y1, z1), FRAME)
    add((384, y0 - 8, z0), (392, y1, z1), FRAME)
    add((-384, y0 - 56, z0 - 16), (384, y0 - 8, z0 - 8), METAL, zp=METAL)
    add((-384, y0 - 56, z0 - 8), (384, y0 - 52, z0 + 24), RAIL)
    for x in (-352, -176, 0, 176, 352):
        for ly in (y1, back):
            add((x - 4, ly, ROOF), (x + 4, ly + 8, z0), FRAME)
        for z in (ROOF + 80, ROOF + 170):
            add((x - 4, y1, z), (x + 4, back + 8, z + 6), FRAME)
        add((x - 12, y0 - 72, z0 - 8), (x + 12, y0 - 56, z0 + 8), METAL)
        occupied[LEVELS].append((x - 20, x + 20, y1 - 16, back + 24))
    for ly in (y1, back):
        for z in (ROOF + 80, ROOF + 170, z0 - 24):
            add((-352, ly, z), (352, ly + 8, z + 6), FRAME)
    for i, x in enumerate((-288, -96, 96, 288)):
        color = "1 0.25 0.6" if i % 2 == 0 else "0.2 0.9 1"
        entity("light", origin="%d %d %d" % (x, y0 - 150, z0 + 96), radius="560", _color=color)
    entity("light", origin="0 -200 %d" % (ROOF + 96), radius="420", _color="1 0.3 0.7")


def floor_spawns(level):
    """Spawn spots on a level that keep clear of stairs, holes, ladders, rubble and furniture."""
    z = level * LEVEL_H + 16
    free = []
    for x in (-256, -160, -64, 32, 128, 224):
        for y in (-272, -176, -80, 80, 176, 272):
            if not any(x0 - 20 < x < x1 + 20 and y0 - 20 < y < y1 + 20 for x0, x1, y0, y1 in occupied[level]):
                free.append((x, y, z))
    return free


def street_spawns():
    points = []
    for i in range(20):
        d = 900 if i % 2 else 1100
        side = i % 4
        t = -720 + (i // 4) * 360
        x, y = [(t, -d), (d, t), (-t, d), (-d, -t)][side]
        points.append((x, y, 24))
    return points


def yaw_to_center(x, y):
    return int(math.degrees(math.atan2(-y, -x))) % 360


def build_spawns():
    for level in range(LEVELS + 1):
        for i, (x, y, z) in enumerate(floor_spawns(level)):
            entity("mp_ctf_spawn_allied", targetname=str(level + 1), origin="%d %d %d" % (x, y, z), angles="0 %d 0" % (i * 90 % 360))
    for x, y, z in street_spawns():
        entity("mp_ctf_spawn_axis", targetname="1", origin="%d %d %d" % (x, y, z), angles="0 %d 0" % yaw_to_center(x, y))
    for level in range(LEVELS):
        for x, y, z in floor_spawns(level)[:12]:
            entity("mp_ctf_spawn_axis", targetname=str(level + 2), origin="%d %d %d" % (x, y, z), angles="0 0 0")
    entity("mp_global_intermission", origin="1150 -1150 1100", angles="25 135 0")


def write(path):
    build_ground()
    build_city()
    build_road()
    build_street()
    build_sky()
    for level in range(LEVELS):
        for side in SIDES:
            build_wall(side, level)
        build_pillars(level)
    build_connections()
    for level in range(LEVELS):
        build_beams(level)
    build_facade_trim()
    build_corner_columns()
    build_parapet()
    for level in range(1, LEVELS + 1):
        build_slab(level)
    build_lights()
    build_props()
    build_billboard()
    build_spawns()

    out = ["iwmap 4", "// entity 0", "{",
           '"classname" "worldspawn"',
           '"sundirection" "-50 135 0"',
           '"suncolor" "1 0.95 0.85"',
           '"sunlight" "1.1"',
           '"sundiffusecolor" "0.75 0.82 0.9"',
           '"diffusefraction" "0.4"',
           '"ambient" "0.2"',
           '"_color" "0.8 0.85 0.95"']
    for i, b in enumerate(world):
        out.append("// brush %d" % i)
        out.append(b)
    out.append("}")
    for n, (classname, keys) in enumerate(entities, start=1):
        out.append("// entity %d" % n)
        out.append("{")
        brush = keys.pop("brush", None)
        for k, v in keys.items():
            out.append('"%s" "%s"' % (k, v))
        out.append('"classname" "%s"' % classname)
        if brush:
            out.append("// brush 0")
            out.append(brush)
        out.append("}")
    with open(path, "w") as f:
        f.write("\n".join(out) + "\n")


if __name__ == "__main__":
    here = os.path.dirname(os.path.abspath(__file__))
    write(os.path.join(here, "mp_skyscraper.map"))
    with open(os.path.join(here, "mp_skyscraper.arena"), "w") as f:
        f.write('{\n\tmap "mp_skyscraper"\n\tlongname "Skyscraper"\n\tgametype "tdm ctf stage zom"\n}\n')
