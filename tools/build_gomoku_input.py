"""单交互实体的五子棋落点：仅在右键时二分求视线与棋盘平面的交点。

不读绝对坐标到整数，兼容世界边界附近，不需要逐刻射线或每格interaction。
gm.square只在服务端存在，visual/refresh把它们定位在实际交点。
"""
from boardgame_assets import PACK, text_file, json_file


def build():
    root = PACK/'data/gomoku/function/input'
    def put(name, body):
        text_file(root/(name+'.mcfunction'), body)
    put('cell', '''
scoreboard players operation #ui_click_table gm_ctx = @s ct_id
tag @a[tag=gm.actor] remove gm.actor
execute on target if entity @s[type=minecraft:player] run function gomoku:input/cell_player
data remove entity @s interaction
tag @a[tag=gm.actor] remove gm.actor
''')
    put('cell_player', '''
execute unless entity @s[tag=ct.player,tag=gm.player] run return 0
execute unless score @s ct_id = #ui_click_table gm_ctx run return 0
execute unless score @s gm_table = #ui_click_table gm_ctx run return 0
function gomoku:input/context
execute unless entity @s[tag=gm.actor] run return 0
execute unless entity @e[tag=gm.current,scores={gm_state=1},limit=1] run return 0
execute unless score @s gm_side = @e[tag=gm.current,limit=1] gm_turn run return 0
function gomoku:input/ray
execute if score #ray_ok gm_ctx matches 1 as @e[tag=gm.current,limit=1] at @s run function gomoku:game/click
''')
    put('ray', '''
# 同步调用内最多一个临时marker；完成后删除，不给客户端产生实体。
kill @e[type=minecraft:marker,tag=gm.ray]
scoreboard players set #ray_ok gm_ctx 0
execute at @s anchored eyes positioned ^ ^ ^ summon minecraft:marker run tag @s add gm.ray
scoreboard players set #ray_low gm_ctx 0
scoreboard players set #ray_high gm_ctx 32768
scoreboard players set #ray_mid gm_ctx 0
function gomoku:input/ray_probe
# 眼睛必须在棋盘上方，向下看时才允许落子。
execute if score #ray_below gm_ctx matches 1 run return run function gomoku:input/ray_clear
scoreboard players operation #ray_mid gm_ctx = #ray_high gm_ctx
function gomoku:input/ray_probe
execute unless score #ray_below gm_ctx matches 1 run return run function gomoku:input/ray_clear
scoreboard players set #ray_count gm_ctx 13
function gomoku:input/ray_bisect
scoreboard players operation #ray_mid gm_ctx = #ray_high gm_ctx
function gomoku:input/ray_probe
execute at @e[type=minecraft:marker,tag=gm.ray,limit=1] run function gomoku:input/ray_target
function gomoku:input/ray_clear
''')
    put('ray_probe', '''
execute store result storage gomoku:ray distance double 0.000244140625 run scoreboard players get #ray_mid gm_ctx
function gomoku:input/ray_position with storage gomoku:ray
scoreboard players set #ray_below gm_ctx 0
# dx/dy/dz选择器的正向边界额外包含一格，所以顶面为1.025。
execute at @e[tag=gm.current,limit=1] positioned ~-8 ~-6.975 ~-8 if entity @e[type=minecraft:marker,tag=gm.ray,dx=15,dy=7,dz=15,limit=1] run scoreboard players set #ray_below gm_ctx 1
''')
    put('ray_position', '$execute at @s anchored eyes positioned ^ ^ ^$(distance) run tp @e[type=minecraft:marker,tag=gm.ray,limit=1] ~ ~ ~')
    put('ray_bisect', '''
scoreboard players operation #ray_mid gm_ctx = #ray_low gm_ctx
scoreboard players operation #ray_mid gm_ctx += #ray_high gm_ctx
scoreboard players set #ray_two gm_ctx 2
scoreboard players operation #ray_mid gm_ctx /= #ray_two gm_ctx
function gomoku:input/ray_probe
execute if score #ray_below gm_ctx matches 1 run scoreboard players operation #ray_high gm_ctx = #ray_mid gm_ctx
execute if score #ray_below gm_ctx matches 0 run scoreboard players operation #ray_low gm_ctx = #ray_mid gm_ctx
scoreboard players remove #ray_count gm_ctx 1
execute if score #ray_count gm_ctx matches 1.. run function gomoku:input/ray_bisect
''')
    put('ray_target', '''
# 本桌marker已定位到交点。最近交点即方格分区，无需扫描361个命中区。
# 这里只按本桌上下文查询，不能点到相邻牌桌。
scoreboard players set #target gm_ctx -1
execute if entity @e[type=minecraft:marker,tag=gm.board,distance=..0.26,limit=1] run scoreboard players operation #target gm_ctx = @e[type=minecraft:marker,tag=gm.board,sort=nearest,limit=1] gm_sq
execute if score #target gm_ctx matches 0..360 run scoreboard players set #ray_ok gm_ctx 1
''')
    put('ray_clear', 'kill @e[type=minecraft:marker,tag=gm.ray]')
    json_file(PACK/'data/gomoku/advancement/click_cell.json', {
        'criteria': {'click': {'trigger': 'minecraft:player_interacted_with_entity', 'conditions': {
            'entity': [{'condition': 'minecraft:entity_properties', 'entity': 'this',
                        'predicate': {'minecraft:entity_type': 'minecraft:interaction'}}]}}},
        'rewards': {'function': 'gomoku:input/click_dispatch'}})


if __name__ == '__main__':
    build()
