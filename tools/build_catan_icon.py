# -*- coding: utf-8 -*-
"""生成卡坦岛21的原创SVG/PNG图标，并同步选游字体、物品模型和文档图片。"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
from pathlib import Path

from PIL import Image
from boardgame_assets import PACK, RP, CARD, export_model
from build_splendor_icon import render, write, preview

SOURCE = RP/'.source/catan'
DOCS = PACK/'docs/game-icons'
SVG_SOURCE = Path(__file__).with_name('catan_icon.svg')


def register_font(image: Image.Image) -> None:
    path = CARD/'font/game_icons.json'
    body = json.loads(path.read_text(encoding='utf-8'))
    provider = {'type': 'bitmap', 'file': 'card:gui/game_icons/21.png', 'ascent': 8, 'height': 9,
                'chars': [chr(0xe600+21*8+i) for i in range(8)]}
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
        spaces[chr(0xe800+21*8+strip)] = 80-advance
        assert advance+spaces[chr(0xe800+21*8+strip)] == 80
    write(path, (json.dumps(body, ensure_ascii=False, indent=2)+'\n').encode('utf-8'))


def build(publish_dir: Path | None = None, force_render: bool = False, refresh_preview: bool = True) -> Image.Image:
    encoded = SVG_SOURCE.read_bytes()
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
    image.save(png_path)
    png_bytes = png_path.read_bytes()
    for destination in (DOCS/'21.png', CARD/'textures/gui/game_icons/21.png',
                        CARD/'textures/item/catan/icon.png', SOURCE/'textures/icon.png'):
        write(destination, png_bytes)
    write(DOCS/'21.svg', encoded)
    export_model('catan', 'icon', {'parent': 'minecraft:item/generated', 'gui_light': 'front',
                 'textures': {'layer0': 'card:item/catan/icon'},
                 'credit': 'Fimel Cards original Catan inspired Minecraft island illustration'})
    register_font(image)
    write(meta_path, (json.dumps({'id': 21, 'name': '卡坦岛', 'format': 'SVG 1024; PNG RGBA 256',
          'svg_sha256': digest, 'png_sha256': hashlib.sha256(png_bytes).hexdigest(),
          'source': 'Fimel Cards original vector art; no official Catan artwork or logo'},
          ensure_ascii=False, indent=2)+'\n').encode('utf-8'))
    if refresh_preview:
        preview(DOCS)
    if publish_dir is not None:
        folder = Path(publish_dir)
        write(folder/'21.svg', encoded)
        write(folder/'21.png', png_bytes)
        preview(folder)
    return image


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--publish-dir', type=Path)
    parser.add_argument('--force-render', action='store_true')
    args = parser.parse_args()
    build(args.publish_dir, args.force_render)
    print('卡坦岛21图标已同步：SVG、PNG、物品模型、选游图片字体和文档图片。')
