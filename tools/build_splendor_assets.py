"""璀璨宝石：Minecraft 主题发展牌、贵族牌与低实体桌面资源。"""
from __future__ import annotations

import json
import argparse
import base64
import copy
import hashlib
import math
import random
import uuid
import zipfile
from functools import lru_cache
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import PACK, RP, CARD, cube, disc, export_model, export_blockbench, export_texture, json_file, text_file

SOURCE = RP / '.source/splendor'
CARD_BASES = {}
COLORS = ('diamond', 'sapphire', 'emerald', 'ruby', 'onyx', 'gold')
INKS = ('#e6edf2', '#407bc5', '#439d77', '#ca5361', '#535062', '#e3b94d')
DARK = ('#698492', '#224a85', '#23654d', '#8e283c', '#292435', '#a47426')
PAPER, INK, GOLD = '#f1e5c9', '#352f39', '#c8a267'
VANILLA = SOURCE / 'vanilla'
TOKEN_ITEMS = ('diamond', 'lapis_lazuli', 'emerald', 'redstone', 'coal', 'gold_ingot')
ART_ITEMS = (
    ('diamond', 'iron_ingot', 'quartz', 'snowball', 'bone', 'iron_pickaxe'),
    ('lapis_lazuli', 'blue_dye', 'prismarine_shard', 'heart_of_the_sea', 'echo_shard', 'diamond_pickaxe'),
    ('emerald', 'slime_ball', 'ender_pearl', 'experience_bottle', 'green_dye', 'kelp'),
    ('redstone', 'red_dye', 'nether_wart', 'fire_charge', 'brick', 'apple'),
    ('coal', 'flint', 'ink_sac', 'netherite_scrap', 'netherite_ingot', 'netherite_pickaxe'),
)
ART_BLOCKS = ('quartz_block_side', 'prismarine', 'moss_block', 'red_nether_bricks', 'polished_blackstone_bricks')
MOBS = (
    ('villager/villager', (8, 8, 16, 18), '村民'),
    ('wandering_trader/wandering_trader', (8, 8, 16, 18), '流浪商人'),
    ('iron_golem/iron_golem', (8, 8, 16, 18), '铁傀儡'),
    ('snow_golem/snow_golem', (8, 8, 16, 16), '雪傀儡'),
    ('allay/allay', (5, 5, 10, 10), '悦灵'),
    ('bee/bee', (7, 10, 19, 17), '蜜蜂'),
    ('fox/fox', (5, 11, 17, 17), '狐狸'),
    ('axolotl/axolotl_lucy', (2, 6, 16, 11), '美西螈'),
    ('turtle/turtle', (3, 6, 21, 11), '海龟'),
    ('pig/pig_temperate', (8, 8, 16, 16), '猪'),
)
_ART_RANKS = {}
GUI = {'gui': {'rotation': [90, 0, 0], 'translation': [0, 0, 0], 'scale': [0.9, 0.9, 0.9]},
       'fixed': {'rotation': [90, 0, 0], 'translation': [0, 0, 0], 'scale': [0.9, 0.9, 0.9]}}
FIRST_PERSON = ['firstperson_righthand', 'firstperson_lefthand']
PUBLIC_HAND = ['thirdperson_righthand', 'thirdperson_lefthand', 'ground']


def font(size, bold=False):
    return ImageFont.truetype('C:/Windows/Fonts/' + ('arialbd.ttf' if bold else 'arial.ttf'), size)


def signature(card):
    """牌面、物品身份都只由奖励、分数和花费决定，不含实例或牌槽。"""
    return (card.get('bonus', -1), card.get('points', 3), tuple(card['cost']))


def signature_text(card):
    bonus, points, cost = signature(card)
    return f'{bonus}:{points}:' + ','.join(map(str, cost))


@lru_cache(maxsize=None)
def vanilla(resource):
    """保留参与合成的原版像素源，已有源文件时无需客户端 jar。"""
    path = VANILLA / (resource + '.png')
    if not path.is_file():
        version = PACK.parents[3]
        archive = version / (version.name + '.jar')
        with zipfile.ZipFile(archive) as client:
            body = client.read('assets/minecraft/textures/' + resource + '.png')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(body)
    return Image.open(path).convert('RGBA')


def paste_sprite(image, resource, box, outline=False):
    sprite = vanilla(resource)
    bbox = sprite.getbbox()
    sprite = sprite.crop(bbox) if bbox else sprite
    x, y, width, height = box
    scale = min(width / sprite.width, height / sprite.height)
    sprite = sprite.resize((max(1, round(sprite.width*scale)), max(1, round(sprite.height*scale))), Image.Resampling.NEAREST)
    point = (round(x+(width-sprite.width)/2), round(y+(height-sprite.height)/2))
    if outline:
        shadow = Image.new('RGBA', sprite.size, '#101b23')
        for dx, dy in ((-2, 0), (2, 0), (0, -2), (0, 2)):
            image.paste(shadow, (point[0]+dx, point[1]+dy), sprite.getchannel('A'))
    image.alpha_composite(sprite, point)


def gem_icon(image, color, xy, size):
    x, y = xy
    paste_sprite(image, 'item/'+TOKEN_ITEMS[color], (x-size/2, y-size/2, size, size), outline=True)


