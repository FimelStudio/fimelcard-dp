# -*- coding: utf-8 -*-
"""胡闹运动会原创体育场、36枚角色立牌、骰子道具和文本图片字体。"""
from __future__ import annotations

import colorsys
import json
import math

from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import PACK, RP, CARD, cube, disc, export_model, export_texture, flat_board, json_file, text_file

GAME = 'magical_athlete'
SOURCE = RP/'.source/magical_athlete'
CHARACTERS = json.loads((PACK/'tools/magical_athlete_characters.json').read_text(encoding='utf-8'))
TRACK = json.loads((PACK/'tools/magical_athlete_track.json').read_text(encoding='utf-8'))
INK, PAPER, GOLD = '#23354c', '#fff7df', '#f3bf39'
TEAMS = ('#f26e69', '#5e9ee5', '#6bc69b', '#e8bf4f', '#a48be0', '#ed97ba')
PROPS = ('dice', 'coin', 'medal_gold', 'medal_silver', 'flag', 'trip', 'portal', 'rocket', 'heart', 'trophy', 'menu', 'banana')


def font(size, chinese=False):
    return ImageFont.truetype('C:/Windows/Fonts/'+('msyhbd.ttc' if chinese else 'arialbd.ttf'), size)


def palette(index):
    return tuple(round(v*255) for v in colorsys.hsv_to_rgb((index*.61803398875+.03)%1, .43, .92))


def texture(name, image):
    export_texture(GAME, name, image)
    path = SOURCE/'textures'/(name+'.png')
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path)


def model(name, value, gui=None):
    value.setdefault('credit', 'Fimel Cards original sports artwork and geometry; no official Magical Athlete illustrations')
    value.setdefault('gui_light', 'front')
    value.setdefault('display', gui or {
        'gui': {'rotation': [20, 210, 0], 'scale': [.8,.8,.8]},
        'firstperson_righthand': {'rotation': [0, 90, 0], 'translation': [0, 1, 0], 'scale': [.45,.45,.45]},
        'firstperson_lefthand': {'rotation': [0, -90, 0], 'translation': [0, 1, 0], 'scale': [.45,.45,.45]},
        'thirdperson_righthand': {'rotation': [0, 90, 0], 'scale': [.45,.45,.45]},
        'thirdperson_lefthand': {'rotation': [0, -90, 0], 'scale': [.45,.45,.45]}})
    export_model(GAME, name, value)


def star(draw, center, radius, fill, outline=INK, width=3):
    x,y=center
    points=[]
    for i in range(10):
        a=-math.pi/2+i*math.pi/5
        r=radius if i%2==0 else radius*.45
        points.append((x+math.cos(a)*r,y+math.sin(a)*r))
    draw.polygon(points,fill=fill,outline=outline,width=width)


def heart(draw, box, color='#ec6480'):
    x0,y0,x1,y1=box; w=x1-x0;h=y1-y0
    draw.ellipse((x0,y0,x0+w*.56,y0+h*.61),fill=color,outline=INK,width=3)
    draw.ellipse((x0+w*.44,y0,x1,y0+h*.61),fill=color,outline=INK,width=3)
    draw.polygon([(x0+2,y0+h*.34),(x1-2,y0+h*.34),(x0+w*.5,y1)],fill=color,outline=INK,width=3)
    draw.line((x0+w*.14,y0+h*.35,x0+w*.5,y0+h*.85,x0+w*.86,y0+h*.35),fill=color,width=6)


