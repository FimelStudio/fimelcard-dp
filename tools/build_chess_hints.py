"""生成选中棋子的合法目标提示，只读规则缓存。"""
from pathlib import Path


def build(root: Path):
    target = root / 'data/chess/function/hints'
    target.mkdir(parents=True, exist_ok=True)

    def put(name, lines):
        (target / (name + '.mcfunction')).write_text(
            ('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')

    put('clear', '''
scoreboard players operation #hint_table ch_ctx = @s ct_id
execute as @e[tag=ch.hint] if score @s ct_id = #hint_table ch_ctx run kill @s
''')
    put('refresh', '''
# 单次同步只读探测，不提交走法，也不改写真实棋格。
function chess:hints/clear
execute unless score @s ch_hints matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute unless score @s ch_sel matches 0..63 run return 0
execute if score @s ch_bot = @s ch_turn run return 0
function chess:hints/query
''')
    saved = ('from', 'to', 'promo', 'target', 'chosen', 'legal', 'piece', 'side')
    query = []
    for name in saved:
        query += [f'scoreboard players set #hint_saved_{name} ch_ctx 0',
                  f'scoreboard players operation #hint_saved_{name} ch_ctx = #{name} ch_ctx']
    query += ['function chess:system/context', 'function chess:visual/context',
              'function chess:engine/cache',
              'scoreboard players operation #hint_from ch_ctx = @s ch_sel',
              'scoreboard players set #promo ch_ctx 5',
              'execute if score #cache_ok ch_ctx matches 1 run function chess:hints/destinations']
    query += [f'scoreboard players operation #{name} ch_ctx = #hint_saved_{name} ch_ctx' for name in saved]
    put('query', query)
    destinations = []
    for square in range(64):
        destinations += ['scoreboard players operation #from ch_ctx = #hint_from ch_ctx',
                         f'scoreboard players set #to ch_ctx {square}',
                         'function chess:engine/check_move',
                         f'execute if score #legal ch_ctx matches 1 run scoreboard players set #vis_sq ch_ctx {square}',
                         'execute if score #legal ch_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function chess:hints/display']
    put('destinations', destinations)
    put('display', '''
tag @s add ch.visual
tag @s add ch.hint
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:chess/hint"}},item_display:"none",brightness:{block:15,sky:15},Glowing:1b,glow_color_override:5635925,shadow_radius:0f,view_range:24f}
function chess:visual/resolve_square
data modify storage chess:visual x set from storage chess:visual coord.x
data modify storage chess:visual z set from storage chess:visual coord.z
execute if score #vis_cap ch_ctx matches 4 run data modify storage chess:visual scale set value 0.27
execute if score #vis_cap ch_ctx matches 4 run data modify storage chess:visual lift set value 0.135
execute if score #vis_cap ch_ctx matches 8 run data modify storage chess:visual scale set value 0.37
execute if score #vis_cap ch_ctx matches 8 run data modify storage chess:visual lift set value 0.185
function chess:hints/pose with storage chess:visual
''')
    put('pose', '$data merge entity @s {transformation:{translation:[$(x)f,$(lift)f,$(z)f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')


if __name__ == '__main__':
    build(Path(__file__).resolve().parents[1])
