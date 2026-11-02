"""卡坦岛：CC0 地形、原创立体棋子、统一拓扑与按桌隔离的事件动画。"""
from __future__ import annotations

import argparse
import copy
import hashlib
import json
import math
from io import BytesIO
from pathlib import Path
import random
from zipfile import ZipFile

from PIL import Image, ImageDraw, ImageEnhance, ImageFont
from boardgame_assets import PACK, RP, CARD, cube, disc, export_texture, export_model, json_file, text_file
from catan_topology import HEXES, VERTICES, EDGES, PORTS, hex_position, vertex_position

ROOT = PACK/'data/catan/function/visual'
SOURCE = RP/'.source/catan'
OBJECTIVES = {key:'dummy' for key in ('ca_vid','ca_vkind','ca_vtimer','ca_vstep','ca_vlife')}
COLORS = ('red','blue','white','orange')
COLORS_RGB = ('#b94b43','#3b80b4','#e3d9ba','#da883a')
TERRAINS = ('forest','hills','pasture','fields','mountains','desert')
SIZES = {4:(.25,1.35),8:(.35,1.8)}
HALF = math.sqrt(.5)
FACE_ROTATIONS = {1:(0,0,0,1),6:(1,0,0,0),2:(HALF,0,0,HALF),5:(-HALF,0,0,HALF),3:(0,0,HALF,HALF),4:(0,0,-HALF,HALF)}
USED = set()


def fmt(value):
    return f'{value:.8f}'.rstrip('0').rstrip('.') if value else '0'


def put(name,body):
    body='\n'.join(body) if isinstance(body,list) else body
    text_file(ROOT/(name+'.mcfunction'),'\n'.join(line[1:] if line.startswith('$') and '$(' not in line else line for line in body.splitlines()))


def png(name,image):
    export_texture('catan',name,image)


def model(name,body):
    body.setdefault('credit','Fimel Cards; CC0 terrain by Kenney, original game-piece geometry')
    body.setdefault('gui_light','front')
    export_model('catan',name,body)
    # Java uses an axis/angle object; Blockbench stores Euler rotations separately.
    source=SOURCE/'models'/(name+'.bbmodel')
    editable=json.loads(source.read_text(encoding='utf-8'))
    for element,java in zip(editable['elements'],body.get('elements',[])):
        rotation=java.get('rotation')
        if rotation:
            element['origin']=rotation.get('origin',[8,8,8])
            element['rotation']=[rotation.get(axis,0) for axis in ('x','y','z')]
            if 'axis' in rotation:element['rotation']['xyz'.index(rotation['axis'])]=rotation['angle']
    json_file(source,editable)


def font(size,bold=True):
    return ImageFont.truetype('C:/Windows/Fonts/'+('arialbd.ttf' if bold else 'arial.ttf'),size)


def original(path):
    archive=SOURCE/'vendor/kenney_hexagon-pack.zip'
    with ZipFile(archive) as z:
        raw=z.read(path)
    target=SOURCE/'vendor/originals'/path
    target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw)
    USED.add(path)
    return Image.open(BytesIO(raw)).convert('RGBA')


def wood(color,seed):
    image=Image.new('RGB',(32,32),color);draw=ImageDraw.Draw(image)
    rng=random.Random(seed)
    base=tuple(int(color[i:i+2],16) for i in (1,3,5))
    for y in range(32):
        amount=rng.choice((-10,-6,-3,0,2,5,8))
        c=tuple(max(0,min(255,v+amount)) for v in base)
        draw.line((0,y,31,y),fill=c)
    for _ in range(10):
        x,y=rng.randrange(25),rng.randrange(30)
        draw.line((x,y,x+rng.randrange(3,7),y),fill=tuple(max(0,v-15) for v in base))
    return image


def top_plane(texture,x0=0,z0=0,x1=16,z1=16,y=0):
    return {'from':[x0,y,z0],'to':[x1,y+.01,z1],
            'faces':{'up':{'texture':'#'+texture,'uv':[0,0,16,16]}}}


def wall(a,b,texture,height=.65,thickness=.22):
    mx,mz=(a[0]+b[0])/2,(a[1]+b[1])/2
    length=math.hypot(a[0]-b[0],a[1]-b[1])
    piece=cube([mx-length/2,-height,mz-thickness/2],[mx+length/2,.005,mz+thickness/2],texture)
    piece['rotation']={'origin':[mx,0,mz],'axis':'y','angle':-math.degrees(math.atan2(b[1]-a[1],b[0]-a[0])),'rescale':False}
    piece['faces'].pop('down',None)
    return piece


def hex_mask(pointy=True):
    mask=Image.new('L',(128,128),0);draw=ImageDraw.Draw(mask)
    ps=[(63.5+63.5*math.cos(math.radians(30+60*k)),63.5+63.5*math.sin(math.radians(30+60*k))) for k in range(6)] if pointy else [(63.5+63.5*math.cos(math.radians(60*k)),63.5+63.5*math.sin(math.radians(60*k))) for k in range(6)]
    # Pointy images map onto a √3:2 rectangle; normalized coordinates need full width.
    if pointy:ps=[(64,1),(127,32.5),(127,95.5),(64,127),(1,95.5),(1,32.5)]
    draw.polygon(ps,fill=255)
    return mask,ps


def sheep(draw,x,y,size=1):
    draw.rectangle((x-4*size,y-1*size,x+4*size,y+4*size),fill='#f3ead6')
    draw.rectangle((x-5*size,y,x-3*size,y+3*size),fill='#eee4c9')
    draw.rectangle((x+3*size,y,x+6*size,y+3*size),fill='#594d3a')
    for lx in (-3,2):draw.rectangle((x+lx*size,y+4*size,x+(lx+1)*size,y+6*size),fill='#5c5845')