def emblem(draw, slug, color=GOLD):
    """All marks are drawn in a 128px square; strong silhouettes survive HUD sizes."""
    white, dark, red, green = PAPER, INK, '#ed735b', '#71b995'
    if slug in ('alchemist', 'genius'):
        if slug=='alchemist':
            draw.polygon([(52,30),(76,30),(76,43),(70,43),(70,61),(92,94),(86,102),(42,102),(36,94),(58,61),(58,43),(52,43)],fill=white,outline=dark,width=4)
            draw.polygon([(47,80),(81,80),(89,94),(84,98),(44,98),(40,94)],fill='#77ccad')
            draw.ellipse((59,85,65,91),fill=white);draw.ellipse((68,73,74,79),fill=white)
        else:
            draw.ellipse((38,26,90,78),fill='#ffe28a',outline=dark,width=4)
            draw.rectangle((52,72,76,94),fill=white,outline=dark,width=4)
            draw.line((54,101,74,101),fill=dark,width=4)
            for a in (0,45,90,135,180):
                r=math.radians(a);draw.line((64+34*math.cos(r),53-34*math.sin(r),64+43*math.cos(r),53-43*math.sin(r)),fill=dark,width=4)
    elif slug in ('baba-yaga','magician'):
        if slug=='baba-yaga':
            draw.polygon([(31,90),(96,90),(77,48),(82,25),(62,37),(48,88)],fill='#685484',outline=dark,width=4)
            draw.polygon([(28,87),(99,87),(105,98),(24,98)],fill='#8f70a3',outline=dark,width=4)
            draw.line((47,78,88,78),fill=GOLD,width=7)
        else:
            draw.rectangle((42,45,88,88),fill=dark,outline=white,width=3)
            draw.ellipse((28,82,100,101),fill=dark,outline=white,width=3)
            draw.rectangle((43,72,87,83),fill=red)
            draw.line((78,48,99,25),fill=white,width=8);star(draw,(98,25),11,GOLD,width=2)
    elif slug=='banana':
        draw.arc((24,25,101,105),5,165,fill=dark,width=25)
        draw.arc((24,22,100,101),6,165,fill='#f8d658',width=18)
        draw.line((27,67,24,58),fill=dark,width=8);draw.line((98,63,103,55),fill=dark,width=8)
        draw.arc((31,29,94,93),12,152,fill='#fff4ab',width=3)
    elif slug=='blimp':
        draw.ellipse((24,35,102,78),fill='#e5a0ab',outline=dark,width=4)
        draw.arc((40,35,86,78),90,270,fill=white,width=3)
        draw.polygon([(28,46),(20,35),(21,66),(30,65)],fill='#8ebacf',outline=dark,width=3)
        draw.line((56,77,56,88),fill=dark,width=3);draw.line((76,76,76,88),fill=dark,width=3)
        draw.rounded_rectangle((48,84,82,98),radius=4,fill=GOLD,outline=dark,width=3)
    elif slug=='centaur':
        draw.polygon([(38,100),(39,84),(53,64),(48,44),(62,28),(76,35),(87,55),(79,68),(66,64),(70,80),(87,100)],fill='#c99566',outline=dark,width=4)
        draw.polygon([(49,45),(42,33),(58,35)],fill='#dfb080',outline=dark,width=3)
        draw.ellipse((68,43,73,48),fill=dark);draw.line((61,70,52,89),fill='#815d53',width=6)
    elif slug=='cheerleader':
        for cx,cy in ((40,50),(89,50)):
            for i in range(12):
                a=i*math.pi/6;draw.line((cx,cy,cx+23*math.cos(a),cy+23*math.sin(a)),fill=red if cx==40 else '#5c9cd3',width=6)
        draw.line((39,57,52,83,77,83,89,57),fill=dark,width=7)
        draw.ellipse((54,51,75,72),fill=GOLD,outline=dark,width=3)
        draw.polygon([(54,76),(75,76),(84,101),(46,101)],fill=white,outline=dark,width=4)
    elif slug=='coach':
        draw.arc((30,28,91,80),180,350,fill=white,width=6)
        draw.ellipse((38,58,85,100),fill='#d9e8e5',outline=dark,width=4)
        draw.rectangle((72,57,105,77),fill='#d9e8e5',outline=dark,width=4)
        draw.ellipse((49,70,72,92),fill=dark);draw.rectangle((84,61,98,69),fill=dark)
    elif slug in ('copycat','hare','leaptoad','huge-baby','twin'):
        if slug=='hare':
            draw.ellipse((39,13,56,64),fill=white,outline=dark,width=4)
            draw.ellipse((71,13,88,64),fill=white,outline=dark,width=4)
            draw.line((46,23,48,50),fill='#e5a8a5',width=5);draw.line((80,23,78,50),fill='#e5a8a5',width=5)
        if slug=='copycat':
            draw.polygon([(35,63),(32,27),(58,47)],fill='#df9f64',outline=dark,width=4)
            draw.polygon([(71,47),(95,27),(93,67)],fill='#df9f64',outline=dark,width=4)
        if slug=='leaptoad':
            draw.ellipse((29,34,56,65),fill=green,outline=dark,width=4)
            draw.ellipse((73,34,100,65),fill=green,outline=dark,width=4)
        if slug=='twin':
            for x in (42,83):
                draw.ellipse((x-22,44,x+22,93),fill='#f2c795',outline=dark,width=4)
                draw.ellipse((x-11,62,x-5,69),fill=dark);draw.ellipse((x+6,62,x+12,69),fill=dark)
                draw.arc((x-9,69,x+10,85),0,180,fill=dark,width=3)
            return
        fill=green if slug=='leaptoad' else '#df9f64' if slug=='copycat' else white if slug=='hare' else '#f2c795'
        draw.ellipse((29,42,100,105),fill=fill,outline=dark,width=4)
        draw.ellipse((44,61,51,71),fill=dark);draw.ellipse((77,61,84,71),fill=dark)
        if slug=='copycat':
            draw.polygon([(59,77),(69,77),(64,83)],fill=dark)
            draw.line((28,81,47,84),fill=dark,width=2);draw.line((81,84,101,81),fill=dark,width=2)
        elif slug=='huge-baby':
            draw.arc((53,31,76,50),170,345,fill=dark,width=4)
            draw.ellipse((51,80,78,100),fill='#8fbed3',outline=dark,width=3);draw.ellipse((59,84,70,94),fill=white)
        else:draw.arc((47,72,83,92),5,175,fill=dark,width=3)
    elif slug in ('dicemonger','dice'):
        draw.rounded_rectangle((32,30,97,99),radius=12,fill=white,outline=dark,width=4)
        for x,y in ((47,46),(82,46),(64,64),(47,83),(82,83)):
            draw.ellipse((x-5,y-5,x+5,y+5),fill=red if x==64 else dark)
    elif slug=='duelist':
        draw.line((31,101,95,27),fill=dark,width=13);draw.line((31,101,95,27),fill='#d8e6ed',width=7)
        draw.line((95,101,31,27),fill=dark,width=13);draw.line((95,101,31,27),fill='#d8e6ed',width=7)
        draw.line((23,79,47,101),fill=GOLD,width=8);draw.line((81,101,105,79),fill=GOLD,width=8)
    elif slug=='egg':
        draw.ellipse((36,24,93,104),fill='#fff8d8',outline=dark,width=4)
        draw.line((39,73,51,65,62,77,74,65,88,73),fill='#d2ad6c',width=4)
        draw.ellipse((53,47,60,57),fill=dark);draw.ellipse((72,47,79,57),fill=dark)
    elif slug=='flip-flop':
        draw.rounded_rectangle((42,23,84,106),radius=19,fill='#ed9576',outline=dark,width=4)
        draw.line((46,54,64,67,81,54),fill='#5d9e9b',width=10)
        draw.line((64,41,64,67),fill='#5d9e9b',width=9)
    elif slug=='gunk':
        draw.polygon([(24,93),(30,76),(42,62),(50,36),(69,28),(87,40),(90,70),(105,95),(94,104),(35,103)],fill='#8cc37e',outline=dark,width=4)
        draw.ellipse((50,57,58,68),fill=dark);draw.ellipse((74,57,82,68),fill=dark)
        draw.arc((55,68,78,85),0,180,fill=dark,width=3);draw.ellipse((40,84,48,91),fill='#bbd89e')
    elif slug=='heckler':
        draw.polygon([(27,53),(47,53),(93,31),(93,94),(47,76),(27,76)],fill='#ec9a6c',outline=dark,width=4)
        draw.polygon([(45,76),(62,82),(56,104),(44,98)],fill='#a6b6ce',outline=dark,width=4)
        draw.line((104,45,115,37),fill=dark,width=4);draw.line((106,64,118,64),fill=dark,width=4)
    elif slug in ('hypnotist','portal'):
        draw.ellipse((29,27,100,100),fill='#c6b9e5',outline=dark,width=4)
        points=[]
        for i in range(140):
            a=i*.13;r=32*(1-i/155);points.append((64+r*math.cos(a),64+r*math.sin(a)))
        draw.line(points,fill=dark,width=4)
        if slug=='hypnotist':draw.line((89,92,103,108),fill=dark,width=7)
    elif slug in ('inchworm','scoocher'):
        if slug=='scoocher':
            draw.ellipse((46,39,100,91),fill='#cda479',outline=dark,width=4)
            draw.arc((53,46,94,85),0,340,fill=dark,width=4)
            draw.arc((61,54,85,78),0,330,fill=dark,width=3)
        for i in range(5 if slug=='inchworm' else 4):
            x=29+i*13;y=82-(9 if i%2 else 0)
            draw.ellipse((x-10,y-12,x+13,y+12),fill=green,outline=dark,width=3)
        draw.line((34,71,30,57),fill=dark,width=3);draw.line((44,71,47,57),fill=dark,width=3)
        draw.ellipse((26,54,33,62),fill=dark);draw.ellipse((43,54,50,62),fill=dark)
    elif slug in ('lackey','flag'):
        draw.line((39,25,39,108),fill=dark,width=7)
        draw.polygon([(42,28),(102,36),(85,59),(102,79),(42,72)],fill='#72b4d8',outline=dark,width=4)
        star(draw,(65,51),13,white,width=2)
    elif slug=='legs':
        for x,offset in ((43,0),(73,-9)):
            draw.line((x,29+offset,x,82+offset),fill=dark,width=15)
            draw.line((x,30+offset,x,81+offset),fill='#f1d4a1',width=9)
            draw.rounded_rectangle((x-7,78+offset,x+25,96+offset),radius=6,fill=red,outline=dark,width=3)
    elif slug in ('lovable-loser','romantic','heart'):
        heart(draw,(30,35,100,101))
        if slug=='lovable-loser':
            draw.rounded_rectangle((34,61,94,78),radius=5,fill='#f3d9a0',outline=dark,width=3)
            draw.rectangle((54,63,74,76),fill='#d7b379')
            for x in (42,85):draw.ellipse((x-1,66,x+1,68),fill=dark)
    elif slug=='mastermind':
        draw.ellipse((32,42,98,96),fill='#e8b3bf',outline=dark,width=4)
        draw.arc((38,50,68,82),80,350,fill=dark,width=3)
        draw.arc((60,51,92,82),180,450,fill=dark,width=3)
        draw.line((64,44,64,91),fill=dark,width=3)
        draw.polygon([(32,40),(29,21),(47,29),(63,16),(80,29),(100,21),(96,40)],fill=GOLD,outline=dark,width=4)
    elif slug=='mouth':
        draw.ellipse((24,31,105,106),fill='#df777b',outline=dark,width=4)
        draw.ellipse((36,47,94,96),fill=dark)
        for x in (43,59,75):draw.rectangle((x,49,x+10,63),fill=white)
        draw.ellipse((52,81,84,97),fill='#f0abb0')
    elif slug=='party-animal':
        draw.polygon([(38,89),(64,20),(96,89)],fill='#8aaee1',outline=dark,width=4)
        for x,y in ((58,48),(72,64),(53,75),(77,83)):draw.ellipse((x-5,y-5,x+5,y+5),fill=GOLD)
        draw.ellipse((55,13,73,31),fill=red,outline=dark,width=3)
        draw.arc((30,82,103,105),180,360,fill=dark,width=5)
        for x,y in ((24,42),(103,49),(21,87)):star(draw,(x,y),6,red,width=1)
    elif slug in ('rocket-scientist','rocket'):
        draw.polygon([(49,88),(37,103),(38,72),(49,63)],fill=red,outline=dark,width=4)
        draw.polygon([(80,88),(92,103),(91,72),(80,63)],fill=red,outline=dark,width=4)
        draw.polygon([(48,88),(48,48),(64,22),(81,48),(81,88)],fill=white,outline=dark,width=4)
        draw.ellipse((54,47,75,68),fill='#81bed3',outline=dark,width=3)
        draw.polygon([(53,92),(64,115),(76,92)],fill=GOLD,outline=dark,width=3)
    elif slug=='sisyphus':
        draw.ellipse((49,25,106,81),fill='#afbbc1',outline=dark,width=4)
        draw.line((57,43,77,35,94,47),fill='#d5dfe2',width=4)
        draw.line((23,107,107,107),fill=dark,width=5)
        draw.ellipse((28,61,46,79),fill=GOLD,outline=dark,width=3)
        draw.line((38,77,47,89,34,105),fill=dark,width=6)
        draw.line((43,87,63,70),fill=dark,width=6)
    elif slug=='skipper':
        draw.ellipse((26,27,101,102),outline=dark,width=7)
        draw.ellipse((36,37,91,92),outline=white,width=5)
        for a in range(0,360,45):
            r=math.radians(a);draw.line((64,65,64+46*math.cos(r),65+46*math.sin(r)),fill=dark,width=6)
        draw.ellipse((54,55,74,75),fill=GOLD,outline=dark,width=4)
    elif slug=='stickler':
        draw.rounded_rectangle((37,23,91,106),radius=5,fill='#f4d582',outline=dark,width=4)
        for y in range(34,100,12):draw.line((43,y,65 if y%24==10 else 56,y),fill=dark,width=3)
        draw.line((76,38,76,88),fill='#dd9b5e',width=3)
    elif slug=='suckerfish':
        draw.polygon([(83,66),(106,44),(106,88)],fill='#6baebb',outline=dark,width=4)
        draw.ellipse((23,39,93,94),fill='#93c7d4',outline=dark,width=4)
        draw.ellipse((36,50,47,63),fill=dark)
        draw.ellipse((20,64,38,83),fill='#d2e6d6',outline=dark,width=3)
        draw.arc((58,48,81,86),100,260,fill='#5592a7',width=4)
    elif slug=='third-wheel':
        for x,y in ((40,49),(89,49),(64,91)):
            draw.ellipse((x-18,y-18,x+18,y+18),fill=white,outline=dark,width=4)
            draw.ellipse((x-7,y-7,x+7,y+7),fill='#83b9ca',outline=dark,width=3)
        draw.line((42,51,64,88,86,51,42,51),fill=dark,width=5)
    elif slug in ('coin','medal_gold','medal_silver','trophy'):
        if slug=='trophy':
            draw.arc((22,28,61,69),75,285,fill=GOLD,width=9)
            draw.arc((68,28,107,69),-105,105,fill=GOLD,width=9)
            draw.polygon([(40,27),(89,27),(84,67),(65,82),(45,67)],fill=GOLD,outline=dark,width=4)
            draw.line((65,80,65,102),fill=GOLD,width=10)
            draw.rectangle((43,100,86,109),fill=GOLD,outline=dark,width=3)
        else:
            if slug!='coin':
                draw.polygon([(34,27),(55,27),(68,65),(47,72)],fill=red,outline=dark,width=3)
                draw.polygon([(74,27),(95,27),(81,72),(61,65)],fill='#609bc8',outline=dark,width=3)
            tint='#d7e3e8' if slug=='medal_silver' else GOLD
            draw.ellipse((29,43 if slug!='coin' else 27,100,111 if slug!='coin' else 101),fill=tint,outline=dark,width=4)
            star(draw,(64,77 if slug!='coin' else 64),22,white,width=2)
    elif slug=='trip':
        draw.line((32,94,94,94),fill=red,width=8)
        draw.ellipse((75,26,95,47),fill=GOLD,outline=dark,width=3)
        draw.line((76,48,57,65,34,57),fill=dark,width=8)
        draw.line((58,65,80,80,105,78),fill=dark,width=8)
        draw.line((58,65,42,86,22,78),fill=dark,width=8)
    elif slug=='menu':
        draw.rounded_rectangle((34,28,95,109),radius=8,fill=white,outline=dark,width=4)
        draw.rounded_rectangle((49,19,80,38),radius=5,fill=GOLD,outline=dark,width=3)
        for y in (54,73,91):
            draw.rectangle((44,y-3,50,y+3),fill='#6fbc9d');draw.line((59,y,84,y),fill=dark,width=4)


