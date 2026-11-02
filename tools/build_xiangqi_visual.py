"""Build original round-disc Xiangqi resources and table display functions.

Java item elements approximate a circular edge with 32 thin columns. All artwork
and geometry are original, with editable Blockbench source preserved in .source.
"""
from __future__ import annotations
import base64
import copy
import json
import math
import shutil
import uuid
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT=Path(__file__).resolve().parents[1]
GAME=ROOT/'data/xiangqi/function/visual'
RP=ROOT.parents[3]/'resourcepacks/fimelcard-rp'
SOURCE=RP/'.source/xiangqi'
ASSETS=RP/'assets/card'
PIECES={1:'pawn',2:'horse',3:'elephant',4:'rook',5:'cannon',6:'general',7:'advisor'}
LETTERS={'red':{1:'\u5175',2:'\u9a6c',3:'\u76f8',4:'\u8f66',5:'\u70ae',6:'\u5e05',7:'\u4ed5'},'black':{1:'\u5352',2:'\u9a6c',3:'\u8c61',4:'\u8f66',5:'\u70ae',6:'\u5c06',7:'\u58eb'}}
BOARDS={
'classic':('#e6c694','#ecd4ab','#a48553','#41301f'),
'wood':('#cfa472','#e3bc8a','#9d7048','#50351f'),
}
PALETTES={'ebony':('#f0dab2','#e6cda1','#b72b27','#28272c'),'walnut':('#d8ac72','#edc895','#9c2722','#33291e')}
LAYOUTS={4:{'step':.255,'piece_scale':.231},8:{'step':.35,'piece_scale':.317}}
SEAT_EDGES={4:{1:2,2:3,3:0,4:1},8:{1:2,2:2,3:3,4:3,5:0,6:0,7:1,8:1}}

def text_file(path,contents):
 path.parent.mkdir(parents=True,exist_ok=True);path.write_text(contents.strip()+'\n',encoding='utf-8')
