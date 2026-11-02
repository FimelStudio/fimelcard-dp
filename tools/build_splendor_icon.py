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
SVG = '''<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="1024" viewBox="0 0 1024 1024" role="img" aria-labelledby="title desc">
<title id="title">璀璨宝石 · SPLENDOR</title>
<desc id="desc">蓝青切面钻石、开发牌和彩色宝石筹码，配金色装饰与深色双语铭牌。</desc>
<defs>
 <linearGradient id="bg" x1="0" x2="1" y1="0" y2="1"><stop stop-color="#315a69"/><stop offset=".53" stop-color="#34394e"/><stop offset="1" stop-color="#171d34"/></linearGradient>
 <radialGradient id="spot"><stop stop-color="#edbf69" stop-opacity=".53"/><stop offset="1" stop-color="#edbf69" stop-opacity="0"/></radialGradient>
 <linearGradient id="gold" x1="0" x2="1" y1="0" y2="1"><stop stop-color="#fff7c8"/><stop offset=".5" stop-color="#f6ca61"/><stop offset="1" stop-color="#bd7c20"/></linearGradient>
 <linearGradient id="paper" x1="0" x2="1" y1="0" y2="1"><stop stop-color="#fff9e6"/><stop offset="1" stop-color="#d7c59e"/></linearGradient>
 <linearGradient id="diamond" x1="0" x2=".7" y1="0" y2="1"><stop stop-color="#f0ffff"/><stop offset=".47" stop-color="#83dfeb"/><stop offset="1" stop-color="#318ab8"/></linearGradient>
 <clipPath id="clip"><rect width="1024" height="1024" rx="88"/></clipPath>
 <g id="spark"><path d="M0-23L5-5L23 0L5 5L0 23L-5 5L-23 0L-5-5Z" fill="#fff2bf"/></g>
 <g id="card"><rect width="176" height="270" rx="19" fill="url(#paper)" stroke="#e6bf70" stroke-width="8"/><rect x="13" y="13" width="150" height="244" rx="11" fill="none" stroke="#a48a5a" stroke-width="3"/><path d="M30 114H146V232H30Z" fill="#3a5864"/><path d="M42 224V166L64 145L85 166V224M101 224V153L123 129L144 153V224" fill="#b5c5c0"/><path d="M25 116L88 79L151 116Z" fill="#c69a55"/><path d="M38 34L47 47L63 49L51 60L53 76L38 69L24 76L26 60L14 49L30 47Z" fill="#d3a953"/><circle cx="126" cy="46" r="18" fill="#3f9279" stroke="#f9df9e" stroke-width="3"/></g>
 <g id="chip"><ellipse cx="0" cy="12" rx="69" ry="58" fill="var(--rim)" stroke="#e7c580" stroke-width="5"/><ellipse cx="0" cy="0" rx="69" ry="58" fill="var(--base)" stroke="#f5db9e" stroke-width="6"/><ellipse rx="53" ry="44" fill="var(--inner)" stroke="#f7dfad" stroke-width="3"/><path d="M-29-8L-17-25H17L29-8L0 27Z" fill="var(--gem)" stroke="#faf1d9" stroke-width="3"/><path d="M-29-8H29M-17-25L-9-8L0 27L9-8L17-25M-9-8L0-25L9-8" fill="none" stroke="#faf1d9" stroke-width="2"/><path d="M-58-17L-52-14M-39-46L-35-41M0-56V-50M39-46L35-41M58-17L52-14M58 18L52 16M0 55V49M-58 18L-52 16" stroke="#fff0c6" stroke-width="5"/></g>
</defs>
<g clip-path="url(#clip)">
 <rect width="1024" height="1024" fill="url(#bg)"/>
 <circle cx="512" cy="375" r="535" fill="url(#spot)"/>
 <g opacity=".13" stroke="#fff" stroke-width="2" fill="none"><circle cx="512" cy="382" r="318"/><circle cx="512" cy="382" r="380"/><path d="M0 720L720 0M280 1024L1024 280"/></g>
 <ellipse cx="512" cy="664" rx="312" ry="26" fill="#111927" opacity=".36"/>
 <use href="#card" transform="translate(212 252) rotate(-17 88 135)"/>
 <use href="#card" transform="translate(642 238) rotate(17 88 135)"/>
 <path d="M315 322L366 231L512 166L658 231L709 322L512 570Z" fill="#1d617e" stroke="#e9e9c9" stroke-width="10" stroke-linejoin="round"/>
 <path d="M366 231L512 166L459 265L315 322Z" fill="#dcffff"/>
 <path d="M512 166L658 231L565 265L459 265Z" fill="#8cd9eb"/>
 <path d="M658 231L709 322L565 265Z" fill="#55bbd9"/>
 <path d="M315 322L459 265L405 322Z" fill="#b3f3ef"/>
 <path d="M459 265H565L619 322H405Z" fill="#f0fff5"/>
 <path d="M565 265L709 322H619Z" fill="#8de4eb"/>
 <path d="M315 322H405L512 570Z" fill="#348cb7"/>
 <path d="M405 322H619L512 570Z" fill="url(#diamond)"/>
 <path d="M619 322H709L512 570Z" fill="#286d9d"/>
 <path d="M366 231L459 265L512 166L565 265L658 231M315 322H709M459 265L405 322L512 570L619 322L565 265M459 265H565" fill="none" stroke="#effff5" stroke-opacity=".72" stroke-width="4" stroke-linejoin="round"/>
 <path d="M315 322L366 231L512 166L658 231L709 322L512 570Z" fill="none" stroke="#f1e5bd" stroke-width="8" stroke-linejoin="round"/>
 <use href="#spark" transform="translate(337 213) scale(1.3)"/>
 <use href="#spark" transform="translate(718 346) scale(.8)"/>
 <use href="#spark" transform="translate(575 126) scale(.65)"/>
 <g transform="translate(261 572) rotate(-12)" style="--rim:#7a2c49;--base:#b75269;--inner:#8b3656;--gem:#f3b4b9"><use href="#chip"/></g>
 <g transform="translate(397 616) rotate(-5)" style="--rim:#286054;--base:#439f82;--inner:#286b5b;--gem:#94dbc0"><use href="#chip"/></g>
 <g transform="translate(543 627) rotate(5)" style="--rim:#272737;--base:#515260;--inner:#343747;--gem:#c3c9d2"><use href="#chip"/></g>
 <g transform="translate(690 603) rotate(12)" style="--rim:#8c662c;--base:#d0a24a;--inner:#ad7e30;--gem:#fff0b3"><use href="#chip"/></g>
 <g transform="translate(791 527) rotate(18) scale(.82)" style="--rim:#607f8d;--base:#d0e2e5;--inner:#8dbac2;--gem:#f2ffff"><use href="#chip"/></g>
 <rect x="60" y="740" width="904" height="210" rx="46" fill="#151427" stroke="#ab8e9a" stroke-width="4"/>
 <path d="M84 760H940" stroke="url(#gold)" stroke-width="9"/>
 <text x="512" y="849" text-anchor="middle" font-family="Microsoft YaHei, Noto Sans CJK SC, sans-serif" font-size="90" font-weight="700" fill="#fff">璀璨宝石</text>
 <text x="512" y="924" text-anchor="middle" font-family="Arial, sans-serif" font-size="42" letter-spacing="2" fill="#d0e1eb">SPLENDOR</text>
 <rect x="14" y="14" width="996" height="996" rx="75" fill="none" stroke="#fff" stroke-opacity=".48" stroke-width="10"/>
</g></svg>
'''


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
    image = Image.new('RGBA', (1024, 1536), '#151725')
    for game in range(1, 23):
        path = folder/f'{game}.png'
        if not path.is_file():
            path = CARD/f'textures/gui/game_icons/{game}.png'
        with Image.open(path) as icon:
            assert icon.size == (256, 256), path
            image.paste(icon.convert('RGBA'), (((game-1) % 4)*256, ((game-1)//4)*256))
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


def build(publish_dir=None, force_render=False):
    encoded = SVG.encode('utf-8')
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
          'source': 'Fimel Cards original vector illustration; no official Splendor artwork or logo'},
          ensure_ascii=False, indent=2)+'\n').encode('utf-8'))
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