def resources():
    SOURCE.mkdir(parents=True,exist_ok=True)
    terrain_sources=('Grass/grass_12','Dirt/dirt_04','Grass/grass_05','Dirt/dirt_06','Stone/stone_07','Sand/sand_07')
    preview=Image.new('RGB',(128*6,196),'#eee6d4');pd=ImageDraw.Draw(preview)
    for index,(name,source) in enumerate(zip(TERRAINS,terrain_sources)):
        image=original('PNG/Tiles/Terrain/'+source+'.png').resize((128,128),Image.Resampling.NEAREST)
        image=ImageEnhance.Color(image).enhance(.78)
        draw=ImageDraw.Draw(image)
        if name=='pasture':
            for x,y in ((35,30),(90,39),(34,88),(88,91)):sheep(draw,x,y)
        if name=='fields':
            draw.polygon([(12,37),(35,17),(53,31),(31,55)],fill='#c29b46')
            draw.polygon([(77,80),(99,64),(115,87),(92,108)],fill='#d6b05b')
            for x,y in ((20,38),(29,31),(38,25),(85,82),(94,75),(101,87)):
                draw.line((x,y+8,x+4,y-2),fill='#f0d180',width=2)
                draw.line((x+1,y+3,x-2,y),fill='#e4c365',width=2)
            obj=original('PNG/Objects/hay.png').resize((22,20),Image.Resampling.NEAREST)
            image.alpha_composite(obj,(82,23))
        if name in ('hills','mountains','desert'):
            objs={'hills':[('rockBrown_large',29,22,22,32),('rockBrown_small',78,82,24,21)],
                  'mountains':[('rockGrey_large',17,14,38,47),('mine',79,71,25,31)],
                  'desert':[('cactus1',31,23,16,28),('cactus2',82,82,16,22)]}[name]
            for obj,x,y,w,h in objs:
                image.alpha_composite(original('PNG/Objects/'+obj+'.png').resize((w,h),Image.Resampling.NEAREST),(x,y))
        mask,ps=hex_mask();image.putalpha(mask)
        draw=ImageDraw.Draw(image);draw.line(ps+[ps[0]],fill='#e3c58e',width=2)
        png('tile/'+name,image)
        preview.paste(image,(index*128,0),image);pd.text((index*128+64,150),name,anchor='mm',fill='#4f4337',font=font(14))
        # Thin top face carries the full six-corner silhouette; no overlapping tops.
        model('tile/'+name,{'textures':{'top':f'card:item/catan/tile/{name}','particle':f'card:item/catan/tile/{name}'},
                              'elements':[top_plane('top',8-4*math.sqrt(3),0,8+4*math.sqrt(3),16)]})
    preview.save(SOURCE/'terrain_preview.png')
    png('wood_edge',wood('#9b713c',1421));png('dark',wood('#33323a',132))
    png('gold',Image.new('RGB',(16,16),'#f6d781'))
    # A flat-top sea hex and six actual side walls; rectangle corners stay transparent.
    ocean=Image.new('RGBA',(128,128),'#5d9caa');draw=ImageDraw.Draw(ocean)
    for y in range(5,128,9):
        for x in range((y//9)%2*10,128,22):
            draw.line((x,y,x+8,y),fill='#7db1b9',width=1)
            draw.line((x+3,y+1,x+10,y+1),fill='#649eae',width=1)
    mask,ps=hex_mask(False);ocean.putalpha(mask);draw=ImageDraw.Draw(ocean)
    draw.line(ps+[ps[0]],fill='#e0c999',width=3)
    png('board/sea',ocean)
    corners=[(8+8*math.cos(k*math.pi/3),8+8*math.sin(k*math.pi/3)) for k in range(6)]
    model('board/sea',{'textures':{'top':'card:item/catan/board/sea','edge':'card:item/catan/wood_edge','particle':'card:item/catan/wood_edge'},
                       'elements':[top_plane('top')]+[wall(corners[k],corners[(k+1)%6],'edge') for k in range(6)]})
    # Land numbers: red 6/8 and probability dots, raised octagonal wooden tokens.
    for value in list(range(2,7))+list(range(8,13)):
        token=Image.new('RGB',(128,128),'#ecd9ad');d=ImageDraw.Draw(token)
        d.ellipse((4,4,123,123),outline='#997749',width=4)
        ink='#ac4139' if value in (6,8) else '#45372c'
        d.text((64,53),str(value),anchor='mm',font=font(61),fill=ink)
        count=6-abs(7-value)
        for i in range(count):
            x=64+(i-(count-1)/2)*14;d.ellipse((x-3,99,x+3,105),fill=ink)
        png(f'number/{value}',token)
        model(f'number/{value}',disc(f'card:item/catan/number/{value}','card:item/catan/wood_edge',height=.8,segments=8))
    # Ports and public flying resource icons.
    icon_sources={0:'logPile',1:'rockBrown_small',4:'rockGrey_small1'}
    for resource in range(-1,5):
        token=Image.new('RGB',(128,128),'#f0e4c8');d=ImageDraw.Draw(token)
        d.ellipse((4,4,123,123),outline='#375e6a',width=5)
        d.text((64,36),'3:1' if resource==-1 else '2:1',anchor='mm',font=font(33),fill='#34505c')
        if resource in icon_sources:
            icon=original('PNG/Objects/'+icon_sources[resource]+'.png');icon.thumbnail((45,45))
            token.paste(icon,((128-icon.width)//2,62),icon)
        elif resource==2:sheep(d,62,75,3)
        elif resource==3:
            for x in (48,62,76):
                d.line((x,103,x+8,63),fill='#b58637',width=4)
                for y in (70,80,90):d.line((x+4,y,x-4,y-5),fill='#d9ae4e',width=5)
        else:
            d.line((38,103,89,103),fill='#467b88',width=4);d.polygon([(41,102),(36,85),(91,85),(85,102)],fill='#467b88')
            d.line((63,83,63,57),fill='#467b88',width=4);d.polygon([(67,58),(67,81),(88,81)],fill='#7296a0')
        key={-1:'generic',0:'wood',1:'brick',2:'wool',3:'grain',4:'ore'}[resource]
        png('port/'+key,token)
        model('port/'+key,disc('card:item/catan/port/'+key,'card:item/catan/wood_edge',height=.65,segments=8))
        if resource>=0:
            icon=token.crop((24,57,104,116)).resize((64,64),Image.Resampling.NEAREST)
            png('resource/'+key,icon)
            model('resource/'+key,{'parent':'minecraft:item/generated','textures':{'layer0':'card:item/catan/resource/'+key}})
    model('port/dock',{'textures':{'all':'card:item/catan/wood_edge','particle':'card:item/catan/wood_edge'},
                       'elements':[wall((0,8),(8,12),'all',height=.18,thickness=.65),wall((16,8),(8,12),'all',height=.18,thickness=.65)]})
    for index,(name,color) in enumerate(zip(COLORS,COLORS_RGB)):
        png('piece/'+name,wood(color,401+index))
        texture=f'card:item/catan/piece/{name}'
        road=[cube([.7,0,6.8],[15.3,1.8,9.2]),cube([1.3,1.8,7.1],[14.7,2.2,8.9])]
        model('road/'+name,{'textures':{'all':texture,'particle':texture},'elements':road})
        home=[cube([4,0,4],[12,6,12])]
        for step in range(5):home.append(cube([3+step,6+step,3],[13-step,7+step,13]))
        model('settlement/'+name,{'textures':{'all':texture,'particle':texture},'elements':home})
        city=[cube([2,0,4],[8,6,12]),cube([8,0,3],[14,10,13])]
        for step in range(4):
            city.append(cube([1+step,6+step,3],[9-step,7+step,13]))
            city.append(cube([7+step,10+step,2],[15-step,11+step,14]))
        model('city/'+name,{'textures':{'all':texture,'particle':texture},'elements':city})
    robber=disc('card:item/catan/dark','card:item/catan/dark',height=1.4,segments=8)
    robber['textures']['all']='card:item/catan/dark'
    robber['elements'] += [cube([4,1.4,4],[12,4,12]),cube([5,4,5],[11,9,11]),cube([5.4,9,5.4],[10.6,13,10.6]),cube([3.5,13,3.5],[12.5,14,12.5])]
    model('robber',robber)
    # Dice follow the same native face convention as existing tabletop dice.
    pip_positions={1:[(32,32)],2:[(16,16),(48,48)],3:[(16,16),(32,32),(48,48)],4:[(16,16),(48,16),(16,48),(48,48)],5:[(16,16),(48,16),(32,32),(16,48),(48,48)],6:[(16,13),(48,13),(16,32),(48,32),(16,51),(48,51)]}
    for shade,bg,ink in [('ivory','#eadcba','#46392e'),('red','#b74942','#f2e4c8')]:
        textures={}
        for value in range(1,7):
            face=Image.new('RGB',(64,64),bg);d=ImageDraw.Draw(face)
            d.rectangle((1,1,62,62),outline='#98734b' if shade=='ivory' else '#7d352f',width=2)
            for x,y in pip_positions[value]:d.ellipse((x-5,y-5,x+5,y+5),fill=ink)
            png(f'dice/{shade}_{value}',face);textures[str(value)]=f'card:item/catan/dice/{shade}_{value}'
        element=cube([0,0,0],[16,16,16])
        for side,value in {'up':1,'down':6,'north':2,'south':5,'east':3,'west':4}.items():element['faces'][side]['texture']='#'+str(value)
        model('dice/'+shade,{'textures':{**textures,'particle':textures['1']},'elements':[element]})
    # Preview outlines: real thin 3D bars, not square overlays pretending to be hexes.
    corners=[(8+8*math.cos(math.radians(30+60*k)),8+8*math.sin(math.radians(30+60*k))) for k in range(6)]
    model('highlight/hex',{'textures':{'all':'card:item/catan/gold','particle':'card:item/catan/gold'},'elements':[wall(corners[k],corners[(k+1)%6],'all',height=.12,thickness=.35) for k in range(6)]})
    corners=[(8+5*math.cos(k*math.pi/4),8+5*math.sin(k*math.pi/4)) for k in range(8)]
    model('highlight/vertex',{'textures':{'all':'card:item/catan/gold','particle':'card:item/catan/gold'},'elements':[wall(corners[k],corners[(k+1)%8],'all',height=.12,thickness=.6) for k in range(8)]})
    model('highlight/edge',{'textures':{'all':'card:item/catan/gold','particle':'card:item/catan/gold'},'elements':[cube([0,0,6.3],[16,.4,9.7])]})
    # Neutral backs conceal steals, trades and private development draws.
    for name in ('bag','development_back'):
        image=Image.new('RGB',(64,64),'#ac8351' if name=='bag' else '#356a7a');d=ImageDraw.Draw(image)
        d.rectangle((3,3,60,60),outline='#e3c58c',width=3)
        if name=='bag':
            d.polygon([(21,17),(43,17),(40,25),(49,44),(45,54),(19,54),(15,44),(24,25)],fill='#dfc392',outline='#6f573a')
            d.line((22,25,42,25),fill='#6f573a',width=3)
        else:
            d.polygon([(32,14),(50,46),(14,46)],outline='#f0d79f',fill='#477e87')
            d.rectangle((26,34,38,46),fill='#e3c58c')
        png(name,image)
        model(name,{'parent':'minecraft:item/generated','textures':{'layer0':'card:item/catan/'+name}})
    manifest={'author':'Kenney Vleugels / Kenney','asset_page':'https://kenney.nl/assets/hexagon-pack','license':'CC0-1.0',
              'license_file':'vendor/Kenney-License.txt','archive':'vendor/kenney_hexagon-pack.zip',
              'archive_sha256':hashlib.sha256((SOURCE/'vendor/kenney_hexagon-pack.zip').read_bytes()).hexdigest(),
              'originals':[{'file':p,'sha256':hashlib.sha256((SOURCE/'vendor/originals'/p).read_bytes()).hexdigest()} for p in sorted(USED)],
              'adaptation':'Nearest-neighbor resize, reduced saturation, hex alpha mask; original sheep/grain/sea/frame/number/piece/dice artwork and all cuboid geometry by Fimel Cards.',
              'topology_source':'fimelcard-dp/tools/catan_topology.py','sizes':{str(k):{'R':v[0],'L':v[1]} for k,v in SIZES.items()}}
    json_file(SOURCE/'visual_manifest.json',manifest)
    text_file(SOURCE/'visual/README.md','''# 卡坦岛视觉资源

地形与自然物件取自 Kenney Hexagon Pack（https://kenney.nl/assets/hexagon-pack），作者 Kenney Vleugels / Kenney，CC0-1.0，允许修改与再分发。原始 ZIP、原始 PNG 及随包许可证保留于 ../vendor/；逐文件哈希见 ../visual_manifest.json。没有复制商业 CATAN 的牌面或插图。

地形采用近邻缩放、适度降饱和与六边形遮罩；羊群、麦穗、海面、港口标记、数字木牌、骰面及所有立体建筑和道路为本项目确定性绘制。红、蓝、白、橙棋子为 Java 原版长方体模型；城市与村庄几何不同，强盗有立体底座、身体和头部。

在数据包目录运行 python tools/build_catan_visual.py 重建。依赖 Pillow、NumPy 和 Windows Arial；使用本地保留的 CC0 原件，不需要再次下载。../models/ 中保存可编辑 Blockbench 源文件，纹理嵌入源模型。地形预览见 ../terrain_preview.png；四人桌、八人桌及两种朝向的实际模型离线预览见 ../board_preview_c4o0.png 等文件。预览使用原始模型面、UV、透明纹理和深度缓冲，属于资产检查图，不是游戏内截图。

拓扑只导入数据包 tools/catan_topology.py，禁止另排 ID。四/八人桌 R=.25/.35、海框 L=1.35/1.8，棋盘旋转、道路、交点、港口和骰面均共享坐标。item_display:none 的固定 Y180 由 right_rotation 抵消。顶面只有一层，数字、建筑与高亮分层，不以重复共面矩形模拟六边形。

视觉只读取公开棋面与已提交的公共动画事件，不读取玩家具体资源或未用开发牌。发牌/交易/偷牌动画使用中性袋子或统一开发牌背；真实扣费、骰值和生产仅由规则引擎决定。音效来源由独立 audio/README.md 记录，视觉导出器不会改写音频。
''')


def multiply(a,b):
    x,y,z,w=a;X,Y,Z,W=b
    return (w*X+x*W+y*Z-z*Y,w*Y-x*Z+y*W+z*X,w*Z+x*Y-y*X+z*W,w*W-x*X-y*Y-z*Z)


def pose(x,z,scale,lift=.022,angle=0):
    return {'x':round(x,8),'y':round(scale/2+lift,8),'z':round(z,8),'scale':round(scale,8),
            'qx':0,'qy':round(math.sin(angle/2),8),'qz':0,'qw':round(math.cos(angle/2),8)}


def layouts():
    result={}
    for cap,(radius,outer) in SIZES.items():
        for orientation in (0,1):
            angle=-orientation*math.pi/2
            rotate=lambda x,z:(-z,x) if orientation else (x,z)
            vertices=[pose(*vertex_position(v['id'],radius,orientation),radius*.68,angle=angle) for v in VERTICES]
            hexes=[pose(*hex_position(h['id'],radius,orientation),2*radius,angle=angle) for h in HEXES]
            edges=[]
            for a,b in EDGES:
                x,z=vertex_position(a,radius,orientation);X,Z=vertex_position(b,radius,orientation)
                edges.append(pose((x+X)/2,(z+Z)/2,radius*.94,angle=-math.atan2(Z-z,X-x)))
            ports=[]
            for p in PORTS:
                a,b=p['vertices'];x,z=vertex_position(a,radius,orientation);X,Z=vertex_position(b,radius,orientation)
                mx,mz=(x+X)/2,(z+Z)/2;dx,dz=X-x,Z-z
                nx,nz=-dz/radius,dx/radius
                if nx*mx+nz*mz<0:dx,dz,nx,nz=-dx,-dz,-nx,-nz
                # Local +z points out to sea; the fork meets precisely the two port vertices.
                ports.append({'dock':pose(mx,mz,radius,lift=.008,angle=-math.atan2(dz,dx)),
                              'token':pose(mx+nx*radius/4,mz+nz*radius/4,.14 if cap==4 else .15,lift=.014,angle=angle)})
            coords4=[(0,0),(0,-1.19),(1.19,0),(0,1.19),(-1.19,0)]
            coords8=[(0,0),(-.82,-1.58),(.82,-1.58),(1.58,-.82),(1.58,.82),(.82,1.58),(-.82,1.58),(-1.58,.82),(-1.58,-.82)]
            # Seats belong to the physical table and are not rotated with the board.
            seats=[{'x':x,'y':.24,'z':z} for x,z in (coords4 if cap==4 else coords8)]
            geom={'radius':radius,'outer':outer,'building_scale':radius*.68,'road_scale':radius*.94,
                  'robber_scale':radius*.66,'token_scale':.115 if cap==4 else .14,
                  'highlight_vertex_scale':radius*.50,'icon_scale':.11 if cap==4 else .14,
                  'qy':round(math.sin(angle/2),8),'qw':round(math.cos(angle/2),8)}
            data={'geom':geom,'sea':pose(0,0,outer*2,lift=0,angle=angle),'hexes':hexes,'vertices':vertices,
                  'edges':edges,'ports':ports,'seats':seats}
            axis=(1,.7,.4);norm=math.sqrt(sum(v*v for v in axis));axis=tuple(v/norm for v in axis)
            qboard=(0,math.sin(angle/2),0,math.cos(angle/2))
            for die in (1,2):
                rolls={};scale=.13 if cap==4 else .15
                x0=(-.105 if die==1 else .105)*(1 if cap==4 else 1.25);z0=-4*radius-.08
                for value,qfinal in FACE_ROTATIONS.items():
                    frames=[]
                    for remaining in range(21):
                        t=1-remaining/20;spin_angle=8*math.pi*(1-(1-t)**2)+(die-1)*4*math.pi*t
                        spin=tuple(v*math.sin(spin_angle/2) for v in axis)+(math.cos(spin_angle/2),)
                        q=multiply(qboard,multiply(qfinal,spin))
                        x,z=rotate(x0+math.sin(3*math.pi*t)*(1-t)*.04,z0+math.sin(4*math.pi*t)*(1-t)*.035)
                        p=pose(x,z,scale,lift=.026)
                        p.update({k:round(v,8) for k,v in zip(('qx','qy','qz','qw'),q)})
                        p['y']=round(p['y']+math.sin(math.pi*t)*.22+abs(math.sin(5*math.pi*t))*(1-t)*.07,8)
                        frames.append(p)
                    rolls['r'+str(value)]=frames
                data['die'+str(die)]=rolls
            result[f'c{cap}o{orientation}']=data
    return result


def functions():
    compact=lambda value:json.dumps(value,separators=(',',':'))
    load=['# Layouts use only the authoritative shared topology.']
    for key,data in layouts().items():
        for field,value in data.items():
            if field.startswith('die'):
                for roll,frames in value.items():load.append(f'data modify storage catan:layout {key}.{field}.{roll} set value '+compact(frames))
            else:load.append(f'data modify storage catan:layout {key}.{field} set value '+compact(value))
    put('load',load)
    put('context',[
        'execute unless data storage catan:layout c8o1.hexes run function catan:visual/load',
        'scoreboard players operation #vis_table ca_ctx = @s ct_id',
        'execute store result storage catan:visual cap int 1 run scoreboard players get @s ct_capacity',
        'execute store result storage catan:visual orient int 1 run scoreboard players get @s ca_orient',
        'function catan:visual/layout with storage catan:visual',
        'tag @a[tag=ca.vview] remove ca.vview',
        'execute as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #vis_table ca_ctx if score @s ct_id = #vis_table ca_ctx run tag @s add ca.vview'])
    put('layout',['$data modify storage catan:visual layout set value "c$(cap)o$(orient)"',
                  '$data modify storage catan:visual geom set from storage catan:layout c$(cap)o$(orient).geom'])
    put('clear',[
        'scoreboard players operation #vis_table ca_ctx = @s ct_id',
        'execute as @e[tag=ca.visual] if score @s ct_id = #vis_table ca_ctx run kill @s',
        'scoreboard players set @s ca_vtimer 0','scoreboard players set @s ca_vkind 0',
        'data remove entity @s data.catan.visual_events','data remove entity @s data.catan.visual_active',
        'data remove entity @s data.catan.visual_motion'])
    put('preview','function catan:visual/refresh')
    put('refresh',[
        'function catan:visual/clear','function catan:visual/context',
        'execute at @s run function catan:visual/refresh_at'])
    put('refresh_at',[
        'data modify storage catan:visual model set value "board/sea"',
        'data modify storage catan:visual kind set value 1','data modify storage catan:visual id set value 0',
        'function catan:visual/sea with storage catan:visual',
        *[f'function catan:visual/tile {{"target":{h["id"]}}}' for h in HEXES],
        *[f'function catan:visual/port {{"target":{p["id"]}}}' for p in PORTS],
        'function catan:visual/update_at',
        'function catan:visual/robber_spawn','function catan:visual/dice_spawn',
        'function catan:visual/dice_done','function catan:visual/select'])
    put('sea',['$data modify storage catan:visual pose set from storage catan:layout $(layout).sea','function catan:visual/spawn'])
    put('spawn','execute positioned ~ ~1.04 ~ summon minecraft:item_display run function catan:visual/init with storage catan:visual')
    put('init',[
        'tag @s add ca.visual','scoreboard players operation @s ct_id = #vis_table ca_ctx',
        '$scoreboard players set @s ca_vid $(id)','$scoreboard players set @s ca_vkind $(kind)',
        '$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:catan/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,shadow_strength:0f,view_range:0.5f}',
        'function catan:visual/pose with storage catan:visual pose'])
    put('pose','$data merge entity @s {start_interpolation:0,interpolation_duration:1,transformation:{translation:[$(x)f,$(y)f,$(z)f],left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')
    put('coordinate',[
        '$data modify storage catan:visual pose set from storage catan:layout $(layout).$(collection)[$(target)]'])
    put('tile',[
        '$data modify storage catan:visual target set value $(target)',
        '$data modify storage catan:visual terrain set from entity @s data.catan.terrain[$(target)]',
        'data modify storage catan:visual collection set value "hexes"',
        'function catan:visual/coordinate with storage catan:visual',
        'data modify storage catan:visual pose.qy set from storage catan:visual geom.qy',
        'data modify storage catan:visual pose.qw set from storage catan:visual geom.qw',
        'data modify storage catan:visual kind set value 2',
        '$data modify storage catan:visual id set value $(target)',
        *[f'execute if data storage catan:visual {{terrain:{i}}} run data modify storage catan:visual model set value "tile/{name}"' for i,name in enumerate(TERRAINS)],
        'function catan:visual/spawn',
        '$data modify storage catan:visual number set from entity @s data.catan.numbers[$(target)]',
        'execute if data storage catan:visual {number:0} run return 0',
        'function catan:visual/number with storage catan:visual'])
    put('number',[
        '$data modify storage catan:visual model set value "number/$(number)"',
        'data modify storage catan:visual kind set value 3',
        'data modify storage catan:visual pose.scale set from storage catan:visual geom.token_scale',
        'execute store result score #vis_scale ca_ctx run data get storage catan:visual geom.token_scale 100000',
        'scoreboard players set #vis_two ca_ctx 2','scoreboard players operation #vis_scale ca_ctx /= #vis_two ca_ctx',
        'scoreboard players add #vis_scale ca_ctx 2600',
        'execute store result storage catan:visual pose.y double 0.00001 run scoreboard players get #vis_scale ca_ctx',
        'function catan:visual/spawn'])
    put('port',[
        '$data modify storage catan:visual target set value $(target)',
        '$data modify storage catan:visual port set from entity @s data.catan.port_types[$(target)]',
        '$data modify storage catan:visual id set value $(target)',
        'function catan:visual/port_at with storage catan:visual'])
    put('port_at',[
        '$data modify storage catan:visual pose set from storage catan:layout $(layout).ports[$(target)].dock',
        'data modify storage catan:visual kind set value 11','data modify storage catan:visual model set value "port/dock"',
        'function catan:visual/spawn',
        '$data modify storage catan:visual pose set from storage catan:layout $(layout).ports[$(target)].token',
        'data modify storage catan:visual kind set value 4',
        *[f'execute if data storage catan:visual {{port:{i}}} run data modify storage catan:visual model set value "port/{name}"' for i,name in [(-1,'generic'),*enumerate(('wood','brick','wool','grain','ore'))]],
        'function catan:visual/spawn'])
    put('update',['function catan:visual/context','execute at @s run function catan:visual/update_at',
                  'execute unless score @s ca_vkind matches 5 run function catan:visual/dice_done'])
    put('update_at',[
        '# Only occupied roads/buildings exist; no per-hex/per-edge interaction entities.',
        'execute as @e[tag=ca.visual,scores={ca_vkind=5..6}] if score @s ct_id = #vis_table ca_ctx run kill @s',
        *[f'function catan:visual/road {{"target":{i}}}' for i in range(len(EDGES))],
        *[f'function catan:visual/building {{"target":{v["id"]}}}' for v in VERTICES]])
    put('owner_color',[
        'data modify storage catan:visual color set value 1',
        'function catan:visual/read_color with storage catan:visual',
        *[f'execute if data storage catan:visual {{color:{i}}} run data modify storage catan:visual color_name set value "{name}"' for i,name in enumerate(COLORS,1)]])
    put('read_color','$data modify storage catan:visual color set from entity @s data.catan.p$(owner).color')
    put('road',[
        '$data modify storage catan:visual owner set from entity @s data.catan.road_owner[$(target)]',
        'execute if data storage catan:visual {owner:0} run return 0',
        '$data modify storage catan:visual target set value $(target)',
        '$data modify storage catan:visual id set value $(target)',
        'data modify storage catan:visual collection set value "edges"','function catan:visual/coordinate with storage catan:visual',
        'function catan:visual/owner_color','function catan:visual/road_model with storage catan:visual',
        'data modify storage catan:visual kind set value 5','function catan:visual/spawn'])
    put('road_model','$data modify storage catan:visual model set value "road/$(color_name)"')
    put('building',[
        '$data modify storage catan:visual owner set from entity @s data.catan.vertex_owner[$(target)]',
        'execute if data storage catan:visual {owner:0} run return 0',
        '$data modify storage catan:visual level set from entity @s data.catan.vertex_level[$(target)]',
        'execute if data storage catan:visual {level:0} run return 0',
        '$data modify storage catan:visual target set value $(target)',
        '$data modify storage catan:visual id set value $(target)',
        'data modify storage catan:visual collection set value "vertices"','function catan:visual/coordinate with storage catan:visual',
        'data modify storage catan:visual pose.qy set from storage catan:visual geom.qy',
        'data modify storage catan:visual pose.qw set from storage catan:visual geom.qw',
        'function catan:visual/owner_color','function catan:visual/building_model with storage catan:visual',
        'data modify storage catan:visual kind set value 6','function catan:visual/spawn'])
    put('building_model',[
        '$execute if data storage catan:visual {level:1} run data modify storage catan:visual model set value "settlement/$(color_name)"',
        '$execute if data storage catan:visual {level:2} run data modify storage catan:visual model set value "city/$(color_name)"'])
    put('robber_spawn',[
        'data modify storage catan:visual target set from entity @s data.catan.robber',
        'data modify storage catan:visual collection set value "hexes"','function catan:visual/coordinate with storage catan:visual',
        'data modify storage catan:visual pose.scale set from storage catan:visual geom.robber_scale',
        'function catan:visual/piece_y','data modify storage catan:visual model set value "robber"',
        'data modify storage catan:visual kind set value 7','data modify storage catan:visual id set value 0','function catan:visual/spawn'])
    put('piece_y',[
        'execute store result score #vis_scale ca_ctx run data get storage catan:visual pose.scale 100000',
        'scoreboard players set #vis_two ca_ctx 2','scoreboard players operation #vis_scale ca_ctx /= #vis_two ca_ctx',
        'scoreboard players add #vis_scale ca_ctx 2400',
        'execute store result storage catan:visual pose.y double 0.00001 run scoreboard players get #vis_scale ca_ctx'])
    put('dice_spawn',sum(([
        f'data modify storage catan:visual model set value "dice/{name}"',
        'data modify storage catan:visual kind set value 8',f'data modify storage catan:visual id set value {i}',
        f'data modify storage catan:visual die set value {i+1}','data modify storage catan:visual roll set value 1',
        'data modify storage catan:visual frame set value 0','function catan:visual/dice_coordinate with storage catan:visual',
        'function catan:visual/spawn'] for i,name in enumerate(('ivory','red'))),[]))
    put('dice_coordinate','$data modify storage catan:visual pose set from storage catan:layout $(layout).die$(die).r$(roll)[$(frame)]')
    put('dice_done',[
        'data modify storage catan:visual frame set value 0',
        'data modify storage catan:visual roll set value 1','data modify storage catan:visual die set value 1',
        'data modify storage catan:visual roll set from entity @s data.catan.dice[0]',
        'function catan:visual/dice_apply',
        'data modify storage catan:visual roll set value 1','data modify storage catan:visual die set value 2',
        'data modify storage catan:visual roll set from entity @s data.catan.dice[1]','function catan:visual/dice_apply'])
    put('dice_apply',[
        'execute store result score #vis_roll ca_ctx run data get storage catan:visual roll',
        'execute unless score #vis_roll ca_ctx matches 1..6 run data modify storage catan:visual roll set value 1',
        'function catan:visual/dice_coordinate with storage catan:visual',
        'function catan:visual/dice_entity with storage catan:visual'])
    put('dice_entity',[
        '$execute if data storage catan:visual {die:1} as @e[tag=ca.visual,scores={ca_vkind=8,ca_vid=0}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/pose with storage catan:visual pose',
        '$execute if data storage catan:visual {die:2} as @e[tag=ca.visual,scores={ca_vkind=8,ca_vid=1}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/pose with storage catan:visual pose'])
    put('clear_selection',[
        'scoreboard players operation #vis_table ca_ctx = @s ct_id',
        'execute as @e[tag=ca.visual,scores={ca_vkind=9}] if score @s ct_id = #vis_table ca_ctx run kill @s'])
    put('select',[
        'function catan:visual/context','function catan:visual/clear_selection',
        'execute unless data entity @s data.catan.preview run return 0',
        'data modify storage catan:visual selection set from entity @s data.catan.preview',
        'execute at @s run function catan:visual/selection with storage catan:visual selection'])
    put('selection',[
        'execute store result score #vis_type ca_ctx run data get storage catan:visual selection.type',
        'execute unless score #vis_type ca_ctx matches 1..3 run return 0',
        '$scoreboard players set #vis_target ca_ctx $(target)',
        'execute if score #vis_type ca_ctx matches 1 unless score #vis_target ca_ctx matches 0..18 run return 0',
        'execute if score #vis_type ca_ctx matches 2 unless score #vis_target ca_ctx matches 0..53 run return 0',
        'execute if score #vis_type ca_ctx matches 3 unless score #vis_target ca_ctx matches 0..71 run return 0',
        '$data modify storage catan:visual target set value $(target)',
        '$data modify storage catan:visual id set value $(target)',
        *sum(([f'$execute if data storage catan:visual selection{{type:{i}}} run data modify storage catan:visual collection set value "{collection}"',
                f'$execute if data storage catan:visual selection{{type:{i}}} run data modify storage catan:visual model set value "highlight/{name}"'] for i,collection,name in ((1,'hexes','hex'),(2,'vertices','vertex'),(3,'edges','edge'))),[]),
        'function catan:visual/coordinate with storage catan:visual',
        'execute if data storage catan:visual selection{type:2} run data modify storage catan:visual pose.scale set from storage catan:visual geom.highlight_vertex_scale',
        'function catan:visual/piece_y',
        'data modify storage catan:visual kind set value 9','function catan:visual/spawn',
        'execute as @e[tag=ca.visual,scores={ca_vkind=9}] if score @s ct_id = #vis_table ca_ctx run data merge entity @s {Glowing:1b,glow_color_override:16773283}'])
    # animate snapshots the public event immediately; a later last update cannot erase it.
    put('animate',[
        'execute unless data entity @s data.catan.last.kind run return 0',
        'execute unless data entity @s data.catan.visual_events run data modify entity @s data.catan.visual_events set value []',
        'data modify entity @s data.catan.visual_events append from entity @s data.catan.last',
        'execute unless score @s ca_vtimer matches 1.. run function catan:visual/start_next'])
    put('start_next',[
        'execute unless data entity @s data.catan.visual_events[0] run return 0',
        'function catan:visual/context',
        'data modify entity @s data.catan.visual_active set from entity @s data.catan.visual_events[0]',
        'data remove entity @s data.catan.visual_events[0]',
        'execute unless data entity @s data.catan.visual_active.owner run data modify entity @s data.catan.visual_active.owner set from entity @s data.catan.visual_active.actor',
        'execute unless data entity @s data.catan.visual_active.target run data modify entity @s data.catan.visual_active.target set from entity @s data.catan.visual_active.a',
        'data modify storage catan:visual event set from entity @s data.catan.visual_active',
        'scoreboard players set @s ca_vkind 0','scoreboard players set @s ca_vtimer 0',
        *[f'execute if data storage catan:visual event{{kind:"{name}"}} run scoreboard players set @s ca_vkind {i}' for i,name in enumerate(('road','settlement','city','robber','dice','trade','production','development','win'),1)],
        'execute if score @s ca_vkind matches 1..4 run scoreboard players set @s ca_vtimer 8',
        'execute if score @s ca_vkind matches 5 run scoreboard players set @s ca_vtimer 20',
        'execute if score @s ca_vkind matches 6..8 run scoreboard players set @s ca_vtimer 2',
        'execute if score @s ca_vkind matches 9 run scoreboard players set @s ca_vtimer 12',
        'execute at @s if score @s ca_vkind matches 1..3 run function catan:visual/build_tick',
        'execute at @s if score @s ca_vkind matches 4 run function catan:visual/robber_start',
        'execute at @s if score @s ca_vkind matches 5 run function catan:visual/dice_start',
        'execute at @s if score @s ca_vkind matches 6 run function catan:visual/trade',
        'execute at @s if score @s ca_vkind matches 7 run function catan:visual/production',
        'execute at @s if score @s ca_vkind matches 8 run function catan:visual/development',
        'execute at @s if score @s ca_vkind matches 9 run function catan:visual/win'])
    put('tick',[
        'function catan:visual/context','execute at @s run function catan:visual/tick_at'])
    put('tick_at',[
        'execute as @e[tag=ca.visual,scores={ca_vkind=10}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/fx_tick',
        'execute if score @s ca_vtimer matches 1.. run function catan:visual/event_tick',
        'execute unless score @s ca_vtimer matches 1.. run function catan:visual/start_next'])
    put('event_tick',[
        'scoreboard players remove @s ca_vtimer 1',
        'data modify storage catan:visual event set from entity @s data.catan.visual_active',
        'execute if score @s ca_vkind matches 1..3 run function catan:visual/build_tick',
        'execute if score @s ca_vkind matches 4 run function catan:visual/robber_tick',
        'execute if score @s ca_vkind matches 5 run function catan:visual/dice_tick',
        'execute if score @s ca_vkind matches 9 run function catan:visual/win',
        'execute unless score @s ca_vtimer matches 1.. run scoreboard players set @s ca_vkind 0'])
    put('build_tick',[
        'data modify storage catan:visual target set from storage catan:visual event.target',
        'data modify storage catan:visual collection set value "vertices"',
        'execute if score @s ca_vkind matches 1 run data modify storage catan:visual collection set value "edges"',
        'function catan:visual/coordinate with storage catan:visual',
        'data modify storage catan:visual kind set value 6',
        'execute if score @s ca_vkind matches 1 run data modify storage catan:visual kind set value 5',
        'scoreboard players set #vis_factor ca_ctx 8','scoreboard players operation #vis_factor ca_ctx -= @s ca_vtimer',
        'scoreboard players add #vis_factor ca_ctx 1',
        'scoreboard players set #vis_total ca_ctx 9',
        'execute store result score #vis_scale ca_ctx run data get storage catan:visual pose.scale 100000',
        'scoreboard players operation #vis_scale ca_ctx *= #vis_factor ca_ctx',
        'scoreboard players operation #vis_scale ca_ctx /= #vis_total ca_ctx',
        'execute store result storage catan:visual pose.scale double 0.00001 run scoreboard players get #vis_scale ca_ctx',
        'function catan:visual/piece_y',
        'function catan:visual/build_entity with storage catan:visual',
        'execute if score @s ca_vtimer matches 8 run function catan:visual/particle_build with storage catan:visual pose'])
    put('build_entity','$execute as @e[tag=ca.visual,scores={ca_vkind=$(kind),ca_vid=$(target)}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/pose with storage catan:visual pose')
    put('particle_build','$particle minecraft:dust{color:[0.86f,0.72f,0.38f],scale:0.45f} ~$(x) ~1.10 ~$(z) 0.045 0.04 0.045 0 9 normal @a[tag=ca.vview]')
    put('robber_start',[
        'data modify storage catan:visual target set from storage catan:visual event.target',
        'data modify storage catan:visual collection set value "hexes"','function catan:visual/coordinate with storage catan:visual',
        'data modify storage catan:visual pose.scale set from storage catan:visual geom.robber_scale','function catan:visual/piece_y',
        'data modify entity @s data.catan.visual_motion set value {}',
        'data modify entity @s data.catan.visual_motion.to set from storage catan:visual pose',
        'data modify storage catan:visual from set value [0.0,0.1,0.0]',
        'execute as @e[tag=ca.visual,scores={ca_vkind=7},limit=100] if score @s ct_id = #vis_table ca_ctx run data modify storage catan:visual from set from entity @s transformation.translation',
        'data modify entity @s data.catan.visual_motion.from set from storage catan:visual from',
        'function catan:visual/robber_tick'])
    put('robber_tick',[
        'data modify storage catan:visual motion set from entity @s data.catan.visual_motion',
        'execute store result storage catan:visual remaining int 1 run scoreboard players get @s ca_vtimer',
        'data modify storage catan:visual total set value 8','function catan:visual/interpolate',
        'data modify storage catan:visual pose.scale set from storage catan:visual geom.robber_scale',
        'data modify storage catan:visual pose.qx set value 0','data modify storage catan:visual pose.qy set value 0',
        'data modify storage catan:visual pose.qz set value 0','data modify storage catan:visual pose.qw set value 1',
        'execute as @e[tag=ca.visual,scores={ca_vkind=7}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/pose with storage catan:visual pose',
        'execute if score @s ca_vtimer matches 4 run function catan:visual/particle_robber with storage catan:visual pose'])
    put('particle_robber','$particle minecraft:smoke ~$(x) ~1.17 ~$(z) 0.03 0.04 0.03 0.002 6 normal @a[tag=ca.vview]')
    put('dice_start',[
        'execute unless data entity @s data.catan.visual_active.die1 run data modify entity @s data.catan.visual_active.die1 set from entity @s data.catan.dice[0]',
        'execute unless data entity @s data.catan.visual_active.die2 run data modify entity @s data.catan.visual_active.die2 set from entity @s data.catan.dice[1]',
        'function catan:visual/dice_tick'])
    put('dice_tick',[
        'execute store result storage catan:visual frame int 1 run scoreboard players get @s ca_vtimer',
        'data modify storage catan:visual die set value 1','data modify storage catan:visual roll set from entity @s data.catan.visual_active.die1',
        'function catan:visual/dice_apply','data modify storage catan:visual die set value 2',
        'data modify storage catan:visual roll set from entity @s data.catan.visual_active.die2','function catan:visual/dice_apply'])
    # Interpolate only local coordinates, avoiding world-coordinate fixed-point overflow.
    interpolate=[
        'execute store result score #vis_total ca_ctx run data get storage catan:visual total',
        'execute store result score #vis_remaining ca_ctx run data get storage catan:visual remaining',
        'scoreboard players operation #vis_t ca_ctx = #vis_total ca_ctx',
        'scoreboard players operation #vis_t ca_ctx -= #vis_remaining ca_ctx',
        'scoreboard players set #vis_1000 ca_ctx 1000','scoreboard players operation #vis_t ca_ctx *= #vis_1000 ca_ctx',
        'scoreboard players operation #vis_t ca_ctx /= #vis_total ca_ctx']
    for index,axis in enumerate(('x','y','z')):
        interpolate.extend([
            f'execute store result score #vis_from ca_ctx run data get storage catan:visual motion.from[{index}] 100000',
            f'execute store result score #vis_to ca_ctx run data get storage catan:visual motion.to.{axis} 100000',
            'scoreboard players operation #vis_to ca_ctx -= #vis_from ca_ctx','scoreboard players operation #vis_to ca_ctx *= #vis_t ca_ctx',
            'scoreboard players operation #vis_to ca_ctx /= #vis_1000 ca_ctx','scoreboard players operation #vis_to ca_ctx += #vis_from ca_ctx',
            f'execute store result storage catan:visual pose.{axis} double 0.00001 run scoreboard players get #vis_to ca_ctx'])
    interpolate.extend([
        'scoreboard players set #vis_arc ca_ctx 1000','scoreboard players operation #vis_arc ca_ctx -= #vis_t ca_ctx',
        'scoreboard players operation #vis_arc ca_ctx *= #vis_t ca_ctx',
        'execute store result score #vis_y ca_ctx run data get storage catan:visual pose.y 1000000',
        'scoreboard players operation #vis_y ca_ctx += #vis_arc ca_ctx',
        'execute store result storage catan:visual pose.y double 0.000001 run scoreboard players get #vis_y ca_ctx'])
    put('interpolate',interpolate)
    put('seat',[
        'data modify storage catan:visual seat set value 0',
        'execute if data storage catan:visual event.seat run data modify storage catan:visual seat set from storage catan:visual event.seat',
        'execute unless data storage catan:visual event.seat run function catan:visual/owner_seat with storage catan:visual event',
        'function catan:visual/seat_coordinate with storage catan:visual'])
    put('owner_seat','$data modify storage catan:visual seat set from entity @s data.catan.p$(owner).seat')
    put('seat_coordinate','$data modify storage catan:visual point set from storage catan:layout $(layout).seats[$(seat)]')
    put('production',[
        'function catan:visual/seat','data modify storage catan:visual motion.to set from storage catan:visual point',
        'data modify storage catan:visual target set from storage catan:visual event.target',
        'data modify storage catan:visual collection set value "hexes"','function catan:visual/coordinate with storage catan:visual',
        'data modify storage catan:visual motion.from set value [0.0,0.12,0.0]',
        'data modify storage catan:visual motion.from[0] set from storage catan:visual pose.x',
        'data modify storage catan:visual motion.from[2] set from storage catan:visual pose.z',
        *[f'execute if data storage catan:visual event{{resource:{i}}} run data modify storage catan:visual model set value "resource/{name}"' for i,name in enumerate(('wood','brick','wool','grain','ore'))],
        'function catan:visual/fx_spawn'])
    put('trade',[
        'data modify storage catan:visual seat set value 0',
        'data modify storage catan:visual seat set from storage catan:visual event.from_seat',
        'function catan:visual/seat_coordinate with storage catan:visual',
        'data modify storage catan:visual motion.from set value [0.0,0.24,0.0]',
        'data modify storage catan:visual motion.from[0] set from storage catan:visual point.x',
        'data modify storage catan:visual motion.from[2] set from storage catan:visual point.z',
        'data modify storage catan:visual seat set value 0',
        'data modify storage catan:visual seat set from storage catan:visual event.to_seat',
        'function catan:visual/seat_coordinate with storage catan:visual',
        'data modify storage catan:visual motion.to set from storage catan:visual point',
        'data modify storage catan:visual model set value "bag"','function catan:visual/fx_spawn',
        'data modify storage catan:visual swap set from storage catan:visual motion.from',
        'data modify storage catan:visual motion.from[0] set from storage catan:visual motion.to.x',
        'data modify storage catan:visual motion.from[2] set from storage catan:visual motion.to.z',
        'data modify storage catan:visual motion.to.x set from storage catan:visual swap[0]',
        'data modify storage catan:visual motion.to.z set from storage catan:visual swap[2]',
        'function catan:visual/fx_spawn'])
    put('development',[
        'function catan:visual/seat','data modify storage catan:visual motion.to set from storage catan:visual point',
        'data modify storage catan:visual motion.from set value [0.0,0.12,0.0]',
        'data modify storage catan:visual model set value "development_back"','function catan:visual/fx_spawn'])
    put('fx_spawn',[
        'data modify storage catan:visual kind set value 10','data modify storage catan:visual id set value 0',
        'data modify storage catan:visual pose.x set from storage catan:visual motion.from[0]',
        'data modify storage catan:visual pose.y set from storage catan:visual motion.from[1]',
        'data modify storage catan:visual pose.z set from storage catan:visual motion.from[2]',
        'data modify storage catan:visual pose.scale set from storage catan:visual geom.icon_scale',
        f'data modify storage catan:visual pose.qx set value {-HALF}',
        'data modify storage catan:visual pose.qy set value 0','data modify storage catan:visual pose.qz set value 0',
        f'data modify storage catan:visual pose.qw set value {HALF}',
        'execute positioned ~ ~1.04 ~ summon minecraft:item_display run function catan:visual/fx_init with storage catan:visual'])
    put('fx_init',[
        'function catan:visual/init with storage catan:visual','scoreboard players set @s ca_vlife 8',
        'data modify entity @s item.components."minecraft:custom_data" set value {catan_fx:{}}',
        'data modify entity @s item.components."minecraft:custom_data".catan_fx set from storage catan:visual motion'])
    put('fx_tick',[
        'scoreboard players remove @s ca_vlife 1',
        'data modify storage catan:visual motion set from entity @s item.components."minecraft:custom_data".catan_fx',
        'execute store result storage catan:visual remaining int 1 run scoreboard players get @s ca_vlife',
        'data modify storage catan:visual total set value 8','function catan:visual/interpolate',
        'data modify storage catan:visual pose.scale set from storage catan:visual geom.icon_scale',
        f'data modify storage catan:visual pose.qx set value {-HALF}',
        'data modify storage catan:visual pose.qy set value 0','data modify storage catan:visual pose.qz set value 0',
        f'data modify storage catan:visual pose.qw set value {HALF}',
        'function catan:visual/pose with storage catan:visual pose',
        'execute if score @s ca_vlife matches 4 run function catan:visual/particle_resource with storage catan:visual pose',
        'execute if score @s ca_vlife matches ..0 run kill @s'])
    put('particle_resource',[
        '$particle minecraft:dust{color:[0.93f,0.81f,0.52f],scale:0.35f} ~$(x) ~1.40 ~$(z) 0.025 0.03 0.025 0 4 normal @a[tag=ca.vview]'])
    put('win',[
        'function catan:visual/seat','function catan:visual/particle_win with storage catan:visual point'])
    put('particle_win','$particle minecraft:happy_villager ~$(x) ~1.48 ~$(z) 0.16 0.17 0.16 0.03 4 normal @a[tag=ca.vview]')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--assets-only',action='store_true')
    args=parser.parse_args()
    resources()
    from render_catan_preview import render_preview
    render_preview(layouts()['c4o0'])
    for name,layout in layouts().items():
        render_preview(layout,SOURCE/f'board_preview_{name}.png',f'{name[1]}-seat table | rotation {int(name[-1])*90} deg')
    if not args.assets_only:functions()
    print('Generated Catan visual assets'+(' only' if args.assets_only else ' and functions')+'.')
