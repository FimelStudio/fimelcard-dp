"""原创飞行棋棋盘、飞机、真实六面骰，以及两桌型的逐段插值动画。"""
import json
import math
from PIL import Image, ImageDraw, ImageFont, ImageColor
from boardgame_assets import PACK, RP, CARD, text_file, export_texture, export_model, flat_board, cube, outline

ROOT = PACK/'data/aeroplane_chess/function/visual'
PATH = json.loads((PACK/'tools/aeroplane_path.json').read_text(encoding='utf-8'))
PALETTES = {
    'classic': ('#db514c', '#3c83bf', '#42a477', '#edbd42'),
}
COLORS = ('red', 'blue', 'green', 'yellow')
FOOTPRINTS = {4: 2.7, 8: 3.6}
HALF = math.sqrt(.5)
FACE_ROTATIONS = {1: (0,0,0,1), 6: (1,0,0,0), 2: (HALF,0,0,HALF),
                  5: (-HALF,0,0,HALF), 3: (0,0,HALF,HALF), 4: (0,0,-HALF,HALF)}


def put(name, body):
    body = '\n'.join(body) if isinstance(body, list) else body
    text_file(ROOT/(name+'.mcfunction'), body.replace('view_range:24f','view_range:0.5f'))


def mix(color, amount, target='#ffffff'):
    a, b = ImageColor.getrgb(color), ImageColor.getrgb(target)
    return tuple(round(x*(1-amount)+y*amount) for x,y in zip(a,b))


def font(size):
    return ImageFont.truetype('C:/Windows/Fonts/arialbd.ttf', size)


