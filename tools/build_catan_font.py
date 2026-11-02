"""独立卡坦岛 Dialog 图片字体；不改动公共卡牌字体或物品牌面。

先运行 build_catan_visual.py 生成资源牌，再执行本脚本和 build_catan_ui.py。
资源图案沿用资源牌；开发牌标记为本项目原创像素图形，保留独立源清单。
"""
from pathlib import Path
import hashlib
import json
from PIL import Image, ImageDraw
from boardgame_assets import RP

RESOURCE_NAMES = ('wood', 'brick', 'wool', 'grain', 'ore')
DEVELOPMENT_NAMES = ('knight', 'road_building', 'monopoly', 'year_of_plenty', 'victory_point')
FONT_ID = 'card:catan'
RESOURCE_GLYPHS = [chr(0xEA00 + i) for i in range(5)]
DEVELOPMENT_GLYPHS = [chr(0xEA10 + i) for i in range(5)]


def development_icon(name):
    image = Image.new('RGBA', (32, 32), (0, 0, 0, 0))
    d = ImageDraw.Draw(image)
    paper, dark, gold, blue = '#f1e5c6', '#43554e', '#deb75e', '#357582'
    d.rounded_rectangle((1, 1, 30, 30), radius=3, fill=paper, outline=dark, width=2)
    if name == 'knight':
        d.polygon([(7, 6), (24, 6), (23, 20), (16, 27), (8, 20)], fill=blue)
        d.rectangle((14, 8, 17, 23), fill=gold)
        d.rectangle((10, 13, 21, 16), fill=gold)
    elif name == 'road_building':
        d.line([(7, 25), (12, 16), (23, 7)], fill=dark, width=9)
        d.line([(12, 17), (24, 24)], fill=dark, width=9)
        for box in [(7, 21, 10, 24), (11, 15, 14, 18), (17, 10, 20, 13), (20, 20, 23, 23)]:
            d.rectangle(box, fill=gold)
    elif name == 'monopoly':
        for box in [(5, 7, 11, 13), (21, 7, 27, 13), (5, 21, 11, 27), (21, 21, 27, 27)]:
            d.rectangle(box, fill=blue)
        d.polygon([(15, 7), (18, 7), (18, 13), (24, 13), (24, 18), (18, 18), (18, 25), (14, 25), (14, 18), (8, 18), (8, 14), (14, 14)], fill=dark)
        d.rectangle((13, 12, 19, 20), fill=gold)
    elif name == 'year_of_plenty':
        for center in (10, 21):
            d.line([(center, 8), (center, 24)], fill=dark, width=2)
            for y in (8, 13, 18):
                d.polygon([(center, y + 4), (center - 5, y), (center - 5, y - 3), (center, y)], fill=gold)
                d.polygon([(center, y + 4), (center + 5, y), (center + 5, y - 3), (center, y)], fill=gold)
    elif name == 'victory_point':
        d.polygon([(16, 5), (19, 12), (27, 13), (21, 19), (22, 27), (16, 23), (9, 27), (11, 19), (5, 13), (13, 12)], fill=gold, outline=dark)
    return image


def build(rp=RP):
    root = Path(rp)
    texture = root / 'assets/card/textures/font/catan'
    texture.mkdir(parents=True, exist_ok=True)
    sources, providers = {}, []
    for name, glyph in zip(RESOURCE_NAMES, RESOURCE_GLYPHS):
        source = root / 'assets/card/textures/item/catan/resource' / (name + '.png')
        image = Image.open(source).convert('RGBA').resize((32, 32), Image.Resampling.NEAREST)
        image.save(texture / (name + '.png'))
        sources[name] = {'source': source.relative_to(root).as_posix(), 'sha256': hashlib.sha256(source.read_bytes()).hexdigest()}
        providers.append({'type': 'bitmap', 'file': 'card:font/catan/' + name + '.png', 'ascent': 12, 'height': 14, 'chars': [glyph]})
    for name, glyph in zip(DEVELOPMENT_NAMES, DEVELOPMENT_GLYPHS):
        development_icon(name).save(texture / (name + '.png'))
        providers.append({'type': 'bitmap', 'file': 'card:font/catan/' + name + '.png', 'ascent': 12, 'height': 14, 'chars': [glyph]})
    font = root / 'assets/card/font/catan.json'
    font.parent.mkdir(parents=True, exist_ok=True)
    font.write_text(json.dumps({'providers': providers}, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    source_dir = root / '.source/catan/font'
    source_dir.mkdir(parents=True, exist_ok=True)
    (source_dir / 'manifest.json').write_text(json.dumps({'font': FONT_ID, 'source_generator': 'fimel_cards/tools/build_catan_font.py',
        'rebuild': ['python tools/build_catan_visual.py', 'python tools/build_catan_font.py', 'python tools/build_catan_ui.py'],
        'resources': sources, 'development_icons': 'Fimel Cards 原创像素图形；不含商业 CATAN 图稿',
        'glyphs': dict(zip(RESOURCE_NAMES + DEVELOPMENT_NAMES, RESOURCE_GLYPHS + DEVELOPMENT_GLYPHS)),
        'display': {'height': 14, 'ascent': 12, 'slice_pixels': [32, 32], 'text_color': 'white', 'line_spacing': '多行文本使用空行，防止高于默认文字的图标重叠'}}, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    (source_dir / 'README.md').write_text('''# 卡坦岛对话框图片字体

字体为 `card:catan`，仅用于卡坦岛 Dialog 内的资源及开发牌图标，不修改其他游戏字体。
木材、砖块、羊毛、粮食、矿石复用本资源包现有资源牌图案；五种开发牌图标由 Fimel Cards 原创。
源路径、源文件 SHA-256 和字形映射保存在 `manifest.json`。

在数据包仓库依次执行：

```powershell
python tools/build_catan_visual.py
python tools/build_catan_font.py
python tools/build_catan_ui.py
python tools/test_catan_ui.py --java <Java25路径>
```

单图标 32×32 像素，显示高 14、ascent 12；低于原版 256×256 单字形限制。
图标组件显式使用白色，旁边的中文与数字仍使用默认字体；多行图标之间留空行，避免挤压。
四列交易按钮每列 110 像素，其他菜单按钮 145 像素。
服务端回归会执行 Dialog 宏、检查字体切片与生成幂等；游戏客户端仍需检查实际显示和点击尺寸。
''', encoding='utf-8')
    print('Catan Dialog font: 10 icons generated')


if __name__ == '__main__':
    build()
