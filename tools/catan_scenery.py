"""Original low-profile Java cuboids; tile centres and building boundaries stay clear."""
from PIL import Image
import random
from boardgame_assets import cube

PALETTE = {
    'bark': '#80532f', 'leaves': '#367947', 'leaf_tip': '#50935a',
    'clay': '#aa6547', 'clay_light': '#c48558', 'stone': '#819298',
    'stone_light': '#b1bec1', 'coal': '#35434c', 'wool': '#eee7d5',
    'hoof': '#585146', 'soil': '#806440', 'wheat': '#d9af4d',
    'straw': '#efce75', 'cactus': '#508555', 'sand': '#d9c38f',
    'planks': '#a67d4c', 'rope': '#d2b377', 'sail': '#eee4c8',
    'hull': '#4d6270', 'paper': '#ede6d1', 'deck_edge': '#34505c',
}


def materials(png):
    for seed, (name, color) in enumerate(PALETTE.items()):
        rng = random.Random(9021 + seed)
        base = tuple(int(color[i:i+2], 16) for i in (1, 3, 5))
        img = Image.new('RGB', (16, 16))
        for z in range(16):
            for x in range(16):
                shift = rng.choice((-8, -4, 0, 0, 3, 6))
                if name in ('bark', 'planks') and x % 5 == 0:
                    shift -= 16
                img.putpixel((x, z), tuple(max(0, min(255, v + shift)) for v in base))
        png('scenery/' + name, img)


class Scene:
    def __init__(self):
        self.elements = []
        self.textures = {}

    def box(self, x, z, width, depth, low, high, material, name):
        self.textures[material] = 'card:item/catan/scenery/' + material
        self.elements.append(cube([x-width/2, low, z-depth/2],
                                  [x+width/2, high, z+depth/2], material, name))

    def tree(self, x, z, height=5.6):
        self.box(x, z, .65, .65, 0, 1.9, 'bark', 'tree_trunk')
        for width, a, b, mat in [(3.3, 1.9, 3.1, 'leaves'),
                                  (2.5, 3.1, 4.5, 'leaves'),
                                  (1.4, 4.5, 5.6, 'leaf_tip')]:
            self.box(x, z, width, width, a*height/5.6, b*height/5.6, mat, 'tree_crown')

    def rock(self, x, z, height, mat='stone'):
        for width, a, b in [(3.4, 0, .35), (2.6, .35, .72), (1.45, .72, 1)]:
            self.box(x, z, width, width*.85, a*height, b*height, mat, 'rock_terrace')

    def sheep(self, x, z, angle=1):
        for dx in (-.56, .56):
            for dz in (-.65, .65):
                self.box(x+dx, z+dz, .3, .3, 0, .8, 'hoof', 'sheep_leg')
        self.box(x, z, 1.65, 2, .8, 2.05, 'wool', 'sheep_body')
        self.box(x, z+angle*1.25, .85, .6, 1.05, 1.8, 'hoof', 'sheep_face')
        self.box(x, z+angle*1.22, .95, .65, 1.8, 2.12, 'wool', 'sheep_forehead')

    def patch(self, x, z):
        self.box(x, z, 3, 3.5, 0, .2, 'soil', 'raised_field')
        for dx in (-.9, 0, .9):
            for dz in (-1, 0, 1):
                self.box(x+dx, z+dz, .18, .18, .2, 1.5, 'wheat', 'wheat_stem')
                self.box(x+dx, z+dz, .45, .45, 1.5, 2.15, 'straw', 'wheat_ear')


