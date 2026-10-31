"""生成选中棋子的合法目标提示，只读规则缓存。"""
from pathlib import Path
from build_xiangqi_ai import candidates


def build(root: Path):
    target = root / 'data/xiangqi/function/hints'
    target.mkdir(parents=True, exist_ok=True)

    def put(name, lines):
        (target / (name + '.mcfunction')).write_text(
            ('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')

    put('clear', '''
scoreboard players operation #hint_table xq_ctx = @s ct_id
execute as @e[tag=xq.hint] if score @s ct_id = #hint_table xq_ctx run kill @s
''')
    put('refresh', '''
# 单次同步只读探测，不提交走法，也不改写真实棋格。
function xiangqi:hints/clear
execute unless score @s xq_hints matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute unless score @s xq_sel matches 0..89 run return 0
execute if score @s xq_bot = @s xq_turn run return 0
function xiangqi:hints/query
''')
    saved = ('from', 'to', 'promo', 'target', 'chosen', 'legal', 'piece', 'side')
    query = []
    for name in saved:
        query += [f'scoreboard players set #hint_saved_{name} xq_ctx 0',
                  f'scoreboard players operation #hint_saved_{name} xq_ctx = #{name} xq_ctx']
    query += ['function xiangqi:system/context', 'function xiangqi:visual/context',
              'function xiangqi:engine/cache',
              'scoreboard players operation #hint_from xq_ctx = @s xq_sel',
              'execute store result storage xiangqi:visual hint_from int 1 run scoreboard players get #hint_from xq_ctx',
              'execute if score #cache_ok xq_ctx matches 1 run function xiangqi:hints/source with storage xiangqi:visual',
              'execute if score #cache_ok xq_ctx matches 1 if score #hint_kind xq_ctx matches 1..7 run function xiangqi:hints/destinations']
    query += [f'scoreboard players operation #{name} xq_ctx = #hint_saved_{name} xq_ctx' for name in saved]
    put('query', query)
    put('source', '''
$scoreboard players operation #hint_kind xq_ctx = #b$(hint_from) xq_ctx
scoreboard players operation #hint_kind xq_ctx *= #side xq_ctx
''')
    # Candidate geometry is only a cheap superset. The exact rule probe still
    # verifies ownership, blockers, horse legs, river/palace and king safety.
    # A cannon/rook now requires at most 17 rule probes instead of all 90.
    destinations = []
    for source in range(90):
        destinations.append(f'execute if score #hint_from xq_ctx matches {source} run function xiangqi:hints/route/s{source}')
        routes=[]
        for kind in range(1,8):
            routes.append(f'execute if score #hint_kind xq_ctx matches {kind} run function xiangqi:hints/candidates/s{source}_k{kind}')
            lines=[]
            for square in candidates(source,kind):
                lines += ['scoreboard players operation #from xq_ctx = #hint_from xq_ctx',
                          f'scoreboard players set #to xq_ctx {square}',
                          'function xiangqi:engine/check_move',
                          f'execute if score #legal xq_ctx matches 1 run scoreboard players set #vis_sq xq_ctx {square}',
                          'execute if score #legal xq_ctx matches 1 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:hints/display']
            path=target/f'candidates/s{source}_k{kind}.mcfunction';path.parent.mkdir(parents=True,exist_ok=True);path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
        path=target/f'route/s{source}.mcfunction';path.parent.mkdir(parents=True,exist_ok=True);path.write_text('\n'.join(routes)+'\n',encoding='utf-8')
    put('destinations', destinations)
    put('display', '''
tag @s add xq.visual
tag @s add xq.hint
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:xiangqi/hint"}},item_display:"none",brightness:{block:15,sky:15},Glowing:1b,glow_color_override:5635925,shadow_radius:0f,view_range:24f}
function xiangqi:visual/resolve_square
data modify storage xiangqi:visual x set from storage xiangqi:visual coord.x
data modify storage xiangqi:visual z set from storage xiangqi:visual coord.z
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual scale set value 0.255
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual lift set value 0.1275
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual scale set value 0.35
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual lift set value 0.175
function xiangqi:hints/pose with storage xiangqi:visual
''')
    put('pose', '$data merge entity @s {transformation:{translation:[$(x)f,$(lift)f,$(z)f],scale:[$(scale)f,$(scale)f,$(scale)f]}}')


if __name__ == '__main__':
    build(Path(__file__).resolve().parents[1])
