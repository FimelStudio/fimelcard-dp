"""生成 UNO 桌面展示函数；复用原卡片几何，正面朝上，按实际座号放置。"""
from pathlib import Path
import math

ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / 'data/uno/function/visual'


def write(name, text):
    path = DEST / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text.strip() + '\n', encoding='utf-8')


def main():
    # 后台牌型保留整数编号，资源路径使用可读的颜色/牌面命名。
    names = [color + rank for color in 'rygb' for rank in [str(n) for n in range(10)] + ['skip', 'reverse', 'plus2']] + ['wild', 'wild_plus4']
    write('resolve_model', '\n'.join(f'execute if score #card un_ctx matches {index} run data modify storage uno:visual model set value "{name}"' for index, name in enumerate(names)))
    write('clear', '''
scoreboard players operation #vis_table un_ctx = @s ct_id
execute as @e[tag=un.visual] if score @s ct_id = #vis_table un_ctx run kill @s
''')
    write('clear_cards', '''
# 局间只清牌面和文字；同一个牌盒从发牌到整场结束一直留在桌心。
scoreboard players operation #vis_table un_ctx = @s ct_id
execute as @e[tag=un.visual,tag=!un.box] if score @s ct_id = #vis_table un_ctx run kill @s
''')
    write('ensure_box', '''
# 同桌唯一常驻牌盒；旧版本盒原位迁至桌心，重载不换实体或重置牌局。
scoreboard players operation #vis_table un_ctx = @s ct_id
scoreboard players set #vis_boxes un_ctx 0
execute as @e[type=minecraft:item_display,tag=un.box] if score @s ct_id = #vis_table un_ctx run scoreboard players add #vis_boxes un_ctx 1
execute if score #vis_boxes un_ctx matches 0 positioned ~ ~1.095 ~ summon minecraft:item_display run function uno:visual/box
execute as @e[type=minecraft:item_display,tag=un.box] if score @s ct_id = #vis_table un_ctx run tp @s ~ ~1.095 ~
execute as @e[type=minecraft:item_display,tag=un.box] if score @s ct_id = #vis_table un_ctx run function uno:visual/box
''')
    write('repair_face', '''
# 旧版已落桌的牌原位翻面；保留实体、牌型、座位、发光、平移XZ和座位朝向。
execute unless entity @s[type=minecraft:item_display,tag=un.face] run return 0
data modify entity @s transformation.right_rotation set value [0f,1f,0f,0f]
data modify entity @s transformation.translation[1] set value 0.040625f
tag @s add un.face_up_v2
''')
    write('repair_faces', '''
# /reload时以控制器为执行者，只迁移本桌尚未翻面的旧展示牌。
scoreboard players operation #vis_table un_ctx = @s ct_id
execute as @e[type=minecraft:item_display,tag=un.face,tag=!un.face_up_v2] if score @s ct_id = #vis_table un_ctx run function uno:visual/repair_face
''')
    write('setup', '''
# 只清本桌牌面和文字，不移除整局常驻牌盒、其他游戏或家具。
function uno:visual/clear_cards
function uno:visual/ensure_box
scoreboard players set #seat un_ctx 0
function uno:visual/play
''')
    write('box', '''
tag @s add un.visual
tag @s add un.box
scoreboard players operation @s ct_id = #vis_table un_ctx
# 原盒中心(.1875,0,.0625)经X+90度及0.65缩放后补偿，底面高于桌面。
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:uno/box"}},item_display:"none",transformation:{translation:[-0.121875f,0.040625f,0f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],scale:[0.65f,0.65f,0.65f]},brightness:{block:15,sky:15},view_range:24f,shadow_radius:0f}
''')
    lines = ['# 调用者为桌心控制器；#card是0..53牌型，#seat为真实座号。',
             'scoreboard players operation #vis_table un_ctx = @s ct_id',
             'scoreboard players operation #vis_seat un_ctx = #seat un_ctx',
             'function uno:visual/resolve_model',
             'execute store result storage uno:visual seat int 1 run scoreboard players get #vis_seat un_ctx',
             'execute as @e[type=minecraft:item_display,tag=un.face] if score @s ct_id = #vis_table un_ctx run data merge entity @s {Glowing:0b}',
             'execute as @e[type=minecraft:item_display,tag=un.face] if score @s ct_id = #vis_table un_ctx if score @s un_seat = #vis_seat un_ctx run kill @s',
             '# 第一张真人出牌替换起始数字牌展示；其他座位保留最近一张。',
             'execute unless score #vis_seat un_ctx matches 0 as @e[type=minecraft:item_display,tag=un.face,scores={un_seat=0}] if score @s ct_id = #vis_table un_ctx run kill @s',
             'execute if score #vis_seat un_ctx matches 0 positioned ~0.60 ~1.04 ~0.18 summon minecraft:item_display run function uno:visual/seat0 with storage uno:visual']
    pos4 = [(0, -.94, 0), (.94, 0, -90), (0, .94, 180), (-.94, 0, 90)]
    pos8 = [(-.85, -1.42, 0), (.85, -1.42, 0), (1.42, -.85, -90), (1.42, .85, -90), (.85, 1.42, 180), (-.85, 1.42, 180), (-1.42, .85, 90), (-1.42, -.85, 90)]
    for capacity, positions in [(4, pos4), (8, pos8)]:
        for seat, (x, z, yaw) in enumerate(positions, 1):
            lines.append(f'execute if score @s ct_capacity matches {capacity} if score #vis_seat un_ctx matches {seat} positioned ~{x} ~1.04 ~{z} summon minecraft:item_display run function uno:visual/seat{seat}_{capacity} with storage uno:visual')
    lines += ['function uno:visual/status']
    write('play', '\n'.join(lines))
    configs = [('seat0', 0, 0)] + [(f'seat{s}_{cap}', s, yaw) for cap, positions in [(4,pos4),(8,pos8)] for s, (_,_,yaw) in enumerate(positions,1)]
    for name, seat, yaw in configs:
        angle = math.radians(yaw / 2)
        q = [math.sqrt(.5)*math.cos(angle), math.sqrt(.5)*math.sin(angle), -math.sqrt(.5)*math.sin(angle), math.sqrt(.5)*math.cos(angle)]
        a = math.radians(yaw)
        # ItemDisplayRenderer 在 NBT 变换之后还会对模型施加 Y+180°：
        # 实际乘法为 left_rotation * right_rotation * renderer_Y180，
        # 按列向量从最右侧开始作用，因此模型先经过 renderer_Y180。
        # 仅对桌面牌补 right_rotation=Y180，抵消固有旋转；保留原来的
        # seatYaw*X90，使正面 north 朝 +Y，文字顶端仍按座位方向朝向桌心。
        # 模型中心为(-1/16,1/16,1/32)，中心补偿后底面保持实体位置的Y。
        shift = [.040625*(math.cos(a)-math.sin(a)), .040625, -.040625*(math.sin(a)+math.cos(a))]
        floats = lambda v: '[' + ','.join(f'{n:.7f}f' for n in v) + ']'
        write(name, '\n'.join([
            'tag @s add un.visual', 'tag @s add un.face', 'tag @s add un.face_up_v2',
            'scoreboard players operation @s ct_id = #vis_table un_ctx',
            f'scoreboard players set @s un_seat {seat}',
            '# 仅桌面牌：right_Y180抵消客户端固有Y180；seatYaw*X90把north正面朝+Y。',
            '$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:uno/$(model)"}},item_display:"none",transformation:{translation:'+floats(shift)+',left_rotation:'+floats(q)+',right_rotation:[0f,1f,0f,0f],scale:[0.65f,0.65f,0.65f]},Glowing:1b,glow_color_override:16766720,brightness:{block:15,sky:15},view_range:24f,shadow_radius:0f}'
        ]))
    write('status', '''
# 兼容出牌展示入口；公开列表独立于手牌Dialog，可由批量摸牌/计分后刷新。
function uno:visual/update_status
''')
    write('update_status', '\n'.join(['''
# 控制器在自身位置执行；仅事件触发，原位更新同一个文字实体。
scoreboard players operation #vis_table un_ctx = @s ct_id
scoreboard players set #vis_turn un_ctx 0
execute if score @s un_turn matches 1..8 run scoreboard players operation #vis_turn un_ctx = @s un_turn
data modify storage uno:visual roster set value {text:"",extra:[{text:"UNO",color:"gold",bold:true}]}
'''.strip(),
        *[f'function uno:visual/status_seat {{seat:{seat}}}' for seat in range(1, 9)],
        '''
scoreboard players set #vis_status un_ctx 0
execute as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run scoreboard players add #vis_status un_ctx 1
# 兼容旧存档残留的重复标签；正常刷新不删除或重新召唤文字。
execute if score #vis_status un_ctx matches 2.. as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run kill @s
execute if score #vis_status un_ctx matches 2.. run scoreboard players set #vis_status un_ctx 0
execute if score #vis_status un_ctx matches 0 positioned ~ ~1.90 ~ summon minecraft:text_display run function uno:visual/status_entity
execute as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run tp @s ~ ~1.90 ~
execute as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run function uno:visual/status_entity
'''.strip()]))
    write('status_seat', '''
# 座号升序；双表号核验，不使用距离或其他桌残留的临时audience标签。
$execute as @e[tag=un.player,tag=ct.player,scores={un_seat=$(seat)}] if score @s un_table = #vis_table un_ctx if score @s ct_id = #vis_table un_ctx at @s run function uno:visual/status_player
''')
    write('status_player', '''
# 固化真实玩家名，避免把选择器原文发送到任何展示组件。
function uno:name/resolve
data modify storage uno:visual status_name set value {text:"",color:"white",extra:[]}
data modify storage uno:visual status_name.extra append from storage uno:name resolved
execute store result storage uno:visual status_seat int 1 run scoreboard players get @s un_seat
execute store result storage uno:visual status_count int 1 run scoreboard players get @s un_count
execute store result storage uno:visual status_score int 1 run scoreboard players get @s un_score
data modify storage uno:visual status_turn set value ""
execute if score @s un_seat = #vis_turn un_ctx run data modify storage uno:visual status_turn set value " ▶"
function uno:visual/status_append with storage uno:visual
''')
    write('status_append', '''
$data modify storage uno:visual roster.extra append value {text:"",extra:[{text:"\\n$(status_seat)号位 ",color:"gray"},$(status_name),{text:" · $(status_count)张 · $(status_score)分",color:"gray"},{text:"$(status_turn)",color:"gold"}]}
''')
    write('status_entity', '''
tag @s add un.visual
tag @s add un.status
scoreboard players operation @s ct_id = #vis_table un_ctx
data modify entity @s text set from storage uno:visual roster
data merge entity @s {billboard:"center",line_width:300,background:0,shadow:1b,view_range:24f,transformation:{scale:[0.48f,0.48f,0.48f]},brightness:{block:15,sky:15}}
''')


if __name__ == '__main__':
    main()