def star(draw, xy, radius, fill=GOLD):
    x, y = xy
    points = [(x+(radius if i%2 == 0 else radius*.45)*math.sin(i*math.pi/5),
               y-(radius if i%2 == 0 else radius*.45)*math.cos(i*math.pi/5)) for i in range(10)]
    draw.polygon(points, fill=fill)


def gem(draw, xy, radius, color):
    x, y = xy
    points = [(x-radius, y-radius*.27), (x-radius*.58, y-radius*.80),
              (x+radius*.58, y-radius*.80), (x+radius, y-radius*.27), (x, y+radius)]
    draw.polygon(points, fill=INKS[color], outline=DARK[color], width=max(1, round(radius*.09)))
    draw.line([points[0], (x, y-radius*.27), points[3]], fill='#f8edce', width=max(1, round(radius*.06)))
    draw.line([(x-radius*.58, y-radius*.80), (x-radius*.29, y-radius*.27), (x, y+radius),
               (x+radius*.29, y-radius*.27), (x+radius*.58, y-radius*.80)], fill=DARK[color], width=max(1, round(radius*.06)))
    draw.line([(x-radius*.29, y-radius*.27), (x, y-radius*.80), (x+radius*.29, y-radius*.27)], fill='#fff3cf', width=max(1, round(radius*.05)))


def seal(draw, xy, r, color):
    x, y = xy
    draw.ellipse((x-r, y-r, x+r, y+r), fill=DARK[color], outline='#f4e0ae', width=max(1, int(r*.08)))
    gem(draw, xy, r*.68, color)


def texture(name, image):
    export_texture('splendor', name, image)
    path = SOURCE / 'textures' / (name + '.png')
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path)


def model(name, body):
    if body.get('parent','').startswith('card:item/splendor/base/'):
        # Runtime variants only contain their parent and texture overrides.
        # Blockbench needs the resolved geometry to remain directly editable.
        export_model('splendor',name,body,editable=False)
        export_blockbench('splendor',name,resolve_model(body))
        unique_editable_textures(name)
        return
    body.setdefault('credit', 'Fimel Cards Minecraft-themed card composition; Minecraft textures by Mojang')
    body.setdefault('gui_light', 'front')
    body.setdefault('display', GUI)
    export_model('splendor', name, body)
    if name.startswith('base/'):unique_editable_textures(name)


def unique_editable_textures(name):
    # Front/back can intentionally share a PNG, but Blockbench texture UUIDs
    # must remain distinct for the two material slots inside one project.
    path=SOURCE/'models'/(name+'.bbmodel')
    editable=json.loads(path.read_text(encoding='utf-8'))
    for index,entry in enumerate(editable['textures']):
        entry['uuid']=str(uuid.uuid5(uuid.NAMESPACE_URL,f'fimel:splendor:{name}:texture:{index}'))
    json_file(path,editable)


def plane_model(name, width=12, depth=16):
    if name.startswith(('tier','noble/','back/')):
        if not CARD_BASES:build_card_bases()
        textures=card_textures(name)
        model(name,{'parent':'card:item/splendor/base/table','textures':textures})
        hand_model(name)
        json_file(CARD/f'items/splendor/{name}.json', {
            'model': {'type': 'minecraft:select', 'property': 'minecraft:display_context',
                      'cases': [{'when': FIRST_PERSON+PUBLIC_HAND,
                                 'model': {'type': 'minecraft:model', 'model': 'card:item/splendor/hand/'+name}}],
                      'fallback': {'type': 'minecraft:model', 'model': 'card:item/splendor/'+name}}})
        return
    resource = 'card:item/splendor/' + name
    element = cube([8-width/2, 7.98, 8-depth/2], [8+width/2, 8.06, 8+depth/2], 'face', 'printed_card')
    element['faces'] = {'up': {'texture': '#face', 'uv': [0, 0, 16, 16]}}
    model(name, {'textures': {'face': resource, 'particle': resource}, 'elements': [element]})


def hand_model(name):
    model('hand/'+name,{'parent':'card:item/splendor/base/hand','textures':card_textures(name)})


def card_textures(name):
    front='card:item/splendor/'+name
    # Public noble cards have no secret reverse. Reserved development cards
    # still use the existing private item-definition selectors in every view.
    back=front
    if name.startswith('tier'):back='card:item/splendor/back/'+name.split('/')[0]
    return {'front':front,'back':back}


def resolve_model(body):
    parent=body.get('parent','')
    if not parent.startswith('card:item/splendor/'):
        return copy.deepcopy(body)
    relative=parent.removeprefix('card:item/splendor/')
    source=CARD_BASES.get(relative)
    if source is None:
        source=json.loads((CARD/f'models/item/splendor/{relative}.json').read_text(encoding='utf-8'))
    base=resolve_model(source)
    return {**base,**{k:v for k,v in body.items() if k not in ('parent','textures')},
            'textures':{**base.get('textures',{}),**body.get('textures',{})}}