def icon(slug, index=0, framed=True):
    image=Image.new('RGBA',(128,128))
    draw=ImageDraw.Draw(image)
    if framed:
        draw.ellipse((3,3,124,124),fill=palette(index),outline=INK,width=5)
        draw.ellipse((10,10,117,117),fill=PAPER,outline='#e4cb8c',width=2)
    emblem(draw,slug)
    return image


def pawn(slug, index):
    face=icon(slug,index)
    texture('racer/'+slug,face)
    edge=Image.new('RGB',(16,16),palette(index));texture('racer_edge/'+slug,edge)
    base=disc('', 'card:item/magical_athlete/racer_edge/'+slug, height=1.7,segments=12)
    base['textures']['top']='card:item/magical_athlete/racer_edge/'+slug
    elements=base['elements']+[cube([6,1,7],[10,5,9],'edge','stem')]
    # A round upright medallion, front/back use the same legible original portrait.
    for i in range(12):
        x0=1+i*14/12;x1=1+(i+1)*14/12
        h=math.sqrt(7**2-((x0+x1)/2-8)**2)
        part=cube([x0,12-h,7.1],[x1,12+h,8.9],'edge',f'portrait_{i:02}')
        for side in ('north','south'):
            part['faces'][side]={'texture':'#portrait','uv':[(x0-1)/14*16,(7-h)/14*16,(x1-1)/14*16,(7+h)/14*16]}
        elements.append(part)
    model('racer/'+slug,{'textures':{'top':base['textures']['top'],'edge':base['textures']['edge'],
                                   'portrait':'card:item/magical_athlete/racer/'+slug,
                                   'particle':'card:item/magical_athlete/racer_edge/'+slug},'elements':elements})
    # Flat face-up badge supports a clear alternative when many racers share one square.
    badge=disc('card:item/magical_athlete/racer/'+slug,'card:item/magical_athlete/racer_edge/'+slug,height=1.6,segments=12)
    model('token/'+slug,badge,gui={'gui':{'rotation':[90,0,0],'scale':[.9,.9,.9]}})