def board_texture(colors):
    """传统折角跑道：绘图锚点与实体共用 manifest，禁止另写一份格心。"""
    size = 1536
    bitmap = Image.new('RGB', (size, size), '#efe7d6')
    draw = ImageDraw.Draw(bitmap)
    ink, paper = '#344756', '#fffbed'
    scale = size / PATH['grid']

    def xy(p):
        return tuple((value + .5) * scale for value in p)

    def polygon(points, fill, width=3, edge=ink):
        points = [xy(p) for p in points]
        draw.polygon(points, fill=fill)
        if width:
            draw.line(points + points[:1], fill=edge, width=width, joint='curve')

    def circle(point, radius, fill, edge=ink, width=3):
        x, y = xy(point)
        r = radius * scale
        draw.ellipse((x-r, y-r, x+r, y+r), fill=fill, outline=edge, width=width)

    def arrow(a, b, color, width=7, dashed=False):
        ax, ay = xy(a)
        bx, by = xy(b)
        distance = math.hypot(bx-ax, by-ay)
        if distance == 0:
            return
        ux, uy = (bx-ax)/distance, (by-ay)/distance
        # 在两端留出圆形落点，箭头尖端与落点边缘分开。
        ax, ay = ax + ux*scale*.38, ay + uy*scale*.38
        bx, by = bx - ux*scale*.43, by - uy*scale*.43
        if dashed:
            count = max(1, round(math.hypot(bx-ax, by-ay) / (scale*.32)))
            for i in range(count):
                t0, t1 = i/count, (i+.58)/count
                draw.line((ax+(bx-ax)*t0, ay+(by-ay)*t0,
                           ax+(bx-ax)*t1, ay+(by-ay)*t1), fill=color, width=width)
        else:
            draw.line((ax, ay, bx, by), fill=color, width=width)
        length, wing = scale*.24, scale*.16
        draw.polygon([(bx,by), (bx-ux*length-uy*wing,by-uy*length+ux*wing),
                      (bx-ux*length+uy*wing,by-uy*length-ux*wing)], fill=color)

    # 双层细边与暖白底，桌面缩小时仍保留清晰轮廓。
    draw.rounded_rectangle((10,10,size-11,size-11), radius=54, fill=paper, outline=ink, width=6)
    draw.rounded_rectangle((26,26,size-27,size-27), radius=40, outline='#d6cbb4', width=2)
    ring = PATH['ring']
    for c, color in enumerate(colors):
        start, end = ring[(c*13+18)%52], ring[(c*13+30)%52]
        arrow(start, end, mix(color,.08), width=6, dashed=True)

    # 传统机场有四色外框、浅色内场和四个独立停机位。
    for c, color in enumerate(colors):
        info = PATH['colors'][c]
        vertices = [xy(p) for p in info['airport']]
        xs, ys = zip(*vertices)
        bounds = (min(xs), min(ys), max(xs), max(ys))
        draw.rounded_rectangle(bounds, radius=28, fill=color, outline=ink, width=4)
        inset = scale*.16
        inner = (bounds[0]+inset,bounds[1]+inset,bounds[2]-inset,bounds[3]-inset)
        draw.rounded_rectangle(inner, radius=19, fill=mix(color,.88), outline=mix(color,.26), width=3)
        for number, point in enumerate(info['hangar'], 1):
            circle(point, .49, mix(color,.6), edge=mix(color,.12,'#344756'), width=3)
            circle(point, .40, paper, edge='#ffffff', width=2)
            draw.text(xy(point), str(number), anchor='mm', font=font(26), fill=mix(color,.45))
        # 机场中央的简洁飞机标记，避开四个实际模型的位置。
        cx, cy = (bounds[0]+bounds[2])/2, (bounds[1]+bounds[3])/2
        draw.ellipse((cx-22,cy-22,cx+22,cy+22), fill=color)
        draw.polygon([(cx,cy-16),(cx+4,cy-3),(cx+15,cy+4),(cx+15,cy+8),
                      (cx+4,cy+4),(cx+3,cy+12),(cx+8,cy+16),(cx-8,cy+16),
                      (cx-3,cy+12),(cx-4,cy+4),(cx-15,cy+8),(cx-15,cy+4),
                      (cx-4,cy-3)], fill=paper)

    # 五格直道接一格箭头终点；边框与落点同时旋转到本色方向。
    for c, color in enumerate(colors):
        info = PATH['colors'][c]
        for cell in info['home_cells']:
            polygon(cell, color)
        polygon(info['terminal'], color, width=5, edge=paper)
        polygon(info['terminal'], color, width=2)
        for point in info['home']:
            circle(point, .235, paper, width=2)

    # 四段旋转一致的矩形/三角形色格，52个落点均来自同一个逻辑路径表。
    for index, (cell, point) in enumerate(zip(PATH['ring_cells'], ring)):
        polygon(cell, colors[(index+2)%4])
        circle(point, .235, paper, width=2)
    for c, color in enumerate(colors):
        info = PATH['colors'][c]
        circle(info['launch'], .255, mix(color,.08), edge=ink, width=2)
        draw.text(xy(info['launch']), 'S', anchor='mm', font=font(24), fill=paper)
        arrow(info['launch'], ring[c*13], color, width=6)
    return bitmap


