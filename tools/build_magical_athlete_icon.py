# -*- coding: utf-8 -*-
"""生成胡闹运动会23的原创SVG/PNG图标；保留1～22及八分片协议。"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
from pathlib import Path

from PIL import Image
from boardgame_assets import PACK, RP, CARD, export_model
from build_splendor_icon import render, write

SOURCE=RP/'.source/magical_athlete'
DOCS=PACK/'docs/game-icons'
SVG='''<svg xmlns="http://www.w3.org/2000/svg" width="1024" height="1024" viewBox="0 0 1024 1024" role="img" aria-labelledby="title desc">
<title id="title">胡闹运动会 · MAGICAL ATHLETE</title>
<desc id="desc">原创体育场跑道、三枚不同角色圆形立牌、六面骰与金色奖杯，配双色运动铭牌。</desc>
<defs>
 <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#315e71"/><stop offset=".54" stop-color="#305767"/><stop offset="1" stop-color="#20253e"/></linearGradient>
 <linearGradient id="track" x1="0" y1="0" x2="0" y2="1"><stop stop-color="#ea9a76"/><stop offset="1" stop-color="#bc615f"/></linearGradient>
 <linearGradient id="gold" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#fff1a3"/><stop offset=".6" stop-color="#f5c750"/><stop offset="1" stop-color="#c68c32"/></linearGradient>
 <linearGradient id="grass" x1="0" y1="0" x2="0" y2="1"><stop stop-color="#bcd8b3"/><stop offset="1" stop-color="#73a788"/></linearGradient>
 <clipPath id="clip"><rect width="1024" height="1024" rx="88"/></clipPath>
 <g id="spark"><path d="M0-20L5-5L20 0L5 5L0 20L-5 5L-20 0L-5-5Z" fill="#fff0b8"/></g>
 <g id="pawn"><ellipse cx="0" cy="91" rx="77" ry="20" fill="#151f30" opacity=".25"/><ellipse cx="0" cy="80" rx="64" ry="20" fill="var(--base)" stroke="#25384a" stroke-width="6"/><rect x="-11" y="24" width="22" height="53" fill="var(--base)" stroke="#25384a" stroke-width="6"/><circle r="67" fill="var(--base)" stroke="#25384a" stroke-width="7"/><circle r="55" fill="#fff4d6" stroke="#f7d58b" stroke-width="3"/></g>
 <g id="die"><rect x="-60" y="-60" width="120" height="120" rx="23" fill="#fff4d6" stroke="#25384a" stroke-width="7"/><path d="M-43-50H43" stroke="#fff" stroke-width="5"/><g fill="#25384a"><circle cx="-29" cy="-29" r="10"/><circle cx="29" cy="-29" r="10"/><circle cx="-29" cy="29" r="10"/><circle cx="29" cy="29" r="10"/></g><circle r="10" fill="#d8665f"/></g>
</defs>
<g clip-path="url(#clip)">
 <rect width="1024" height="1024" fill="url(#bg)"/>
 <g opacity=".12" stroke="#fff" stroke-width="3" fill="none"><circle cx="518" cy="361" r="315"/><circle cx="518" cy="361" r="375"/><path d="M-100 710L760-50M270 1040L1110 300"/></g>
 <ellipse cx="512" cy="637" rx="388" ry="53" fill="#101d30" opacity=".3"/>
 <rect x="123" y="350" width="778" height="292" rx="142" fill="url(#track)" stroke="#ffe9b7" stroke-width="10"/>
 <rect x="159" y="376" width="706" height="239" rx="117" fill="none" stroke="#f8d5b7" stroke-width="4"/>
 <rect x="193" y="401" width="638" height="188" rx="92" fill="none" stroke="#f8d5b7" stroke-width="4"/>
 <rect x="229" y="426" width="566" height="136" rx="65" fill="url(#grass)" stroke="#ffe9b7" stroke-width="7"/>
 <path d="M280 496H747M512 429V559" stroke="#e9e9bf" stroke-width="3" opacity=".7"/>
 <path d="M724 351V643" stroke="#f8dfb5" stroke-width="31"/>
 <g fill="#26394b"><path d="M710 358H724V379H710ZM724 379H738V400H724ZM710 400H724V421H710ZM724 421H738V442H724ZM710 442H724V463H710ZM724 463H738V484H724ZM710 484H724V505H710ZM724 505H738V526H724ZM710 526H724V547H710ZM724 547H738V568H724ZM710 568H724V589H710ZM724 589H738V610H724ZM710 610H724V631H710Z"/></g>
 <g transform="translate(725 251) rotate(16)"><use href="#die"/></g>
 <path d="M320 201C279 189 258 229 280 260C289 273 310 277 330 271M516 201C557 189 578 229 556 260C547 273 526 277 506 271" fill="none" stroke="#24384c" stroke-width="26"/>
 <path d="M320 201C279 189 258 229 280 260C289 273 310 277 330 271M516 201C557 189 578 229 556 260C547 273 526 277 506 271" fill="none" stroke="url(#gold)" stroke-width="15"/>
 <path d="M320 183H516L501 272L474 314L435 335V385H483V410H354V385H402V335L363 314L336 272Z" fill="url(#gold)" stroke="#24384c" stroke-width="8" stroke-linejoin="round"/>
 <path d="M343 204H493M356 219L365 267L384 292" fill="none" stroke="#fff5bd" stroke-width="7" stroke-linecap="round"/>
 <path d="M419 219L428 241L451 243L433 259L438 282L418 269L398 282L402 259L385 243L409 241Z" fill="#fff4b4" stroke="#c3903d" stroke-width="3"/>
 <g transform="translate(272 454) rotate(-9) scale(1.05)" style="--base:#ef9382"><use href="#pawn"/><path d="M-34 15Q-20 48 12 42Q38 37 41 10" fill="none" stroke="#28394a" stroke-width="20"/><path d="M-34 11Q-20 44 12 38Q38 33 41 6" fill="none" stroke="#f4cd52" stroke-width="12"/><path d="M-35 9L-39 2M41 6L45-3" stroke="#28394a" stroke-width="8"/></g>
 <g transform="translate(491 508) scale(1.15)" style="--base:#82b3d1"><use href="#pawn"/><path d="M-21 38V-7L0-39L21-7V38Z" fill="#e9f1df" stroke="#28394a" stroke-width="5"/><path d="M-22 16L-40 44V3L-22-12M22 16L40 44V3L22-12" fill="#dc7d6c" stroke="#28394a" stroke-width="5"/><circle cy="-5" r="12" fill="#82b3d1" stroke="#28394a" stroke-width="4"/><path d="M-12 42L0 64L12 42" fill="#e8ba48" stroke="#28394a" stroke-width="3"/></g>
 <g transform="translate(754 482) rotate(8) scale(1.08)" style="--base:#9cbb84"><use href="#pawn"/><path d="M-24-17Q-40-73-21-65Q-11-54-12-23M12-23Q12-67 26-66Q40-62 25-15" fill="#fff6da" stroke="#28394a" stroke-width="5"/><ellipse cy="12" rx="39" ry="33" fill="#fff6da" stroke="#28394a" stroke-width="5"/><circle cx="-15" cy="6" r="5" fill="#28394a"/><circle cx="15" cy="6" r="5" fill="#28394a"/><path d="M-14 22Q0 36 14 22" fill="none" stroke="#28394a" stroke-width="4"/></g>
 <path d="M118 279L181 267M105 310L169 300M825 667L898 647M848 689L910 673" stroke="#d7e6cd" stroke-width="8" stroke-linecap="round"/>
 <use href="#spark" transform="translate(207 217) scale(1.2)"/><use href="#spark" transform="translate(807 157) scale(.8)"/><use href="#spark" transform="translate(622 347) scale(.7)"/>
 <rect x="60" y="740" width="904" height="210" rx="46" fill="#18263b" stroke="#85acba" stroke-width="4"/>
 <path d="M84 760H940" stroke="url(#gold)" stroke-width="9"/>
 <text x="512" y="850" text-anchor="middle" font-family="Microsoft YaHei, Noto Sans CJK SC, sans-serif" font-size="86" font-weight="700" fill="#fff4dd">胡闹运动会</text>
 <text x="512" y="923" text-anchor="middle" font-family="Arial, sans-serif" font-size="39" font-weight="700" letter-spacing="2" fill="#cfe5de">MAGICAL ATHLETE</text>
 <rect x="14" y="14" width="996" height="996" rx="75" fill="none" stroke="#fff" stroke-opacity=".48" stroke-width="10"/>
</g></svg>'''


def register_font(image):
    path=CARD/'font/game_icons.json';body=json.loads(path.read_text(encoding='utf-8'))
    provider={'type':'bitmap','file':'card:gui/game_icons/23.png','ascent':8,'height':9,
              'chars':[chr(0xe600+23*8+i) for i in range(8)]}
    found=next((i for i,p in enumerate(body['providers']) if p.get('file')==provider['file']),None)
    if found is None:body['providers'].append(provider)
    else:body['providers'][found]=provider
    spaces=next(p['advances'] for p in body['providers'] if p['type']=='space')
    for strip in range(8):
        bounds=image.crop((0,strip*32,256,(strip+1)*32)).getchannel('A').getbbox()
        assert bounds is not None
        spaces[chr(0xe800+23*8+strip)]=80-(math.floor(bounds[2]*9/32+.5)+1)
    write(path,(json.dumps(body,ensure_ascii=False,indent=2)+'\n').encode('utf-8'))


def preview(folder):
    image=Image.new('RGBA',(1024,1536),'#151725')
    for game in range(1,24):
        path=folder/f'{game}.png'
        if not path.exists():path=CARD/f'textures/gui/game_icons/{game}.png'
        with Image.open(path) as icon:
            image.paste(icon.convert('RGBA'),(((game-1)%4)*256,((game-1)//4)*256))
    image.save(folder/'preview.png')


def build(publish_dir=None,force_render=False):
    encoded=SVG.encode('utf-8');digest=hashlib.sha256(encoded).hexdigest()
    svg_path=SOURCE/'icon.svg';png_path=SOURCE/'icon.png';meta_path=SOURCE/'icon.json'
    write(svg_path,encoded)
    metadata=json.loads(meta_path.read_text(encoding='utf-8')) if meta_path.exists() else {}
    cached=(not force_render and png_path.exists() and metadata.get('svg_sha256')==digest and
            metadata.get('png_sha256')==hashlib.sha256(png_path.read_bytes()).hexdigest())
    if cached:
        with Image.open(png_path) as source:image=source.convert('RGBA')
    else:image=render(svg_path)
    png_path.parent.mkdir(parents=True,exist_ok=True);image.save(png_path);content=png_path.read_bytes()
    for destination in (DOCS/'23.png',CARD/'textures/gui/game_icons/23.png',CARD/'textures/item/magical_athlete/icon.png',SOURCE/'textures/icon.png'):
        write(destination,content)
    write(DOCS/'23.svg',encoded)
    export_model('magical_athlete','icon',{'parent':'minecraft:item/generated',
        'textures':{'layer0':'card:item/magical_athlete/icon'},'gui_light':'front',
        'credit':'Fimel Cards original sports illustration; no official Magical Athlete artwork'})
    register_font(image)
    write(meta_path,(json.dumps({'id':23,'name':'胡闹运动会','svg_sha256':digest,
        'png_sha256':hashlib.sha256(content).hexdigest(),
        'source':'Fimel Cards original vector art, no official illustrations or logo'},ensure_ascii=False,indent=2)+'\n').encode('utf-8'))
    preview(DOCS)
    if publish_dir is not None:
        folder=Path(publish_dir);write(folder/'23.svg',encoded);write(folder/'23.png',content);preview(folder)
    return image


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--publish-dir',type=Path)
    parser.add_argument('--force-render',action='store_true')
    args=parser.parse_args();build(args.publish_dir,args.force_render)
    print('Magical Athlete 23 original SVG, PNG, item and menu font registered; icons 1-22 preserved.')