def board(kind):
    size=1536;s=size/16
    image=Image.new('RGB',(size,size),'#194c59' if kind=='mild' else '#41365e')
    draw=ImageDraw.Draw(image)
    draw.rounded_rectangle((15,15,size-16,size-16),radius=64,fill='#ffefd0',outline=INK,width=9)
    draw.rounded_rectangle((38,38,size-39,size-39),radius=48,fill='#cde0b4',outline='#bdad88',width=3)
    # Soft striped pitch surrounded by one numbered, unmistakable racing lane.
    for i in range(10):
        x0=round(3.2*s+i*.96*s);x1=round(3.2*s+(i+1)*.96*s)
        draw.rectangle((x0,3.2*s,x1,12.8*s),fill=('#c7ddb0','#c1d6a7')[i%2])
    draw.rounded_rectangle((3.4*s,3.4*s,12.6*s,12.6*s),radius=40,outline='#e6edcf',width=4)
    draw.line((3.4*s,8*s,12.6*s,8*s),fill='#e6edcf',width=4)
    draw.ellipse((6.4*s,6.4*s,9.6*s,9.6*s),outline='#e6edcf',width=4)
    positions=TRACK['layout']['positions']
    points=[(x*s,z*s) for x,z in positions]
    draw.line(points,fill='#314957',width=round(1.38*s),joint='curve')
    wild=TRACK['wild'] if kind=='wild' else {}
    for number,(x,z) in enumerate(positions):
        cx,cy=x*s,z*s;r=.65*s
        effect=wild.get(str(number),{})
        color='#fff8e2'
        if 'points' in effect:color='#fae29a'
        if 'trip' in effect:color='#efb19e'
        if 'move' in effect:color='#b3dfe0' if effect['move']>0 else '#d0c0e1'
        if number==0:color='#9dcda6'
        if number==30:color='#fff5c7'
        draw.rounded_rectangle((cx-r,cy-r,cx+r,cy+r),radius=round(.16*s),fill=color,outline=INK,width=3)
        draw.rounded_rectangle((cx-r+7,cy-r+7,cx+r-7,cy+r-7),radius=round(.10*s),outline='#ffffff',width=2)
        if number in (0,30):
            text='起点' if number==0 else '终点'
            draw.text((cx,cy+.24*s),text,font=font(round(.23*s),True),fill=INK,anchor='mm')
            if number==30:
                for row in range(2):
                    for column in range(6):
                        if (row+column)%2==0:
                            draw.rectangle((cx+(.15*column-.45)*s,cy+(.15*row-.42)*s,cx+(.15*column-.3)*s,cy+(.15*row-.27)*s),fill=INK)
            else:
                draw.polygon([(cx-.24*s,cy-.4*s),(cx+.29*s,cy-.12*s),(cx-.24*s,cy+.08*s)],fill=INK)
        else:
            draw.text((cx,cy-.29*s if effect else cy),str(number),font=font(round(.35*s)),fill=INK,anchor='mm')
            if 'points' in effect:
                star(draw,(cx,cy+.2*s),.22*s,GOLD,width=2)
            elif 'trip' in effect:
                draw.line((cx-.25*s,cy+.05*s,cx+.25*s,cy+.45*s),fill='#c55245',width=7)
                draw.line((cx+.25*s,cy+.05*s,cx-.25*s,cy+.45*s),fill='#c55245',width=7)
            elif 'move' in effect:
                value=effect['move'];draw.text((cx,cy+.2*s),f'{value:+d}',font=font(round(.34*s)),fill='#276b76' if value>0 else '#76538e',anchor='mm')
    # The pitch is intentionally low contrast so dice and moving characters stand out.
    draw.rounded_rectangle((4.2*s,4.35*s,11.8*s,6.25*s),radius=22,fill='#fff3d4',outline=INK,width=4)
    draw.text((8*s,5.13*s),'胡闹运动会',font=font(round(.65*s),True),fill=INK,anchor='mm')
    draw.text((8*s,5.83*s),'MAGICAL ATHLETE',font=font(round(.27*s)),fill='#628080',anchor='mm')
    draw.text((8*s,10.65*s),'温和赛道' if kind=='mild' else '狂野赛道',font=font(round(.39*s),True),fill='#3f7069' if kind=='mild' else '#775d87',anchor='mm')
    draw.text((8*s,11.23*s),'ROLL  ·  RUN  ·  MAKE CHAOS',font=font(round(.19*s)),fill='#77957b',anchor='mm')
    for i,color in enumerate(TEAMS):
        x=(5.75+i*.9)*s
        draw.polygon([(x,7.05*s),(x+.44*s,7.05*s),(x+.34*s,7.48*s),(x+.11*s,7.48*s)],fill=color,outline=INK,width=2)
    texture('board/'+kind,image)
    model('board/'+kind,flat_board('card:item/magical_athlete/board/'+kind),
          gui={'gui':{'rotation':[90,0,0],'scale':[1,1,1]}})
    return image


