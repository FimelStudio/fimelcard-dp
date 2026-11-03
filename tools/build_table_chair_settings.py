"""公共椅子数量菜单：大厅即时调整，独立会话校验，不占用各游戏设置编码。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/cardtable/function/chairs/settings'
MINIMUM = {1: 4, 2: 2, 3: 2, 4: 2, 5: 3, 6: 3, 7: 3, 8: 2, 9: 2,
           10: 1, 11: 2, 12: 1, 13: 1, 14: 1, 15: 1, 16: 5, 17: 2,
           18: 1, 19: 2, 20: 1, 21: 3, 22: 2, 23: 2}
OBJECTIVES = {name: 'dummy' for name in ('ct_ch_epoch ct_ch_nonce ct_ch_load ct_ch_table '
              'ct_ch_game ct_ch_seen ct_ch_seat').split()}
OBJECTIVES['ct_chair_pick'] = 'trigger'


def build():
    def put(name, body):
        path = ROOT / (name + '.mcfunction')
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes((body.strip() + '\n').encode('utf-8'))

    put('load', '\n'.join([f'scoreboard objectives add {name} {kind}' for name, kind in OBJECTIVES.items()]) + '''
scoreboard players add #chair_load ct_ctx 1
execute unless score #chair_serial ct_ctx matches 1..99999999 run scoreboard players set #chair_serial ct_ctx 1
scoreboard players set #chair_ten ct_ctx 10
scoreboard players reset * ct_chair_pick
scoreboard players reset * ct_ch_nonce
function cardtable:chairs/layout/load
''')
    put('minimum', 'scoreboard players set #chair_min ct_ctx 1\n' + '\n'.join(
        f'execute if score @s ct_game matches {game} run scoreboard players set #chair_min ct_ctx {count}'
        for game, count in MINIMUM.items()) + '''
# 飞行棋关闭电脑补位时须给至少两名真人留座。
execute if score @s ct_game matches 15 if score @s ac_fill matches 2 run scoreboard players set #chair_min ct_ctx 2
''')
    put('clear_session', '\n'.join(f'scoreboard players reset @s {objective}' for objective in OBJECTIVES))
    put('handle', '''
scoreboard players operation #chair_input ct_ctx = @s ct_chair_pick
scoreboard players reset @s ct_chair_pick
execute unless entity @s[tag=ct.player] run return 0
scoreboard players operation #chair_table ct_ctx = @s ct_id
tag @e[tag=ct.chair_controller] remove ct.chair_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #chair_table ct_ctx run tag @s add ct.chair_controller
execute unless entity @e[tag=ct.chair_controller,limit=1] run return run function cardtable:chairs/settings/invalid
# 1只打开当前桌的实时菜单，不提交状态；真正的变更使用下面的一次性编码。
execute if score #chair_input ct_ctx matches 1 run return run function cardtable:chairs/settings/open_actor
execute unless score #chair_input ct_ctx matches 10..999999998 run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_load = #chair_load ct_ctx run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_table = @s ct_id run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_seat = @s ct_seat run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_game = @e[tag=ct.chair_controller,limit=1] ct_game run return run function cardtable:chairs/settings/invalid
execute unless score @s ct_ch_seen = @e[tag=ct.chair_controller,limit=1] ct_ch_epoch run return run function cardtable:chairs/settings/invalid
scoreboard players operation #chair_nonce ct_ctx = #chair_input ct_ctx
scoreboard players operation #chair_nonce ct_ctx /= #chair_ten ct_ctx
execute unless score #chair_nonce ct_ctx = @s ct_ch_nonce run return run function cardtable:chairs/settings/invalid
scoreboard players operation #chair_choice ct_ctx = #chair_input ct_ctx
scoreboard players operation #chair_choice ct_ctx %= #chair_ten ct_ctx
scoreboard players reset @s ct_ch_nonce
execute if score #chair_choice ct_ctx matches 0 run return run function cardtable:chairs/settings/back
execute unless score #chair_choice ct_ctx matches 1..8 run return run function cardtable:chairs/settings/invalid
tag @s add ct.chair_actor
execute as @e[tag=ct.chair_controller,limit=1] at @s run function cardtable:chairs/settings/apply
tag @s remove ct.chair_actor
tag @e[tag=ct.chair_controller] remove ct.chair_controller
''')
    put('invalid', '''
tellraw @s {text:"[牌桌] 椅子设置已过期，请重新打开游戏设置。",color:"yellow"}
function cardtable:chairs/settings/clear_session
tag @e[tag=ct.chair_controller] remove ct.chair_controller
''')
    put('open_actor', '''
tag @s add ct.chair_actor
execute as @e[tag=ct.chair_controller,limit=1] at @s run function cardtable:chairs/settings/open
tag @s remove ct.chair_actor
tag @e[tag=ct.chair_controller] remove ct.chair_controller
''')
    put('open', '''
execute unless score @s ct_state matches 0 run return 0
function cardtable:chairs/settings/minimum
function cardtable:chairs/layout/ensure
scoreboard players add #chair_serial ct_ctx 1
execute if score #chair_serial ct_ctx matches 100000000.. run scoreboard players add #chair_load ct_ctx 1
execute if score #chair_serial ct_ctx matches 100000000.. run scoreboard players set #chair_serial ct_ctx 1
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_nonce = #chair_serial ct_ctx
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_load = #chair_load ct_ctx
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_table = @s ct_id
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_game = @s ct_game
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_seen = @s ct_ch_epoch
scoreboard players operation @a[tag=ct.chair_actor,limit=1] ct_ch_seat = @a[tag=ct.chair_actor,limit=1] ct_seat
scoreboard players set @a[tag=ct.chair_actor,limit=1] ct_chair_pick 0
scoreboard players enable @a[tag=ct.chair_actor,limit=1] ct_chair_pick
data modify storage cardtable:chairs row set value {text:"椅子数量：",color:"gray",extra:[]}
execute store result storage cardtable:chairs current int 1 run scoreboard players get @s ct_chairs
execute store result storage cardtable:chairs minimum int 1 run scoreboard players get #chair_min ct_ctx
scoreboard players operation #chair_base ct_ctx = #chair_serial ct_ctx
scoreboard players operation #chair_base ct_ctx *= #chair_ten ct_ctx
execute store result storage cardtable:chairs back int 1 run scoreboard players get #chair_base ct_ctx
''' + '\n'.join(f'execute if score #chair_min ct_ctx matches ..{count} if score @s ct_capacity matches {count}.. run function cardtable:chairs/settings/choice {{count:{count}}}' for count in range(1, 9)) + '''
function cardtable:chairs/settings/show with storage cardtable:chairs
''')
    put('choice', '''
$data modify storage cardtable:chairs option set value {text:" [$(count)] ",color:"aqua"}
$scoreboard players set #chair_code ct_ctx $(count)
scoreboard players operation #chair_code ct_ctx += #chair_base ct_ctx
execute store result storage cardtable:chairs code int 1 run scoreboard players get #chair_code ct_ctx
$execute if score @s ct_chairs matches $(count) run data modify storage cardtable:chairs option.color set value "gold"
$execute if score @s ct_chairs matches $(count) run data modify storage cardtable:chairs option.bold set value true
$execute unless score @s ct_chairs matches $(count) run function cardtable:chairs/settings/command with storage cardtable:chairs
data modify storage cardtable:chairs row.extra append from storage cardtable:chairs option
''')
    put('command', '$data modify storage cardtable:chairs option.click_event set value {action:"run_command",command:"trigger ct_chair_pick set $(code)"}')
    put('show', '$dialog show @a[tag=ct.chair_actor,limit=1] ' + json.dumps({
        'type': 'minecraft:notice', 'title': {'text': '牌桌 · 椅子数量', 'color': 'gold'},
        'body': [{'type': 'minecraft:plain_message', 'width': 440, 'contents': '__row__'},
                 {'type': 'minecraft:plain_message', 'width': 440,
                  'contents': {'text': '当前 $(current) 把，当前游戏至少 $(minimum) 把。仅大厅可调整；已坐人的椅子保留，八人桌同侧只剩一把时自动居中。', 'color': 'gray'}}],
        'action': {'label': {'text': '返回游戏设置'}, 'width': 180,
                   'action': {'type': 'minecraft:run_command', 'command': 'trigger ct_chair_pick set $(back)'}},
        'pause': False, 'after_action': 'none'}, ensure_ascii=False, separators=(',', ':')).replace('"__row__"', '$(row)'))
    put('apply', '''
function cardtable:chairs/settings/minimum
execute if score #chair_choice ct_ctx < #chair_min ct_ctx run return run function cardtable:chairs/settings/rejected
execute if score #chair_choice ct_ctx > @s ct_capacity run return run function cardtable:chairs/settings/rejected
scoreboard players set #chair_occupied ct_ctx 0
scoreboard players operation #chair_table ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #chair_table ct_ctx run scoreboard players add #chair_occupied ct_ctx 1
execute if score #chair_choice ct_ctx < #chair_occupied ct_ctx run return run function cardtable:chairs/settings/rejected
scoreboard players operation @s ct_chairs = #chair_choice ct_ctx
function cardtable:chairs/layout/apply
function cardtable:chairs/settings/open
''')
    put('rejected', '''
tellraw @a[tag=ct.chair_actor,limit=1] {text:"[牌桌] 椅子不能少于游戏最低人数或当前已入座人数。",color:"yellow"}
function cardtable:chairs/settings/open
''')
    put('back', '''
tag @a[tag=ct.settings_actor] remove ct.settings_actor
tag @s add ct.settings_actor
execute as @e[tag=ct.chair_controller,limit=1] at @s run function cardtable:skin/open
tag @s remove ct.settings_actor
tag @e[tag=ct.chair_controller] remove ct.chair_controller
''')


if __name__ == '__main__':
    build()
