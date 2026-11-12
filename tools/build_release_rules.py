"""生成发布说明书的资源实图和逐件图鉴；不修改游戏或资源包。

python tools/build_release_rules.py
仅覆盖说明书的 BEGIN/END COMPONENTS 区域，人工规则正文保留。
需要 Pillow、numpy；从本机已安装客户端读取原版物品纹理。
"""
from __future__ import annotations

import argparse
import hashlib
import io
import json
import math
import re
import shutil
import zipfile
from functools import lru_cache
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFont

from boardgame_assets import PACK, RP

ROOT = PACK / 'docs/releases/rules'
IMAGES = ROOT / 'images'
FONT = 'C:/Windows/Fonts/msyh.ttc'
BEGIN, END = '<!-- BEGIN COMPONENTS -->', '<!-- END COMPONENTS -->'
RECORDS = []
GAMES = [
    ('01-Fast Card.md','Fast Card'),('02-赌命德州扑克.md','赌命德州扑克'),
    ('03-花火.md','花火'),('04-出包魔法师.md','出包魔法师'),
    ('05-瞎掰王.md','瞎掰王'),('06-谍报风云.md','谍报风云'),
    ('07-临界点.md','临界点'),('08-问非所答.md','问非所答'),
    ('09-骷髅牌.md','骷髅牌'),('10-斗地主.md','斗地主'),('11-UNO.md','UNO'),
    ('12-国际象棋.md','国际象棋'),('13-中国象棋.md','中国象棋'),
    ('14-五子棋.md','五子棋'),('15-飞行棋.md','飞行棋'),('16-阿瓦隆.md','阿瓦隆'),
    ('17-情书.md','情书'),('18-掼蛋.md','掼蛋'),('19-命悬一线.md','命悬一线'),
    ('20-围棋.md','围棋'),('21-卡坦岛.md','卡坦岛'),('22-璀璨宝石.md','璀璨宝石'),
    ('23-胡闹运动会.md','胡闹运动会'),
]


def load(path):
    return json.loads(Path(path).read_text(encoding='utf-8'))


@lru_cache(None)
def vanilla_jar():
    versions = RP.parents[1]
    choices = sorted(versions.glob('*.jar'))
    choices += sorted((versions.parents[1]/'libraries/net/minecraft/client').glob('**/*.jar'))
    for path in choices:
        with zipfile.ZipFile(path) as archive:
            if 'assets/minecraft/textures/item/paper.png' in archive.namelist():
                return path
    raise FileNotFoundError('找不到包含原版纹理的客户端 JAR')


def resource(path):
    ns, rel = path.split(':',1) if ':' in path else ('minecraft',path)
    return RP/f'assets/{ns}/{rel}'


@lru_cache(None)
def raw_texture(identifier):
    ns, name = identifier.split(':',1)
    relative = f'assets/{ns}/textures/{name}.png'
    path = RP/relative
    meta = None
    if path.is_file():
        image = Image.open(path).convert('RGBA')
        if path.with_suffix('.png.mcmeta').exists():
            meta = load(path.with_suffix('.png.mcmeta')).get('animation',{})
    elif ns=='minecraft':
        with zipfile.ZipFile(vanilla_jar()) as archive:
            image = Image.open(io.BytesIO(archive.read(relative))).convert('RGBA')
            if relative+'.mcmeta' in archive.namelist():
                meta = json.loads(archive.read(relative+'.mcmeta'))['animation']
    else:
        raise FileNotFoundError(path)
    if meta is not None:
        width = meta.get('width',min(image.size))
        height = meta.get('height',min(image.size))
        frame = meta.get('frames',[0])[0]
        frame = frame.get('index',0) if isinstance(frame,dict) else frame
        cols = image.width//width
        x,y = frame%cols*width,frame//cols*height
        image = image.crop((x,y,x+width,y+height))
    return image


@lru_cache(None)
def native_model(identifier):
    ns,name = identifier.split(':',1) if ':' in identifier else ('minecraft',identifier)
    path = RP/f'assets/{ns}/models/{name}.json'
    if not path.exists():
        raise FileNotFoundError(path)
    body = load(path)
    parent = body.get('parent')
    if parent and parent not in ('minecraft:item/generated','minecraft:item/handheld','builtin/generated'):
        base = dict(native_model(parent))
        base['textures'] = {**base.get('textures',{}),**body.get('textures',{})}
        body = {**base,**{k:v for k,v in body.items() if k!='textures'},'textures':base['textures']}
    return body


def rotated(points,rotation):
    if not rotation:
        return points
    points = np.asarray(points,dtype=float)
    origin = np.asarray(rotation.get('origin',[8,8,8]),dtype=float)
    theta = math.radians(rotation.get('angle',0))
    c,s = math.cos(theta),math.sin(theta)
    axis = rotation.get('axis','y')
    matrix = {'x':[[1,0,0],[0,c,-s],[0,s,c]],
              'y':[[c,0,s],[0,1,0],[-s,0,c]],
              'z':[[c,-s,0],[s,c,0],[0,0,1]]}[axis]
    if rotation.get('rescale'):
        scale = np.array([1 if a==axis else 1/abs(c) for a in 'xyz'])
        points = (points-origin)*scale+origin
    return (points-origin)@np.asarray(matrix).T+origin


