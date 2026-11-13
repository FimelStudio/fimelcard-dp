# -*- coding: utf-8 -*-
"""复用五子棋几何，生成独立围棋展示、提子动画和按行合并的占地标记。"""
import json
from PIL import Image, ImageDraw, ImageFont
import build_gomoku_visual as base
from boardgame_assets import PACK, RP, CARD, text_file, json_file, export_model, export_texture, cube

ROOT=PACK/'data/weiqi/function/visual'
OBJECTIVES={n:'dummy' for n in ('go_v_age','go_v_len','go_vowner','go_vrun','go_vrow')}
LETTERS='ABCDEFGHJKLMNOPQRST'


def put(name,body):
    text_file(ROOT/(name+'.mcfunction'),'\n'.join(body) if isinstance(body,list) else body)


def inherited(name,body):
    if name=='win_loop':return
    s='\n'.join(body) if isinstance(body,list) else body
    s=s.replace('gomoku:','weiqi:').replace('card:gomoku/','card:weiqi/').replace('gm_','go_').replace('gm.','go.').replace('data.gomoku','data.weiqi')
    put(name,s.replace('view_range:24f','view_range:0.5f'))


def resources():
    # 保留五子棋原资源；围棋只覆盖坐标字母，几何与棋子用parent复用。
    for board in ('classic','wood'):
        ink='#44331e' if board=='classic' else '#4a331f'
        for size in (13,15,19):
            image=Image.open(CARD/f'textures/item/gomoku/board/{board}_{size}_plain.png').convert('RGB')
            draw=ImageDraw.Draw(image);font=ImageFont.truetype('C:/Windows/Fonts/arial.ttf',23)
            for row in range(size):
                position=round(64+row*896/(size-1))
                draw.text((position,990),LETTERS[row],fill=ink,font=font,anchor='mm')
                draw.text((32,1024-position),str(row+1),fill=ink,font=font,anchor='mm')
            key=f'board/{board}_{size}_coords'
            export_texture('weiqi',key,image)
            for labels in ('plain','coords'):
                name=f'board/{board}_{size}_{labels}'
                model={'parent':f'card:item/gomoku/board/{board}_{size}_{labels}'}
                if labels=='coords':model['textures']={'all':f'card:item/weiqi/{key}'}
                json_file(CARD/f'models/item/weiqi/{name}.json',model)
                json_file(CARD/f'items/weiqi/{name}.json',{'model':{'type':'minecraft:model','model':f'card:item/weiqi/{name}'}})
    for color in ('black','white'):
        key=f'stone/ebony_{color}'
        json_file(CARD/f'models/item/weiqi/{key}.json',{'parent':f'card:item/gomoku/{key}'})
        json_file(CARD/f'items/weiqi/{key}.json',{'model':{'type':'minecraft:model','model':f'card:item/weiqi/{key}'}})
    for mark in ('selection','last'):
        json_file(CARD/f'models/item/weiqi/{mark}.json',{'parent':f'card:item/gomoku/{mark}'})
        json_file(CARD/f'items/weiqi/{mark}.json',{'model':{'type':'minecraft:model','model':f'card:item/weiqi/{mark}'}})
    for mark,color in (('territory_black','#252935'),('territory_white','#f4e8c9'),('dead','#e65b65')):
        export_texture('weiqi',mark,Image.new('RGB',(16,16),color))
        # 完整单元平面便于把相邻同色占地合并为一条带，减少展示实体。
        elements=[cube([0,0,0],[16,.08,16])]
        if mark=='dead':elements=[cube([2,0,7],[14,.12,9]),cube([7,0,2],[9,.12,14])]
        export_model('weiqi',mark,{'textures':{'all':f'card:item/weiqi/{mark}'},'elements':elements})
    text_file(RP/'.source/weiqi/README.md','''# 围棋资源

棋盘和圆形棋子复用本项目五子棋的原创几何。classic／wood 的 13、15、19 路坐标图从无坐标底图生成，字母采用围棋常用的跳 I 标法；原五子棋资源不变。
占地色带与死子标记由代码生成，完整源见数据包 tools/build_weiqi_visual.py；音效源在 audio/。
占地显示仅在请求时创建，同一行相邻同色空点合并为一个展示实体；关闭或下一手后清除。棋盘只有一个客户端交互实体，逻辑交点为服务端 marker。
''')