def resources():
    for palette, colors in PALETTES.items():
        bitmap = board_texture(colors)
        key='board/'+palette
        export_texture('aeroplane_chess',key,bitmap)
        export_model('aeroplane_chess',key,flat_board('card:item/aeroplane_chess/'+key))
        for c,color in enumerate(colors):
            texture=Image.new('RGB',(32,32),color)
            d=ImageDraw.Draw(texture)
            d.rectangle((0,0,31,5),fill=mix(color,.22))
            export_texture('aeroplane_chess',f'plane/{palette}_{COLORS[c]}',texture)
            elements=[cube([6.5,1.1,2],[9.5,3,14],'body','fuselage'),
                      cube([1,1.4,6],[15,2.25,9.5],'body','wings'),
                      cube([4.5,1.4,11],[11.5,2.2,13],'body','tailplane'),
                      cube([7.5,2.2,10.5],[8.5,5.1,13.8],'body','tail_fin'),
                      cube([7,3,3.8],[9,3.65,6.6],'glass','cockpit'),
                      cube([5.8,.25,4.4],[6.6,1.25,6.1],'wheel','wheel_left'),
                      cube([9.4,.25,4.4],[10.2,1.25,6.1],'wheel','wheel_right')]
            export_model('aeroplane_chess',f'plane/{palette}_{COLORS[c]}',{
                'credit':'Fimel Cards original aeroplane', 'textures':{
                    'body':f'card:item/aeroplane_chess/plane/{palette}_{COLORS[c]}',
                    'glass':'card:item/aeroplane_chess/glass','wheel':'card:item/aeroplane_chess/wheel'},'elements':elements},editable=False)
    export_texture('aeroplane_chess','glass',Image.new('RGB',(16,16),'#e3f4f8'))
    export_texture('aeroplane_chess','wheel',Image.new('RGB',(16,16),'#454852'))
    # 补齐已经生成模型的可编辑源（公共玻璃、轮子纹理此时已落盘）。
    from boardgame_assets import export_blockbench
    for palette in PALETTES:
        for color in COLORS:
            name=f'plane/{palette}_{color}'
            export_blockbench('aeroplane_chess',name,json.loads((CARD/f'models/item/aeroplane_chess/{name}.json').read_text(encoding='utf-8')))
    patterns={1:[(1,1)],2:[(0,0),(2,2)],3:[(0,0),(1,1),(2,2)],
              4:[(0,0),(2,0),(0,2),(2,2)],5:[(0,0),(2,0),(1,1),(0,2),(2,2)],
              6:[(0,0),(0,1),(0,2),(2,0),(2,1),(2,2)]}
    for value,points in patterns.items():
        bitmap=Image.new('RGB',(64,64),'#f8f3e8');d=ImageDraw.Draw(bitmap)
        d.rectangle((1,1,62,62),outline='#beb5a5',width=2)
        for x,y in points:
            px,py=16+16*x,16+16*y
            d.ellipse((px-5,py-5,px+5,py+5),fill='#d3453a' if value==1 else '#353943')
        export_texture('aeroplane_chess',f'dice/{value}',bitmap)
    die=cube([1,1,1],[15,15,15])
    faces={'up':1,'down':6,'north':2,'south':5,'east':3,'west':4}
    for face,value in faces.items(): die['faces'][face]['texture']=f'#f{value}'
    export_model('aeroplane_chess','dice',{'credit':'Opposite dice faces sum to seven',
        'textures':{f'f{i}':f'card:item/aeroplane_chess/dice/{i}' for i in range(1,7)},'elements':[die]})
    export_texture('aeroplane_chess','selection',Image.new('RGB',(16,16),'#fff0a3'))
    export_model('aeroplane_chess','selection',outline('card:item/aeroplane_chess/selection'))
    preview=Image.new('RGB',(1536,1536))
    for i,name in enumerate(PALETTES):
        preview.paste(Image.open(CARD/f'textures/item/aeroplane_chess/board/{name}.png'),(0,0))
    preview.save(RP/'.source/aeroplane_chess/palettes.png')
    text_file(RP/'.source/aeroplane_chess/README.md','''
# 飞行棋原创资源

棋盘图像、飞机、六面骰由 Fimel Cards 绘制/建模。模型为原版 Java 方块元素，保留可编辑 Blockbench 文件。
棋盘布局借鉴传统实体飞行棋的折角跑道、四角机场和彩色终点，参考 [AlbertNi 的 Aeroplane Chess 棋盘展示](https://steamcommunity.com/sharedfiles/filedetails/?id=2131170438)。本项目重新绘制，未直接使用该展示图片。
从数据包目录运行 `python tools/build_aeroplane_visual.py` 重建，依赖 Pillow。
路径唯一来源为 `tools/aeroplane_path.json`，先运行 `tools/build_aeroplane_game.py` 更新规则路径。
四人桌棋盘边长2.7，八人桌3.6。传统17单位模板缩放到15单位版面；52个外环色格、机场、起飞位、六格终点均在路径表中定义，绘图与实体读取同一份坐标，方向旋转同步模型、路径和命中区。
六面骰上1下6、北2南5、东3西4；动画目标只读取服务器已锁定点数，所有对面点数相加为7。
飞机沿普通路径逐格低跳，起飞抬升、跳格跃起、飞越提高航线、撞机6刻返回本方机场。
仅生成16架以内飞机和对应命中区；停用颜色不生成模型。叠放飞机轻微错位，也可用Q菜单选择编号。
''')


