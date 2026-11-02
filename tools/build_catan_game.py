"""卡坦岛 21：生命周期和规则结果到表现层的单向桥接。"""
from pathlib import Path
import importlib.util
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/catan/function'
OBJECTIVES = {n: 'dummy' for n in '''ca_ctx ca_state ca_epoch ca_turn ca_winner ca_anim ca_finish
ca_table ca_seat ca_side ca_seen ca_ui_load ca_ui_table ca_nonce ca_mode ca_pick ca_cmd
ca_first ca_layout ca_orient ca_music ca_drop ca_action ca_settings ca_setnonce ca_set_table ca_offline ca_pulse'''.split()}
OBJECTIVES['ca_drop'] = 'minecraft.dropped:minecraft.paper'
OBJECTIVES['ca_action'] = OBJECTIVES['ca_settings'] = 'trigger'


def put(name, body):
    p = ROOT / (name + '.mcfunction'); p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(('\n'.join(body) if isinstance(body, list) else body).strip()+'\n', encoding='utf-8')


def msg(text, color='yellow', target='@a[tag=ca.audience]'):
    return 'tellraw '+target+' '+json.dumps({'text': '[卡坦岛] '+text, 'color': color}, ensure_ascii=False)


def main():
    objectives = dict(OBJECTIVES)
    for module in ('engine', 'input', 'ui', 'settings', 'sound', 'visual'):
        p = Path(__file__).with_name('build_catan_'+module+'.py')
        if not p.exists(): continue
        spec = importlib.util.spec_from_file_location('_catan_'+module, p)
        mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
        extra = getattr(mod, 'OBJECTIVES', {})
        objectives.update(extra if isinstance(extra, dict) else {n:'dummy' for n in extra})
    put('system/install', [f'scoreboard objectives add {n} {v}' for n,v in sorted(objectives.items()) if n!='ca_ctx'] + ['scoreboard players set #version ca_ctx 1'])
    put('load', '''
scoreboard objectives add ca_ctx dummy
execute unless score #version ca_ctx matches 1.. run function catan:system/install
function catan:engine/install
scoreboard players set #two ca_ctx 2
scoreboard players set #minus ca_ctx -1
scoreboard players set #factor ca_ctx 10000
scoreboard players add #ui_load ca_ctx 1
scoreboard players reset * ca_action
scoreboard players reset * ca_nonce
function catan:visual/load
function catan:sound/load
function catan:settings/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21}] at @s run function catan:system/reload
''')
    put('system/context', '''
scoreboard players operation #table ca_ctx = @s ct_id
tag @e[tag=ca.current] remove ca.current
tag @a[tag=ca.audience] remove ca.audience
tag @s add ca.current
execute as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #table ca_ctx if score @s ct_id = #table ca_ctx run tag @s add ca.audience
''')
    put('game/init_table', ['tag @s add ca.controller','function catan:settings/defaults','execute if score @s ct_state matches 0 run function catan:game/preview'])
    put('game/preview', '''
execute unless score @s ct_game matches 21 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.catan{review:1b} run return run function catan:game/preserve_review
function catan:system/context
function catan:input/clear_surface
function catan:sound/stop
execute unless score @s ca_epoch matches 1.. run scoreboard players set @s ca_epoch 1
scoreboard players set #players ca_ctx 4
scoreboard players operation #layout ca_ctx = @s ca_layout
scoreboard players operation #saved_epoch ca_ctx = @s ca_epoch
function catan:engine/init
scoreboard players operation @s ca_epoch = #saved_epoch ca_ctx
scoreboard players add @s ca_epoch 1
execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch
scoreboard players set @s ca_state 0
scoreboard players set @s ca_anim 0
function catan:visual/preview
''')
    put('game/preserve_review','''
function catan:system/context
function catan:input/clear_surface
function catan:sound/stop
scoreboard players set @s ca_state 0
scoreboard players set @s ca_anim 0
scoreboard players add @s ca_epoch 1
execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch
data remove entity @s data.catan.preview
function catan:visual/refresh
''')
    put('system/reload', '''
tag @s add ca.controller
function catan:settings/defaults
execute if score @s ct_state matches 0 run return run function catan:game/preview
function catan:system/context
execute unless data entity @s data.catan.p1 run return run function catan:game/abort
scoreboard players add @s ca_epoch 1
execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch
scoreboard players set @s ca_anim 0
data remove entity @s data.catan.preview
data remove entity @s data.catan.visual_events
function catan:game/sync
function catan:visual/refresh
execute unless score @s ca_state matches 11 run function catan:input/create_surface
function catan:sound/reload
execute as @a[tag=ca.audience] run function catan:input/give
''')
    put('game/start', [
        'function catan:settings/defaults','function catan:system/context',
        'execute unless score @s ca_epoch matches 1.. run scoreboard players set @s ca_epoch 1',
        'execute unless score @s ct_joined matches 3..4 run '+msg('需要 3–4 名真人玩家。','red','@a[tag=ct.start_actor,limit=1]'),
        'execute unless score @s ct_joined matches 3..4 run return fail',
        'scoreboard players set #online ca_ctx 0','scoreboard players set #blocked ca_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx run scoreboard players add #online ca_ctx 1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx if items entity @s hotbar.0 * unless items entity @s hotbar.0 minecraft:paper[minecraft:custom_data~{catan:{tool:1b}}] run scoreboard players set #blocked ca_ctx 1',
        'execute unless score #online ca_ctx = @s ct_joined run return fail',
        'execute if score #blocked ca_ctx matches 1 run '+msg('请先清空快捷栏第 1 格和最后一格。','red','@a[tag=ct.start_actor,limit=1]'),
        'execute if score #blocked ca_ctx matches 1 run return fail',
        'execute as @a[tag=ca.player] if score @s ca_table = #table ca_ctx run function catan:player/clear_state',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ca_ctx run function catan:player/init',
        'function catan:system/context','scoreboard players set @a[tag=ca.audience] ca_side 0',
        'scoreboard players operation #players ca_ctx = @s ct_joined','scoreboard players operation #layout ca_ctx = @s ca_layout',
        'scoreboard players operation #saved_epoch ca_ctx = @s ca_epoch','function catan:engine/init',
        'scoreboard players operation @s ca_epoch = #saved_epoch ca_ctx','scoreboard players add @s ca_epoch 1',
        'execute store result entity @s data.catan.epoch int 1 run scoreboard players get @s ca_epoch',
        'function catan:game/assign','function catan:settings/invalidate_table',
        'scoreboard players set @s ca_anim 0','scoreboard players set @s ca_finish 0',
        'scoreboard players set @s ca_offline 0',
        'function catan:game/sync','function catan:visual/refresh','function catan:input/create_surface',
        'execute as @a[tag=ca.audience] run function catan:input/give','function catan:sound/start',
        'scoreboard players set @s ct_start 1',msg('按顺序放置村庄和道路；第二轮逆序。第 1 格按 Q 瞄准，最后一格按 Q 打开菜单。'),
        'function cardtable:log {text:"卡坦岛开始"}',
    ])
    assign=[]
    for side in range(1,5):
        assign += [f'execute if score #players ca_ctx matches {side}.. run scoreboard players set #side ca_ctx {side}',
                   f'execute if score #players ca_ctx matches {side}.. if score @s ca_first matches 0 as @a[tag=ca.audience,scores={{ca_side=0}},sort=random,limit=1] run function catan:player/assign']
        for seat in range(1,9):
            assign += [f'execute if score #players ca_ctx matches {side}.. if score @s ca_first matches 1 as @a[tag=ca.audience,scores={{ca_side=0,ca_seat={seat}}},limit=1] unless entity @a[tag=ca.audience,scores={{ca_side={side}}}] run function catan:player/assign']
    put('game/assign', assign)
    put('player/init','''
tag @s add ca.player
scoreboard players operation @s ca_table = @s ct_id
scoreboard players operation @s ca_seat = @s ct_seat
scoreboard players set @s ca_mode 0
scoreboard players set @s ca_pick -1
scoreboard players set @s ca_seen -1
function catan:ui/init
''')
    put('player/assign','''
scoreboard players operation @s ca_side = #side ca_ctx
execute store result storage catan:runtime side int 1 run scoreboard players get @s ca_side
execute store result storage catan:runtime seat int 1 run scoreboard players get @s ca_seat
function catan:name/capture
function catan:player/store with storage catan:runtime
''')
    put('player/store','''
$data modify entity @e[tag=ca.current,limit=1] data.catan.p$(side).name set from storage catan:runtime name.value
$data modify entity @e[tag=ca.current,limit=1] data.catan.p$(side).seat set value $(seat)
$data modify entity @e[tag=ca.current,limit=1] data.catan.p$(side).color set value $(side)
''')
    name=(PACK/'data/weiqi/function/name/capture.mcfunction').read_text(encoding='utf-8').replace('weiqi:','catan:').replace('go.name_resolver','ca.name_resolver')
    put('name/capture', name)
    loot=PACK/'data/catan/loot_table/player_name.json';loot.parent.mkdir(parents=True,exist_ok=True)
    loot.write_text((PACK/'data/weiqi/loot_table/player_name.json').read_text(encoding='utf-8'),encoding='utf-8')
    put('game/sync', ['execute store result score @s ca_state run data get entity @s data.catan.phase','execute store result score @s ca_epoch run data get entity @s data.catan.epoch','execute store result score @s ca_turn run data get entity @s data.catan.turn','execute store result score @s ca_winner run data get entity @s data.catan.winner']+[f'execute if score @s ca_state matches {phase} run data modify entity @s data.catan.hint set value "{hint}"' for phase,hint in [(1,'放置村庄'),(2,'放置相邻道路'),(3,'等待投骰'),(4,'建造／交易／结束回合'),(5,'等待弃牌'),(6,'移动强盗'),(7,'选择偷取对象'),(8,'免费修路'),(10,'计算最长道路'),(11,'对局结束')]])
    put('game/action','''
# 入口只接受绑定本桌、未失效的 UI/落点；引擎是最终裁判。
function catan:system/context
execute unless entity @a[tag=ca.actor,tag=ca.audience,limit=1] run return 0
function catan:game/online
execute unless score #live ca_ctx = #required ca_ctx run return 0
execute unless score @s ca_anim matches 0 run return run function catan:game/busy
execute if score @s ca_vtimer matches 1.. run return run function catan:game/busy
function catan:engine/action
execute unless score #ok ca_ctx matches 1 run return run function catan:game/illegal
function catan:game/after_action
''')
    put('game/busy',msg('动画进行中，请稍候。','gray','@a[tag=ca.actor]'))
    put('game/illegal',[msg('该操作目前不合法：请检查轮次、位置、费用或是否仍有棋子。','red','@a[tag=ca.actor]'),'function catan:sound/illegal','execute as @a[tag=ca.actor] run function catan:ui/open'])
    after=['function catan:game/sync','data modify storage catan:runtime event set from entity @s data.catan.last','scoreboard players set #event ca_ctx -1','execute store result score #event ca_ctx run data get entity @s data.catan.last.code','execute as @a[tag=ca.audience] run scoreboard players set @s ca_pick -1','data remove entity @s data.catan.preview','function catan:visual/clear_selection','function catan:visual/update']
    kinds={1:('settlement',16),2:('road',12),10:('dice',24),12:('robber',18),20:('road',12),21:('settlement',16),22:('city',20),23:('development',16),30:('development',16),41:('trade',18),50:('trade',18)}
    for code,(kind,ticks) in kinds.items():
        after += [f'execute if score #event ca_ctx matches {code} run function catan:game/event_{code}', f'execute if score #event ca_ctx matches {code} run scoreboard players set @s ca_anim {ticks}']
        ev=[f'data modify entity @s data.catan.last.kind set value "{kind}"','data modify entity @s data.catan.last.owner set from storage catan:runtime event.actor']
        if code==10:ev+=['data modify entity @s data.catan.last.die1 set from entity @s data.catan.dice[0]','data modify entity @s data.catan.last.die2 set from entity @s data.catan.dice[1]']
        ev+=['function catan:game/event_seats with entity @s data.catan.last']
        if code==41:ev+=['function catan:game/trade_seats with entity @s data.catan.last']
        ev+=['function catan:visual/animate',f'function catan:sound/{"roll" if code==10 else kind}','function catan:game/log_event']
        put(f'game/event_{code}', ev)
    after += ['data modify entity @s data.catan.anim_production set from storage catan:runtime event.production','execute if data entity @s data.catan.anim_production[0] run function catan:game/production','data modify entity @s data.catan.last set from storage catan:runtime event','execute if score @s ca_winner matches 1..4 run return run function catan:game/win','execute as @a[tag=ca.audience] run function catan:input/give']
    put('game/after_action',after)
    put('game/event_seats', '''
$data modify entity @s data.catan.last.seat set from entity @s data.catan.p$(owner).seat
$data modify entity @s data.catan.last.from_seat set from entity @s data.catan.p$(owner).seat
''')
    put('game/trade_seats','''
$data modify entity @s data.catan.last.from_seat set from entity @s data.catan.p$(from).seat
$data modify entity @s data.catan.last.to_seat set from entity @s data.catan.p$(to).seat
''')
    put('game/production','''
data modify entity @s data.catan.last set from entity @s data.catan.anim_production[0]
data modify entity @s data.catan.last.kind set value "production"
data modify entity @s data.catan.last.target set from entity @s data.catan.last.hex
function catan:game/event_seats with entity @s data.catan.last
function catan:visual/animate
data remove entity @s data.catan.anim_production[0]
execute if data entity @s data.catan.anim_production[0] run function catan:game/production
''')
    put('game/log_event', '''
data modify storage catan:runtime log set from entity @s data.catan.last
data modify storage catan:runtime log.label set value "完成操作"
execute if data storage catan:runtime log{kind:"road"} run data modify storage catan:runtime log.label set value "修建道路"
execute if data storage catan:runtime log{kind:"settlement"} run data modify storage catan:runtime log.label set value "建造村庄"
execute if data storage catan:runtime log{kind:"city"} run data modify storage catan:runtime log.label set value "升级城市"
execute if data storage catan:runtime log{kind:"robber"} run data modify storage catan:runtime log.label set value "移动强盗"
execute if data storage catan:runtime log{kind:"development"} run data modify storage catan:runtime log.label set value "操作开发牌"
execute if data storage catan:runtime log{code:23} run data modify storage catan:runtime log.label set value "购买开发牌"
execute if data storage catan:runtime log{code:30,target:0} run data modify storage catan:runtime log.label set value "使用骑士"
execute if data storage catan:runtime log{code:30,target:1} run data modify storage catan:runtime log.label set value "使用修路"
execute if data storage catan:runtime log{code:30,target:2} run data modify storage catan:runtime log.label set value "使用垄断"
execute if data storage catan:runtime log{code:30,target:3} run data modify storage catan:runtime log.label set value "使用发明"
execute if data storage catan:runtime log{kind:"trade"} run data modify storage catan:runtime log.label set value "完成交易"
execute if data storage catan:runtime log{kind:"dice"} run function catan:game/log_dice with storage catan:runtime log
function catan:game/log_actor with storage catan:runtime log
''')
    put('game/log_dice','$data modify storage catan:runtime log.label set value "掷出 $(die1) + $(die2)"')
    put('game/log_actor', '$tellraw @a[tag=ca.audience] [{text:"[卡坦岛] ",color:"gold"},{nbt:"data.catan.p$(actor).name",entity:"@s",interpret:true},{text:" · $(label)",color:"gray"}]')
    put('log','$tellraw @a[tag=ct.debug] {text:"[卡坦岛 Debug] $(text)",color:"gray"}')
    put('tick', '''
execute as @a[scores={ca_settings=1..}] run function catan:settings/save
execute as @a[scores={ca_action=1..}] run function catan:ui/handle
execute as @a[tag=ca.player,scores={ca_drop=1..}] at @s run function catan:input/drop
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21,ct_state=1}] at @s run function catan:game/tick
execute as @a[tag=ca.player] unless entity @s[tag=ct.player] run function catan:player/clear_state
''')
    put('game/tick','''
function catan:system/context
function catan:visual/tick
function catan:sound/tick
scoreboard players add @s ca_pulse 1
execute if score @s ca_pulse matches 20.. run function catan:game/hud
execute if score @s ca_finish matches 1.. run return run function catan:game/finish_tick
function catan:game/online
execute if score #live ca_ctx = #required ca_ctx run scoreboard players set @s ca_offline 0
execute unless score #live ca_ctx = #required ca_ctx run scoreboard players add @s ca_offline 1
execute if score @s ca_offline matches 200.. run return run function catan:game/abort
execute unless score #live ca_ctx = #required ca_ctx run return 0
execute if score @s ca_anim matches 1.. run function catan:input/clear_pending
execute if score @s ca_vtimer matches 1.. run function catan:input/clear_pending
execute if score @s ca_anim matches 1.. run scoreboard players remove @s ca_anim 1
execute if score @s ca_anim matches 1.. run return 0
execute if score @s ca_vtimer matches 1.. run return 0
function catan:engine/tick
execute if score #changed ca_ctx matches 1 run function catan:game/after_action
execute as @e[type=minecraft:interaction,tag=ca.surface] if score @s ct_id = #table ca_ctx if data entity @s interaction run function catan:input/cell
execute as @a[tag=ca.audience] run function catan:input/give
''')
    put('game/online','''
scoreboard players set #live ca_ctx 0
execute as @a[tag=ca.audience] run scoreboard players add #live ca_ctx 1
execute store result score #required ca_ctx run data get entity @s data.catan.n
''')
    put('game/hud',['scoreboard players set @s ca_pulse 0','function catan:game/hud_show with entity @s data.catan'])
    put('game/hud_show','$title @a[tag=ca.audience] actionbar [{text:"卡坦岛 · ",color:"gold"},{nbt:"data.catan.p$(turn).name",entity:"@s",interpret:true},{text:" · ",color:"gray"},{nbt:"data.catan.hint",entity:"@s",interpret:false,color:"yellow"}]')
    put('game/win',['execute if score @s ca_finish matches 1.. run return 0','execute unless score @s ca_winner matches 1..4 run return 0','scoreboard players set @s ca_finish 100','scoreboard players set @s ca_anim 0','function catan:input/clear_surface','function catan:sound/result','data modify entity @s data.catan.last.kind set value "win"','execute store result entity @s data.catan.last.owner int 1 run scoreboard players get @s ca_winner','function catan:visual/animate','function catan:game/winner_announce with entity @s data.catan','function catan:game/firework'])
    put('game/winner_announce','$tellraw @a[tag=ca.audience] [{text:"[卡坦岛] ",color:"gold"},{nbt:"data.catan.p$(winner).name",entity:"@s",interpret:true},{text:" 达到 10 分，获得胜利！",color:"gold"}]')
    put('game/firework','''
scoreboard players operation #winner ca_ctx = @s ca_winner
execute as @a[tag=ca.audience] if score @s ca_side = #winner ca_ctx at @s run function catan:game/firework_player
''')
    # 与现有游戏使用同一 SK Firework 接口。
    put('game/firework_player','''
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["ca.firework","ca.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=ca.firework.new] ct_id = #table ca_ctx
tag @e[type=minecraft:firework_rocket,tag=ca.firework.new] remove ca.firework.new
''')
    put('game/finish_tick',['scoreboard players remove @s ca_finish 1','execute if score @s ca_finish matches 0 run function catan:game/cleanup'])
    put('game/cleanup',['function catan:system/context','function catan:sound/stop','function catan:input/clear_surface','data remove entity @s data.catan.preview','data remove entity @s data.catan.trade','data modify entity @s data.catan.review set value 1b','function catan:visual/refresh','execute as @e[type=minecraft:firework_rocket,tag=ca.firework] if score @s ct_id = #table ca_ctx run kill @s','execute as @a[tag=ca.audience] run function catan:player/clear_state','scoreboard players set @s ca_state 0','scoreboard players set @s ca_anim 0','scoreboard players set @s ca_finish 0','function catan:settings/invalidate_table','function cardtable:game/return_lobby'])
    put('game/abort',['execute unless score @s ct_state matches 1 run return fail','function catan:system/context',msg('游戏已中止，返回大厅。'),'function catan:game/cleanup'])
    put('game/end_vote','function catan:game/abort')
    put('game/remove',['function catan:system/context','function catan:sound/stop','function catan:input/clear_surface','function catan:visual/clear','execute as @e[type=minecraft:firework_rocket,tag=ca.firework] if score @s ct_id = #table ca_ctx run kill @s','execute as @a[tag=ca.audience] run function catan:player/clear_state','function catan:settings/invalidate_table','data remove entity @s data.catan','tag @s remove ca.controller'])
    put('player/clear_state','''
function catan:sound/stop_player
clear @s minecraft:paper[minecraft:custom_data~{catan:{tool:1b}}]
function catan:settings/clear_session
scoreboard players reset @s ca_action
scoreboard players reset @s ca_nonce
scoreboard players reset @s ca_drop
tag @s remove ca.player
tag @s remove ca.audience
tag @s remove ca.actor
''')
    put('admin/abort','''
execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=21}] run return run function catan:game/abort
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21,ct_state=1},sort=nearest,limit=1,distance=..8] at @s run function catan:game/abort
''')
    print('Catan lifecycle generated')


if __name__ == '__main__': main()
