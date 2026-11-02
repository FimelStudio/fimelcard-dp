"""璀璨宝石22：牌桌生命周期、玩家入口和规则结果到表现的桥接。"""
from pathlib import Path
import importlib.util
import json
from build_table_pause_guards import write_guarded

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/splendor/function'
OBJECTIVES = {n: 'dummy' for n in '''sp_ctx sp_state sp_epoch sp_turn sp_anim sp_finish
sp_table sp_seat sp_side sp_seen sp_nonce sp_ui_load sp_ui_table sp_panel sp_target
sp_first sp_music sp_pulse sp_settings sp_setnonce sp_setload sp_settable sp_setepoch
sp_setseat sp_setlayout sp_load sp_slot'''.split()}
OBJECTIVES.update({f'sp_pick{i}': 'dummy' for i in range(6)})
OBJECTIVES.update({'sp_action': 'trigger', 'sp_settings': 'trigger', 'sp_drop': 'minecraft.dropped:minecraft.paper'})


def put(name, body):
    p = ROOT / (name + '.mcfunction')
    p.parent.mkdir(parents=True, exist_ok=True)
    write_guarded(p, ('\n'.join(body) if isinstance(body, list) else body).strip() + '\n', encoding='utf-8')


def main():
    objectives = dict(OBJECTIVES)
    for name in ('sound', 'visual'):
        path = Path(__file__).with_name('build_splendor_' + name + '.py')
        if path.exists():
            spec = importlib.util.spec_from_file_location('_splendor_' + name, path)
            module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(module)
            extra = getattr(module, 'OBJECTIVES', {})
            objectives.update(extra if isinstance(extra, dict) else {n: 'dummy' for n in extra})
    put('system/install', [f'scoreboard objectives add {n} {kind}' for n, kind in sorted(objectives.items()) if n != 'sp_ctx'] + ['scoreboard players set #version sp_ctx 2'])
    put('system/migrate2', ['scoreboard objectives remove sp_settings', 'scoreboard objectives add sp_settings trigger', 'scoreboard players set #version sp_ctx 2'])
    put('load', '''
scoreboard objectives add sp_ctx dummy
execute unless score #version sp_ctx matches 1.. run function splendor:system/install
execute if score #version sp_ctx matches 1 run function splendor:system/migrate2
function splendor:engine/install
scoreboard players set #factor sp_ctx 10000
scoreboard players set #hundred sp_ctx 100
scoreboard players add #ui_load sp_ctx 1
scoreboard players reset * sp_action
scoreboard players reset * sp_nonce
function splendor:settings/load
function splendor:visual/load
function splendor:sound/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22}] at @s run function splendor:system/reload
''')
    put('system/context', '''
scoreboard players operation #table sp_ctx = @s ct_id
tag @e[tag=sp.current] remove sp.current
tag @a[tag=sp.audience] remove sp.audience
tag @s add sp.current
execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #table sp_ctx if score @s ct_id = #table sp_ctx run tag @s add sp.audience
''')
    put('game/init_table', ['tag @s add sp.controller', 'function splendor:settings/defaults', 'execute if score @s ct_state matches 0 run function splendor:game/preview'])
    put('game/preview', '''
execute unless score @s ct_game matches 22 run return 0
execute unless score @s ct_state matches 0 run return 0
function splendor:system/context
execute if data entity @s data.splendor{review:1b} run return run function splendor:visual/refresh
scoreboard players set #players sp_ctx 4
function splendor:engine/init
function splendor:game/sync
scoreboard players set @s sp_state 0
scoreboard players set @s sp_anim 0
function splendor:visual/preview
''')
    put('system/reload', '''
tag @s add sp.controller
function splendor:settings/defaults
execute if score @s ct_state matches 0 run return run function splendor:game/preview
function splendor:system/context
execute unless data entity @s data.splendor.p1 run return run function splendor:game/abort
data remove entity @s data.splendor.preview
scoreboard players set @s sp_anim 0
function splendor:game/sync
function splendor:visual/refresh
function splendor:sound/reload
execute as @a[tag=sp.audience] run function splendor:input/give
''')
    put('game/start', '''
function splendor:settings/defaults
function splendor:system/context
execute unless score @s ct_joined matches 2..4 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[璀璨宝石] 需要2～4名真人玩家。",color:"red"}
execute unless score @s ct_joined matches 2..4 run return fail
scoreboard players set #online sp_ctx 0
scoreboard players set #blocked sp_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx run scoreboard players add #online sp_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run scoreboard players set #blocked sp_ctx 1
execute unless score #online sp_ctx = @s ct_joined run return fail
execute if score #blocked sp_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[璀璨宝石] 请先腾空快捷栏最后一格。",color:"red"}
execute if score #blocked sp_ctx matches 1 run return fail
execute as @a[tag=sp.player] if score @s sp_table = #table sp_ctx run function splendor:player/clear_state
execute as @a[tag=ct.player] if score @s ct_id = #table sp_ctx run function splendor:player/init
function splendor:system/context
scoreboard players operation #players sp_ctx = @s ct_joined
function splendor:engine/init
scoreboard players operation #players sp_ctx = @s ct_joined
scoreboard players set @a[tag=sp.audience] sp_side 0
function splendor:game/assign
function splendor:settings/invalidate_table
scoreboard players set @s sp_finish 0
scoreboard players set @s sp_anim 0
function splendor:game/sync
function splendor:visual/refresh
execute as @a[tag=sp.audience] run function splendor:input/give
function splendor:sound/start
scoreboard players set @s ct_start 1
tellraw @a[tag=sp.audience] {text:"[璀璨宝石] 开始交易！快捷栏最后一格按Q打开宝石市场与预约牌。",color:"gold"}
function splendor:log {text:"璀璨宝石开始"}
''')
    assign = []
    for side in range(1, 5):
        assign += [f'execute if score #players sp_ctx matches {side}.. run scoreboard players set #side sp_ctx {side}',
                   f'execute if score #players sp_ctx matches {side}.. if score @s sp_first matches 1 as @a[tag=sp.audience,scores={{sp_side=0}},sort=random,limit=1] run function splendor:player/assign']
        for seat in range(1, 9):
            assign += [f'execute if score #players sp_ctx matches {side}.. if score @s sp_first matches 0 as @a[tag=sp.audience,scores={{sp_side=0,sp_seat={seat}}},limit=1] unless entity @a[tag=sp.audience,scores={{sp_side={side}}}] run function splendor:player/assign']
    put('game/assign', assign)
    put('player/init', '''
tag @s add sp.player
scoreboard players operation @s sp_table = @s ct_id
scoreboard players operation @s sp_seat = @s ct_seat
scoreboard players set @s sp_drop 0
scoreboard players reset @s sp_nonce
''')
    put('player/assign', '''
scoreboard players operation @s sp_side = #side sp_ctx
execute store result storage splendor:runtime side int 1 run scoreboard players get @s sp_side
execute store result storage splendor:runtime seat int 1 run scoreboard players get @s sp_seat
function splendor:name/capture
function splendor:player/store with storage splendor:runtime
''')
    put('player/store', '''
$data modify entity @e[tag=sp.current,limit=1] data.splendor.p$(side).name set from storage splendor:runtime name.value
$data modify entity @e[tag=sp.current,limit=1] data.splendor.p$(side).seat set value $(seat)
''')
    source = (PACK / 'data/weiqi/function/name/capture.mcfunction').read_text(encoding='utf-8')
    put('name/capture', source.replace('weiqi:', 'splendor:').replace('go.name_resolver', 'sp.name_resolver'))
    loot = PACK / 'data/splendor/loot_table/player_name.json'
    loot.parent.mkdir(parents=True, exist_ok=True)
    loot.write_text((PACK / 'data/weiqi/loot_table/player_name.json').read_text(encoding='utf-8'), encoding='utf-8')
    put('game/sync', [f'execute store result score @s sp_{score} run data get entity @s data.splendor.{field}' for score, field in [('state','phase'),('epoch','epoch'),('turn','turn')]])
    put('game/action', '''
execute if score @s ct_paused matches 1 run return 0
function splendor:system/context
execute unless entity @a[tag=sp.actor,tag=sp.audience,limit=1] run return 0
execute if score @s sp_anim matches 1.. run return 0
function splendor:engine/action
execute unless score #ok sp_ctx matches 1 run return run function splendor:game/illegal
function splendor:game/after_action
''')
    put('game/illegal', ['tellraw @a[tag=sp.actor] {text:"[璀璨宝石] 操作未完成：请检查库存、支付数量、当前回合和待完成事项。",color:"red"}', 'function splendor:sound/illegal', 'execute as @a[tag=sp.actor] run function splendor:ui/open'])
    put('game/after_action', '''
function splendor:game/sync
scoreboard players reset @a[tag=sp.audience] sp_nonce
execute as @a[tag=sp.audience] run dialog clear @s
function splendor:game/log_event with entity @s data.splendor.last
function splendor:visual/refresh
function splendor:visual/animate
scoreboard players set @s sp_anim 12
execute if data entity @s data.splendor.last{code:1} run function splendor:sound/take
execute if data entity @s data.splendor.last{code:2} run function splendor:sound/reserve
execute if data entity @s data.splendor.last{code:3} run function splendor:sound/buy
execute if data entity @s data.splendor.last{code:4} run function splendor:sound/return
execute if data entity @s data.splendor.last{code:5} run function splendor:sound/noble
scoreboard players set #visited sp_ctx -1
execute store result score #visited sp_ctx run data get entity @s data.splendor.last.noble
execute if score #visited sp_ctx matches 0..9 unless data entity @s data.splendor.last{code:5} run function splendor:sound/noble
execute if score @s sp_state matches 4 run function splendor:game/win
''')
    put('game/log_event', '''
$data modify storage splendor:runtime actor_name set from entity @s data.splendor.p$(actor).name
data modify storage splendor:runtime event_label set value "完成操作"
$execute if predicate {condition:"minecraft:value_check",value:$(code),range:1} run data modify storage splendor:runtime event_label set value "拿取宝石"
$execute if predicate {condition:"minecraft:value_check",value:$(code),range:2} run data modify storage splendor:runtime event_label set value "预约开发卡"
$execute if predicate {condition:"minecraft:value_check",value:$(code),range:3} run data modify storage splendor:runtime event_label set value "购买开发卡"
$execute if predicate {condition:"minecraft:value_check",value:$(code),range:4} run data modify storage splendor:runtime event_label set value "退回超限筹码"
$execute if predicate {condition:"minecraft:value_check",value:$(code),range:5} run data modify storage splendor:runtime event_label set value "获得贵族来访"
function splendor:game/log_show with storage splendor:runtime
''')
    put('game/log_show', '$tellraw @a[tag=sp.audience] [{text:"[璀璨宝石] ",color:"gold"},$(actor_name),{text:" · $(event_label)",color:"gray"}]')
    put('tick', '''
execute as @a[scores={sp_settings=1..}] at @s run function splendor:settings/save
execute as @a[scores={sp_action=1..}] at @s run function splendor:ui/handle
execute as @a[tag=sp.player,scores={sp_drop=1..}] at @s run function splendor:input/drop
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1}] at @s run function splendor:game/tick
execute as @a[tag=sp.player] unless entity @s[tag=ct.player] run function splendor:player/clear_state
''')
    put('game/tick', '''
execute if score @s ct_paused matches 1 run return 0
function splendor:system/context
function splendor:visual/tick
function splendor:sound/tick
scoreboard players add @s sp_pulse 1
execute if score @s sp_pulse matches 20.. run function splendor:game/hud
execute if score @s sp_finish matches 1.. run return run function splendor:game/finish_tick
execute if score @s sp_anim matches 1.. run scoreboard players remove @s sp_anim 1
execute if score @s sp_anim matches 1 run function splendor:game/after_animation
execute if score @s sp_pulse matches 0 as @a[tag=sp.audience] run function splendor:input/give
''')
    put('game/after_animation', ['scoreboard players set @s sp_anim 0', 'execute as @a[tag=sp.audience] if score @s sp_side = @e[tag=sp.current,limit=1] sp_turn if entity @e[tag=sp.current,scores={sp_state=2..3},limit=1] run function splendor:ui/open'])
    put('game/hud', ['scoreboard players set @s sp_pulse 0', 'function splendor:game/hud_show with entity @s data.splendor'])
    put('game/hud_show', '$title @a[tag=sp.audience] actionbar [{text:"璀璨宝石 · 第$(round)轮 · ",color:"gold"},{nbt:"data.splendor.p$(turn).name",entity:"@s",interpret:true},{text:" 行动 · Q打开市场",color:"yellow"}]')
    put('game/win', '''
execute if score @s sp_finish matches 1.. run return 0
scoreboard players set @s sp_finish 100
function splendor:sound/result
tellraw @a[tag=sp.audience] {text:"[璀璨宝石] 本轮结束，按声望优先、已购开发卡更少者优先结算：",color:"gold"}
'''+ '\n'.join(f'execute if data entity @s data.splendor{{winners:[{side}]}} run function splendor:game/announce {{side:{side}}}' for side in range(1,5)))
    put('game/announce', '''
$tellraw @a[tag=sp.audience] [{text:"获胜：",color:"gold"},{nbt:"data.splendor.p$(side).name",entity:"@s",interpret:true},{text:" · ",color:"gray"},{nbt:"data.splendor.p$(side).vp",entity:"@s"},{text:"分，",color:"gray"},{nbt:"data.splendor.p$(side).card_count",entity:"@s"},{text:"张开发卡",color:"gray"}]
$execute as @a[tag=sp.audience,scores={sp_side=$(side)}] at @s run function splendor:game/firework
''')
    put('game/firework', '''
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["sp.firework","sp.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=sp.firework.new] ct_id = #table sp_ctx
tag @e[type=minecraft:firework_rocket,tag=sp.firework.new] remove sp.firework.new
''')
    put('game/finish_tick', ['scoreboard players remove @s sp_finish 1', 'execute if score @s sp_finish matches 0 run function splendor:game/cleanup'])
    put('game/cleanup', '''
function splendor:system/context
function splendor:sound/stop
data modify entity @s data.splendor.review set value 1b
function splendor:visual/refresh
execute as @e[tag=sp.firework] if score @s ct_id = #table sp_ctx run kill @s
execute as @a[tag=sp.audience] run function splendor:player/clear_state
scoreboard players set @s sp_anim 0
scoreboard players set @s sp_finish 0
function splendor:settings/invalidate_table
function cardtable:game/return_lobby
''')
    put('game/abort', ['execute unless score @s ct_state matches 1 run return fail', 'function splendor:system/context', 'tellraw @a[tag=sp.audience] {text:"[璀璨宝石] 游戏已中止，返回大厅。",color:"yellow"}', 'function splendor:game/cleanup'])
    put('game/end_vote', 'function splendor:game/abort')
    put('game/player_left', 'function splendor:game/abort')
    put('game/remove', '''
function splendor:system/context
function splendor:sound/stop
function splendor:visual/clear
execute as @e[tag=sp.firework] if score @s ct_id = #table sp_ctx run kill @s
execute as @a[tag=sp.audience] run function splendor:player/clear_state
function splendor:settings/invalidate_table
data remove entity @s data.splendor
tag @s remove sp.controller
''')
    put('player/clear_state', '''
function splendor:sound/stop_player
clear @s minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}]
function splendor:settings/clear_session
scoreboard players reset @s sp_nonce
scoreboard players reset @s sp_action
scoreboard players reset @s sp_drop
scoreboard players reset @s sp_panel
scoreboard players reset @s sp_target
tag @s remove sp.player
tag @s remove sp.audience
tag @s remove sp.actor
'''+ '\n'.join(f'scoreboard players reset @s {n}' for n in ['sp_table','sp_seat','sp_side','sp_seen','sp_ui_load','sp_ui_table']+[f'sp_pick{i}' for i in range(6)]))
    put('admin/abort', '''
execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=22}] run return run function splendor:game/abort
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1},distance=..8] run tellraw @s {text:"[璀璨宝石] 同维度8格内没有进行中的璀璨宝石。",color:"yellow"}
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1},sort=nearest,limit=1,distance=..8] at @s run function splendor:game/abort
''')
    put('log', '$tellraw @a[tag=ct.debug] {text:"[璀璨宝石 Debug] $(text)",color:"gray"}')
    put('input/context', '''
tag @a[tag=sp.actor] remove sp.actor
tag @e[tag=sp.current] remove sp.current
execute unless entity @s[tag=ct.player,tag=sp.player] run return 0
execute unless score @s sp_table = @s ct_id run return 0
execute if score @s ct_paused matches 1 run return 0
scoreboard players operation #input_table sp_ctx = @s sp_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=sp.controller,scores={ct_game=22,ct_state=1}] if score @s ct_id = #input_table sp_ctx unless score @s ct_paused matches 1 run tag @s add sp.current
execute unless entity @e[tag=sp.current,limit=1] run return 0
tag @s add sp.actor
execute as @e[tag=sp.current,limit=1] at @s run function splendor:system/context
''')
    put('input/give', '''
execute unless entity @s[tag=sp.player,tag=ct.player] run return 0
execute unless score @s sp_table = @s ct_id run return 0
execute if score @s ct_paused matches 1 run return 0
execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run return 0
execute store result storage splendor:input table int 1 run scoreboard players get @s sp_table
execute unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run function splendor:input/menu_tool with storage splendor:input
''')
    put('input/menu_tool', '$item replace entity @s hotbar.8 with minecraft:paper[minecraft:custom_name={text:"璀璨宝石 · 市场",color:"gold",italic:false},minecraft:item_model="card:splendor/bag",minecraft:custom_data={splendor:{tool:1b,table:$(table)}},minecraft:lore=[{text:"Q 打开市场与预约牌",color:"gray",italic:false}]]')
    put('input/drop', '''
scoreboard players set @s sp_drop 0
tag @a[tag=sp.dropper] remove sp.dropper
tag @s add sp.dropper
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run function splendor:input/check_drop
tag @s remove sp.dropper
''')
    put('input/check_drop', '''
scoreboard players set #owner sp_ctx 0
execute on origin if entity @s[tag=sp.dropper] run scoreboard players set #owner sp_ctx 1
execute unless score #owner sp_ctx matches 1 run return 0
data modify storage splendor:input drop set from entity @s Item.components."minecraft:custom_data".splendor
function splendor:input/use_drop with storage splendor:input drop
kill @s
''')
    put('input/use_drop', '''
$execute unless score @a[tag=sp.dropper,limit=1] sp_table matches $(table) run return 0
execute as @a[tag=sp.dropper,limit=1] run function splendor:input/give
execute as @a[tag=sp.dropper,limit=1] run function splendor:ui/open
''')
    print('璀璨宝石生命周期和玩家入口已生成。')


if __name__ == '__main__':
    main()
