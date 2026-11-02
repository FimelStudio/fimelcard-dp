"""璀璨宝石：原创几何宝石、开发牌与低实体桌面资源。"""
from __future__ import annotations

import json
import argparse
import base64
import math
import random
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import PACK, RP, CARD, cube, disc, export_model, export_texture, json_file, text_file

SOURCE = RP / '.source/splendor'
COLORS = ('diamond', 'sapphire', 'emerald', 'ruby', 'onyx', 'gold')
INKS = ('#e6edf2', '#407bc5', '#439d77', '#ca5361', '#535062', '#e3b94d')
DARK = ('#698492', '#224a85', '#23654d', '#8e283c', '#292435', '#a47426')
PAPER, INK, GOLD = '#f1e5c9', '#352f39', '#c8a267'
GUI = {'gui': {'rotation': [90, 0, 0], 'translation': [0, 0, 0], 'scale': [0.9, 0.9, 0.9]},
       'fixed': {'rotation': [90, 0, 0], 'translation': [0, 0, 0], 'scale': [0.9, 0.9, 0.9]}}


def font(size, bold=False):
    return ImageFont.truetype('C:/Windows/Fonts/' + ('georgiab.ttf' if bold else 'georgia.ttf'), size)


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
    body.setdefault('credit', 'Fimel Cards original geometric gemstone artwork and models')
    body.setdefault('gui_light', 'front')
    body.setdefault('display', GUI)
    export_model('splendor', name, body)


def plane_model(name, width=12, depth=16):
    resource = 'card:item/splendor/' + name
    element = cube([8-width/2, 7.98, 8-depth/2], [8+width/2, 8.06, 8+depth/2], 'face', 'printed_card')
    element['faces'] = {'up': {'texture': '#face', 'uv': [0, 0, 16, 16]}}
    model(name, {'textures': {'face': resource, 'particle': resource}, 'elements': [element]})


def architecture(draw, tier, color, seed):
    """同一版式中的原创矿场、作坊与宫殿剪影，避免复刻官方插画。"""
    rng = random.Random(seed)
    draw.rounded_rectangle((15, 78, 240, 239), radius=8, fill=DARK[color])
    for i in range(13):
        x, y = rng.randrange(23, 232), rng.randrange(88, 230)
        draw.ellipse((x, y, x+2, y+2), fill=INKS[color])
    if tier == 1:
        for x, y, size in ((60, 182, 32), (126, 157, 47), (197, 185, 30)):
            gem(draw, (x, y), size, color)
        draw.line((35, 217, 222, 217), fill=GOLD, width=3)
    elif tier == 2:
        for x, h in ((40, 64), (92, 102), (146, 77), (196, 117)):
            draw.rectangle((x, 227-h, x+21, 227), fill=PAPER)
            draw.polygon([(x-3, 227-h), (x+10, 207-h), (x+24, 227-h)], fill=GOLD)
        gem(draw, (128, 145), 27, color)
    else:
        draw.rectangle((39, 169, 216, 228), fill=PAPER)
        for x in (46, 87, 128, 169, 210):
            draw.rectangle((x-5, 125, x+5, 225), fill=GOLD)
        draw.polygon([(31, 165), (127, 93), (223, 165)], fill=PAPER)
        draw.line((31, 165, 127, 93, 223, 165), fill=GOLD, width=5)
        gem(draw, (127, 137), 21, color)


def cost_row(draw, values, y=288):
    costs = [(i, amount) for i, amount in enumerate(values) if amount]
    spacing = 45
    start = 128-(len(costs)-1)*spacing/2
    for index, (color, amount) in enumerate(costs):
        x = start+index*spacing
        seal(draw, (x, y-13), 16, color)
        draw.text((x, y+21), str(amount), font=font(26, True), anchor='mm', fill=INK)