def build_card_bases():
    texture('base/paper',Image.new('RGB',(16,16),PAPER))
    edge=Image.new('RGB',(16,16),'#d9c8a6')
    ImageDraw.Draw(edge).line((0,0,15,0),fill='#f5ead2',width=2)
    texture('base/edge',edge)
    poker = json.loads((CARD/'models/item/fake_card.json').read_text(encoding='utf-8'))
    for name,lo,hi,front,back,display in [
        ('table',[2,7.98,0],[14,8.06,16],'up','down',GUI),
        # Same pivot and handheld poses as poker; the new card is thinner and
        # its 12:16.5 proportions match the 256:352 printed face exactly.
        ('hand',[1,.75,8.4],[13,17.25,8.6],'north','south',poker['display'])]:
        element=cube(lo,hi,'edge','printed_card' if name=='table' else 'held_card')
        element['faces'][front]={'texture':'#front','uv':[0,0,16,16]}
        element['faces'][back]={'texture':'#back','uv':[0,0,16,16]}
        body={'credit':'Fimel Cards custom double-sided card geometry','gui_light':'front',
              'textures':{'front':'card:item/splendor/base/paper','back':'card:item/splendor/base/paper',
                          'edge':'card:item/splendor/base/edge','particle':'#front'},
              'elements':[element],'display':copy.deepcopy(display)}
        CARD_BASES['base/'+name]=body
        model('base/'+name,body)


def build_card_models():
    CARD_BASES.clear();build_card_bases()
    data=json.loads((PACK/'tools/splendor_cards.json').read_text(encoding='utf-8'))
    for card in data['cards']:plane_model(card['name'])
    for card in data['nobles']:plane_model('noble/'+card['name'])
    for tier in range(1,4):plane_model(f'back/tier{tier}')


def reserved_definition(card):
    front = 'card:item/splendor/'+card['name']
    back = f'card:item/splendor/back/tier{card["tier"]}'
    return {'model': {'type': 'minecraft:select', 'property': 'minecraft:display_context',
        'cases': [
            {'when': ['gui'], 'model': {'type': 'minecraft:model', 'model': front}},
            {'when': FIRST_PERSON, 'model': {'type': 'minecraft:model', 'model': 'card:item/splendor/hand/'+card['name']}},
            {'when': PUBLIC_HAND, 'model': {'type': 'minecraft:model', 'model': f'card:item/splendor/hand/back/tier{card["tier"]}'}},
        ], 'fallback': {'type': 'minecraft:model', 'model': back}}}


def block(image, color, box, dark=False):
    x, y, width, height = map(round, box)
    source = vanilla('block/'+ART_BLOCKS[color]).resize((32, 32), Image.Resampling.NEAREST)
    tile = Image.new('RGBA', (width, height))
    for ty in range(0, height, 32):
        for tx in range(0, width, 32):
            tile.paste(source, (tx, ty))
    image.alpha_composite(tile, (x, y))
    draw = ImageDraw.Draw(image)
    if dark:
        draw.rectangle((x, y, x+width-1, y+height-1), fill=(10, 18, 28, 95))
    draw.line((x, y+height-1, x+width-1, y+height-1, x+width-1, y), fill='#17212b', width=3)
    draw.line((x, y+height-2, x, y, x+width-2, y), fill=INKS[color], width=2)


def architecture(image, card):
    """原版像素物品与三类方块场景；相同牌面签名始终取相同画面。"""
    draw = ImageDraw.Draw(image)
    color = card['bonus']
    rank = _ART_RANKS.get(signature(card), int(hashlib.sha256(signature_text(card).encode()).hexdigest()[:8], 16)%18)
    variant, item = rank//6, ART_ITEMS[color][rank%6]
    draw.rectangle((14, 78, 241, 237), fill='#182733')
    rng = random.Random(signature_text(card))
    for _ in range(23):
        x, y = rng.randrange(23, 233), rng.randrange(87, 214)
        draw.rectangle((x, y, x+2, y+2), fill=INKS[color])
    if variant == 0:
        # 矿洞：不规则矿层与掉落物，工具依然保留原版像素轮廓。
        for box in ((15, 202, 227, 35), (15, 78, 32, 32), (47, 78, 32, 20),
                    (210, 78, 32, 62), (178, 78, 32, 27), (15, 171, 32, 32), (210, 184, 32, 25)):
            block(image, color, box)
        paste_sprite(image, 'item/'+item, (76, 100, 106, 102), outline=True)
    elif variant == 1:
        # 作坊：柱廊和工作台。
        for box in ((20, 94, 32, 143), (204, 94, 32, 143), (20, 78, 216, 24),
                    (59, 195, 138, 25), (72, 220, 25, 17), (159, 220, 25, 17)):
            block(image, color, box)
        paste_sprite(image, 'item/'+item, (79, 108, 99, 82), outline=True)
    else:
        # 遗迹：阶梯、方柱与上方的珍藏。
        for box in ((39, 213, 178, 24), (65, 190, 126, 24), (92, 167, 72, 24),
                    (19, 126, 24, 111), (213, 126, 24, 111)):
            block(image, color, box)
        paste_sprite(image, 'item/'+item, (83, 86, 90, 79), outline=True)
    # 层级只占一条小刻度，不与奖励宝石或费用争夺空间。
    draw = ImageDraw.Draw(image)
    for index in range(card['tier']):
        draw.rectangle((112+index*13-(card['tier']-1)*6, 225, 120+index*13-(card['tier']-1)*6, 230), fill='#ffe3a5')
    return {'item': item, 'scene': ('mine', 'workshop', 'ruins')[min(variant, 2)]}