def multiply(a,b):
    x,y,z,w=a;X,Y,Z,W=b
    return [w*X+x*W+y*Z-z*Y,w*Y-x*Z+y*W+z*X,w*Z+x*Y-y*X+z*W,w*W-x*X-y*Y-z*Z]


def point(c,plane,pos,step,orient):
    info=PATH['colors'][c]
    if pos<0: x,z=info['hangar'][plane]
    elif pos==0:x,z=info['launch']
    elif pos<52:x,z=PATH['ring'][(c*13+pos-1)%52]
    else:x,z=info['home'][pos-52]
    # 同格四架飞机仍能看清，并保留各自命中区；终点分别向本色通道微移。
    if pos>=0:
        x+=(-.13,.13,-.13,.13)[plane]
        z+=(-.13,-.13,.13,.13)[plane]
    x,z=(x-7)*step,(z-7)*step
    if orient:x,z=-z,x
    angle=-(c+orient)*math.pi/2
    return {'x':round(x,8),'z':round(z,8),'qy':round(math.sin(angle/2),8),'qw':round(math.cos(angle/2),8)}


def functions():
    data=[]
    for cap,foot in FOOTPRINTS.items():
        step=foot/15
        for orient in (0,1):
            key=f'c{cap}o{orient}'
            geom={'footprint':foot,'step':step,'scale':step*.72,'width':step*.72,
                  'board_y':foot*.5,'plane_y':step*.72*.5+.012,'die_scale':step*.8,
                  'die_y':step*.8*7/16+.012,'qy':-math.sin(orient*math.pi/4),'qw':math.cos(orient*math.pi/4)}
            poses={f'p{c}{p}':[point(c,p,pos,step,orient) for pos in range(-1,58)] for c in range(4) for p in range(4)}
            # 每架60个位置拆成独立storage命令，避免单行超过32767字符。
            data.append(f'data modify storage aeroplane_chess:layout {key}.geom set value '+json.dumps(geom,separators=(',',':')))
            for name,values in poses.items(): data.append(f'data modify storage aeroplane_chess:layout {key}.{name} set value '+json.dumps(values,separators=(',',':')))
    for roll,qfinal in FACE_ROTATIONS.items():
        frames=[]
        axis=(1,.7,.4);norm=math.sqrt(sum(v*v for v in axis));axis=tuple(v/norm for v in axis)
        for timer in range(21):
            t=1-timer/20;angle=8*math.pi*(1-(1-t)**2)
            spin=[v*math.sin(angle/2) for v in axis]+[math.cos(angle/2)]
            q=multiply(qfinal,spin)
            frames.append({'qx':round(q[0],8),'qy':round(q[1],8),'qz':round(q[2],8),'qw':round(q[3],8),
                           'lift':round(math.sin(math.pi*t)*.28+abs(math.sin(5*math.pi*t))*(1-t)*.12,8),
                           'x':round(math.sin(3*math.pi*t)*(1-t)*.07,8),'z':round(math.cos(3*math.pi*t)*math.sin(math.pi*t)*.05,8)})
        data.append(f'data modify storage aeroplane_chess:layout r{roll} set value '+json.dumps(frames,separators=(',',':')))
    put('load',data)
    put('context',[
        'execute unless data storage aeroplane_chess:layout r6 run function aeroplane_chess:visual/load',
        'scoreboard players operation #vis_table ac_ctx = @s ct_id',
        'execute store result storage aeroplane_chess:visual cap int 1 run scoreboard players get @s ct_capacity',
        'execute store result storage aeroplane_chess:visual orient int 1 run scoreboard players get @s ac_orient',
        'data modify storage aeroplane_chess:visual palette set value "classic"',
        *[f'execute if score @s ac_palette matches {i} run data modify storage aeroplane_chess:visual palette set value "{name}"' for i,name in enumerate(PALETTES)],
        'function aeroplane_chess:visual/layout with storage aeroplane_chess:visual'])
    put('layout',['$data modify storage aeroplane_chess:visual layout set value "c$(cap)o$(orient)"']+
        [f'$data modify storage aeroplane_chess:visual {k} set from storage aeroplane_chess:layout c$(cap)o$(orient).geom.{k}' for k in
         ('footprint','step','scale','width','board_y','plane_y','die_scale','die_y','qy','qw')])
    put('clear','''
scoreboard players operation #vis_table ac_ctx = @s ct_id
execute as @e[tag=ac.visual] if score @s ct_id = #vis_table ac_ctx run kill @s
''')
    put('setup','function aeroplane_chess:visual/refresh')
    put('refresh','''
function aeroplane_chess:system/context
function aeroplane_chess:visual/clear
function aeroplane_chess:visual/context
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function aeroplane_chess:visual/board with storage aeroplane_chess:visual
data modify storage aeroplane_chess:visual duration set value 0
execute as @e[tag=ac.board,scores={ac_active=1}] run function aeroplane_chess:visual/spawn_plane
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function aeroplane_chess:visual/die_init with storage aeroplane_chess:visual
execute positioned ~ ~1.035 ~ summon minecraft:interaction run function aeroplane_chess:visual/die_click with storage aeroplane_chess:visual
function aeroplane_chess:visual/roll_done
function aeroplane_chess:visual/select
''')
    put('board','''
tag @s add ac.visual
tag @s add ac.board_display
scoreboard players operation @s ct_id = #vis_table ac_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/board/$(palette)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f,transformation:{translation:[0f,$(board_y)f,0f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(footprint)f,$(footprint)f,$(footprint)f]}}
''')
    put('plane_data','''
execute store result storage aeroplane_chess:visual color int 1 run scoreboard players get @s ac_color
execute store result storage aeroplane_chess:visual plane int 1 run scoreboard players get @s ac_plane
scoreboard players operation #vis_index ac_ctx = @s ac_pos
scoreboard players add #vis_index ac_ctx 1
execute store result storage aeroplane_chess:visual index int 1 run scoreboard players get #vis_index ac_ctx
function aeroplane_chess:visual/coord with storage aeroplane_chess:visual
function aeroplane_chess:visual/color_name
''')
    put('coord','''
$data modify storage aeroplane_chess:visual point set from storage aeroplane_chess:layout $(layout).p$(color)$(plane)[$(index)]
data modify storage aeroplane_chess:visual x set from storage aeroplane_chess:visual point.x
data modify storage aeroplane_chess:visual z set from storage aeroplane_chess:visual point.z
data modify storage aeroplane_chess:visual py set from storage aeroplane_chess:visual point.qy
data modify storage aeroplane_chess:visual pw set from storage aeroplane_chess:visual point.qw
''')
    put('color_name',[f'execute if data storage aeroplane_chess:visual {{color:{c}}} run data modify storage aeroplane_chess:visual color_name set value "{name}"' for c,name in enumerate(COLORS)])
    put('spawn_plane','''
function aeroplane_chess:visual/plane_data
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function aeroplane_chess:visual/plane_init with storage aeroplane_chess:visual
function aeroplane_chess:visual/click_at with storage aeroplane_chess:visual
''')
    put('plane_init','''
tag @s add ac.visual
tag @s add ac.man
scoreboard players operation @s ct_id = #vis_table ac_ctx
$scoreboard players set @s ac_color $(color)
$scoreboard players set @s ac_plane $(plane)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/plane/$(palette)_$(color_name)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function aeroplane_chess:visual/plane_pose with storage aeroplane_chess:visual
''')
    put('plane_pose','$data merge entity @s {start_interpolation:0,interpolation_duration:$(duration),transformation:{translation:[$(x)f,$(plane_y)f,$(z)f],left_rotation:[0f,$(py)f,0f,$(pw)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')
    put('click_at','$execute positioned ~$(x) ~1.035 ~$(z) summon minecraft:interaction run function aeroplane_chess:visual/click_init with storage aeroplane_chess:visual')
    put('click_init','''
tag @s add ac.visual
tag @s add ac.plane_click
scoreboard players operation @s ct_id = #vis_table ac_ctx
$scoreboard players set @s ac_color $(color)
$scoreboard players set @s ac_plane $(plane)
$data merge entity @s {width:$(width)f,height:0.15f,response:1b}
''')
    put('die_init','''
tag @s add ac.visual
tag @s add ac.die
scoreboard players operation @s ct_id = #vis_table ac_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/dice"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
''')
    put('die_click','''
tag @s add ac.visual
tag @s add ac.dice_click
scoreboard players operation @s ct_id = #vis_table ac_ctx
data merge entity @s {width:0.32f,height:0.48f,response:1b}
''')
    put('roll_tick','''
function aeroplane_chess:visual/context
execute store result storage aeroplane_chess:visual roll int 1 run scoreboard players get @s ac_roll
execute store result storage aeroplane_chess:visual frame int 1 run scoreboard players get @s ac_timer
function aeroplane_chess:visual/die_frame with storage aeroplane_chess:visual
''')
    put('roll_done','''
function aeroplane_chess:visual/context
execute store result storage aeroplane_chess:visual roll int 1 run scoreboard players get @s ac_roll
data modify storage aeroplane_chess:visual frame set value 0
function aeroplane_chess:visual/die_frame with storage aeroplane_chess:visual
''')
    put('die_frame','''
$data modify storage aeroplane_chess:visual frame_data set from storage aeroplane_chess:layout r$(roll)[$(frame)]
data modify storage aeroplane_chess:visual frame_data.scale set from storage aeroplane_chess:visual die_scale
# 高度用score只处理局部小数，不读取世界坐标，保持大坐标可用。
execute store result score #vis_y ac_ctx run data get storage aeroplane_chess:visual die_y 1000000
execute store result score #vis_lift ac_ctx run data get storage aeroplane_chess:visual frame_data.lift 1000000
scoreboard players operation #vis_y ac_ctx += #vis_lift ac_ctx
execute store result storage aeroplane_chess:visual frame_data.y double 0.000001 run scoreboard players get #vis_y ac_ctx
execute as @e[tag=ac.die] if score @s ct_id = #vis_table ac_ctx run function aeroplane_chess:visual/die_pose with storage aeroplane_chess:visual frame_data
''')
    put('die_pose','$data merge entity @s {start_interpolation:0,interpolation_duration:1,transformation:{translation:[$(x)f,$(y)f,$(z)f],left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')
    put('select','''
function aeroplane_chess:system/context
function aeroplane_chess:visual/context
execute as @e[tag=ac.highlight] if score @s ct_id = #vis_table ac_ctx run kill @s
execute unless score @s ac_state matches 3 run return 0
execute unless score @s ac_hints matches 1 run return 0
scoreboard players operation #vis_color ac_ctx = @s ac_turn
execute as @e[tag=ac.board,scores={ac_legal=1,ac_active=1}] if score @s ac_color = #vis_color ac_ctx run function aeroplane_chess:visual/hint
''')
    put('hint','''
function aeroplane_chess:visual/plane_data
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function aeroplane_chess:visual/hint_init with storage aeroplane_chess:visual
''')
    put('hint_init','''
tag @s add ac.visual
tag @s add ac.highlight
scoreboard players operation @s ct_id = #vis_table ac_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/selection"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f,Glowing:1b,glow_color_override:16773283,transformation:{translation:[$(x)f,$(plane_y)f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}
''')
    put('move','''
function aeroplane_chess:visual/context
execute as @e[tag=ac.highlight] if score @s ct_id = #vis_table ac_ctx run kill @s
execute store result storage aeroplane_chess:visual color int 1 run scoreboard players get @s ac_turn
execute store result storage aeroplane_chess:visual plane int 1 run scoreboard players get @s ac_selected
scoreboard players operation #vis_index ac_ctx = @s ac_frompos
scoreboard players add #vis_index ac_ctx 1
execute store result storage aeroplane_chess:visual index int 1 run scoreboard players get #vis_index ac_ctx
function aeroplane_chess:visual/coord with storage aeroplane_chess:visual
data modify storage aeroplane_chess:visual from set from storage aeroplane_chess:visual point
scoreboard players operation #vis_index ac_ctx = @s ac_topos
scoreboard players add #vis_index ac_ctx 1
execute store result storage aeroplane_chess:visual index int 1 run scoreboard players get #vis_index ac_ctx
function aeroplane_chess:visual/coord with storage aeroplane_chess:visual
data modify storage aeroplane_chess:visual to set from storage aeroplane_chess:visual point
execute store result storage aeroplane_chess:visual total int 1 run scoreboard players get @s ac_timer
data modify entity @s data.aeroplane_visual set value {}
data modify entity @s data.aeroplane_visual.from set from storage aeroplane_chess:visual from
data modify entity @s data.aeroplane_visual.to set from storage aeroplane_chess:visual to
data modify entity @s data.aeroplane_visual.total set from storage aeroplane_chess:visual total
data modify entity @s data.aeroplane_visual.color set from storage aeroplane_chess:visual color
data modify entity @s data.aeroplane_visual.plane set from storage aeroplane_chess:visual plane
''')
    put('move_tick','''
function aeroplane_chess:visual/context
data modify storage aeroplane_chess:visual movement set from entity @s data.aeroplane_visual
execute store result storage aeroplane_chess:visual movement.remaining int 1 run scoreboard players get @s ac_timer
execute store result storage aeroplane_chess:visual movement.kind int 1 run scoreboard players get @s ac_kind
function aeroplane_chess:visual/interpolate
''')
    put('finish_move','''
function aeroplane_chess:visual/context
data modify storage aeroplane_chess:visual movement set from entity @s data.aeroplane_visual
data modify storage aeroplane_chess:visual movement.remaining set value 0
execute store result storage aeroplane_chess:visual movement.kind int 1 run scoreboard players get @s ac_kind
function aeroplane_chess:visual/interpolate
''')
    # 局部定点插值，每tick1帧，服务器与客户端都不重新决定路线。
    interpolate='''
execute store result score #vis_total ac_ctx run data get storage aeroplane_chess:visual movement.total
execute store result score #vis_remaining ac_ctx run data get storage aeroplane_chess:visual movement.remaining
scoreboard players operation #vis_t ac_ctx = #vis_total ac_ctx
scoreboard players operation #vis_t ac_ctx -= #vis_remaining ac_ctx
scoreboard players set #vis_1000 ac_ctx 1000
scoreboard players operation #vis_t ac_ctx *= #vis_1000 ac_ctx
scoreboard players operation #vis_t ac_ctx /= #vis_total ac_ctx
'''
    for axis in ('x','z'):
        interpolate+=f'''execute store result score #vis_from ac_ctx run data get storage aeroplane_chess:visual movement.from.{axis} 100000
execute store result score #vis_to ac_ctx run data get storage aeroplane_chess:visual movement.to.{axis} 100000
scoreboard players operation #vis_to ac_ctx -= #vis_from ac_ctx
scoreboard players operation #vis_to ac_ctx *= #vis_t ac_ctx
scoreboard players operation #vis_to ac_ctx /= #vis_1000 ac_ctx
scoreboard players operation #vis_to ac_ctx += #vis_from ac_ctx
execute store result storage aeroplane_chess:visual {axis} double 0.00001 run scoreboard players get #vis_to ac_ctx
'''
    interpolate+='''
# 抛物线4t(1-t)，普通步低跳，跳格/起飞/飞越逐级加高。
scoreboard players set #vis_lift ac_ctx 1000
scoreboard players operation #vis_lift ac_ctx -= #vis_t ac_ctx
scoreboard players operation #vis_lift ac_ctx *= #vis_t ac_ctx
scoreboard players set #vis_height ac_ctx 1
execute if data storage aeroplane_chess:visual movement{kind:1} run scoreboard players set #vis_height ac_ctx 4
execute if data storage aeroplane_chess:visual movement{kind:2} run scoreboard players set #vis_height ac_ctx 3
execute if data storage aeroplane_chess:visual movement{kind:3} run scoreboard players set #vis_height ac_ctx 7
scoreboard players operation #vis_lift ac_ctx *= #vis_height ac_ctx
execute store result score #vis_y ac_ctx run data get storage aeroplane_chess:visual plane_y 10000000
scoreboard players operation #vis_y ac_ctx += #vis_lift ac_ctx
execute store result storage aeroplane_chess:visual plane_y double 0.0000001 run scoreboard players get #vis_y ac_ctx
data modify storage aeroplane_chess:visual py set from storage aeroplane_chess:visual movement.to.qy
data modify storage aeroplane_chess:visual pw set from storage aeroplane_chess:visual movement.to.qw
data modify storage aeroplane_chess:visual color set from storage aeroplane_chess:visual movement.color
data modify storage aeroplane_chess:visual plane set from storage aeroplane_chess:visual movement.plane
data modify storage aeroplane_chess:visual duration set value 1
function aeroplane_chess:visual/moving_entity with storage aeroplane_chess:visual
'''
    put('interpolate',interpolate)
    put('moving_entity','$execute as @e[tag=ac.man,scores={ac_color=$(color),ac_plane=$(plane)}] if score @s ct_id = #vis_table ac_ctx run function aeroplane_chess:visual/plane_pose with storage aeroplane_chess:visual')
    put('capture','''
function aeroplane_chess:visual/context
data modify storage aeroplane_chess:visual duration set value 6
execute as @e[tag=ac.board,tag=ac.captured] run function aeroplane_chess:visual/capture_plane
''')
    put('capture_plane','''
function aeroplane_chess:visual/plane_data
function aeroplane_chess:visual/capture_entity with storage aeroplane_chess:visual
''')
    put('capture_entity','$execute as @e[tag=ac.man,scores={ac_color=$(color),ac_plane=$(plane)}] if score @s ct_id = #vis_table ac_ctx run function aeroplane_chess:visual/plane_pose with storage aeroplane_chess:visual')


if __name__ == '__main__':
    # 只清理本脚本曾生成、现已删除的配色，不涉及其他资源。
    obsolete=('pastel','contrast','candy')
    for base in (CARD/'models/item/aeroplane_chess',CARD/'items/aeroplane_chess',
                 CARD/'textures/item/aeroplane_chess',RP/'.source/aeroplane_chess/models'):
        if base.exists():
            for path in base.rglob('*'):
                if path.is_file() and path.stem.startswith(obsolete):
                    assert path.resolve().is_relative_to(RP.resolve())
                    path.unlink()
    resources()
    functions()
    print('Generated Aeroplane Chess resources and animated visuals.')