def json_file(path,obj):text_file(path,json.dumps(obj,ensure_ascii=False,indent=2))
def function(name,contents):text_file(GAME/(name+'.mcfunction'),contents)
def f(value):return f'{value:.7f}'.rstrip('0').rstrip('.') if value else '0.0'
def nbt_vector(values):return '['+','.join(f(v)+'f' for v in values)+']'
def rotate(x,z,orient):return (-z,x) if orient else (x,z)
def square_position(square,capacity,orient):
 step=LAYOUTS[capacity]['step'];return rotate((square%9-4)*step,(4.5-square//9)*step,orient)
def hit_dimensions(piece,capacity):
 scale=LAYOUTS[capacity]['piece_scale'];return scale*.96,scale*3/16+.012


def font(size):
 return ImageFont.truetype('C:/Windows/Fonts/simkai.ttf',size)


def circle_model(texture, edge):
 """Vanilla Java elements only: 32 vertical strips form a rounded disc."""
 elements=[]
 for index in range(32):
  x0=.5+index*15/32;x1=.5+(index+1)*15/32
  dz=math.sqrt(7.5**2-((x0+x1)/2-8)**2)
  z0,z1=8-dz,8+dz
  faces={face:{'texture':'#edge','uv':[0,0,16,3]} for face in ('north','south','east','west')}
  faces['up']={'texture':'#top','uv':[x0,z0,x1,z1]}
  faces['down']={'texture':'#edge','uv':[x0,z0,x1,z1]}
  elements.append({'name':f'disc_{index:02}','from':[x0,0,z0],'to':[x1,3,z1],'faces':faces})
 return {'credit':'Fimel Cards: original Xiangqi geometry and artwork','textures':{'top':texture,'edge':edge,'particle':edge},'gui_light':'front','elements':elements}


def item_model(name,model):
 json_file(ASSETS/f'models/item/xiangqi/{name}.json',model)
 json_file(ASSETS/f'items/xiangqi/{name}.json',{'model':{'type':'minecraft:model','model':f'card:item/xiangqi/{name}'}})


def texture_file(name,image):
 target=ASSETS/f'textures/item/xiangqi/{name}.png'
 target.parent.mkdir(parents=True,exist_ok=True);image.save(target)


def blockbench_source(model,texture,target):
 """Editable native .bbmodel with embedded textures; no export dependency."""
 textures=[]
 for index,path in enumerate((texture,texture.with_name('edge.png'))):
  tex_id=str(uuid.uuid5(uuid.NAMESPACE_URL,'fimel:xiangqi:'+path.relative_to(ASSETS).as_posix()))
  data=base64.b64encode(path.read_bytes()).decode('ascii')
  with Image.open(path) as image:width,height=image.size
  textures.append({'path':str(path),'name':path.name,'id':str(index),'uuid':tex_id,'width':width,'height':height,'uv_width':16,'uv_height':16,'source':'data:image/png;base64,'+data})
 elements=[]
 for index,item in enumerate(model['elements']):
  cube=copy.deepcopy(item);cube['uuid']=str(uuid.uuid5(uuid.NAMESPACE_URL,'fimel:xiangqi:'+target.relative_to(SOURCE).as_posix()+':'+str(index)))
  cube['type']='cube';cube['name']=item.get('name',f'disc_{index:02}');cube['origin']=[8,0,8];cube['rescale']=False;cube['box_uv']=False
  for face in cube['faces'].values():face['texture']=0 if face['texture']=='#top' else 1
  elements.append(cube)
 json_file(target,{'meta':{'format_version':'5.0','model_format':'java_block','box_uv':False},'name':target.stem,'resolution':{'width':16,'height':16},'elements':elements,'outliner':[element['uuid'] for element in elements],'textures':textures})


def export_resourcepack():
 SOURCE.mkdir(parents=True,exist_ok=True)
 # 删除固定列表内的旧配色；每个绝对路径须位于本资源包内。
 for subtree in ('models/item/xiangqi','items/xiangqi','textures/item/xiangqi'):
  for name in ('green','blue','purple'):
   suffix='.png' if subtree.startswith('textures/') else '.json'
   path=(ASSETS/subtree/f'board_{name}{suffix}').resolve()
   assert path.is_relative_to(RP.resolve()),path
   path.unlink(missing_ok=True)
  for name in ('ice','jade'):
   path=(ASSETS/subtree/name).resolve()
   assert path.is_relative_to(RP.resolve()),path
   if path.exists():shutil.rmtree(path)
 for name in ('ice','jade'):
  path=(SOURCE/'models'/name).resolve()
  assert path.is_relative_to(RP.resolve()),path
  if path.exists():shutil.rmtree(path)
 for palette,(base,top,red,black) in PALETTES.items():
  edge=Image.new('RGB',(64,64),base);draw=ImageDraw.Draw(edge)
  for y in range(64):
   color=tuple(max(0,min(255,int(base[i:i+2],16)+((y*11)%9-4))) for i in (1,3,5))
   draw.line((0,y,63,y),fill=color)
  draw.line((0,6,63,6),fill=top,width=2);draw.line((0,55,63,55),fill=top,width=2)
  texture_file(f'{palette}/edge',edge)
  for side,ink in [('red',red),('black',black)]:
   # 揭棋盖面不绘制身份；双方只能由边环识别红黑归属。
   image=Image.new('RGB',(128,128),base);d=ImageDraw.Draw(image)
   d.ellipse((5,5,122,122),fill=base,outline=ink,width=2)
   d.ellipse((11,11,116,116),fill=top,outline=ink,width=2)
   d.ellipse((42,42,85,85),outline=base,width=3)
   d.ellipse((49,49,78,78),outline=base,width=2)
   resource=f'{palette}/{side}_covered';texture_file(resource,image)
   model=circle_model(f'card:item/xiangqi/{resource}',f'card:item/xiangqi/{palette}/edge')
   item_model(resource,model)
   blockbench_source(model,ASSETS/f'textures/item/xiangqi/{resource}.png',SOURCE/f'models/{palette}/{side}_covered.bbmodel')
   for kind,name in PIECES.items():
    image=Image.new('RGB',(128,128),top);d=ImageDraw.Draw(image)
    d.ellipse((5,5,122,122),fill=base,outline=ink,width=2)
    d.ellipse((11,11,116,116),fill=top,outline=ink,width=2)
    d.text((64,66),LETTERS[side][kind],font=font(77),fill=ink,anchor='mm',stroke_width=0)
    resource=f'{palette}/{side}_{name}';texture_file(resource,image)
    model=circle_model(f'card:item/xiangqi/{resource}',f'card:item/xiangqi/{palette}/edge')
    item_model(resource,model)
    blockbench_source(model,ASSETS/f'textures/item/xiangqi/{resource}.png',SOURCE/f'models/{palette}/{side}_{name}.bbmodel')
 for name,(base,panel,border,ink) in BOARDS.items():
  image=Image.new('RGB',(576,640),base);d=ImageDraw.Draw(image)
  d.rounded_rectangle((4,4,571,635),radius=12,fill=panel,outline=border,width=3)
  for row in range(10):d.line((32,32+row*64,544,32+row*64),fill=ink,width=2)
  for file in range(9):
   x=32+file*64
   if file in (0,8):d.line((x,32,x,608),fill=ink,width=2)
   else:
    d.line((x,32,x,288),fill=ink,width=2);d.line((x,352,x,608),fill=ink,width=2)
  for ya,yb in [(32,160),(480,608)]:
   d.line((224,ya,352,yb),fill=ink,width=2);d.line((352,ya,224,yb),fill=ink,width=2)
  for file,rank in [(1,2),(7,2),(1,7),(7,7)]+[(x,y) for x in (0,2,4,6,8) for y in (3,6)]:
   x,y=32+file*64,32+(9-rank)*64
   for sx in (-1,1):
    if (file==0 and sx==-1) or (file==8 and sx==1):continue
    for sy in (-1,1):d.line([(x+sx*7,y+sy*19),(x+sx*7,y+sy*7),(x+sx*19,y+sy*7)],fill=ink,width=2)
  d.text((160,320),'楚 河',font=font(41),fill=ink,anchor='mm')
  d.text((416,320),'汉 界',font=font(41),fill=ink,anchor='mm')
  for file in range(9):
   d.text((32+file*64,622),'九八七六五四三二一'[file],font=font(16),fill=ink,anchor='mm')
   letter=Image.new('RGBA',(28,24),(0,0,0,0));ImageDraw.Draw(letter).text((14,12),str(file+1),font=font(16),fill=ink,anchor='mm')
   letter=letter.rotate(180);image.paste(letter,(18+file*64,4),letter)
  texture_file(f'board_{name}',image)
  texture=f'card:item/xiangqi/board_{name}'
  faces={face:{'texture':'#board','uv':[0,0,16,16]} for face in ('up','down','north','east','south','west')}
  item_model(f'board_{name}',{'textures':{'board':texture,'particle':texture},'elements':[{'from':[.8,0,0],'to':[15.2,.05,16],'faces':faces}]})
 # Geometry outlines avoid textures fighting the board's fine lines.
 for name,texture in [('selection','minecraft:block/gold_block'),('hint','minecraft:block/emerald_block')]:
  elements=[]
  for start,end in [([.6,0,.6],[15.4,.05,1.25]),([.6,0,14.75],[15.4,.05,15.4]),([.6,0,1.25],[1.25,.05,14.75]),([14.75,0,1.25],[15.4,.05,14.75])]:
   elements.append({'from':start,'to':end,'faces':{face:{'texture':'#frame'} for face in ('up','down','north','east','south','west')}})
  item_model(name,{'textures':{'frame':texture,'particle':texture},'elements':elements})
 preview=Image.new('RGB',(max(576*len(BOARDS),720*len(PALETTES)),640+160),'#24262b')
 for index,name in enumerate(BOARDS):preview.paste(Image.open(ASSETS/f'textures/item/xiangqi/board_{name}.png'),(576*index,0))
 for index,palette in enumerate(PALETTES):
  for j,side in enumerate(('red','black')):
   for k,piece in enumerate(PIECES.values()):
    icon=Image.open(ASSETS/f'textures/item/xiangqi/{palette}/{side}_{piece}.png').resize((72,72))
    preview.paste(icon,(index*720+k*80,640+j*80))
 preview.save(SOURCE/'palettes.png')


def export_functions():
    from build_xiangqi_hints import build as build_hints
    build_hints(ROOT)
    function("context", """
# 同步调用专用上下文；不得将 #vis_* 跨刻使用。
scoreboard players operation #vis_table xq_ctx = @s ct_id
scoreboard players operation #vis_cap xq_ctx = @s ct_capacity
scoreboard players operation #vis_orient xq_ctx = @s xq_orient
scoreboard players operation #vis_palette xq_ctx = @s xq_palette
scoreboard players operation #vis_board xq_ctx = @s xq_board
scoreboard players operation #vis_red xq_ctx = @s xq_red
scoreboard players operation #vis_black xq_ctx = @s xq_black
data modify storage xiangqi:visual palette set value "ebony"
data modify storage xiangqi:visual board set value "classic"
""" + "\n".join(f'execute if score #vis_palette xq_ctx matches {index} run data modify storage xiangqi:visual palette set value "{name}"' for index, name in enumerate(PALETTES)) + "\n" + "\n".join(f'execute if score #vis_board xq_ctx matches {index} run data modify storage xiangqi:visual board set value "{name}"' for index, name in enumerate(BOARDS)) + "\n" + "\n".join([
        "scoreboard players operation #vis_redge xq_ctx = #vis_orient xq_ctx",
        "scoreboard players operation #vis_bedge xq_ctx = #vis_orient xq_ctx",
        "scoreboard players add #vis_bedge xq_ctx 2",
    ] + [f"execute if score #vis_cap xq_ctx matches {cap} if score #vis_{side} xq_ctx matches {seat} run scoreboard players set #vis_{edge_side}edge xq_ctx {edge}" for cap,edges in SEAT_EDGES.items() for seat,edge in edges.items() for side,edge_side in [("red","r"),("black","b")]] + [
        "scoreboard players set #vis_overlap xq_ctx 0",
        "execute if score #vis_redge xq_ctx = #vis_bedge xq_ctx run scoreboard players set #vis_overlap xq_ctx 1",
    ]))
    function("clear", """
scoreboard players operation #vis_table xq_ctx = @s ct_id
execute as @e[tag=xq.visual] if score @s ct_id = #vis_table xq_ctx run kill @s
""")
    function("clear_board", """
# 刷新布局不影响时钟，不删除规则棋格 marker 或其他桌的任何实体。
scoreboard players operation #vis_table xq_ctx = @s ct_id
execute as @e[tag=xq.visual,tag=!xq.clock] if score @s ct_id = #vis_table xq_ctx run kill @s
""")
    function("setup", """
# 新局／新预览入口；重载已有对局请使用 refresh。
data modify entity @s data.xiangqi.captured set value []
scoreboard players set @s xq_rcapt 0
scoreboard players set @s xq_bcapt 0
function xiangqi:visual/refresh
""")
    function("refresh", """
function xiangqi:visual/clear_board
function xiangqi:visual/context
scoreboard players set #vis_duration xq_ctx 0
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function xiangqi:visual/board with storage xiangqi:visual
execute if score #vis_cap xq_ctx matches 4 if score #vis_orient xq_ctx matches 0 run function xiangqi:visual/cells4_0
execute if score #vis_cap xq_ctx matches 4 if score #vis_orient xq_ctx matches 1 run function xiangqi:visual/cells4_1
execute if score #vis_cap xq_ctx matches 8 if score #vis_orient xq_ctx matches 0 run function xiangqi:visual/cells8_0
execute if score #vis_cap xq_ctx matches 8 if score #vis_orient xq_ctx matches 1 run function xiangqi:visual/cells8_1
execute as @e[type=minecraft:marker,tag=xq.square] if score @s ct_id = #vis_table xq_ctx unless score @s xq_piece matches 0 run function xiangqi:visual/spawn_man
data modify storage xiangqi:visual restore set from entity @s data.xiangqi.captured
execute if data storage xiangqi:visual restore[0] run function xiangqi:visual/restore_captured
function xiangqi:visual/select
""")
    function("board", """
# ItemDisplayRenderer 在模型前固定旋转 Y 180°；右旋抵消它，保留上表面 UV 与逻辑格一致。
tag @s add xq.visual
tag @s add xq.board_display
scoreboard players operation @s ct_id = #vis_table xq_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:xiangqi/board_$(board)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
""" + "\n".join(f'execute if score #vis_cap xq_ctx matches {cap} if score #vis_orient xq_ctx matches {orient} run data merge entity @s {{transformation:{{translation:{nbt_vector([0, cfg["step"] * 10 * .5, 0])},left_rotation:{nbt_vector([0, -math.sin(orient*math.pi/4), 0, math.cos(orient*math.pi/4)])},right_rotation:[0f,1f,0f,0f],scale:' + nbt_vector([cfg["step"] * 10]*3) + '}}' for cap,cfg in LAYOUTS.items() for orient in range(2)))
    function("cell", """
tag @s add xq.visual
tag @s add xq.cell
tag @s add xq.tile
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
data merge entity @s {height:0.025f,response:1b}
execute if score #vis_cap xq_ctx matches 4 run data merge entity @s {width:0.251f}
execute if score #vis_cap xq_ctx matches 8 run data merge entity @s {width:0.346f}
""")
    for cap in LAYOUTS:
        for orient in range(2):
            lines = []
            for square in range(90):
                x,z=square_position(square,cap,orient)
                lines += [f"scoreboard players set #vis_sq xq_ctx {square}", f"execute positioned ~{f(x)} ~1.025 ~{f(z)} summon minecraft:interaction run function xiangqi:visual/cell"]
            function(f"cells{cap}_{orient}", "\n".join(lines))

    function("spawn_man", """
scoreboard players operation #vis_piece xq_ctx = @s xq_piece
scoreboard players set #vis_covered xq_ctx 0
execute if score @s xq_covered matches 1 run scoreboard players set #vis_covered xq_ctx 1
scoreboard players operation #vis_sq xq_ctx = @s xq_sq
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function xiangqi:visual/man_init
function xiangqi:visual/spawn_hit with storage xiangqi:visual
""")
    function("spawn_hit", '$execute positioned ~$(x) ~1.035 ~$(z) summon minecraft:interaction run function xiangqi:visual/hit_init')
    function("hit_init", """
tag @s add xq.visual
tag @s add xq.cell
tag @s add xq.piece_hit
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players operation @s xq_covered = #vis_covered xq_ctx
data merge entity @s {response:1b}
function xiangqi:visual/hit_shape
""")
    shape = []
    for cap in LAYOUTS:
        for piece in PIECES:
            width, height = hit_dimensions(piece, cap)
            for sign in (1, -1):
                shape.append(f'execute if score #vis_cap xq_ctx matches {cap} if score @s xq_piece matches {piece * sign} run data merge entity @s {{width:{f(width)}f,height:{f(height)}f}}')
    function("hit_shape", "\n".join(shape))
    function("move_hit", """
# 执行位置继承桌心；只将本桌该棋子的命中区迁到已提交的终点。
$tp @s ~$(x) ~1.035 ~$(z)
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players set @s xq_covered 0
function xiangqi:visual/hit_shape
""")
    function("man_init", """
tag @s add xq.visual
tag @s add xq.man
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players operation @s xq_covered = #vis_covered xq_ctx
scoreboard players set @s xq_owner 0
scoreboard players set @s xq_slot -1
data merge entity @s {item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function xiangqi:visual/man_model
function xiangqi:visual/man_pose
""")
    model_lines=[]
    for side,sign in [("red",1),("black",-1)]:
        for value,name in PIECES.items():
            model_lines.append(f'execute if score @s xq_piece matches {sign*value} run data modify storage xiangqi:visual man set value "{side}_{name}"')
    model_lines += [
        'execute if score @s xq_covered matches 1 if score @s xq_piece matches 1.. run data modify storage xiangqi:visual man set value "red_covered"',
        'execute if score @s xq_covered matches 1 if score @s xq_piece matches ..-1 run data modify storage xiangqi:visual man set value "black_covered"',
        "function xiangqi:visual/set_model with storage xiangqi:visual",
    ]
    function("man_model", "\n".join(model_lines))
    function("set_model", '$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:xiangqi/$(palette)/$(man)"}}}')

    pose_lines=["scoreboard players operation #vis_sq xq_ctx = @s xq_sq", "execute store result storage xiangqi:visual duration int 1 run scoreboard players get #vis_duration xq_ctx"]
    coordinate_routes = []
    for cap,config in LAYOUTS.items():
        scale=config["piece_scale"]
        pose_lines += [f'execute if score #vis_cap xq_ctx matches {cap} run data modify storage xiangqi:visual scale set value {f(scale)}', f'execute if score #vis_cap xq_ctx matches {cap} run data modify storage xiangqi:visual lift set value {f(scale*.5)}']
        for orient in range(2):
            coordinates = []
            for square in range(90):
                x,z=square_position(square,cap,orient)
                coordinates.append(f'execute if score #vis_sq xq_ctx matches {square} run data modify storage xiangqi:visual coord set value {{x:{f(x)},z:{f(z)}}}')
            function(f"coordinates{cap}_{orient}", "\n".join(coordinates))
            coordinate_routes.append(f"execute if score #vis_cap xq_ctx matches {cap} if score #vis_orient xq_ctx matches {orient} run function xiangqi:visual/coordinates{cap}_{orient}")
    function("resolve_square", "\n".join(coordinate_routes))
    pose_lines += ["function xiangqi:visual/resolve_square", "data modify storage xiangqi:visual x set from storage xiangqi:visual coord.x", "data modify storage xiangqi:visual z set from storage xiangqi:visual coord.z", "function xiangqi:visual/man_rotation", "function xiangqi:visual/set_pose with storage xiangqi:visual"]
    function("man_pose", "\n".join(pose_lines))
    rotation=['# Red lettering faces south, black lettering faces north.']
    for orient in range(2):
        for side,score in [(1,"1.."),(-1,"..-1")]:
            yaw=(0 if side==1 else 180)-orient*90
            rotation.append(f'execute if score #vis_orient xq_ctx matches {orient} if score @s xq_piece matches {score} run data modify storage xiangqi:visual rotation set value {{qy:{f(math.sin(math.radians(yaw/2)))},qw:{f(math.cos(math.radians(yaw/2)))}}}')
    rotation += ["data modify storage xiangqi:visual qy set from storage xiangqi:visual rotation.qy", "data modify storage xiangqi:visual qw set from storage xiangqi:visual rotation.qw"]
    function("man_rotation", "\n".join(rotation))
    function("set_pose", '$data merge entity @s {start_interpolation:0,interpolation_duration:$(duration),transformation:{translation:[$(x)f,$(lift)f,$(z)f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')

    function("select", """
function xiangqi:visual/context
execute as @e[tag=xq.highlight] if score @s ct_id = #vis_table xq_ctx run kill @s
scoreboard players operation #vis_sq xq_ctx = @s xq_sel
execute if score #vis_sq xq_ctx matches 0..89 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:visual/highlight
function xiangqi:hints/refresh
""")
    highlight=["tag @s add xq.visual", "tag @s add xq.highlight", "scoreboard players operation @s ct_id = #vis_table xq_ctx", "scoreboard players operation @s xq_sq = #vis_sq xq_ctx", 'data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:xiangqi/selection"}},item_display:"none",brightness:{block:15,sky:15},Glowing:1b,glow_color_override:16766720,shadow_radius:0f,view_range:24f}']
    for cap,cfg in LAYOUTS.items():
        for orient in range(2):
            for square in range(90):
                x,z=square_position(square,cap,orient)
                highlight.append(f'execute if score #vis_cap xq_ctx matches {cap} if score #vis_orient xq_ctx matches {orient} if score #vis_sq xq_ctx matches {square} run data merge entity @s {{transformation:{{translation:{nbt_vector([x,cfg["step"]*.5,z])},scale:' + nbt_vector([cfg["step"]]*3) + '}}')
    function("highlight", "\n".join(highlight))

    function("move", """
# 规则 marker 已提交；显示实体仍停在旧位置。所有临时状态在本函数链中消费。
function xiangqi:visual/context
scoreboard players set #vis_duration xq_ctx 8
scoreboard players set #vis_capture xq_ctx -1
execute store result score #vis_from xq_ctx run data get entity @s data.xiangqi.last.from
execute store result score #vis_to xq_ctx run data get entity @s data.xiangqi.last.to
execute store result score #vis_piece xq_ctx run data get entity @s data.xiangqi.last.piece
execute store result score #vis_taken xq_ctx run data get entity @s data.xiangqi.last.captured
scoreboard players set #vis_taken_covered xq_ctx 0
execute store result score #vis_taken_covered xq_ctx run data get entity @s data.xiangqi.last.captured_covered
execute store result score #vis_capture xq_ctx run data get entity @s data.xiangqi.last.capture_sq
scoreboard players set #vis_owner xq_ctx 1
execute if score #vis_piece xq_ctx matches ..-1 run scoreboard players set #vis_owner xq_ctx -1
execute unless score #vis_taken xq_ctx matches 0 if score #vis_capture xq_ctx matches 0..89 run function xiangqi:visual/capture
execute as @e[type=minecraft:item_display,tag=xq.man,tag=!xq.captured] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_from xq_ctx run function xiangqi:visual/move_man
function xiangqi:visual/select
""")
    function("move_man", """
tag @s add xq.moving
scoreboard players operation @s xq_sq = #vis_to xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players set @s xq_covered 0
function xiangqi:visual/man_model
function xiangqi:visual/man_pose
scoreboard players operation #vis_piece xq_ctx = @s xq_piece
execute as @e[type=minecraft:interaction,tag=xq.piece_hit] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_from xq_ctx run function xiangqi:visual/move_hit with storage xiangqi:visual
""")
    function("finish_move", """
scoreboard players operation #vis_table xq_ctx = @s ct_id
execute as @e[tag=xq.man,tag=xq.moving] if score @s ct_id = #vis_table xq_ctx run tag @s remove xq.moving
""")
    function("capture", """
scoreboard players set #vis_slot xq_ctx 0
execute if score #vis_owner xq_ctx matches 1 run scoreboard players operation #vis_slot xq_ctx = @s xq_rcapt
execute if score #vis_owner xq_ctx matches -1 run scoreboard players operation #vis_slot xq_ctx = @s xq_bcapt
data modify storage xiangqi:visual captured set value {piece:0,owner:0,slot:0,covered:0}
execute store result storage xiangqi:visual captured.piece int 1 run scoreboard players get #vis_taken xq_ctx
execute store result storage xiangqi:visual captured.covered int 1 run scoreboard players get #vis_taken_covered xq_ctx
execute store result storage xiangqi:visual captured.owner int 1 run scoreboard players get #vis_owner xq_ctx
execute store result storage xiangqi:visual captured.slot int 1 run scoreboard players get #vis_slot xq_ctx
data modify entity @s data.xiangqi.captured append from storage xiangqi:visual captured
execute if score #vis_owner xq_ctx matches 1 run scoreboard players add @s xq_rcapt 1
execute if score #vis_owner xq_ctx matches -1 run scoreboard players add @s xq_bcapt 1
execute as @e[type=minecraft:interaction,tag=xq.piece_hit] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_capture xq_ctx run kill @s
execute as @e[type=minecraft:item_display,tag=xq.man,tag=!xq.captured] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_capture xq_ctx run function xiangqi:visual/capture_man
""")
    function("capture_man", """
tag @s add xq.captured
tag @s add xq.moving
scoreboard players set @s xq_sq -1
scoreboard players operation @s xq_owner = #vis_owner xq_ctx
scoreboard players operation @s xq_slot = #vis_slot xq_ctx
scoreboard players operation @s xq_covered = #vis_taken_covered xq_ctx
function xiangqi:visual/man_model
function xiangqi:visual/captured_pose
""")
    function("restore_captured", """
execute store result score #vis_piece xq_ctx run data get storage xiangqi:visual restore[0].piece
scoreboard players set #vis_covered xq_ctx 0
execute store result score #vis_covered xq_ctx run data get storage xiangqi:visual restore[0].covered
execute store result score #vis_owner xq_ctx run data get storage xiangqi:visual restore[0].owner
execute store result score #vis_slot xq_ctx run data get storage xiangqi:visual restore[0].slot
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function xiangqi:visual/restore_man
data remove storage xiangqi:visual restore[0]
execute if data storage xiangqi:visual restore[0] run function xiangqi:visual/restore_captured
""")
    function("restore_man", """
tag @s add xq.visual
tag @s add xq.man
tag @s add xq.captured
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players operation @s xq_covered = #vis_covered xq_ctx
scoreboard players operation @s xq_owner = #vis_owner xq_ctx
scoreboard players operation @s xq_slot = #vis_slot xq_ctx
scoreboard players set @s xq_sq -1
data merge entity @s {item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function xiangqi:visual/man_model
function xiangqi:visual/captured_pose
""")
    # Translate real seat to the edge at that viewer's right.  Edge 0=east,
    # 1=south, 2=west, 3=north.  Preview/no-seat falls back to board sides.
    captures=["scoreboard players operation #vis_slot xq_ctx = @s xq_slot", "scoreboard players operation #vis_owner xq_ctx = @s xq_owner", "execute store result storage xiangqi:visual duration int 1 run scoreboard players get #vis_duration xq_ctx", "execute if score #vis_owner xq_ctx matches 1 run scoreboard players operation #vis_edge xq_ctx = #vis_redge xq_ctx", "execute if score #vis_owner xq_ctx matches -1 run scoreboard players operation #vis_edge xq_ctx = #vis_bedge xq_ctx"]
    for cap,cfg in LAYOUTS.items():
        scale=.12 if cap==4 else .165
        captures += [f'execute if score #vis_cap xq_ctx matches {cap} run data modify storage xiangqi:visual scale set value {f(scale)}', f'execute if score #vis_cap xq_ctx matches {cap} run data modify storage xiangqi:visual lift set value {f(scale*.5)}']
        for slot in range(15):
            outward=(1.265 if cap==4 else 1.735)+(slot//8)*(.13 if cap==4 else .17)
            along=(slot%8-3.5)*cfg['step']
            for edge in range(4):
                x,z=[(outward,along),(-along,outward),(-outward,-along),(along,-outward)][edge]
                captures.append(f'execute if score #vis_cap xq_ctx matches {cap} if score #vis_edge xq_ctx matches {edge} if score #vis_slot xq_ctx matches {slot} run data modify storage xiangqi:visual coord set value {{x:{f(x)},z:{f(z)}}}')
    captures += ["data modify storage xiangqi:visual x set from storage xiangqi:visual coord.x", "data modify storage xiangqi:visual z set from storage xiangqi:visual coord.z", "function xiangqi:visual/man_rotation", "function xiangqi:visual/set_pose with storage xiangqi:visual"]
    function("captured_pose", "\n".join(captures))



def export_notes():
    text_file(SOURCE/'README.md', """
# Fimel Cards \u4e2d\u56fd\u8c61\u68cb\u539f\u521b\u8d44\u6e90

\u68cb\u76d8\u3001\u68cb\u5b50\u7eb9\u7406\u548c\u5706\u76d8\u51e0\u4f55\u5747\u4e3a Fimel Cards \u81ea\u5236\uff0c\u672a\u4f7f\u7528\u7f51\u7ad9\u7684\u68cb\u76d8\u56fe\u7247\u6216\u7b2c\u4e09\u65b9\u68cb\u5b50\u6a21\u578b\u3002
\u68cb\u5b50\u4f7f\u7528 32 \u4e2a Java \u539f\u7248\u5143\u7d20\u62fc\u6210\u8fd1\u5706\u5f62\u8fb9\u7f18\uff0c\u76f4\u5f84 15/16\uff0c\u539a\u5ea6 3/16\uff0c\u65e0\u9700 OptiFine \u6216\u6a21\u7ec4\u3002
\u4e03\u79cd\u7ea2\u65b9\u68cb\u5b50\u4e3a\u5e05\u3001\u4ed5\u3001\u76f8\u3001\u9a6c\u3001\u8f66\u3001\u70ae\u3001\u5175\uff1b\u9ed1\u65b9\u4e3a\u5c06\u3001\u58eb\u3001\u8c61\u3001\u9a6c\u3001\u8f66\u3001\u70ae\u3001\u5352\u3002
\u7ecf\u5178\u548c\u6728\u8272\u4e24\u79cd\u68cb\u5b50\u6750\u8d28\u4e0e\u68cb\u76d8\u914d\u8272\u53ef\u5728\u6e38\u620f\u8bbe\u7f6e\u4e2d\u8c03\u6574\u3002 `palettes.png` \u4e3a\u9884\u89c8\uff0c`models/` \u5185\u662f\u53ef\u4ee5\u5728 Blockbench \u7ee7\u7eed\u7f16\u8f91\u7684 .bbmodel\u3002

\u751f\u6210\u65b9\u6cd5\uff1a\u4ece\u6570\u636e\u5305\u76ee\u5f55\u6267\u884c `python tools/build_xiangqi_visual.py`\uff0c\u4f9d\u8d56 Pillow \u548c Windows \u6977\u4f53\u5b57\u4f53 simkai.ttf\u3002
\u903b\u8f91\u683c\u53f7 `rank*9+file`\uff0c\u7ea2\u65b9\u5e95\u7ebf\u4e3a rank=0\uff0c\u7ea2\u65b9\u5c06\u5e05\u4f4d\u4e8e file=4\u3002
\u56db\u4eba\u684c\u683c\u957f 0.255\uff0c\u516b\u4eba\u684c 0.35\uff0c\u68cb\u76d8\u603b\u5c3a\u5bf8\u5206\u522b\u4e3a 2.295*2.55 \u548c 3.15*3.5\u3002
\u65b9\u5411 0 \u7ea2\u65b9\u5728\u5357\u4fa7\uff0c\u65b9\u5411 1 \u7ea2\u65b9\u5728\u897f\u4fa7\uff0c\u5b57\u9762\u671d\u5411\u5404\u81ea\u73a9\u5bb6\u3002
\u68cb\u5b50\u548c\u88ab\u5403\u68cb\u5b50\u7684\u79fb\u52a8\u4f7f\u7528 8 \u523b\u63d2\u503c\uff0c\u88ab\u5403\u68cb\u5b50\u7f29\u5c0f\u540e\u6392\u5728\u5403\u5b50\u8005\u53f3\u624b\u8fb9\u3002
\u9009\u4e2d\u683c\u7528\u91d1\u8272\u8fb9\u6846\uff0c\u5408\u6cd5\u7ec8\u70b9\u7528\u7eff\u8272\u53d1\u5149\u8fb9\u6846\uff0c\u63d0\u793a\u76f4\u63a5\u8c03\u7528\u89c4\u5219\u5f15\u64ce\u7684\u53ea\u8bfb\u6a21\u62df\u3002

揭棋盖面资源为每种材质的 `red_covered`、`black_covered`，沿用圆盘几何，仅以边环区分阵营，不绘制身份。
公开展示与点击实体仅保存棋子模板／已翻开身份及盖面标记，不读取暗子真实身份。首次行棋后换为真实牌面，被吃暗子在右侧槽内保持盖面；悔棋和重载均恢复盖面。
""")

if __name__=='__main__':
    export_resourcepack()
    export_functions()
    export_notes()
    print(f'Built {len(list(GAME.glob("*.mcfunction")))} Xiangqi visual functions.')