def mesh(identifier,shift=(0,0,0),scale=1):
    body = native_model(identifier)
    faces = []
    for e in body.get('elements',[]):
        x,y,z = e['from'];X,Y,Z = e['to']
        corners = {'up':[(x,Y,z),(X,Y,z),(X,Y,Z),(x,Y,Z)],
            'down':[(x,y,Z),(X,y,Z),(X,y,z),(x,y,z)],
            'north':[(X,Y,z),(x,Y,z),(x,y,z),(X,y,z)],
            'south':[(x,Y,Z),(X,Y,Z),(X,y,Z),(x,y,Z)],
            'west':[(x,Y,z),(x,Y,Z),(x,y,Z),(x,y,z)],
            'east':[(X,Y,Z),(X,Y,z),(X,y,z),(X,y,Z)]}
        for side,face in e.get('faces',{}).items():
            tex = face.get('texture','')
            if not tex:
                continue
            while tex.startswith('#'):
                tex = body['textures'][tex[1:]]
            points = (rotated(np.array(corners[side]),e.get('rotation'))-8)/16*scale+shift
            faces.append((points,tex,face.get('uv',[0,0,16,16]),face.get('rotation',0)))
    return faces


def render(faces,size=(560,500),camera=(3,3.4,5)):
    """正交投影、逐像素深度缓冲与 UV 采样，直接使用游戏 Java 模型。"""
    view = np.array(camera,dtype=float);view /= np.linalg.norm(view)
    right = np.array([view[2],0,-view[0]]);right /= np.linalg.norm(right)
    up = np.cross(view,right)
    vertices = np.concatenate([f[0] for f in faces])
    projected = np.stack((vertices@right,-vertices@up),axis=1)
    low,high = projected.min(axis=0),projected.max(axis=0)
    zoom = min((size[0]-48)/max(1e-6,high[0]-low[0]),(size[1]-48)/max(1e-6,high[1]-low[1]))
    center = (high+low)/2
    canvas = np.zeros((size[1],size[0],4),dtype=np.uint8)
    depth_buffer = np.full((size[1],size[0]),-np.inf)
    for points,tex,uv,angle in faces:
        quad = (np.stack((points@right,-points@up),axis=1)-center)*zoom+np.array(size)/2
        depths = points@view
        a,b = quad[1]-quad[0],quad[3]-quad[0]
        det = a[0]*b[1]-a[1]*b[0]
        if abs(det)<1e-9:
            continue
        x0,y0 = np.maximum(0,np.floor(quad.min(axis=0)).astype(int))
        x1,y1 = np.minimum(size,np.ceil(quad.max(axis=0)).astype(int))
        if x1<=x0 or y1<=y0:
            continue
        yy,xx = np.mgrid[y0:y1,x0:x1]
        xx=xx+.5-quad[0,0]; yy=yy+.5-quad[0,1]
        s=(b[1]*xx-b[0]*yy)/det;t=(-a[1]*xx+a[0]*yy)/det
        inside=(s>=0)&(s<=1)&(t>=0)&(t<=1)
        ss,tt=s,t
        for _ in range((angle//90)%4):
            ss,tt=tt,1-ss
        bitmap=raw_texture(tex)
        tx=np.clip(((uv[0]+(uv[2]-uv[0])*ss)*bitmap.width/16).astype(int),0,bitmap.width-1)
        ty=np.clip(((uv[1]+(uv[3]-uv[1])*tt)*bitmap.height/16).astype(int),0,bitmap.height-1)
        pixels=np.array(bitmap)[ty,tx].copy()
        d=depths[0]+s*(depths[1]-depths[0])+t*(depths[3]-depths[0])
        visible=inside&(pixels[:,:,3]>0)&(d>depth_buffer[y0:y1,x0:x1]+1e-9)
        normal=np.cross(points[1]-points[0],points[3]-points[0])
        normal/=max(np.linalg.norm(normal),1e-9)
        shade=.73+.27*abs(np.dot(normal,np.array([.25,.9,.35])))
        pixels[:,:,:3]=(pixels[:,:,:3]*min(1,shade)).astype('uint8')
        canvas[y0:y1,x0:x1][visible]=pixels[visible]
        depth_buffer[y0:y1,x0:x1][visible]=d[visible]
    result=Image.fromarray(canvas)
    if result.getbbox() is None:
        raise ValueError('模型渲染为空')
    return result


def save_image(image,key,source,kind):
    path=IMAGES/'components'/(key+'.png')
    path.parent.mkdir(parents=True,exist_ok=True)
    image.save(path,optimize=True)
    RECORDS.append(dict(image=path.relative_to(ROOT).as_posix(),source=source,kind=kind,
        sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    return path.relative_to(ROOT).as_posix()


def sprite(key,name,texture,effect='',count='—'):
    image=raw_texture(texture)
    # Preserve the real card face. No AI redraw, UV atlas or baked first-person pose.
    if max(image.size)<320:
        image=image.resize(tuple(v*max(1,320//max(image.size)) for v in image.size),Image.Resampling.NEAREST)
    path=save_image(image,key,texture,'texture-first-frame')
    return dict(name=name,path=path,effect=effect,count=str(count))


def model(key,name,identifier,effect='',count='—',camera=(3,3.4,5)):
    body=native_model(identifier)
    if not body.get('elements'):
        layer=body.get('textures',{}).get('layer0')
        if layer:
            return sprite(key,name,layer,effect,count)
    path=save_image(render(mesh(identifier),camera=camera),key,identifier,'native-model')
    return dict(name=name,path=path,effect=effect,count=str(count))


def gallery(key,title,entries,cols=4,cell=(300,390)):
    pages=[]
    for start in range(0,len(entries),cols*4):
        subset=entries[start:start+cols*4]
        sheet=Image.new('RGB',(cols*cell[0],85+math.ceil(len(subset)/cols)*cell[1]),'#eee9df')
        draw=ImageDraw.Draw(sheet)
        draw.text((26,18),title,font=ImageFont.truetype(FONT,27),fill='#292f39')
        for i,e in enumerate(subset):
            x=i%cols*cell[0];y=85+i//cols*cell[1]
            art=Image.open(ROOT/e['path']).convert('RGBA')
            art.thumbnail((cell[0]-28,cell[1]-68),Image.Resampling.LANCZOS)
            sheet.paste(art,(x+(cell[0]-art.width)//2,y),art)
            name=e['name']
            draw.text((x+cell[0]//2,y+cell[1]-48),name,font=ImageFont.truetype(FONT,19),anchor='mt',fill='#303848')
        page=IMAGES/'catalogs'/f'{key}-{start//(cols*4)+1:02}.png'
        page.parent.mkdir(parents=True,exist_ok=True);sheet.save(page,optimize=True)
        pages.append(f'![{title}，第 {len(pages)+1} 页]({page.relative_to(ROOT).as_posix()})')
    return '\n\n'.join(pages)


def section(key,title,entries,cols=4):
    header=f'### {title}\n\n'+gallery(key,title,entries,cols)+'\n\n'
    table='| 实图 | 名称 | 数量／所属 | 用途与区别 |\n| --- | --- | --- | --- |\n'
    for e in entries:
        table+=f'| <img src="{e["path"]}" width="88" alt="{e["name"]}"> | {e["name"]} | {e["count"]} | {e["effect"] or "见本说明书的回合与规则说明。"} |\n'
    return header+table


def board_scene(folder,board):
    """实际棋盘与示范棋子组合，避免仅展示一块空纹理。"""
    board_faces=mesh('card:item/'+board,scale=8)
    ymax=max(p[:,1].max() for p,_,_,_ in board_faces)
    faces=[(p-np.array([0,ymax,0]),t,uv,a) for p,t,uv,a in board_faces]
    def put(identifier,x,z,scale=.9):
        part=mesh('card:item/'+identifier,scale=scale)
        bottom=min(p[:,1].min() for p,_,_,_ in part)
        faces.extend((p+np.array([x,.015-bottom,z]),t,uv,a) for p,t,uv,a in part)
    if folder=='chess':
        lineup=['rook','knight','bishop','queen','king','bishop','knight','rook']
        step=8*32/280  # 12 px coordinate border; playable cells are 32 px.
        for color,row,pawnrow in [('black',-3.5,-2.5),('white',3.5,2.5)]:
            for col,piece in enumerate(lineup):
                put(f'chess/ebony/{color}_{piece}',(col-3.5)*step,row*step,step*.39/.27)
                put(f'chess/ebony/{color}_pawn',(col-3.5)*step,pawnrow*step,step*.39/.27)
    elif folder=='xiangqi':
        # The source board's outer frame leaves an inset playing rectangle.
        for color,sign in [('red',1),('black',-1)]:
            for col,piece in enumerate(['rook','horse','elephant','advisor','general','advisor','elephant','horse','rook']):
                put(f'xiangqi/ebony/{color}_{piece}',(col-4)*.8,sign*3.6,.8*.231/.255)
            for col in (1,7):
                put(f'xiangqi/ebony/{color}_cannon',(col-4)*.8,sign*2,.8*.231/.255)
            for col in (0,2,4,6,8):
                put(f'xiangqi/ebony/{color}_pawn',(col-4)*.8,sign*1.2,.8*.231/.255)
    elif folder in ('gomoku','weiqi'):
        step=7/(14 if folder=='gomoku' else 18)
        for color,x,z in [('black',0,0),('white',1,0),('black',0,1),('white',1,1),('black',-1,-1)]:
            put('gomoku/stone/ebony_'+color,x*step,z*step,step*.9)
    else:
        for color,x,z in [('red',-2.6,2.6),('blue',-2.6,-2.6),('green',2.6,-2.6),('yellow',2.6,2.6)]:
            for dx,dz in [(-.25,-.25),(.25,-.25),(-.25,.25),(.25,.25)]:
                put('aeroplane_chess/plane/classic_'+color,x+dx,z+dz,.37)
        put('aeroplane_chess/dice',0,0,.75)
    return render(faces,size=(1440,1100),camera=(1.8,5,4.5))


def athlete_scene(kind):
    track=load(PACK/'tools/magical_athlete_track.json')
    faces=mesh('card:item/magical_athlete/board/'+kind,scale=8)
    for slug,pos in [('magician',0),('romantic',4),('sisyphus',9),('baba-yaga',15),('rocket-scientist',21),('legs',29)]:
        x,z=track['layout']['positions'][pos]
        for points,texture,uv,angle in mesh('card:item/magical_athlete/token/'+slug,scale=.68):
            points=points.copy();points[:,0]*=-1;points[:,2]*=-1
            points+=np.array([(x-8)*.5,.036,(z-8)*.5])
            faces.append((points,texture,uv,angle))
    return render(faces,size=(1600,1300),camera=(2.4,5,4.6))


def poker_deck():
    entries=[]
    # The inherited pack calls its spade sprite "c" and club sprite "s".
    for suit,name in [('c','黑桃'),('h','红桃'),('s','梅花'),('d','方块')]:
        for rank in ['2','3','4','5','6','7','8','9','10','j','q','k','a']:
            entries.append(sprite(f'poker/{suit}_{rank}',name+rank.upper(),f'card:item/poker/{suit}_{rank}',
                '点数和花色见牌角；不同游戏的大小关系及连续牌规则分别说明。',1))
    for slug,name in [('j_2','小王'),('j_1','大王'),('joker','小丑')]:
        entries.append(sprite(f'poker/{slug}',name,f'card:item/poker/{slug}','专用特殊牌；是否使用见该游戏牌库。',1))
    return entries


def all_components():
    components={i:[] for i in range(1,24)}
    poker=poker_deck()
    fast=[e for e in poker if re.fullmatch('(黑桃|红桃|梅花|方块)(10|J|Q|K)',e['name'])]+[poker[-1]]
    components[1].append(section('01-cards','17 张传牌牌库',fast))
    poker_sample=poker[:13]+[poker[25],poker[38],poker[51]]
    for game,kings,multiplicity in [(2,False,1),(10,True,1),(18,True,2)]:
        sample=poker_sample+(poker[52:54] if kings else [])
        cards=section(f'{game:02}-cards','扑克牌面示例与完整牌库清单',sample)
        cards+='\n花色与点数只改变牌角和花色图案，省略重复的大图。下表列出实际全部牌面：\n\n| 花色 | 全部点数 | 各牌面张数 |\n| --- | --- | --- |\n'
        for suit in ('黑桃','红桃','梅花','方块'):
            cards+=f'| {suit} | 2、3、4、5、6、7、8、9、10、J、Q、K、A | {multiplicity} |\n'
        if kings:
            cards+=f'| 王 | 小王、大王 | {multiplicity} |\n'
        components[game].append(cards)
    for n in (1,2,10,18):
        box=model('poker/box','公共扑克牌盒','card:item/cardbox','仅用于发牌、收牌展示，不是可带走的手牌。',1)
        components[n].append(section(f'{n:02}-box','牌盒',[box]))
    hb=[]
    for color,name in [('w','白色'),('r','红色'),('b','蓝色'),('y','黄色'),('g','绿色'),('m','彩色')]:
        for digit in range(1,6):
            count=1 if color=='m' else (3 if digit==1 else 1 if digit==5 else 2)
            hb.append(sprite(f'hanabi/{color}_{digit}',f'{name}{digit}',f'card:item/hanabi/{color}_{digit}',
                f'只能在{name}烟花堆顶为 {digit-1} 时打出。'+('仅彩色风暴启用。' if color=='m' else ''),count))
    sample=[e for e in hb if e['name'].startswith('红色') or e['name'].endswith('1')]
    components[3].append(section('03-cards','烟花牌示例：数字与各颜色',sample,5)+'\n完整牌库：白、红、蓝、黄、绿各有 1×3、2×2、3×2、4×2、5×1；可选彩色另有 1～5 各一。相同版式不重复逐色展开。\n')
    hbknown=[sprite('hanabi/back','未知牌背','card:item/hanabi/back','自己看不见尚未获得提示的牌。')]
    hbknown += [sprite(f'hanabi/{c}_color',name+'已知色','card:item/hanabi/'+c+'_color','只知道颜色，不知道数字。') for c,name in [('w','白'),('r','红'),('b','蓝'),('y','黄'),('g','绿'),('m','彩色')]]
    hbknown += [sprite(f'hanabi/n_{d}',f'已知数字{d}',f'card:item/hanabi/n_{d}','只知道数字，不知道颜色。') for d in range(1,6)]
    components[3].append(section('03-information','隐藏信息与提示后的牌面',hbknown))
    spells=[('古代巨龙','其他所有人受到同样的随机 1～3 点伤害。'),('黑暗幽灵','其他人各失 1 生命，自己恢复 1。'),('甜蜜的梦','自己恢复随机 1～3 生命。'),('猫头鹰','私下查看一枚秘密石，存活结算时获得额外塔层。'),('闪电暴风雨','左右邻座各失 1 生命；两人局不重复扣。'),('暴风雪','左邻失 1 生命。'),('火球','右邻失 1 生命。'),('魔法药水','自己恢复 1 生命。')]
    entries=[sprite(f'abraca/{i}',f'{i} · {name}',f'card:item/abraca/spell_{i}',effect,i) for i,(name,effect) in enumerate(spells,1)]
    components[4].append(section('04-spells','36 枚咒语石，8 种效果',entries))
    components[4].append(section('04-box','牌背、秘密石与牌盒',[
        sprite('abraca/back','普通牌背','card:item/abraca/back','本人未知咒语。'),
        sprite('abraca/secret','秘密石','card:item/abraca/secret','每小局预留 4 枚；猫头鹰用于查看。',4),
        model('abraca/box','咒语牌盒','card:item/abraca/box','剩余普通咒语石。',1)]))
    components[5].append(section('05-call','专用质疑牌',[sprite('bullshit/call','净他喵扯淡！','card:item/bullshit/call','大聪明每轮可质疑一人；不代替最终指认。',1)]))
    critical=[sprite(f'critical/{i}',f'数字 {i}',f'card:item/poker/c_{i}','每名玩家整局限用一次；不比较花色。','每人 1 张') for i in range(1,6) if i!=1]
    critical.insert(0,sprite('critical/1','数字 1','card:item/poker/c_a','本游戏按 1 点计，不按扑克 A 的大小。','每人 1 张'))
    components[7].append(section('07-numbers','每人的五张数字牌',critical,5))
    skull=[]
    for seat in range(1,9):
        for kind,name,count,effect in [('flower','花牌',3,'挑战时翻到即安全，累计花数。'),('skull','骷髅',1,'挑战者翻到立即失败。'),('back','统一牌背','—','扣放时不公开正面。')]:
            skull.append(sprite(f'skull/{seat}/{kind}',f'{seat}号座 · {name}',f'card:item/skull/set{seat}/{kind}',effect,count))
    components[9].append(section('09-sets','八个座位的花牌、骷髅与牌背',skull,3))
    uno=[]
    for color,name in [('r','红'),('y','黄'),('g','绿'),('b','蓝')]:
        for digit in range(10):
            uno.append(sprite(f'uno/{color}{digit}',f'{name}{digit}',f'card:item/uno/{color}{digit}','同色或同数字可出；计分按面值。',1 if digit==0 else 2))
        for slug,label,effect in [('skip','跳过','下一家跳过回合。'),('reverse','反转','反转行动方向；二人时等于跳过。'),('draw2','+2','下一家摸 2 张并跳过；不能叠加。')]:
            # Actual resource filenames are resolved explicitly below.
            alias={'skip':'s','reverse':'r','draw2':'d'}[slug]
            candidates=[f'{color}{"plus2" if slug=="draw2" else slug}',f'{color}_{slug}',f'{color}{alias}',f'{color}_{alias}']
            actual=next((x for x in candidates if (RP/f'assets/card/textures/item/uno/{x}.png').exists()),None)
            if actual is None:
                raise FileNotFoundError(f'UNO {color} {slug}')
            uno.append(sprite(f'uno/{actual}',name+label,f'card:item/uno/{actual}',effect,2))
    for slug,name,effect in [('wild','变色','指定后续颜色，50 分。'),('wild_draw4','变色 +4','指定颜色并要求下一家接受或质疑，50 分。')]:
        candidates=[slug,'wild_plus4' if slug!='wild' else 'wild','w' if slug=='wild' else 'w4']
        actual=next(x for x in candidates if (RP/f'assets/card/textures/item/uno/{x}.png').exists())
        uno.append(sprite(f'uno/{actual}',name,f'card:item/uno/{actual}',effect,4))
    sample=[e for e in uno if e['name'].startswith('红') or e['name'] in ('黄0','绿0','蓝0','变色','变色 +4')]
    components[11].append(section('11-cards','UNO 全部功能与颜色示例',sample)+'\n完整颜色／牌型清单：红、黄、绿、蓝每色都有 0、1、2、3、4、5、6、7、8、9、跳过、反转、+2；每色 0 一张，其他各两张。变色与变色 +4 无固定色，各四张。相同符号的四色效果相同，省略换色重复图。\n')
    for game,folder,board in [(12,'chess','chess/board_classic'),(13,'xiangqi','xiangqi/board_classic'),(14,'gomoku','gomoku/board/classic_15_coords'),(15,'aeroplane_chess','aeroplane_chess/board/classic'),(20,'weiqi','weiqi/board/classic_19_coords')]:
        model_id='card:item/'+board
        if not (RP/('assets/card/models/item/'+board+'.json')).exists():
            model_id='card:item/'+folder+'/board/'+board.split('/')[-1]
        path=save_image(board_scene(folder,model_id.split('item/',1)[1]),folder+'/scene',model_id,'native-model-scene')
        components[game].append('### 棋盘与棋子组合预览\n\n![棋盘模型与示范棋子]('+path+')\n\n国际象棋为标准开局；其他组合用于辨认组件与位置，具体初始布局由游戏自动摆放。配色不改变规则，不重复展开同模型换色图。\n')
    chess=[]
    info=[('king','王',1,'任意方向一格；不能进入被攻击格。'),('queen','后',1,'横竖斜线任意距离，不越子。'),('rook','车',2,'横竖任意距离，不越子。'),('bishop','象',2,'斜线任意距离，不越子。'),('knight','马',2,'日形跳跃，可越子。'),('pawn','兵',8,'向前行、斜前吃；首步两格及升变见正文。')]
    for color,label in [('white','白'),('black','黑')]:
        for slug,name,count,effect in info:
            chess.append(model(f'chess/{color}_{slug}',label+name,f'card:item/chess/ebony/{color}_{slug}',effect,count))
    components[12].append(section('12-pieces','双方全部 32 枚棋子：12 种外观',chess,6))
    xq=[]
    for color,label in [('red','红'),('black','黑')]:
        for slug,r,b,count,effect in [('general','帅','将',1,'九宫内横直一格；不能将帅照面。'),('advisor','仕','士',2,'九宫斜一格；揭棋翻明后可离宫。'),('elephant','相','象',2,'田字，堵象眼不能走；标准局不得过河。'),('horse','马','马',2,'日字，先检查马腿。'),('rook','车','车',2,'横竖任意距离，不越子。'),('cannon','炮','炮',2,'平移同车，吃子必须隔一个炮架。'),('pawn','兵','卒',5,'前进一步，过河可左右，不后退。'),('covered','暗子','暗子',15,'仅揭棋使用，首步按位置规则，落地再翻明。')]:
            xq.append(model(f'xiangqi/{color}_{slug}',label+(r if color=='red' else b),f'card:item/xiangqi/ebony/{color}_{slug}',effect,count))
    components[13].append(section('13-pieces','全部棋种与揭棋盖面',xq))
    stones=[model(f'gomoku/{c}',label+'子',f'card:item/gomoku/stone/ebony_{c}','置于交点；颜色代表行棋方。') for c,label in [('black','黑'),('white','白')]]
    for g in (14,20):
        components[g].append(section(f'{g:02}-stones','黑白棋子',stones,2))
    planes=[model(f'aeroplane/{c}',label+'飞机',f'card:item/aeroplane_chess/plane/classic_{c}','同色 4 架分别行动；都到终点才能完成比赛。',4) for c,label in [('red','红'),('blue','蓝'),('green','绿'),('yellow','黄')]]
    planes.append(model('aeroplane/dice','共用骰子','card:item/aeroplane_chess/dice','六面点数 1～6；只在本人可投骰时操作。',1))
    components[15].append(section('15-pieces','四方飞机与骰子',planes))
    av=[]
    for slug,name,effect in [('merlin','梅林','好人；看见全部坏人，包括奥伯伦。'),('percival','派西维尔','好人；看见梅林与莫甘娜两名候选。'),('loyalist','忠臣','好人；没有额外情报。'),('morgana','莫甘娜','坏人；伪装成梅林，与可互认坏人互认。'),('assassin','刺客','坏人；可刺杀梅林。'),('oberon','奥伯伦','坏人；与其他坏人互不认识。'),('minion','爪牙','坏人；与非奥伯伦坏人互认。')]:
        av.append(sprite('avalon/'+slug,name,'card:avalon/'+slug,effect,'按人数表配置'))
    components[16].append(section('16-roles','七种身份牌',av))
    components[16].append(section('16-route','任务路线',[sprite('avalon/route','五次任务','card:avalon/map/route','成功、失败标记放在对应任务；否决不推进任务。',1)],1))
    ll=[]
    names=[('spy','间谍',2),('guard','侍卫',6),('priest','牧师',2),('baron','男爵',2),('handmaid','侍女',2),('prince','王子',2),('chancellor','大臣',2),('king','国王',1),('countess','女爵',1),('princess','公主',1)]
    effects=['曾用过间谍的唯一存活者额外 +1 好感。','猜非侍卫身份，猜中淘汰。','私看目标手牌。','比剩余手牌，低者淘汰。','保护自己至下次摸牌前。','目标弃牌重摸，可选自己。','再摸至多两张，从候选中留一张，其余放牌堆底。','交换手牌。','持王子或国王时必须出女爵。','打出或弃掉自己立即淘汰。']
    for n,((slug,name,count),effect) in enumerate(zip(names,effects)):
        ll.append(sprite('love_letter/'+slug,f'{n} · {name}','card:item/love_letter/'+slug,effect,count))
    components[17].append(section('17-roles','21 张角色牌：全部 10 种正面',ll,5))
    components[17].append(section('17-props','牌盒与状态标记',[
        model('love_letter/box','牌盒','card:item/love_letter/box','上方数字是实时普通牌库余量。',1),
        sprite('love_letter/back','牌背','card:item/love_letter/back','秘密手牌不向其他人显示正面。'),
        sprite('love_letter/favor','好感','card:item/love_letter/favor','小局胜者及合格间谍获得。'),
        sprite('love_letter/protection','保护','card:item/love_letter/protection','该玩家暂时不能被角色效果指定。')]))
    ito=[sprite(f'ito/{i}',f'{i}',f'card:item/ito/{i}','仅持有人知道数值；用主题描述相对程度，不可直接说数字。',1) for i in (1,25,50,75,100)]
    components[19].append(section('19-examples','数字牌示例：省略重复的 1～100 展开',ito,5)+'\n牌库是整数 1～100，各一张。它们的规则相同，只是数字不同，因此不再逐张铺图。全部牌的用法均为：根据所发主题描述相对程度，按对应模式出牌或配对。\n')
    catan=[]
    for slug,name,effect,count in [('forest','森林','产木材，建路与村庄使用。',4),('hills','丘陵','产砖块，建路与村庄使用。',3),('pasture','牧场','产羊毛，建村庄与买开发牌使用。',4),('fields','麦田','产粮食，建村庄、城市与开发牌使用。',4),('mountains','矿山','产矿石，建城市与开发牌使用。',3),('desert','沙漠','不生产；开局强盗在此。',1)]:
        catan.append(model('catan/tile/'+slug,name,'card:item/catan/tile/'+slug,effect,count))
    components[21].append(section('21-terrain','19 块立体地形',catan,3))
    catan=[]
    for slug,name in [('wood','木材'),('brick','砖块'),('wool','羊毛'),('grain','粮食'),('ore','矿石')]:
        catan.append(sprite('catan/resource/'+slug,name,'card:item/catan/resource/'+slug,'资源是秘密手牌；用于支付费用和交易。',19))
    components[21].append(section('21-resources','95 张资源牌：五种各 19 张',catan,5))
    catan=[]
    for c,label in [('red','红'),('blue','蓝'),('white','白'),('orange','橙')]:
        for slug,name,count,effect in [('road','道路',15,'连接己方网络，不直接计分。'),('settlement','村庄',5,'1 分，每次邻格生产领 1。'),('city','城市',4,'升级村庄，总计 2 分，每次邻格生产领 2。')]:
            catan.append(model(f'catan/{slug}/{c}',label+name,f'card:item/catan/{slug}/{c}',effect,'每方 '+str(count)))
    catan += [model('catan/robber','强盗','card:item/catan/robber','所在地块不生产；移动后可偷相邻对手资源。',1),model('catan/deck','开发牌堆','card:item/catan/development_deck','25 张；余量显示在牌堆上。',1)]
    components[21].append(section('21-pieces','四色建筑、强盗与开发牌堆',catan))
    ports=[model('catan/port/'+slug,name,'card:item/catan/port/'+slug,effect,count) for slug,name,effect,count in [('generic','通用港','任一资源 3:1。',4),('wood','木材港','木材 2:1。',1),('brick','砖块港','红边框的大幅红砖堆；砖块 2:1。',1),('wool','羊毛港','绿边框的浅色毛线团；羊毛 2:1。',1),('grain','粮食港','粮食 2:1。',1),('ore','矿石港','矿石 2:1。',1)]]
    ports.append(model('catan/dock','栈桥与帆船','card:item/catan/port/dock','相邻交点有自己的建筑才拥有港口。',9))
    components[21].append(section('21-ports','9 个港口的全部类型',ports))
    labels=[model('catan/number/'+str(n),f'数字 {n}','card:item/catan/number/'+str(n),'两骰之和为该数时生产；6、8 红色标注。','见正文') for n in (2,6,8)]
    labels += [model('catan/dice/'+c,name,'card:item/catan/dice/'+c,'两枚点数相加；7 不生产，改处理强盗。',1) for c,name in [('ivory','白骰'),('red','红骰')]]
    components[21].append(section('21-labels','数字标记示例与双骰',labels,5)+'\n数字全表：2、12 各一枚；3、4、5、6、8、9、10、11 各两枚，共十八枚。没有 7 标记；沙漠不放数字。相同数字版式省略重复展示。\n')
    dev=[]
    for slug,name,item,count,effect in [('knight','骑士','iron_sword',14,'移动强盗、偷资源，计入军队。'),('road_building','修路','stick',2,'免费修至多两段合法道路。'),('monopoly','垄断','gold_ingot',2,'取得全部对手所选资源。'),('plenty','丰收（发明）','wheat',2,'从银行选两张资源，可同种。'),('victory_point','胜利点','gold_nugget',5,'秘密 +1 分；无需打出。')]:
        # Read actual item definition so later sprite changes cannot silently drift.
        itemdef=load(RP/f'assets/card/items/catan/hand/dev/{slug}.json')
        chosen=itemdef['model'].get('fallback',itemdef['model'])['model'].split('/')[-1]
        tex='minecraft:block/rail' if chosen=='rail' else 'minecraft:item/'+chosen
        dev.append(sprite('catan/dev/'+slug,name,tex,effect,count))
    components[21].append(section('21-dev','25 张开发牌：五种道具外观',dev,5))
    for name in ('board_preview_c4o0.png','board_preview_c4o1.png','board_preview_c8o0.png','board_preview_c8o1.png'):
        target=IMAGES/'boards'/('catan-'+name)
        target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(RP/'.source/catan'/name,target)
    components[21].insert(0,'### 完整立体棋盘\n\n![四座桌棋盘模型实图](images/boards/catan-board_preview_c4o0.png)\n\n展示用建筑用于辨认组件，不代表初始布置。另可查看[四座旋转](images/boards/catan-board_preview_c4o1.png)、[八座默认](images/boards/catan-board_preview_c8o0.png)、[八座旋转](images/boards/catan-board_preview_c8o1.png)。\n')
    data=load(PACK/'tools/splendor_cards.json')
    tokens=[sprite('splendor/token/'+slug,name,'minecraft:item/'+item,effect,'按人数表') for slug,name,item,effect in [('diamond','钻石','diamond','白色普通宝石。'),('sapphire','蓝宝石','lapis_lazuli','蓝色普通宝石。'),('emerald','祖母绿','emerald','绿色普通宝石。'),('ruby','红宝石','redstone','红色普通宝石。'),('onyx','缟玛瑙','coal','黑色普通宝石。'),('gold','黄金','gold_ingot','万能支付，只能随预定领取，不能直接拿。')]]
    components[22].append(section('22-tokens','六种筹码',tokens,6))
    components[22].append(section('22-mat','市场底板',[sprite('splendor/mat','市场布局','card:item/splendor/mat','三层各四牌、左侧牌堆、上方贵族、下方六色银行。',1)],1))
    color_names=['钻石','蓝宝石','祖母绿','红宝石','缟玛瑙']
    cost=lambda values:'＋'.join(f'{color_names[i]}{v}' for i,v in enumerate(values) if v) or '无'
    for tier in (1,2,3):
        entries=[]
        for card in data['cards']:
            if card['tier']!=tier:
                continue
            entries.append(sprite('splendor/'+card['name'],f'{card["id"]+1:02} · {color_names[card["bonus"]]} · {card["points"]}分','card:item/splendor/'+card['name'],
                f'购买费用：{cost(card["cost"])}。购买后永久提供 1 {color_names[card["bonus"]]}折扣；得 {card["points"]} 分。',1))
        components[22].append(section(f'22-tier{tier}',f'{tier} 级发展卡：{len(entries)} 张逐张图鉴',entries,5))
    nobles=[]
    for n in data['nobles']:
        name=n.get('name',f'noble/{n["id"]:02}')
        candidates=['noble/'+n['name'],f'noble/{n["id"]}',f'noble/{n["id"]+1}',f'noble/{n["id"]:02}',f'nobles/{n["id"]}']
        stem=next((x for x in candidates if (RP/f'assets/card/textures/item/splendor/{x}.png').exists()),None)
        if stem is None:
            raise FileNotFoundError(f'贵族纹理 {n}')
        requirement=n.get('requirement',n.get('cost',n.get('requirements')))
        nobles.append(sprite('splendor/'+stem,f'贵族 {n["id"]+1}','card:item/splendor/'+stem,'需要永久折扣：'+cost(requirement)+'；来访 +3 分。',1))
    components[22].append(section('22-nobles','10 位贵族逐张需求',nobles,5))
    racers=load(PACK/'tools/magical_athlete_characters.json')
    figures=[]
    for c in racers:
        label=f'{c["id"]+1:02} · {c["name"]}'
        figures.append(model('magical/figure/'+c['slug'],label,'card:item/magical_athlete/token/'+c['slug'],c['ability'],1,camera=(3,2.8,-5)))
    combined='### 36 位选手：立体棋子与完整能力\n\n'+gallery('23-figures','36 位选手立体模型',figures,4)+'\n\n| 棋子模型 | 选手 | 完整能力 |\n| --- | --- | --- |\n'
    for figure in figures:
        combined+=f'| <img src="{figure["path"]}" width="112" alt="{figure["name"]}棋子"> | {figure["name"]} | {figure["effect"]} |\n'
    components[23].append(combined)
    boards=[]
    for slug,name in [('mild','普通赛道 · 昼间体育场'),('wild','狂野赛道 · 夜间体育场')]:
        path=save_image(athlete_scene(slug),'magical/stadium_'+slug,'card:item/magical_athlete/board/'+slug,'native-model-scene')
        boards.append(f'### {name}\n\n![{name}立体看台与棋子实图]({path})\n\n展示用选手仅用于辨认模型，比赛阵容与位置由实际对局决定。\n')
    components[23][0:0]=boards
    faces=[sprite('magical/guess/'+str(n),f'预测 {n} 点','card:item/magical_athlete/guess/'+str(n),'天才技能：前六格依次放 1～6，Q 一次预测；第七格可不预测。',1) for n in range(1,7)]
    components[23].append(section('23-guess','天才的六种独立骰面选项',faces,6))
    return components


def write_catalogs(components):
    for number,(filename,_) in enumerate(GAMES,1):
        path=ROOT/filename
        text=path.read_text(encoding='utf-8')
        catalog='## 组件实图与逐件图鉴\n\n这些图片直接取自配套资源包，立体物件按实际 Java 模型渲染。卡牌展示真实正面，动画纹理取第一帧；皮肤头像、发光和粒子属于游戏内动态效果。\n\n'+'\n\n'.join(components[number])
        if not components[number]:
            catalog+='本游戏的信息通过文字、书本和原版染料显示；没有额外的独立棋盘或插画牌组。正文逐项说明身份、操作物与题卡类别。\n'
        block=BEGIN+'\n\n'+catalog.strip()+'\n\n'+END
        if BEGIN in text:
            text=re.sub(re.escape(BEGIN)+r'.*?'+re.escape(END),lambda _:block,text,flags=re.S)
        else:
            text+='\n\n'+block+'\n'
        path.write_text(text,encoding='utf-8')
    # These two generated directories belong exclusively to this tool. Prune
    # obsolete numeric sheets and unused duplicates; never touch migrated icons.
    used=set()
    for path in ROOT.glob('*.md'):
        text=path.read_text(encoding='utf-8')
        used.update(re.findall(r'(images/(?:components|catalogs)/[^)"\s<>]+\.png)',text))
    for folder in ('components','catalogs'):
        owned=(IMAGES/folder).resolve()
        for path in owned.rglob('*.png'):
            resolved=path.resolve()
            if owned not in resolved.parents:
                raise ValueError('图片清理路径越界')
            if path.relative_to(ROOT).as_posix() not in used:
                path.unlink()
    unique={r['image']:r for r in RECORDS if r['image'] in used}
    manifest=dict(version=1,generator='tools/build_release_rules.py',note='Native resource images; no Minecraft screenshot claims.',
        catalog_counts={'games':23,'splendor_development_cards':90,'splendor_nobles':10,'magical_athlete_characters':36},
        images=list(unique.values()))
    (IMAGES/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')


def validate():
    problems=[]
    paths=[ROOT/f for f,_ in GAMES]+[ROOT/'README.md',ROOT/'00-新手入门与界面图例.md',IMAGES/'README.md']
    for path in paths:
        if not path.exists():
            problems.append('missing '+str(path));continue
        text=path.read_text(encoding='utf-8')
        if path.name in {f for f,_ in GAMES}:
            if text.count(BEGIN)!=1 or text.count(END)!=1:
                problems.append(path.name+': missing/duplicate component section')
            if text.count('\n## ')<5:
                problems.append(path.name+': incomplete manual structure')
        links=re.findall(r'!?(?:\[[^\]]*\])\(<?([^)>]+)>?\)',text)+re.findall(r'<img[^>]+src="([^"]+)"',text)
        for link in links:
            if '://' in link or link.startswith('#'):
                continue
            from urllib.parse import unquote
            target=(path.parent/unquote(link.split('#')[0])).resolve()
            if not target.exists():
                problems.append(f'{path.name}: missing {link}')
    for item in load(IMAGES/'manifest.json')['images']:
        path=ROOT/item['image']
        with Image.open(path) as im:
            im.verify()
        if hashlib.sha256(path.read_bytes()).hexdigest()!=item['sha256']:
            problems.append('hash mismatch '+str(path))
    preview=Image.open(IMAGES/'icons/preview.png')
    if preview.size!=(1280,1280):
        problems.append(f'icon preview should be 5 columns, got {preview.size}')
    icon=Image.open(IMAGES/'icons/22.png').convert('RGBA')
    if icon.getpixel((0,0))[3]!=0:
        problems.append('Splendor icon corners are not transparent')
    for folder in ('components','catalogs'):
        for path in (IMAGES/folder).rglob('*.png'):
            if not any(path.relative_to(ROOT).as_posix() in p.read_text(encoding='utf-8') for p in ROOT.glob('*.md')):
                problems.append('unreferenced image '+str(path))
    if problems:
        raise SystemExit('\n'.join(problems))
    print(f'Validated {len(paths)} manuals/indexes and {len(load(IMAGES/"manifest.json")["images"])} component images.')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check',action='store_true')
    args=parser.parse_args()
    if not args.check:
        components=all_components()
        write_catalogs(components)
    validate()