def terrain(name):
    s = Scene()
    if name == 'forest':
        for x, z, h in [(4, 4.7, 5.6), (11.8, 4.5, 4.8), (4.4, 11.8, 4.6), (12, 11.4, 5.4)]:
            s.tree(x, z, h)
    elif name == 'hills':
        for x, z, h in [(4, 4.8, 2.8), (12, 11.4, 3.2), (4.4, 11.7, 1.5)]:
            s.rock(x, z, h, 'clay')
        for dx in (0, 1.15):
            s.box(11.7+dx, 4.6, 1, .7, .05, .65, 'clay_light', 'clay_brick')
        s.box(12.25, 4.6, 1, .7, .65, 1.25, 'clay_light', 'clay_brick')
    elif name == 'pasture':
        for x, z, facing in [(4.5, 4.8, 1), (11.6, 4.8, -1), (4.5, 11.5, -1), (11.6, 11.6, 1)]:
            s.sheep(x, z, facing)
    elif name == 'fields':
        for x, z in [(4.3, 4.7), (11.8, 4.5), (4.3, 11.6), (11.6, 11.5)]:
            s.patch(x, z)
    elif name == 'mountains':
        s.rock(4, 4.6, 5.6)
        s.box(4, 4.6, 1.15, 1, 5.6, 5.85, 'stone_light', 'mountain_summit')
        s.rock(11.8, 11.5, 4.2, 'stone_light')
        s.rock(4.4, 11.8, 2.1)
        s.box(4, 6.12, 1.5, .18, 0, 1.8, 'coal', 'mine_entrance')
        for x in (2.9, 5.1):
            s.box(x, 6.3, .5, .5, 0, 2, 'bark', 'mine_support')
        s.box(4, 6.3, 2.7, .55, 2, 2.5, 'bark', 'mine_lintel')
        s.box(12, 4.8, 1, 1, 0, 1.15, 'coal', 'ore_outcrop')
    elif name == 'desert':
        for x, z in [(4.5, 4.7), (11.6, 11.5)]:
            s.box(x, z, .8, .8, 0, 3.6, 'cactus', 'cactus_stem')
            s.box(x+.85, z, .9, .65, 1.7, 2.25, 'cactus', 'cactus_arm')
            s.box(x+1.15, z, .4, .65, 2.25, 2.9, 'cactus', 'cactus_tip')
            s.box(x-.7, z, .6, .6, 1.1, 1.6, 'cactus', 'cactus_arm')
        s.rock(11.8, 4.5, 1.15, 'sand')
        s.rock(4.5, 11.8, .7, 'sand')
    # Inset the complete ornaments from roads and settlement intersections.
    for element in s.elements:
        for point in ('from', 'to'):
            for axis in (0, 2):
                element[point][axis] = round(8 + (element[point][axis]-8)*.94, 5)
    return s


def harbour():
    s = Scene()
    s.box(8, 11.2, 9, 6.4, 0, .7, 'planks', 'pier_deck')
    for x in (3.9, 12.1):
        for z in (9, 13.6):
            s.box(x, z, .65, .65, -.65, 2.2, 'bark', 'pier_piling')
            s.box(x, z, .8, .8, 1.4, 1.8, 'rope', 'rope_collar')
    for z in (10, 12.4):
        s.box(5, z, 1.15, 1.15, .7, 2, 'clay_light', 'cargo_crate')
    # Boat out to sea, away from the rotating ratio token near the coast.
    s.box(8, 21, 3.6, 5.6, -.1, .6, 'hull', 'boat_keel')
    s.box(8, 21, 5, 7.2, .6, 1.4, 'hull', 'boat_hull')
    s.box(8, 21, 4, 6.2, 1.4, 1.8, 'planks', 'boat_deck')
    s.box(8, 21, .45, .45, 1.8, 9, 'bark', 'boat_mast')
    for y, width in [(3.3, 3.8), (4.6, 3), (5.9, 2.2), (7.2, 1.4)]:
        s.box(8.35+width/2, 21, width, .16, y, y+1.25, 'sail', 'stepped_sail')
    return s


def development_deck():
    s = Scene()
    s.box(8, 8, 13.2, 16, 0, .45, 'deck_edge', 'card_tray')
    for i in range(4):
        s.box(8, 8, 11.8, 15.2, .45+i*.45, .85+i*.45, 'paper', 'card_layer')
    s.textures['back'] = 'card:item/catan/development_back'
    s.elements.append({'name': 'upper_card_back', 'from': [2.1, 2.21, .4], 'to': [13.9, 2.21, 15.6],
                       'faces': {'up': {'texture': '#back', 'uv': [0, 0, 16, 16]}}})
    return {'textures': {**s.textures, 'particle': s.textures['deck_edge']}, 'elements': s.elements}