def dice():
    patterns={1:[(1,1)],2:[(0,0),(2,2)],3:[(0,0),(1,1),(2,2)],
              4:[(0,0),(2,0),(0,2),(2,2)],5:[(0,0),(2,0),(1,1),(0,2),(2,2)],
              6:[(0,0),(0,1),(0,2),(2,0),(2,1),(2,2)]}
    for value,points in patterns.items():
        image=Image.new('RGB',(64,64),'#fff7df');draw=ImageDraw.Draw(image)
        draw.rounded_rectangle((1,1,62,62),radius=9,outline='#b3b7ab',width=2)
        for x,y in points:
            px,py=16+x*16,16+y*16
            draw.ellipse((px-5,py-5,px+5,py+5),fill='#db6559' if value==1 else INK)
        texture('dice/'+str(value),image)
    textures={f'f{i}':'card:item/magical_athlete/dice/'+str(i) for i in range(1,7)}
    element=cube([1,1,1],[15,15,15])
    mapping={'up':1,'down':6,'north':2,'south':5,'east':3,'west':4}
    for side,value in mapping.items():element['faces'][side]['texture']='#f'+str(value)
    body={'textures':textures,'elements':[element]}
    model('dice',body)
    # Six top-face variants are useful for dialog previews; table animations use dice itself.
    for value in range(1,7):
        model('dice/'+str(value),{'parent':'minecraft:item/generated','textures':{'layer0':'card:item/magical_athlete/dice/'+str(value)}},gui={'gui':{'scale':[1,1,1]}})