def functions():
    original=base.put
    try:
        base.put=inherited
        base.functions()
    finally:base.put=original
    load=(ROOT/'load.mcfunction').read_text(encoding='utf8')
    put('load',[f'scoreboard objectives add {n} {t}' for n,t in OBJECTIVES.items()]+[load])
    put('context',r'''
execute unless data storage weiqi:layout s19c8o1 run function weiqi:visual/load
scoreboard players operation #vis_table go_ctx = @s ct_id
execute store result storage weiqi:visual size int 1 run scoreboard players get @s go_size
execute store result storage weiqi:visual cap int 1 run scoreboard players get @s ct_capacity
execute store result storage weiqi:visual orient int 1 run scoreboard players get @s go_orient
data modify storage weiqi:visual board set value "classic"
execute if score @s go_board matches 1 run data modify storage weiqi:visual board set value "wood"
data modify storage weiqi:visual palette set value "ebony"
data modify storage weiqi:visual labels set value "coords"
execute if score @s go_coords matches 0 run data modify storage weiqi:visual labels set value "plain"
function weiqi:visual/layout with storage weiqi:visual
''')
    put('select',r'''
function weiqi:visual/context
execute as @e[tag=go.highlight] if score @s ct_id = #vis_table go_ctx run kill @s
execute if score @s go_sel matches 0..360 run function weiqi:visual/selection
execute if score @s go_mark matches 1 if data entity @s data.weiqi.last.sq if data entity @s data.weiqi.last{pass:0b} run function weiqi:visual/last
''')
    # 新棋子落下同时提走相邻无气组；提子只根据引擎已确认的公开列表。
    put('capture',r'''
function weiqi:visual/context
data modify storage weiqi:visual captured set value []
data modify storage weiqi:visual captured set from entity @s data.weiqi.last.captured
execute if data storage weiqi:visual captured[0] run function weiqi:visual/capture_loop
''')
    put('capture_loop',r'''
data modify storage weiqi:visual sq set from storage weiqi:visual captured[0]
function weiqi:visual/capture_one with storage weiqi:visual
data remove storage weiqi:visual captured[0]
execute if data storage weiqi:visual captured[0] run function weiqi:visual/capture_loop
''')
    put('capture_one',r'''
$execute as @e[type=minecraft:item_display,tag=go.man,scores={go_sq=$(sq)}] if score @s ct_id = #vis_table go_ctx run function weiqi:visual/retract
''')
    put('clear_estimate',r'''
scoreboard players operation #vis_table go_ctx = @s ct_id
execute as @e[tag=go.territory] if score @s ct_id = #vis_table go_ctx run kill @s
execute as @e[tag=go.dead_mark] if score @s ct_id = #vis_table go_ctx run kill @s
''')
    put('estimate',r'''
function weiqi:system/context
function weiqi:visual/context
function weiqi:visual/clear_estimate
scoreboard players operation #v_size go_ctx = @s go_size
scoreboard players set #v_sq go_ctx 0
scoreboard players set #v_row go_ctx 0
scoreboard players set #v_col go_ctx 0
scoreboard players set #v_owner go_ctx 0
scoreboard players set #v_start go_ctx 0
scoreboard players set #v_length go_ctx 0
function weiqi:visual/territory_scan
execute as @e[type=minecraft:marker,tag=go.board,scores={go_dead=1}] run function weiqi:visual/dead_marker
''')
    put('territory_scan',r'''
execute store result storage weiqi:visual sq int 1 run scoreboard players get #v_sq go_ctx
function weiqi:visual/territory_read with storage weiqi:visual
execute unless score #v_cell_owner go_ctx = #v_owner go_ctx run function weiqi:visual/territory_flush
execute if score #v_length go_ctx matches 0 run scoreboard players operation #v_start go_ctx = #v_sq go_ctx
scoreboard players operation #v_owner go_ctx = #v_cell_owner go_ctx
scoreboard players add #v_length go_ctx 1
scoreboard players add #v_col go_ctx 1
scoreboard players add #v_sq go_ctx 1
execute if score #v_col go_ctx >= #v_size go_ctx run function weiqi:visual/territory_row_end
execute if score #v_row go_ctx < #v_size go_ctx run function weiqi:visual/territory_scan
''')
    put('territory_read',r'''
scoreboard players set #v_cell_owner go_ctx 0
$execute if entity @e[tag=go.board,scores={go_sq=$(sq),go_piece=0},limit=1] run scoreboard players operation #v_cell_owner go_ctx = @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_owner
$execute if entity @e[tag=go.board,scores={go_sq=$(sq),go_dead=1},limit=1] run scoreboard players operation #v_cell_owner go_ctx = @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_owner
''')
    put('territory_row_end',r'''
function weiqi:visual/territory_flush
scoreboard players set #v_col go_ctx 0
scoreboard players add #v_row go_ctx 1
scoreboard players operation #v_sq go_ctx = #v_row go_ctx
scoreboard players set #v_stride go_ctx 19
scoreboard players operation #v_sq go_ctx *= #v_stride go_ctx
''')
    put('territory_flush',r'''
execute if score #v_length go_ctx matches 1.. unless score #v_owner go_ctx matches 0 run function weiqi:visual/territory_strip
scoreboard players set #v_length go_ctx 0
scoreboard players set #v_owner go_ctx 0
''')
    put('territory_strip',r'''
execute store result storage weiqi:visual sq int 1 run scoreboard players get #v_start go_ctx
execute store result storage weiqi:visual length int 1 run scoreboard players get #v_length go_ctx
data modify storage weiqi:visual owner set value "black"
execute if score #v_owner go_ctx matches -1 run data modify storage weiqi:visual owner set value "white"
function weiqi:visual/coord with storage weiqi:visual
function weiqi:visual/strip_geometry with storage weiqi:visual
''')
    # 非逐tick计算；一行色带以薄面覆盖单色区域，用横/竖缩放适应两方向。
    put('strip_geometry',r'''
execute store result score #strip_x go_ctx run data get storage weiqi:visual x 1000000
execute store result score #strip_z go_ctx run data get storage weiqi:visual z 1000000
execute store result score #strip_step go_ctx run data get storage weiqi:visual step 1000000
$scoreboard players set #strip_n go_ctx $(length)
scoreboard players remove #strip_n go_ctx 1
scoreboard players operation #strip_n go_ctx *= #strip_step go_ctx
scoreboard players set #strip_two go_ctx 2
scoreboard players operation #strip_n go_ctx /= #strip_two go_ctx
execute if data storage weiqi:visual {orient:0} run scoreboard players operation #strip_x go_ctx += #strip_n go_ctx
execute if data storage weiqi:visual {orient:1} run scoreboard players operation #strip_z go_ctx += #strip_n go_ctx
execute store result storage weiqi:visual strip_x double 0.000001 run scoreboard players get #strip_x go_ctx
execute store result storage weiqi:visual strip_z double 0.000001 run scoreboard players get #strip_z go_ctx
$scoreboard players set #strip_width go_ctx $(length)
scoreboard players operation #strip_width go_ctx *= #strip_step go_ctx
scoreboard players set #strip_half go_ctx 2
scoreboard players operation #strip_step go_ctx /= #strip_half go_ctx
scoreboard players operation #strip_width go_ctx -= #strip_step go_ctx
execute store result storage weiqi:visual strip_width double 0.000001 run scoreboard players get #strip_width go_ctx
execute store result storage weiqi:visual strip_thin double 0.000001 run scoreboard players get #strip_step go_ctx
execute positioned ~ ~1.032 ~ summon minecraft:item_display run function weiqi:visual/strip with storage weiqi:visual
''')
    put('strip',r'''
tag @s add go.visual
tag @s add go.territory
scoreboard players operation @s ct_id = #vis_table go_ctx
$scoreboard players set @s go_v_len $(length)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:weiqi/territory_$(owner)"}},item_display:"none",brightness:{block:15,sky:15},view_range:0.5f,shadow_radius:0f,transformation:{translation:[$(strip_x)f,0.06f,$(strip_z)f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(strip_width)f,0.1f,$(strip_thin)f]}}
''')
    put('dead_marker',r'''
execute store result storage weiqi:visual sq int 1 run scoreboard players get @s go_sq
function weiqi:visual/coord with storage weiqi:visual
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function weiqi:visual/dead_display with storage weiqi:visual
''')
    put('dead_display',r'''
tag @s add go.visual
tag @s add go.dead_mark
scoreboard players operation @s ct_id = #vis_table go_ctx
$scoreboard players set @s go_sq $(sq)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:weiqi/dead"}},item_display:"none",brightness:{block:15,sky:15},view_range:0.5f,shadow_radius:0f,transformation:{translation:[$(x)f,$(last_y)f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}
''')


def build():
    resources();functions()
    print('WeiQi visuals generated with reused Gomoku geometry, one board hitbox and compressed territory strips.')


if __name__=='__main__':build()
