"""璀璨宝石／卡坦岛终局资产展示。只读权威终局数据，复用现有字体和表现清理。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]


def normalize_results(game, name, text):
    if game in ('splendor', 'catan') and name in ('game/win', 'visual/refresh'):
        call = f'function {game}:result/show'
        if call not in text: text = text.rstrip() + '\n# terminal-review: 仅终局显示，保留至新局／拆桌。\n' + call + '\n'
    return text


def build(games=('splendor', 'catan')):
    from build_table_pause_guards import write_guarded
    for game, prefix, phase, title in [('splendor','sp',4,'璀璨宝石 · 终局收藏'),('catan','ca',11,'卡坦岛 · 终局战绩')]:
        if game not in games: continue
        ctx = prefix + '_ctx'
        store = game + ':result'
        root = PACK / 'data' / game / 'function'
        def put(name, body):
            path = root / (name + '.mcfunction')
            path.parent.mkdir(parents=True, exist_ok=True)
            write_guarded(path, body.strip() + '\n', encoding='utf-8')
        put('result/show', f'''
scoreboard players operation #result_table {ctx} = @s ct_id
execute as @e[type=minecraft:text_display,tag={prefix}.result] if score @s ct_id = #result_table {ctx} run kill @s
execute unless score @s ct_game matches {22 if game == 'splendor' else 21} run return 0
execute unless data entity @s data.{game}{{phase:{phase}}} run return 0
scoreboard players set #result_y {ctx} 180
execute store result score #result_n {ctx} run data get entity @s data.{game}.n
''' + '\n'.join(f'execute if score #result_n {ctx} matches {side}..4 run function {game}:result/player {{side:{side}}}' for side in (4,3,2,1)) + f'''
data modify storage {store} line set value {{text:"{title}",color:"gold",bold:true}}
function {game}:result/emit
''')
        put('result/emit', f'''
execute store result storage {store} y double 0.01 run scoreboard players get #result_y {ctx}
function {game}:result/spawn with storage {store}
scoreboard players add #result_y {ctx} 25
''')
        put('result/spawn', f'$execute positioned ~ ~$(y) ~ summon minecraft:text_display run function {game}:result/init with storage {store}')
        put('result/init', f'''
tag @s add {prefix}.visual
tag @s add {prefix}.result
scoreboard players operation @s ct_id = #result_table {ctx}
scoreboard players operation @s {prefix}_table = #result_table {ctx}
$data merge entity @s {{text:$(line),billboard:"vertical",alignment:"center",line_width:600,background:1073741824,shadow:1b,see_through:0b,view_range:24f,brightness:{{block:15,sky:15}},transformation:{{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],scale:[0.22f,0.22f,0.22f],right_rotation:[0f,0f,0f,1f]}}}}
''')
        common = f'''
$data modify storage {store} p set from entity @s data.{game}.p$(side)
$data modify storage {store} p.side set value $(side)
data modify storage {store} p.mark set value ""
$execute unless data storage {store} p.name run data modify storage {store} p.name set value {{text:"玩家$(side)",color:"white"}}
data modify storage {store} p.name.color set value "white"
'''
        if game == 'splendor':
            put('result/player', common + f'''
$execute if data entity @s data.splendor{{winners:[$(side)]}} run data modify storage {store} p.mark set value " ★ 胜者"
execute store result storage {store} p.cards_count int 1 run data get storage {store} p.cards
execute store result storage {store} p.noble_count int 1 run data get storage {store} p.nobles
data modify storage {store} line set value {{text:"贵族卡： ",color:"aqua",extra:[]}}
data modify storage {store} queue set from storage {store} p.nobles
execute unless data storage {store} queue[0] run data modify storage {store} line.extra append value {{text:"无",color:"gray"}}
execute if data storage {store} queue[0] run function splendor:result/nobles
function splendor:result/emit
data modify storage {store} line set value {{text:"发展卡： ",color:"aqua",extra:[]}}
data modify storage {store} queue set from storage {store} p.cards
scoreboard players set #result_col {ctx} 0
execute unless data storage {store} queue[0] run data modify storage {store} line.extra append value {{text:"无",color:"gray"}}
execute if data storage {store} queue[0] run function splendor:result/cards
execute if score #result_col {ctx} matches 1.. run function splendor:result/emit
execute if score #result_col {ctx} matches 0 unless data storage {store} p.cards[0] run function splendor:result/emit
function splendor:result/header with storage {store} p
scoreboard players add #result_y {ctx} 12
''')
            put('result/header', f'''$data modify storage {store} line set value {{text:"",extra:[{{text:"$(side)号　",color:"gray"}},$(name),{{text:" · $(vp)分 · 发展卡$(cards_count)张／贵族$(noble_count)张",color:"yellow"}},{{text:"$(mark)",color:"gold"}}]}}
function splendor:result/emit''')
            for kind, count, base in [('cards',90,0xE900),('nobles',10,0xEA00)]:
                col = 'scoreboard players add #result_col sp_ctx 1\n' if kind == 'cards' else ''
                flush = f'''execute if score #result_col sp_ctx matches 16 run function splendor:result/emit
execute if score #result_col sp_ctx matches 16 run data modify storage {store} line set value {{text:"发展卡（续）： ",color:"aqua",extra:[]}}
execute if score #result_col sp_ctx matches 16 run scoreboard players set #result_col sp_ctx 0
''' if kind == 'cards' else ''
                put('result/'+kind, f'''execute store result score #result_card sp_ctx run data get storage {store} queue[0]
data remove storage {store} queue[0]
data modify storage {store} glyph set value {{text:"?",color:"red"}}
function splendor:result/glyph_{kind}
data modify storage {store} line.extra append from storage {store} glyph
data modify storage {store} line.extra append value {{text:" ",font:"minecraft:default"}}
{col}{flush}execute if data storage {store} queue[0] run function splendor:result/{kind}''')
                put('result/glyph_'+kind, '\n'.join(f'execute if score #result_card sp_ctx matches {i} run data modify storage {store} glyph set value '+json.dumps({'text':chr(base+i),'font':'card:splendor/small','color':'white','shadow_color':0},ensure_ascii=False,separators=(',',':')) for i in range(count)))
        else:
            body = common + f'''
$execute if data entity @s data.catan{{winner:$(side)}} run data modify storage {store} p.mark set value " ★ 胜者"
scoreboard players set #result_longest ca_ctx 0
scoreboard players set #result_army ca_ctx 0
$execute if data entity @s data.catan{{longest:$(side)}} run scoreboard players set #result_longest ca_ctx 2
$execute if data entity @s data.catan{{army:$(side)}} run scoreboard players set #result_army ca_ctx 2
'''
            for key, initial, field in [('settlements',5,'settlements_left'),('cities',4,'cities_left'),('roads',15,'roads_left')]:
                body += f'''scoreboard players set #result_count ca_ctx {initial}
execute store result score #result_left ca_ctx run data get storage {store} p.{field}
scoreboard players operation #result_count ca_ctx -= #result_left ca_ctx
execute store result storage {store} p.{key} int 1 run scoreboard players get #result_count ca_ctx
'''
            body += f'''execute store result score #result_hidden ca_ctx run data get storage {store} p.vp
execute store result score #result_public ca_ctx run data get storage {store} p.public_vp
scoreboard players operation #result_hidden ca_ctx -= #result_public ca_ctx
execute store result storage {store} p.hidden int 1 run scoreboard players get #result_hidden ca_ctx
execute store result storage {store} p.longest_points int 1 run scoreboard players get #result_longest ca_ctx
execute store result storage {store} p.army_points int 1 run scoreboard players get #result_army ca_ctx
'''
            for i in range(5):
                body += f'''execute store result score #result_dev ca_ctx run data get storage {store} p.dev[{i}]
execute store result score #result_fresh ca_ctx run data get storage {store} p.fresh[{i}]
scoreboard players operation #result_dev ca_ctx += #result_fresh ca_ctx
execute store result storage {store} p.d{i} int 1 run scoreboard players get #result_dev ca_ctx
'''
            body += f'function catan:result/details with storage {store} p\nscoreboard players add #result_y ca_ctx 12\n'
            put('result/player',body)
            lines = [
                '{text:"发展卡：骑士$(d0)／修路$(d1)／丰收$(d2)／垄断$(d3)／胜利点$(d4)",color:"aqua"}',
                '{text:"道路$(roads) · 当前最长$(road_length)（奖分$(longest_points)） · 已用骑士$(knights)（军团奖分$(army_points)）",color:"gray"}',
                '{text:"村庄$(settlements)／城市$(cities) · 公开$(public_vp)分＋隐藏胜利点$(hidden)分 · 剩余资源$(resource_count)张",color:"gray"}',
                '{text:"",extra:[{text:"$(side)号　",color:"gray"},$(name),{text:" · $(vp)分",color:"yellow"},{text:"$(mark)",color:"gold"}]}',
            ]
            put('result/details','\n'.join(f'$data modify storage {store} line set value {line}\nfunction catan:result/emit' for line in lines))
        for name in ('game/win','visual/refresh'):
            path = root/(name+'.mcfunction')
            write_guarded(path,normalize_results(game,name,path.read_text(encoding='utf-8')),encoding='utf-8')


if __name__ == '__main__': build()