def props():
    texture('solid/edge',Image.new('RGB',(16,16),INK))
    for slug in PROPS:
        if slug=='dice':continue
        image=icon(slug,PROPS.index(slug))
        texture('prop/'+slug,image)
        if slug in ('coin','medal_gold','medal_silver','trip','portal'):
            body=disc('card:item/magical_athlete/prop/'+slug,'card:item/magical_athlete/solid/edge',height=1.8,segments=16)
            model('prop/'+slug,body,gui={'gui':{'rotation':[90,0,0],'scale':[.85,.85,.85]}})
        elif slug=='trophy':
            texture('solid/gold',Image.new('RGB',(16,16),GOLD))
            elements=[cube([3,0,3],[13,1.4,13],'gold','base'),cube([6.3,1.4,6.3],[9.7,9,9.7],'gold','stem')]
            for i in range(5):
                width=4+i*1.6;elements.append(cube([8-width/2,8+i,8-width/2],[8+width/2,9.1+i,8+width/2],'gold',f'cup_{i}'))
            elements.extend([cube([0,9,6],[2.2,12,10],'gold','handle_left'),cube([13.8,9,6],[16,12,10],'gold','handle_right')])
            model('prop/'+slug,{'textures':{'gold':'card:item/magical_athlete/solid/gold'},'elements':elements})
        else:
            part=cube([1,1,7.75],[15,15,8.25],'face','printed_prop')
            model('prop/'+slug,{'textures':{'face':'card:item/magical_athlete/prop/'+slug},'elements':[part]},
                  gui={'gui':{'rotation':[0,0,0],'scale':[1,1,1]},
                       'firstperson_righthand':{'rotation':[0,0,0],'scale':[.5,.5,.5]},
                       'firstperson_lefthand':{'rotation':[0,0,0],'scale':[.5,.5,.5]}})
    # Dice cup is an actual hollow stepped cylinder, not a flat illustration.
    texture('solid/cup',Image.new('RGB',(16,16),'#538f95'))
    cup=[]
    for i in range(12):
        angle=2*math.pi*i/12
        x,z=8+5.4*math.cos(angle),8+5.4*math.sin(angle)
        cup.append(cube([x-.75,1,z-.75],[x+.75,12,z+.75],'cup',f'cup_wall_{i:02}'))
    cup.append(cube([3,0,3],[13,1,13],'cup','cup_bottom'))
    model('prop/dice_cup',{'textures':{'cup':'card:item/magical_athlete/solid/cup'},'elements':cup})