def cost_row(image, values, y=273, development=False):
    draw = ImageDraw.Draw(image)
    costs = [(i, amount) for i, amount in enumerate(values) if amount]
    spacing = min(66 if development else 54, 220/max(1, len(costs)))
    start = 128-(len(costs)-1)*spacing/2
    for index, (color, amount) in enumerate(costs):
        x = start+index*spacing
        if development:
            # 贵族要求永久发展卡折扣：使用卡片轮廓，与支付筹码明确区分。
            draw.rounded_rectangle((x-23, y-25, x+23, y+25), radius=3, fill=INKS[color], outline=INK, width=2)
            draw.rectangle((x-18, y-20, x+18, y+19), fill='#f5eace')
            draw.rectangle((x-18, y+8, x+18, y+19), fill=DARK[color])
            gem_icon(image, color, (x, y-3), 29)
        else:
            gem_icon(image, color, (x, y), 36)
        draw = ImageDraw.Draw(image)
        draw.text((x, y+46), str(amount), font=font(34, True), anchor='mm', fill=INK)


def front(card):
    image = Image.new('RGBA', (256, 352), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((1, 1, 254, 350), radius=12, fill=PAPER, outline=DARK[card['bonus']], width=6)
    draw.rounded_rectangle((9, 9, 246, 342), radius=7, outline=INKS[card['bonus']], width=2)
    draw.text((38, 43), str(card['points']), font=font(55, True), anchor='mm', fill=INK)
    star(draw, (82, 44), 13)
    gem_icon(image, card['bonus'], (208, 42), 53)
    architecture(image, card)
    cost_row(image, card['cost'])
    return image


def noble(card):
    image = Image.new('RGBA', (256, 352), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((1, 1, 254, 350), radius=17, fill='#d9c49b', outline='#3e3240', width=4)
    draw.rounded_rectangle((10, 10, 245, 341), radius=12, fill=PAPER, outline=GOLD, width=3)
    draw.text((38, 42), '3', font=font(55, True), anchor='mm', fill=INK)
    star(draw, (82, 43), 13)
    # 贵族头冠图标，与发展牌右上角的宝石奖励区别。
    draw.polygon(((183, 33), (196, 44), (208, 26), (221, 44), (234, 33), (229, 57), (188, 57)), fill=GOLD, outline=INK)
    draw.rectangle((15, 78, 240, 234), fill='#253546')
    draw.rectangle((22, 85, 233, 227), outline=GOLD, width=2)
    portrait(image, card['id'])
    cost_row(image, card['cost'], y=271, development=True)
    return image


def portrait(image, index):
    layer = Image.new('RGBA', image.size, (0, 0, 0, 0))
    portrait_pixels(layer, index)
    art = layer.crop(layer.getbbox())
    scale = min(188/art.width, 132/art.height)
    art = art.resize((round(art.width*scale), round(art.height*scale)), Image.Resampling.NEAREST)
    image.alpha_composite(art, ((256-art.width)//2, 78+(156-art.height)//2))


def portrait_pixels(image, index):
    resource, uv, _ = MOBS[index%len(MOBS)]
    source = vanilla('entity/'+resource)
    face = source.crop(uv).resize((96, 100 if index in (0, 1, 2) else 84), Image.Resampling.NEAREST)
    draw = ImageDraw.Draw(image)
    # 脸部直接使用原版实体 UV，仅保留生物自身特征。
    if index == 8:
        # 海龟保持横向头部和龟壳轮廓，避免把展开 UV 拉成类人脸。
        draw.ellipse((60, 146, 196, 226), fill='#657943', outline='#8c9d60', width=6)
        for x in (84, 116, 148):
            draw.rectangle((x, 170, x+22, 195), outline='#91a564', width=3)
        face = source.crop(uv).resize((126, 43), Image.Resampling.NEAREST)
        image.alpha_composite(face, (65, 112))
        for x in (43, 181):
            draw.rectangle((x, 189, x+31, 218), fill='#5a9a56')
        return
    top = 90 if index in (0, 1, 2) else 99
    image.alpha_composite(face, (80, top))
    if index in (0, 1, 2):
        # 村民/流浪商人/铁傀儡的标志性鼻子。
        nose = source.crop((26, 2, 28, 6)).resize((18, 34), Image.Resampling.NEAREST)
        image.alpha_composite(nose, (119, top+56))
    draw = ImageDraw.Draw(image)
    if index == 4:
        draw.polygon(((68, 175), (39, 142), (45, 205), (77, 201)), fill='#99f0f0')
        draw.polygon(((188, 175), (217, 142), (211, 205), (179, 201)), fill='#99f0f0')
    elif index == 5:
        draw.ellipse((42, 101, 91, 141), fill='#dae9ed')
        draw.ellipse((165, 101, 214, 141), fill='#dae9ed')
        for x in (94, 150):
            draw.rectangle((x, 88, x+7, 108), fill='#362d28')
    elif index == 6:
        draw.rectangle((80, 84, 102, 105), fill='#d78b36')
        draw.rectangle((154, 84, 176, 105), fill='#d78b36')
    elif index == 7:
        for x in (65, 181):
            for y in (107, 125, 143):
                draw.rectangle((x, y, x+10, y+11), fill='#d773a4')
    elif index == 9:
        draw.rectangle((108, 147, 147, 171), fill='#d47d8b')
        for x in (114, 136):
            draw.rectangle((x, 154, x+5, 163), fill='#914e60')


def back(tier):
    image = Image.new('RGBA', (256, 352), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    bg = ('#365a4b', '#a17b3d', '#3f4472')[tier-1]
    draw.rounded_rectangle((1, 1, 254, 350), radius=17, fill=bg, outline='#d4b57b', width=5)
    draw.rounded_rectangle((12, 12, 243, 339), radius=11, outline='#dcc796', width=2)
    for y in range(32, 325, 28):
        for x in range(32, 230, 28):
            draw.polygon([(x, y-4), (x+4, y), (x, y+4), (x-4, y)], fill='#bfa777')
    draw.ellipse((48, 96, 207, 255), fill='#332f44', outline=GOLD, width=5)
    gem_icon(image, 5, (128, 158), 86)
    draw.text((128, 222), 'I'*tier, anchor='mm', font=font(30, True), fill=PAPER)
    return image


def build():
    data = json.loads((PACK/'tools/splendor_cards.json').read_text(encoding='utf-8'))
    canonical = {}
    for card in data['cards']:
        canonical.setdefault(signature(card), card)
    _ART_RANKS.clear()
    for color in range(5):
        for rank, key in enumerate(sorted(key for key in canonical if key[0] == color)):
            _ART_RANKS[key] = rank
    previews = []
    glyphs = []
    for card in data['cards']:
        identity = canonical[signature(card)]
        image = front(identity)
        texture(card['name'], image)
        plane_model(card['name'])
        # 本人 GUI/第一人称可看预定牌；其他展示上下文统一显示牌背。
        # fixed/head 等也走牌背，防止展示框和其他穿戴方式泄露盲预定。
        json_file(CARD/f'items/splendor/reserved/{card["name"]}.json', reserved_definition(identity))
        glyphs.append((0xe900+card['id'], card['name'], image))
        if card['id'] in (0, 40, 70):
            previews.append(image)
    for card in data['nobles']:
        image = noble(card)
        texture('noble/'+card['name'], image)
        plane_model('noble/'+card['name'])
        glyphs.append((0xea00+card['id'], 'noble/'+card['name'], image))
    for tier in range(1, 4):
        image = back(tier)
        texture(f'back/tier{tier}', image)
        plane_model(f'back/tier{tier}')
        glyphs.append((0xe98f+tier, f'back/tier{tier}', image))
    for color, name in enumerate(COLORS):
        image = Image.new('RGBA', (128, 128), (0, 0, 0, 0))
        draw = ImageDraw.Draw(image)
        draw.ellipse((2, 2, 125, 125), fill=DARK[color], outline='#f5dd9a', width=4)
        draw.ellipse((10, 10, 117, 117), fill=INKS[color], outline='#392e38', width=3)
        seal(draw, (64, 64), 43, color)
        for angle in range(0, 360, 45):
            x, y = 64+57*math.cos(math.radians(angle)), 64+57*math.sin(math.radians(angle))
            draw.ellipse((x-3, y-3, x+3, y+3), fill=PAPER)
        texture('token/'+name, image)
        edge = Image.new('RGB', (16, 16), DARK[color])
        texture('edge/'+name, edge)
        body = disc('card:item/splendor/token/'+name, 'card:item/splendor/edge/'+name, .85, 12)
        for element in body['elements']:
            element['from'][1] += 8
            element['to'][1] += 8
        model('token/'+name, body)
        # 桌面银行由原版物品展示；HUD 也使用同一物品轮廓，颜色与费用区一致。
        icon = Image.new('RGBA', (64, 64))
        paste_sprite(icon, 'item/'+TOKEN_ITEMS[color], (2, 2, 60, 60))
        glyphs.append((0xe980+color, 'token/'+name, icon))
    # 木框深蓝桌垫仅用一个展示实体，不给每个牌槽添加交互实体。
    image = Image.new('RGBA', (768, 768), '#44383b')
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((8, 8, 759, 759), radius=30, fill='#2e3946', outline=GOLD, width=7)
    draw.rounded_rectangle((21, 21, 746, 746), radius=24, outline='#6b7181', width=2)
    for row in range(3):
        y = 208+row*166
        for col in range(4):
            x = 204+col*120
            draw.rounded_rectangle((x-47, y-58, x+47, y+58), radius=6, outline='#586372', width=2)
        draw.text((81, y), 'I'*(3-row), font=font(32, True), anchor='mm', fill=GOLD)
    draw.text((384, 52), 'SPLENDOR', anchor='mm', font=font(27, True), fill='#d5be8d')
    texture('mat', image)
    plane_model('mat', 16, 16)
    # 道具为真正立体宝石袋；持有时收小，GUI 保持辨识度。
    bag = Image.new('RGB', (32, 32), '#876d9b')
    draw = ImageDraw.Draw(bag)
    for y in range(0, 32, 4):
        draw.line((0, y, 31, y), fill='#795d90')
    texture('bag_cloth', bag)
    texture('bag_rope', Image.new('RGB', (16, 16), GOLD))
    bag_model = {'textures': {'cloth': 'card:item/splendor/bag_cloth', 'rope': 'card:item/splendor/bag_rope',
                             'gem': 'card:item/splendor/token/gold', 'particle': 'card:item/splendor/bag_cloth'},
                 'elements': [cube([3, 2, 4], [13, 10, 12], 'cloth', 'bag'),
                              cube([4, 10, 5], [12, 12, 11], 'cloth', 'neck'),
                              cube([3.5, 9.5, 4.5], [12.5, 10.6, 11.5], 'rope', 'drawstring')],
                 'display': {'gui': {'rotation': [20, 35, 0], 'scale': [1, 1, 1]},
                             'firstperson_righthand': {'rotation': [0, 35, 0], 'scale': [.45, .45, .45]},
                             'firstperson_lefthand': {'rotation': [0, -35, 0], 'scale': [.45, .45, .45]},
                             'thirdperson_righthand': {'scale': [.45, .45, .45]}}}
    model('bag', bag_model)
    image = Image.new('RGBA', (128, 128), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((21, 37, 107, 118), radius=23, fill='#876d9b', outline=GOLD, width=4)
    draw.polygon([(32, 38), (24, 13), (104, 13), (96, 38)], fill='#876d9b', outline=GOLD, width=3)
    draw.line((26, 39, 103, 39), fill=GOLD, width=8)
    gem(draw, (64, 79), 26, 5)
    texture('bag', image)
    glyphs.append((0xe986, 'bag', image))
    # 选游、物品与小字形共用完整矢量图标，不再放大小型资源宝石示意图。
    from build_splendor_icon import build as build_icon
    icon = build_icon(refresh_preview=False)
    texture('icon', icon)
    model('icon', {'parent': 'minecraft:item/generated', 'textures': {'layer0': 'card:item/splendor/icon'}, 'display': {}})
    glyphs.append((0xe987, 'icon', icon))
    star = Image.new('RGBA', (64, 64), (0, 0, 0, 0))
    draw = ImageDraw.Draw(star)
    points = [(32+(28 if i%2 == 0 else 13)*math.sin(i*math.pi/5),
               32-(28 if i%2 == 0 else 13)*math.cos(i*math.pi/5)) for i in range(10)]
    draw.polygon(points, fill='#e7c274', outline='#8f6730', width=2)
    texture('points', star)
    glyphs.append((0xe993, 'points', star))
    for variant, card_height, icon_height in (('', 48, 16), ('small', 28, 10), ('cards', 62, 20)):
        providers = []
        for code, name, bitmap in glyphs:
            dest = CARD / ('textures/font/splendor/'+name+'.png')
            dest.parent.mkdir(parents=True, exist_ok=True)
            is_card = name.startswith(('tier', 'noble/', 'back/'))
            image = bitmap.resize((96, 132) if is_card else (64, 64), Image.Resampling.LANCZOS)
            image.save(dest)
            height = card_height if is_card else icon_height
            providers.append({'type': 'bitmap', 'file': 'card:font/splendor/'+name+'.png',
                              'height': height, 'ascent': height-3 if is_card else height-2,
                              'chars': [chr(code)]})
        json_file(CARD/('font/splendor'+('/'+variant if variant else '')+'.json'), {'providers': providers})
    json_file(SOURCE/'resource_map.json', {'cards': [{'id': c['id'], 'model': 'card:splendor/'+c['name'],
        'glyph': f'U+{0xe900+c["id"]:04X}', 'signature': signature_text(c),
        'canonical_id': canonical[signature(c)]['id'], 'canonical_model': 'card:splendor/'+canonical[signature(c)]['name'],
        'reserved_model': 'card:splendor/reserved/'+canonical[signature(c)]['name'],
        'art': {'item': ART_ITEMS[c['bonus']][_ART_RANKS[signature(c)]%6],
                'scene': ('mine', 'workshop', 'ruins')[_ART_RANKS[signature(c)]//6]}} for c in data['cards']],
        'nobles': [{'id': c['id'], 'model': 'card:splendor/noble/'+c['name'], 'glyph': f'U+{0xea00+c["id"]:04X}',
                   'mob': MOBS[c['id']%10][0], 'mob_name': MOBS[c['id']%10][2], 'requirement': 'development_cards'} for c in data['nobles']],
        'tokens': [{'color': i, 'name': n, 'model': 'card:splendor/token/'+n, 'vanilla_item': 'minecraft:'+TOKEN_ITEMS[i],
                    'glyph': f'U+{0xe980+i:04X}'} for i, n in enumerate(COLORS)]})
    previews = [front(data['cards'][i]) for i in (0, 8, 16, 24, 32, 40, 46, 52, 58, 64, 70, 74, 78, 82, 86)]
    previews += [noble(c) for c in data['nobles']]
    sheet = Image.new('RGB', (256*5, 352*5), '#e8ddc3')
    for index, image in enumerate(previews):
        sheet.paste(image, ((index%5)*256, (index//5)*352), image)
    sheet.save(SOURCE/'preview.png')
    json_file(VANILLA/'manifest.json', {'source': 'Local Minecraft 26.2 client jar', 'owner': 'Mojang / Microsoft',
        'purpose': 'Minecraft resource-pack card composition, with pixel art kept at nearest-neighbor scale',
        'files': {p.relative_to(VANILLA).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
                  for p in sorted(VANILLA.rglob('*.png'))}})
    text_file(SOURCE/'README.md', '''# 璀璨宝石 Minecraft 主题资源

发展牌、贵族牌、桌垫与宝石袋使用 Fimel Cards 自行设计的版式，不复刻璀璨宝石原作插画。
宝石、材料、方块与生物脸部来自本机 Minecraft 26.2 客户端；权利归 Mojang / Microsoft，参与合成的原版源图保留在 vanilla/，SHA-256 见 vanilla/manifest.json。
重建优先复用 vanilla/，源图缺失时才从本机版本 jar 提取。源图只供此 Minecraft 资源包合成使用，不宣称原创或 CC0。
牌面数值来自数据包 tools/splendor_cards.json，数值引用见该文件 sources。
发展牌顶部左侧大数字与星标为分数，右侧原版宝石为永久折扣；底部原版宝石和大数字为支付花费。中部为矿洞、作坊、遗迹三类方块场景与对应颜色的材料，共 90 种牌面。
贵族使用村民、流浪商人、铁傀儡、雪傀儡、悦灵、蜜蜂、狐狸、美西螈、海龟和猪；下方要求采用发展卡轮廓，表示需要永久折扣而非支付宝石。
牌面 canonical signature 为 bonus:points:cost；相同奖励、分数、花费使用同一 canonical_id/model 和同一纹理。物品组件也应只携带这种牌的身份，不携带取得时间或牌槽，才能叠加。
预定牌物品入口位于 card:splendor/reserved/层级/牌名；本人 GUI 与第一人称显示正面，第三人称、掉落、展示框及其他上下文统一显示对应层牌背，避免暴露盲预定身份。
所有发展卡、贵族卡与牌背分别复用 `base/table`、`base/hand` 两份自定义父模型，不依赖原版生成物品父类。模型都有正反面与独立纸边，手持牌采用与 poker 一致的姿态及中心，牌面比例为 256:352；子模型仅覆盖纹理，Blockbench 源文件保留展开后的完整几何。执行 `python tools/build_splendor_assets.py --models-only --check` 可只重建这部分。
以 tier1/diamond_01 等“层级／宝石／同组序号”命名；源模型位于 models/*.bbmodel，可在 Blockbench 编辑。
纹理源位于 textures/，预览见 preview.png；所有源文件可由数据包 tools/build_splendor_assets.py 重建。
选游图标以 Minecraft 原版像素钻石、六色物品宝石和发展卡构图，保留双语铭牌。
数据包 tools/splendor_icon.svg 为可编辑布局模板，build_splendor_icon.py 将缓存的原版物品像素展开为独立 SVG 色块；
源 icon.svg（1024×1024）无外部图片依赖，导出 icon.png（256×256），仅更新22号图标与其字体切片。
首次渲染使用本机 Edge/Chromium，可设置 SPLENDOR_SVG_BROWSER 指定；未修改SVG时直接复用已提交PNG，无需浏览器。

字体 card:splendor 提供 E900～E959 发展牌、E980～E985 钻石/青金石/绿宝石/红石/煤炭/金锭图标、E986 宝石袋、E987 游戏图标、E990～E992 三层牌背、E993 分数星、EA00～EA09 贵族。
card:splendor/small 使用较小字形，card:splendor/cards 使用较大牌面；单字形切片最多 96×132，不超过 26.2 客户端 256×256 限制。

音频来源、许可和重建说明见 audio/README.md；桌面只展示公开市场、银行与贵族，不展示预约牌身份。
''')


def check():
    """检查真实纹理、物品入口、可编辑嵌入图和 26.2 字形上传尺寸。"""
    import hashlib
    data = json.loads((PACK/'tools/splendor_cards.json').read_text(encoding='utf-8'))
    mapping = json.loads((SOURCE/'resource_map.json').read_text(encoding='utf-8'))
    assert len(mapping['cards']) == 90 and len(mapping['nobles']) == 10 and len(mapping['tokens']) == 6
    seen = {}
    for card, entry in zip(data['cards'], mapping['cards']):
        assert entry['signature'] == signature_text(card)
        assert entry['canonical_model'] == 'card:splendor/'+data['cards'][entry['canonical_id']]['name']
        png = (CARD/'textures/item/splendor'/f'{card["name"]}.png').read_bytes()
        key = signature(card)
        if key in seen:
            assert seen[key] == png, (key, 'identical card properties must share the same face')
        seen[key] = png
        reserved = json.loads((CARD/f'items/splendor/reserved/{card["name"]}.json').read_text(encoding='utf-8'))['model']
        assert reserved['type'] == 'minecraft:select' and reserved['property'] == 'minecraft:display_context'
        canonical_card = data['cards'][entry['canonical_id']]
        assert reserved == reserved_definition(canonical_card)['model']
        assert entry['reserved_model'] == 'card:splendor/reserved/'+canonical_card['name']
    assert len({hashlib.sha256(png).digest() for png in seen.values()}) == len(seen), 'different cards accidentally have identical faces'
    for entry in mapping['nobles']:
        assert entry['requirement'] == 'development_cards'
    vanilla_manifest = json.loads((VANILLA/'manifest.json').read_text(encoding='utf-8'))
    for name, digest in vanilla_manifest['files'].items():
        assert hashlib.sha256((VANILLA/name).read_bytes()).hexdigest() == digest
    required = {c['name'] for c in data['cards']} | {'noble/'+c['name'] for c in data['nobles']}
    models = list((CARD/'models/item/splendor').rglob('*.json'))
    assert required <= {p.relative_to(CARD/'models/item/splendor').with_suffix('').as_posix() for p in models}
    for path in models:
        raw_body = json.loads(path.read_text(encoding='utf-8'))
        body = resolve_model(raw_body)
        name = path.relative_to(CARD/'models/item/splendor')
        item = json.loads((CARD/'items/splendor'/name).read_text(encoding='utf-8'))
        if name.as_posix().startswith(('tier', 'noble/', 'back/')):
            assert item['model']['fallback']['model'] == 'card:item/splendor/'+name.with_suffix('').as_posix()
            assert item['model']['cases'] == [{'when': FIRST_PERSON+PUBLIC_HAND, 'model': {'type': 'minecraft:model', 'model': 'card:item/splendor/hand/'+name.with_suffix('').as_posix()}}]
        else:
            assert item['model']['model'] == 'card:item/splendor/'+name.with_suffix('').as_posix()
        if name.as_posix().startswith('hand/'):
            poker = json.loads((CARD/'models/item/fake_card.json').read_text(encoding='utf-8'))
            assert body['display'] == poker['display'], (name, 'handheld pose differs from poker')
            assert body['elements'][0]['from'] == [1,.75,8.4] and body['elements'][0]['to'] == [13,17.25,8.6]
            assert set(body['elements'][0]['faces']) == {'up', 'down', 'north', 'south', 'east', 'west'}
            assert body['elements'][0]['faces']['north']['texture']=='#front'
            assert body['elements'][0]['faces']['south']=={'texture':'#back','uv':[0,0,16,16]}
        if name.as_posix().startswith(('hand/','tier','noble/','back/')):
            assert raw_body['parent'] in ('card:item/splendor/base/hand','card:item/splendor/base/table')
            assert set(raw_body)=={'parent','textures'},(name,'card variants must reuse shared geometry and poses')
            assert 'parent' not in body,(name,'card base must be self contained')
        editable = json.loads((SOURCE/'models'/name.with_suffix('.bbmodel')).read_text(encoding='utf-8'))
        assert len(editable['elements']) == len(body.get('elements', []))
        index = 0
        for key, reference in body.get('textures', {}).items():
            if reference.startswith('#'):
                continue
            namespace, location = reference.split(':')
            texture_path = RP/f'assets/{namespace}/textures/{location}.png'
            assert texture_path.is_file(), (path, reference)
            if key != 'particle':
                embedded = base64.b64decode(editable['textures'][index]['source'].split(',', 1)[1])
                assert embedded == texture_path.read_bytes(), (path, key, 'editable texture differs')
                index += 1
        assert len(editable['textures']) == index
        assert len({entry['uuid'] for entry in editable['textures']}) == len(editable['textures'])
        for element in body.get('elements', []):
            assert all(-16 <= v <= 32 for v in element['from']+element['to'])
            for face in element['faces'].values():
                assert face['texture'][1:] in body['textures']
                assert all(0 <= v <= 16 for v in face.get('uv', []))
    for font_path in (CARD/'font/splendor.json', CARD/'font/splendor/small.json', CARD/'font/splendor/cards.json'):
        glyphs = set()
        for provider in json.loads(font_path.read_text(encoding='utf-8'))['providers']:
            namespace, location = provider['file'].split(':')
            with Image.open(RP/f'assets/{namespace}/textures/{location}') as image:
                chars = provider['chars']
                assert len({len(row) for row in chars}) == 1
                assert image.width % len(chars[0]) == image.height % len(chars) == 0
                assert image.width/len(chars[0]) <= 256 and image.height/len(chars) <= 256
                assert image.getbbox() is not None
            for row in chars:
                for char in row:
                    assert char not in glyphs, (font_path, hex(ord(char)))
                    glyphs.add(char)
        assert len(glyphs) == 112
        assert all(chr(0xe900+c['id']) in glyphs for c in data['cards'])
        assert all(chr(0xea00+c['id']) in glyphs for c in data['nobles'])
    sound_path = RP/'assets/splendor/sounds.json'
    if sound_path.is_file():
        audio = json.loads((SOURCE/'audio/manifest.json').read_text(encoding='utf-8'))
        assert audio['license'] == 'CC0-1.0'
        for event, definition in json.loads(sound_path.read_text(encoding='utf-8')).items():
            assert len(definition['sounds']) == 1
            namespace, location = definition['sounds'][0]['name'].split(':')
            path = RP/f'assets/{namespace}/sounds/{location}.ogg'
            assert hashlib.sha256(path.read_bytes()).hexdigest() == audio['references'][event]['sha256']
    assert len(list((CARD/'items/splendor/reserved').rglob('*.json'))) == 90
    print(f'Splendor assets: {len(models)} models/items/editable sources, 90 canonical card faces, 90 private reserved selectors, 10 Minecraft mobs, '
          f'{len(vanilla_manifest["files"])} cached vanilla textures, 3 fonts x 112 glyphs, references verified')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='重建后校验模型、源文件、纹理、图片字体及音频引用')
    parser.add_argument('--models-only',action='store_true',help='只重建卡牌共用父模型、子模型和可编辑源文件')
    args = parser.parse_args()
    if args.models_only:build_card_models()
    else:build()
    if args.check:
        check()
