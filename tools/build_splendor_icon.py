"""重建璀璨宝石22的矢量图标；仅修改22，桌面导出使用可选 --publish-dir。"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
import shutil
import subprocess
import tempfile
from pathlib import Path

from PIL import Image
from boardgame_assets import PACK, RP, CARD, export_model

DOCS = PACK/'docs/game-icons'
SOURCE = RP/'.source/splendor'


def make_svg():
    """将已缓存的原版物品像素变成矢量色块，SVG不依赖外部图片路径。"""
    sprites = []
    for name in ('diamond','lapis_lazuli','emerald','redstone','coal','gold_ingot'):
        with Image.open(SOURCE/'vanilla/item'/f'{name}.png') as image:
            image = image.convert('RGBA')
            assert image.size == (16, 16), (name, image.size)
            colors = {}
            for y in range(16):
                x = 0
                while x < 16:
                    color = image.getpixel((x,y))
                    end = x+1
                    while end < 16 and image.getpixel((end,y)) == color:
                        end += 1
                    if color[3]:
                        colors.setdefault(color, []).append(f'M{x} {y}h{end-x}v1h{x-end}z')
                    x = end
        paths = []
        for (r,g,b,a), segments in colors.items():
            paths.append(f'<path fill="#{r:02x}{g:02x}{b:02x}" fill-opacity="{a/255:.4f}" d="'+''.join(segments)+'"/>')
        sprites.append(f'<g id="{name}" shape-rendering="crispEdges">'+''.join(paths)+'</g>')
    template = Path(__file__).with_name('splendor_icon.svg').read_text(encoding='utf-8')
    assert template.count('<!-- sprites -->') == 1
    return template.replace('<!-- sprites -->', '\n'.join(sprites))



def write(path, content):
    path.parent.mkdir(parents=True, exist_ok=True)
    if not path.exists() or path.read_bytes() != content:
        path.write_bytes(content)


def find_browser():
    candidates = [os.environ.get('SPLENDOR_SVG_BROWSER'), shutil.which('msedge'), shutil.which('chromium'),
                  shutil.which('chromium-browser'), shutil.which('google-chrome')]
    for env in ('PROGRAMFILES(X86)', 'PROGRAMFILES', 'LOCALAPPDATA'):
        base = os.environ.get(env)
        if base:
            candidates += [str(Path(base)/'Microsoft/Edge/Application/msedge.exe'),
                           str(Path(base)/'Google/Chrome/Application/chrome.exe')]
    for candidate in candidates:
        if candidate and Path(candidate).is_file():
            return candidate
    raise RuntimeError('首次渲染需 Edge/Chromium，或设置 SPLENDOR_SVG_BROWSER；已提交的 icon.png 可直接重用。')


def render(svg_path):
    """浏览器仅负责原生SVG渲染；独立临时profile，不读取用户浏览器。"""
    folder = Path(tempfile.mkdtemp(prefix='fimel-splendor-icon-'))
    try:
        output = folder/'icon.png'
        options = {'stdout': subprocess.DEVNULL, 'stderr': subprocess.DEVNULL, 'check': True, 'timeout': 45}
        if os.name == 'nt':
            options['creationflags'] = subprocess.CREATE_NO_WINDOW
        subprocess.run([find_browser(), '--headless=new', '--disable-gpu', '--disable-extensions',
                        '--no-first-run', '--no-default-browser-check', '--hide-scrollbars',
                        '--default-background-color=00000000', '--force-device-scale-factor=1',
                        '--window-size=1024,1024', '--user-data-dir='+str(folder/'profile'),
                        '--screenshot='+str(output), svg_path.resolve().as_uri()], **options)
        with Image.open(output) as image:
            assert image.size == (1024, 1024), image.size
            return image.convert('RGBA').resize((256, 256), Image.Resampling.LANCZOS)
    finally:
        shutil.rmtree(folder, ignore_errors=True)


def preview(folder):
    games = sorted({int(p.stem) for p in (CARD/'textures/gui/game_icons').glob('*.png') if p.stem.isdecimal()})
    image = Image.new('RGBA', (1024, math.ceil(len(games)/4)*256), '#151725')
    for index, game in enumerate(games):
        path = folder/f'{game}.png'
        if not path.is_file():
            path = CARD/f'textures/gui/game_icons/{game}.png'
        with Image.open(path) as icon:
            assert icon.size == (256, 256), path
            image.paste(icon.convert('RGBA'), ((index % 4)*256, (index//4)*256))
    image.save(folder/'preview.png')


def register_font(image):
    path = CARD/'font/game_icons.json'
    body = json.loads(path.read_text(encoding='utf-8'))
    provider = {'type': 'bitmap', 'file': 'card:gui/game_icons/22.png', 'ascent': 8, 'height': 9,
                'chars': [chr(0xe600+22*8+i) for i in range(8)]}
    previous = next((i for i, entry in enumerate(body['providers']) if entry.get('file') == provider['file']), None)
    if previous is None:
        body['providers'].append(provider)
    else:
        body['providers'][previous] = provider
    spaces = next(entry['advances'] for entry in body['providers'] if entry['type'] == 'space')
    for strip in range(8):
        bounds = image.crop((0, strip*32, 256, (strip+1)*32)).getchannel('A').getbbox()
        assert bounds is not None, '图标切片不得全透明'
        advance = math.floor(bounds[2]*9/32+.5)+1
        spaces[chr(0xe800+22*8+strip)] = 80-advance
        assert advance+spaces[chr(0xe800+22*8+strip)] == 80
    write(path, (json.dumps(body, ensure_ascii=False, indent=2)+'\n').encode('utf-8'))


def build(publish_dir=None, force_render=False, refresh_preview=True):
    encoded = make_svg().encode('utf-8')
    digest = hashlib.sha256(encoded).hexdigest()
    svg_path, png_path, meta_path = SOURCE/'icon.svg', SOURCE/'icon.png', SOURCE/'icon.json'
    write(svg_path, encoded)
    metadata = json.loads(meta_path.read_text(encoding='utf-8')) if meta_path.exists() else {}
    cached = (not force_render and png_path.exists() and metadata.get('svg_sha256') == digest
              and metadata.get('png_sha256') == hashlib.sha256(png_path.read_bytes()).hexdigest())
    if cached:
        with Image.open(png_path) as source:
            image = source.convert('RGBA')
    else:
        image = render(svg_path)
    assert image.size == (256, 256)
    png_path.parent.mkdir(parents=True, exist_ok=True)
    image.save(png_path)
    png_bytes = png_path.read_bytes()
    for destination in (DOCS/'22.png', CARD/'textures/gui/game_icons/22.png',
                        CARD/'textures/item/splendor/icon.png', SOURCE/'textures/icon.png'):
        write(destination, png_bytes)
    write(DOCS/'22.svg', encoded)
    font_icon = CARD/'textures/font/splendor/icon.png'
    font_icon.parent.mkdir(parents=True, exist_ok=True)
    image.resize((64, 64), Image.Resampling.LANCZOS).save(font_icon)
    export_model('splendor', 'icon', {'credit': 'Fimel Cards original geometric gemstone artwork and models',
                 'gui_light': 'front', 'parent': 'minecraft:item/generated',
                 'textures': {'layer0': 'card:item/splendor/icon'}, 'display': {}})
    register_font(image)
    write(meta_path, (json.dumps({'name': '璀璨宝石', 'id': 22, 'format': 'SVG 1024; PNG RGBA 256',
          'svg_sha256': digest, 'png_sha256': hashlib.sha256(png_bytes).hexdigest(),
          'source': 'Fimel Cards vector layout with Minecraft item sprites (Mojang); no official Splendor artwork or logo'},
          ensure_ascii=False, indent=2)+'\n').encode('utf-8'))
    if refresh_preview:
        preview(DOCS)
    if publish_dir is not None:
        folder = Path(publish_dir)
        write(folder/'22.svg', encoded)
        write(folder/'22.png', png_bytes)
        preview(folder)
    return image


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--publish-dir', type=Path, help='可选：同时导出22.svg、22.png及22游戏预览；不修改1～21')
    parser.add_argument('--force-render', action='store_true', help='忽略已提交PNG缓存，用Edge/Chromium重新渲染SVG')
    args = parser.parse_args()
    build(args.publish_dir, args.force_render)
    print('璀璨宝石22图标已同步：SVG、PNG、物品模型、图片字体及选游八切片；既有1～21不变。')