def fonts():
    root=RP/'assets/magical_athlete/textures/font';root.mkdir(parents=True,exist_ok=True)
    avatars=Image.new('RGBA',(384,384))
    for entry in CHARACTERS:
        i=entry['id'];avatars.paste(icon(entry['slug'],i).resize((64,64),Image.Resampling.LANCZOS),((i%6)*64,(i//6)*64))
    avatars.save(root/'racers.png')
    atlas=Image.new('RGBA',(384,128))
    for i,slug in enumerate(PROPS):
        atlas.paste(icon(slug,i).resize((64,64),Image.Resampling.LANCZOS),((i%6)*64,(i//6)*64))
    atlas.save(root/'props.png')
    json_file(RP/'assets/magical_athlete/font/icons.json',{'providers':[
        {'type':'bitmap','file':'magical_athlete:font/racers.png','ascent':19,'height':22,
         'chars':[''.join(chr(0xe200+y*6+x) for x in range(6)) for y in range(6)]},
        {'type':'bitmap','file':'magical_athlete:font/props.png','ascent':13,'height':16,
         'chars':[''.join(chr(0xe100+y*6+x) for x in range(6)) for y in range(2)]}]})
    json_file(SOURCE/'font-map.json',{'font':'magical_athlete:icons',
        'characters':[{**entry,'glyph':chr(0xe200+entry['id'])} for entry in CHARACTERS],
        'props':{slug:chr(0xe100+i) for i,slug in enumerate(PROPS)},
        'racers':{'height':22,'ascent':19},'prop_height':16})


def previews(mild,wild):
    SOURCE.mkdir(parents=True,exist_ok=True)
    preview=Image.new('RGB',(1536,768),INK)
    preview.paste(mild.resize((768,768),Image.Resampling.LANCZOS),(0,0))
    preview.paste(wild.resize((768,768),Image.Resampling.LANCZOS),(768,0));preview.save(SOURCE/'boards-preview.png')
    sheet=Image.new('RGB',(1152,1344),PAPER);draw=ImageDraw.Draw(sheet)
    for entry in CHARACTERS:
        i=entry['id'];x=(i%6)*192;y=(i//6)*224
        face=icon(entry['slug'],i).resize((144,144),Image.Resampling.LANCZOS)
        sheet.paste(face,(x+24,y+8),face)
        draw.text((x+96,y+171),entry['name'],font=font(20,True),fill=INK,anchor='mm')
        draw.text((x+96,y+204),entry['slug'],font=font(13),fill='#69828b',anchor='mm')
    sheet.save(SOURCE/'racers-preview.png')
    atlas=Image.new('RGB',(768,256),PAPER)
    for i,slug in enumerate(PROPS):
        face=icon(slug,i);atlas.paste(face,((i%6)*128,(i//6)*128),face)
    atlas.save(SOURCE/'props-preview.png')


def build():
    assert [entry['id'] for entry in CHARACTERS]==list(range(36))
    assert len(TRACK['layout']['positions'])==31 and TRACK['finish']==30
    mild,wild=board('mild'),board('wild')
    for entry in CHARACTERS:pawn(entry['slug'],entry['id'])
    dice();props();fonts();previews(mild,wild)
    json_file(SOURCE/'asset-map.json',{'id':23,'namespace':GAME,'texture_style':'Original sports-medallion illustration',
        'track_source':'fimel_cards/tools/magical_athlete_track.json', 'layout':TRACK['layout'],
        'models':{'board':['card:magical_athlete/board/'+k for k in ('mild','wild')],
                  'racers':['card:magical_athlete/racer/'+e['slug'] for e in CHARACTERS],
                  'flat_tokens':['card:magical_athlete/token/'+e['slug'] for e in CHARACTERS],
                  'dice':'card:magical_athlete/dice','cup':'card:magical_athlete/prop/dice_cup'},
        'dice_faces':{'up':1,'down':6,'north':2,'south':5,'east':3,'west':4},
        'footprint_4':2.7,'footprint_8':3.6,'pawn_recommended_scale':.18})
    text_file(SOURCE/'README.md','''# 胡闹运动会原创资源

本目录保留 Fimel Cards 原创体育场、36 枚角色头像立牌、同款平放徽章、六面骰、骰盅、奖杯与道具模型的纹理、可编辑 Blockbench 工程及预览。角色用鲜明的物件／动物徽章区分，不使用 CMYK 的官方插画、商标图或角色牌面。

- `boards-preview.png`：温和／狂野两面；四人桌与八人桌共用纹理，分别缩放至 2.7／3.6 格。
- `racers-preview.png`：36 位角色的中文名、资源名和头像对照。
- `props-preview.png`：骰子、积分、金银奖牌、旗帜、绊倒、传送、火箭、爱心、奖杯、菜单和香蕉。
- `models/`：每个运行模型对应的 `.bbmodel`，内嵌纹理，可直接用 Blockbench 打开。
- `asset-map.json`／`font-map.json`：运行资源 ID、格心、骰子面向与 Unicode 图片字体映射。

赛道规则来自原作，体育场外观重新绘制。唯一格心数据为数据包 `tools/magical_athlete_track.json` 的 `layout.positions`（16×16 模型单位，0 起点、30 终点；第 15 格为第二转角），纹理与运行棋子从同一份格心定位。改棋盘尺寸必须一起重建，不得再独立手写坐标。

`card:magical_athlete/racer/<英文名>` 为带圆形头像的立牌，`token/<英文名>` 为平放圆形徽章。骰子上 1 下 6、北 2 南 5、东 3 西 4，对面合计 7。默认手持缩小，桌面投骰动画使用 `none` 模式并按服务器已锁定点数旋转。

文本图片字体为 `magical_athlete:icons`：角色从 U+E200 至 U+E223，按 0～35 号对应；道具从 U+E100 至 U+E10B。头像字高 22、上升 19；道具字高 16、上升 13。每个单字图像只有 64×64，不依赖系统中文字体显示图案。

在数据包根目录运行 `python tools/build_magical_athlete_assets.py` 重建，依赖 Pillow。音乐和音效原件、作曲源说明与许可见 `audio/`，独立重建器为 `build_magical_athlete_sound.py`。本项目原创图像／模型使用与仓库一致的许可；音频单独按其 CC0 声明。
''')


if __name__=='__main__':
    build();print('Magical Athlete original boards, 36 racers, dice, props, fonts and Blockbench sources built.')
