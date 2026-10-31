"""生成三种尺寸五子棋的原创资源及四／八人桌展示、落子和收回动画。"""
import json
import math
from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import PACK, RP, CARD, json_file, text_file, export_model, export_texture, flat_board, disc, outline, cube

GAME = PACK/'data/gomoku/function/visual'
SIZES = (13, 15, 19)
FOOTPRINTS = {4: 2.7, 8: 3.6}
BOARDS = {
    'classic': ('#d9b575', '#e8c992', '#705334', '#44331e'),
    'wood': ('#b18b63', '#d6b28a', '#795836', '#4a331f'),
}
PALETTES = {'ebony': ('#20212a', '#f3eee0')}


def put(name, body):
    body = '\n'.join(body) if isinstance(body, list) else body
    text_file(GAME/(name+'.mcfunction'), body.replace('view_range:24f','view_range:0.5f'))


def position(size, cap, orient, sq):
    step = FOOTPRINTS[cap]*.875/(size-1)
    x = (sq%19-(size-1)/2)*step
    z = ((size-1)/2-sq//19)*step
    return (-z, x) if orient else (x, z)


def font(size):
    return ImageFont.truetype('C:/Windows/Fonts/arial.ttf', size)


def resources():
    for name, colors in BOARDS.items():
        base, panel, edge, ink = colors
        for size in SIZES:
            for labels in ('plain', 'coords'):
                bitmap = Image.new('RGB', (1024, 1024), base)
                draw = ImageDraw.Draw(bitmap)
                draw.rounded_rectangle((7, 7, 1016, 1016), radius=22, fill=panel, outline=edge, width=5)
                for row in range(size):
                    coordinate = round(64+row*896/(size-1))
                    draw.line((64, coordinate, 960, coordinate), fill=ink, width=2)
                    draw.line((coordinate, 64, coordinate, 960), fill=ink, width=2)
                    if labels == 'coords':
                        draw.text((coordinate, 990), chr(65+row), fill=ink, font=font(23), anchor='mm')
                        draw.text((32, 1024-coordinate), str(row+1), fill=ink, font=font(23), anchor='mm')
                star_positions = (3, (size-1)//2, size-4)
                for x in star_positions:
                    for y in star_positions:
                        px, py = 64+x*896/(size-1), 64+y*896/(size-1)
                        draw.ellipse((px-5, py-5, px+5, py+5), fill=ink)
                key = f'board/{name}_{size}_{labels}'
                export_texture('gomoku', key, bitmap)
                export_model('gomoku', key, flat_board('card:item/gomoku/'+key))
    for palette, colors in PALETTES.items():
        for side, color in zip(('black', 'white'), colors):
            bitmap = Image.new('RGB', (96, 96), color)
            draw = ImageDraw.Draw(bitmap)
            rgb = tuple(int(color[i:i+2], 16) for i in (1, 3, 5))
            for radius in range(45, 0, -1):
                factor = .78+.22*(1-radius/45)
                shade = tuple(int(v*factor) for v in rgb)
                draw.ellipse((48-radius, 48-radius, 48+radius, 48+radius), fill=shade)
            highlight = tuple(min(255, v+33) for v in rgb)
            draw.arc((18, 14, 68, 64), 208, 282, fill=highlight, width=3)
            key = f'stone/{palette}_{side}'
            export_texture('gomoku', key, bitmap)
            edge = Image.new('RGB', (32, 32), tuple(round(v*.65) for v in rgb))
            export_texture('gomoku', key+'_edge', edge)
            export_model('gomoku', key, disc('card:item/gomoku/'+key, 'card:item/gomoku/'+key+'_edge'))
    for name, color in [('selection', '#f1c64d'), ('winning', '#52dd97'), ('last', '#f05b56')]:
        export_texture('gomoku', name, Image.new('RGB', (16, 16), color))
        if name == 'last':
            model = {'textures': {'all': 'card:item/gomoku/last'}, 'elements': [
                cube([7.65, 0, 6], [8.35, .15, 10]), cube([6, 0, 7.65], [10, .15, 8.35])]}
        else:
            model = outline('card:item/gomoku/'+name)
        export_model('gomoku', name, model)
    preview = Image.new('RGB', (512*2, 512+104), '#252831')
    for index, name in enumerate(BOARDS):
        preview.paste(Image.open(CARD/f'textures/item/gomoku/board/{name}_19_coords.png').resize((512, 512)), (index*512, 0))
    for index, palette in enumerate(PALETTES):
        for column, side in enumerate(('black', 'white')):
            preview.paste(Image.open(CARD/f'textures/item/gomoku/stone/{palette}_{side}.png'), (index*320+column*112, 516))
    preview.save(RP/'.source/gomoku/palettes.png')
    text_file(RP/'.source/gomoku/README.md', '''
# 五子棋原创资源

三种棋盘为13×13、15×15、19×19，仅保留经典、木色两种棋盘与黑白棋子。
棋盘与圆盘棋子均由本项目制作，模型仅使用原版Java元素，保留可编辑的Blockbench源文件。
从数据包目录运行 `python tools/build_gomoku_visual.py` 重建，依赖Pillow和Windows Arial字体。
四人桌棋盘边长2.7、八人桌3.6；网格占外框的87.5%，逻辑格号采用固定19步长。
19路四人桌交点间距0.13125格，另提供对局菜单辅助选点与可选二次确认。
模型的物品展示固定Y180度通过right_rotation抵消，坐标贴图与真实点击点一致。
每桌只有一个棋盘交互实体；点击时才用二分视线求交定位交点，不逐刻投射视线。
逻辑交点使用仅在服务端存在的marker，不向客户端同步；已落子才创建棋子展示。
棋子模型每枚16条圆盘、80个面，省去不可见底面；展示物的视距系数0.5（默认约32格）。
''')


def functions():
    layouts = []
    for size in SIZES:
        for cap, footprint in FOOTPRINTS.items():
            step = footprint*.875/(size-1)
            for orient in (0, 1):
                cells = []
                for sq in range(361):
                    x, z = position(size, cap, orient, sq)
                    cells.append({'x': round(x, 8), 'z': round(z, 8)})
                geom = {'step': step, 'scale': step*.9, 'width': step*.98, 'footprint': footprint,
                        'board_y': footprint*.5, 'stone_y': step*.45,
                        'frame_y': step*.5+.012, 'last_y': step*.5+step*.9*1.8/16+.012,
                        'qy': -math.sin(orient*math.pi/4), 'qw': math.cos(orient*math.pi/4)}
                key = f's{size}c{cap}o{orient}'
                layouts.append('data modify storage gomoku:layout '+key+' set value '+json.dumps({'geom': geom, 'cells': cells}, separators=(',', ':')))
    put('load', layouts)
    context = [
        'execute unless data storage gomoku:layout s19c8o1 run function gomoku:visual/load',
        'scoreboard players operation #vis_table gm_ctx = @s ct_id',
        'execute store result storage gomoku:visual size int 1 run scoreboard players get @s gm_size',
        'execute store result storage gomoku:visual cap int 1 run scoreboard players get @s ct_capacity',
        'execute store result storage gomoku:visual orient int 1 run scoreboard players get @s gm_orient',
        'data modify storage gomoku:visual board set value "classic"',
        'data modify storage gomoku:visual palette set value "ebony"',
        'data modify storage gomoku:visual labels set value "coords"',
        'execute if score @s gm_coords matches 0 run data modify storage gomoku:visual labels set value "plain"',
    ]
    context += [f'execute if score @s gm_board matches {i} run data modify storage gomoku:visual board set value "{name}"' for i, name in enumerate(BOARDS)]
    context += [f'execute if score @s gm_palette matches {i} run data modify storage gomoku:visual palette set value "{name}"' for i, name in enumerate(PALETTES)]
    context += ['function gomoku:visual/layout with storage gomoku:visual']
    put('context', context)
    put('layout', ['$data modify storage gomoku:visual layout set value "s$(size)c$(cap)o$(orient)"'] +
        [f'$data modify storage gomoku:visual {key} set from storage gomoku:layout s$(size)c$(cap)o$(orient).geom.{key}' for key in
         ('step', 'scale', 'width', 'footprint', 'board_y', 'stone_y', 'frame_y', 'last_y', 'qy', 'qw')])
    put('coord', '''
$data modify storage gomoku:visual coord set from storage gomoku:layout $(layout).cells[$(sq)]
data modify storage gomoku:visual x set from storage gomoku:visual coord.x
data modify storage gomoku:visual z set from storage gomoku:visual coord.z
''')
    put('clear', '''
scoreboard players operation #vis_table gm_ctx = @s ct_id
execute as @e[tag=gm.visual] if score @s ct_id = #vis_table gm_ctx run kill @s
''')
    put('clear_board', '''
scoreboard players operation #vis_table gm_ctx = @s ct_id
execute as @e[tag=gm.visual,tag=!gm.clock] if score @s ct_id = #vis_table gm_ctx run kill @s
''')
    put('setup', 'function gomoku:visual/refresh')
    put('review', 'function gomoku:visual/refresh')
    put('refresh', '''
function gomoku:system/context
function gomoku:visual/clear_board
function gomoku:visual/context
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function gomoku:visual/board with storage gomoku:visual
execute positioned ~ ~1.025 ~ summon minecraft:interaction run function gomoku:visual/board_hitbox with storage gomoku:visual
execute as @e[type=minecraft:marker,tag=gm.board] run function gomoku:visual/cell
data modify storage gomoku:visual duration set value 0
execute as @e[type=minecraft:marker,tag=gm.board] unless score @s gm_piece matches 0 run function gomoku:visual/spawn_from_marker
function gomoku:visual/select
''')
    put('board', '''
tag @s add gm.visual
tag @s add gm.board_display
scoreboard players operation @s ct_id = #vis_table gm_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:gomoku/board/$(board)_$(size)_$(labels)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f,transformation:{translation:[0f,$(board_y)f,0f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(footprint)f,$(footprint)f,$(footprint)f]}}
''')
    put('cell', '''
execute store result storage gomoku:visual sq int 1 run scoreboard players get @s gm_sq
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/cell_at with storage gomoku:visual
''')
    put('cell_at', '$tp @s ~$(x) ~1.025 ~$(z)')
    put('board_hitbox', '''
tag @s add gm.visual
tag @s add gm.cell
tag @s add gm.tile
scoreboard players operation @s ct_id = #vis_table gm_ctx
$data merge entity @s {width:$(footprint)f,height:0.035f,response:1b}
''')
    put('spawn_from_marker', '''
execute store result storage gomoku:visual sq int 1 run scoreboard players get @s gm_sq
execute store result storage gomoku:visual side int 1 run scoreboard players get @s gm_piece
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/stone_name
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function gomoku:visual/stone_init with storage gomoku:visual
''')
    put('stone_name', '''
data modify storage gomoku:visual color set value "black"
execute if data storage gomoku:visual {side:-1} run data modify storage gomoku:visual color set value "white"
''')
    put('stone_init', '''
tag @s add gm.visual
tag @s add gm.man
scoreboard players operation @s ct_id = #vis_table gm_ctx
$scoreboard players set @s gm_sq $(sq)
$scoreboard players set @s gm_piece $(side)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:gomoku/stone/$(palette)_$(color)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function gomoku:visual/stone_pose with storage gomoku:visual
''')
    put('stone_pose', '$data merge entity @s {start_interpolation:0,interpolation_duration:$(duration),transformation:{translation:[$(x)f,$(stone_y)f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')
    put('place', '''
function gomoku:visual/context
data modify storage gomoku:visual sq set from entity @s data.gomoku.last.sq
data modify storage gomoku:visual side set from entity @s data.gomoku.last.side
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/stone_name
data modify storage gomoku:visual duration set value 0
data modify storage gomoku:visual stone_y set value 0.24
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function gomoku:visual/falling_init with storage gomoku:visual
function gomoku:visual/select
''')
    put('falling_init', '''
function gomoku:visual/stone_init with storage gomoku:visual
tag @s add gm.falling
data modify entity @s data.gomoku_visual.started set value 0b
''')
    put('tick', '''
function gomoku:visual/context
data modify storage gomoku:visual duration set value 5
execute as @e[tag=gm.falling] if score @s ct_id = #vis_table gm_ctx if data entity @s data.gomoku_visual{started:0b} run function gomoku:visual/fall
''')
    put('fall', '''
execute store result storage gomoku:visual sq int 1 run scoreboard players get @s gm_sq
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/stone_pose with storage gomoku:visual
data modify entity @s data.gomoku_visual.started set value 1b
''')
    put('finish_move', '''
function gomoku:visual/context
data modify storage gomoku:visual duration set value 0
execute as @e[tag=gm.falling] if score @s ct_id = #vis_table gm_ctx run function gomoku:visual/fall
execute as @e[tag=gm.falling] if score @s ct_id = #vis_table gm_ctx run tag @s remove gm.falling
execute as @e[tag=gm.retracting] if score @s ct_id = #vis_table gm_ctx run kill @s
function gomoku:visual/select
''')
    put('undo', '''
function gomoku:system/context
function gomoku:visual/context
execute as @e[tag=gm.man] if score @s ct_id = #vis_table gm_ctx run function gomoku:visual/undo_probe
function gomoku:visual/select
''')
    put('undo_probe', '''
execute store result storage gomoku:visual sq int 1 run scoreboard players get @s gm_sq
function gomoku:visual/undo_check with storage gomoku:visual
''')
    put('undo_check', '$execute if entity @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=$(sq),gm_piece=0},limit=1] run function gomoku:visual/retract')
    put('retract', '''
tag @s add gm.retracting
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/retract_pose with storage gomoku:visual
''')
    put('retract_pose', '$data merge entity @s {start_interpolation:0,interpolation_duration:4,transformation:{translation:[$(x)f,0.26f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[0.015f,0.015f,0.015f]}}')
    put('select', '''
function gomoku:visual/context
execute as @e[tag=gm.highlight] if score @s ct_id = #vis_table gm_ctx run kill @s
execute if score @s gm_sel matches 0..360 run function gomoku:visual/selection
execute if score @s gm_mark matches 1 if data entity @s data.gomoku.last.sq run function gomoku:visual/last
data modify storage gomoku:visual winning set value []
data modify storage gomoku:visual winning set from entity @s data.gomoku.win
execute if data storage gomoku:visual winning[0] run function gomoku:visual/win_loop
''')
    put('selection', '''
execute store result storage gomoku:visual sq int 1 run scoreboard players get @s gm_sel
data modify storage gomoku:visual mark set value "selection"
function gomoku:visual/mark
''')
    put('last', '''
data modify storage gomoku:visual sq set from entity @s data.gomoku.last.sq
data modify storage gomoku:visual mark set value "last"
function gomoku:visual/mark
''')
    put('win_loop', '''
data modify storage gomoku:visual sq set from storage gomoku:visual winning[0]
data remove storage gomoku:visual winning[0]
data modify storage gomoku:visual mark set value "winning"
function gomoku:visual/mark
execute if data storage gomoku:visual winning[0] run function gomoku:visual/win_loop
''')
    put('mark', '''
function gomoku:visual/coord with storage gomoku:visual
data modify storage gomoku:visual mark_scale set from storage gomoku:visual step
data modify storage gomoku:visual mark_y set from storage gomoku:visual frame_y
execute if data storage gomoku:visual {mark:"last"} run data modify storage gomoku:visual mark_y set from storage gomoku:visual last_y
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function gomoku:visual/mark_init with storage gomoku:visual
''')
    # Last mark uses a small cross embedded in a full-cell model, so a common step scale keeps it visible.
    put('mark_init', '''
tag @s add gm.visual
tag @s add gm.highlight
scoreboard players operation @s ct_id = #vis_table gm_ctx
$scoreboard players set @s gm_sq $(sq)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:gomoku/$(mark)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f,transformation:{translation:[$(x)f,$(mark_y)f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[$(mark_scale)f,$(mark_scale)f,$(mark_scale)f]}}
execute if data storage gomoku:visual {mark:"winning"} run data merge entity @s {Glowing:1b,glow_color_override:5430679}
''')


if __name__ == '__main__':
    obsolete=('green','blue','purple','walnut','ice','jade')
    for base in (CARD/'models/item/gomoku',CARD/'items/gomoku',CARD/'textures/item/gomoku',RP/'.source/gomoku/models'):
        if base.exists():
            for path in base.rglob('*'):
                if path.is_file() and path.stem.startswith(obsolete):
                    assert path.resolve().is_relative_to(RP.resolve())
                    path.unlink()
    resources()
    functions()
    print('Generated Gomoku boards, stones, Blockbench sources and visual functions.')