def front(card):
    image = Image.new('RGBA', (256, 352), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((1, 1, 254, 350), radius=17, fill=PAPER, outline='#332e39', width=4)
    draw.rounded_rectangle((9, 9, 246, 342), radius=12, outline=GOLD, width=2)
    draw.text((33, 42), str(card['points']), font=font(46, True), anchor='mm', fill=INK)
    draw.text((83, 42), 'VP', font=font(14, True), anchor='mm', fill='#776a57')
    seal(draw, (207, 41), 28, card['bonus'])
    architecture(draw, card['tier'], card['bonus'], card['id']+2200)
    draw.text((128, 255), 'I'*card['tier'], font=font(17, True), anchor='mm', fill='#8a7248')
    cost_row(draw, card['cost'])
    return image


def noble(card):
    image = Image.new('RGBA', (256, 352), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((1, 1, 254, 350), radius=17, fill='#d9c49b', outline='#3e3240', width=4)
    draw.rounded_rectangle((10, 10, 245, 341), radius=12, fill=PAPER, outline=GOLD, width=3)
    draw.text((36, 40), '3', font=font(46, True), anchor='mm', fill=INK)
    draw.text((85, 40), 'VP', font=font(14, True), anchor='mm', fill='#776a57')
    draw.text((128, 83), 'NOBLE', font=font(22, True), anchor='mm', fill=INK)
    draw.polygon([(65, 118), (191, 118), (191, 193), (128, 232), (65, 193)], fill='#423f60', outline=GOLD, width=4)
    draw.polygon([(81, 143), (99, 165), (128, 132), (157, 165), (175, 143), (164, 191), (92, 191)], fill=GOLD)
    draw.rectangle((92, 197, 165, 206), fill=GOLD)
    cost_row(draw, card['cost'])
    return image


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
    gem(draw, (128, 160), 47, 5)
    draw.text((128, 222), 'I'*tier, anchor='mm', font=font(30, True), fill=PAPER)
    return image


def build():
    data = json.loads((PACK/'tools/splendor_cards.json').read_text(encoding='utf-8'))
    previews = []
    glyphs = []
    for card in data['cards']:
        image = front(card)
        texture(card['name'], image)
        plane_model(card['name'])
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
        glyphs.append((0xe980+color, 'token/'+name, image))
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
    icon = build_icon()
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
        'glyph': f'U+{0xe900+c["id"]:04X}'} for c in data['cards']],
        'nobles': [{'id': c['id'], 'model': 'card:splendor/noble/'+c['name'], 'glyph': f'U+{0xea00+c["id"]:04X}'} for c in data['nobles']],
        'tokens': [{'color': i, 'name': n, 'model': 'card:splendor/token/'+n, 'glyph': f'U+{0xe980+i:04X}'} for i, n in enumerate(COLORS)]})
    sheet = Image.new('RGB', (256*4, 352), '#e8ddc3')
    for index, image in enumerate(previews+[noble(data['nobles'][0])]):
        sheet.paste(image, (index*256, 0), image)
    sheet.save(SOURCE/'preview.png')
    text_file(SOURCE/'README.md', '''# 璀璨宝石原创资源

宝石、筹码、开发牌、贵族徽章、桌垫与宝石袋均为 Fimel Cards 原创程序绘制，不复用原版游戏插画、卡面或商标图。
牌面数值来自数据包 tools/splendor_cards.json，数值引用见该文件 sources。
以 tier1/diamond_01 等“层级／宝石／同组序号”命名；源模型位于 models/*.bbmodel，可在 Blockbench 编辑。
纹理源位于 textures/，预览见 preview.png；所有源文件可由数据包 tools/build_splendor_assets.py 重建。
选游图标原画为 icon.svg（1024×1024），导出 icon.png（256×256），完整保留双语铭牌；
数据包 tools/build_splendor_icon.py 可单独重建，仅处理22号图标，不覆盖其他游戏。
首次渲染使用本机 Edge/Chromium，可设置 SPLENDOR_SVG_BROWSER 指定；未修改SVG时直接复用已提交PNG，无需浏览器。

字体 card:splendor 提供 E900～E959 开发牌、E980～E985 白蓝绿红黑金筹码、E986 宝石袋、E987 游戏图标、E990～E992 三层牌背、E993 分数星、EA00～EA09 贵族。
card:splendor/small 使用较小字形，card:splendor/cards 使用较大牌面；单字形切片最多 96×132，不超过 26.2 客户端 256×256 限制。

音频来源、许可和重建说明见 audio/README.md；桌面只展示公开市场、银行与贵族，不展示预约牌身份。
''')


def check():
    """检查真实纹理、物品入口、可编辑嵌入图和 26.2 字形上传尺寸。"""
    import hashlib
    data = json.loads((PACK/'tools/splendor_cards.json').read_text(encoding='utf-8'))
    mapping = json.loads((SOURCE/'resource_map.json').read_text(encoding='utf-8'))
    assert len(mapping['cards']) == 90 and len(mapping['nobles']) == 10 and len(mapping['tokens']) == 6
    required = {c['name'] for c in data['cards']} | {'noble/'+c['name'] for c in data['nobles']}
    models = list((CARD/'models/item/splendor').rglob('*.json'))
    assert required <= {p.relative_to(CARD/'models/item/splendor').with_suffix('').as_posix() for p in models}
    for path in models:
        body = json.loads(path.read_text(encoding='utf-8'))
        name = path.relative_to(CARD/'models/item/splendor')
        item = json.loads((CARD/'items/splendor'/name).read_text(encoding='utf-8'))
        assert item['model']['model'] == 'card:item/splendor/'+name.with_suffix('').as_posix()
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
    print(f'Splendor assets: {len(models)} models/items/editable sources, 3 fonts x 112 glyphs, references verified')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true', help='重建后校验模型、源文件、纹理、图片字体及音频引用')
    args = parser.parse_args()
    build()
    if args.check:
        check()
