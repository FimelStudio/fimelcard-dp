# -*- coding: utf-8 -*-
"""胡闹运动会23：按桌生命周期，角色引擎到动画/无OP界面的桥接。"""
from pathlib import Path
from build_table_pause_guards import write_guarded

PACK=Path(__file__).resolve().parents[1]
ROOT=PACK/'data/magical_athlete/function'
FIELDS='state epoch turn pending previous anim finish pulse table seat side seen nonce ui_load ui_table ui_seat panel target setnonce setload settable setepoch setseat setlayout draft track music speed orient music_tick vid vtimer vframe vpos vfrom vto'.split()
OBJECTIVES={('ma_'+key):'dummy' for key in FIELDS}
OBJECTIVES.update(ma_action='trigger',ma_settings='trigger',ma_drop='minecraft.dropped:minecraft.paper')


def put(name,body):
    path=ROOT/(name+'.mcfunction');path.parent.mkdir(parents=True,exist_ok=True)
    write_guarded(path, ('\n'.join(body) if isinstance(body,list) else body).strip()+'\n',encoding='utf-8')


def main():
    put('system/install',[f'scoreboard objectives add {name} {kind}' for name,kind in sorted(OBJECTIVES.items())]+['scoreboard players set #version ma_ctx 1'])
    put('load','''
scoreboard objectives add ma_ctx dummy
execute unless score #version ma_ctx matches 1.. run function magical_athlete:system/install
function magical_athlete:engine/install
scoreboard players set #factor ma_ctx 10000
scoreboard players set #hundred ma_ctx 100
scoreboard players add #ui_load ma_ctx 1
scoreboard players reset * ma_action
scoreboard players reset * ma_nonce
function magical_athlete:settings/load
function magical_athlete:ui/load
function magical_athlete:visual/load
'''+ '\n'.join(f'execute in minecraft:{dim} as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={{ct_game=23}}] at @s run function magical_athlete:system/reload' for dim in ('overworld','the_nether','the_end')))
    put('system/context','''
scoreboard players operation #table ma_ctx = @s ct_id
tag @e[tag=ma.current] remove ma.current
tag @a[tag=ma.audience] remove ma.audience
tag @s add ma.current
execute as @a[tag=ma.player,tag=ct.player] if score @s ma_table = #table ma_ctx if score @s ct_id = #table ma_ctx run tag @s add ma.audience
''')
    put('game/init_table',['tag @s add ma.controller','function magical_athlete:settings/defaults','execute unless score @s ma_epoch matches 1.. run scoreboard players set @s ma_epoch 1','execute if score @s ct_state matches 0 run function magical_athlete:game/preview'])
    put('game/preview','''
execute unless score @s ct_game matches 23 run return 0
execute unless score @s ct_state matches 0 run return 0
function magical_athlete:system/context
scoreboard players set @s ma_state 0
scoreboard players set @s ma_anim 0
function magical_athlete:visual/preview
''')
    put('system/reload','''
tag @s add ma.controller
function magical_athlete:settings/defaults
execute if score @s ct_state matches 0 run return run function magical_athlete:game/preview
function magical_athlete:system/context
execute unless data entity @s data.magical_athlete.version run return run function magical_athlete:game/abort
# 丢弃未播放的表现，规则已提交的角色、骰值、得分及待选技能不变。
scoreboard players set @s ma_anim 0
data remove entity @s data.magical_athlete.visual_queue
function magical_athlete:game/sync
function magical_athlete:visual/refresh
function magical_athlete:sound/reload
execute as @a[tag=ma.audience] run function magical_athlete:input/give
''')
    put('game/start','''
function magical_athlete:settings/defaults
function magical_athlete:system/context
execute unless score @s ct_joined matches 2..6 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[胡闹运动会] 需要2～6名真人玩家。",color:"red"}
execute unless score @s ct_joined matches 2..6 run return fail
scoreboard players set #online ma_ctx 0
scoreboard players set #blocked ma_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx run scoreboard players add #online ma_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run scoreboard players set #blocked ma_ctx 1
execute unless score #online ma_ctx = @s ct_joined run return fail
execute if score #blocked ma_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"[胡闹运动会] 请先腾空快捷栏最后一格。",color:"red"}
execute if score #blocked ma_ctx matches 1 run return fail
execute as @a[tag=ma.player] if score @s ma_table = #table ma_ctx run function magical_athlete:player/clear_state
execute as @a[tag=ct.player] if score @s ct_id = #table ma_ctx run function magical_athlete:player/init
function magical_athlete:system/context
scoreboard players operation #players ma_ctx = @s ct_joined
function magical_athlete:engine/init
scoreboard players set @a[tag=ma.audience] ma_side 0
function magical_athlete:game/assign
function magical_athlete:settings/invalidate_table
scoreboard players set @s ma_finish 0
scoreboard players set @s ma_anim 0
scoreboard players set @s ma_pulse 0
function magical_athlete:game/sync
function magical_athlete:visual/refresh
execute as @a[tag=ma.audience] run function magical_athlete:input/give
function magical_athlete:sound/start
function magical_athlete:sound/race_start
scoreboard players set @s ct_start 1
tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 开始四场积分赛！快捷栏最后一格按Q打开比赛菜单。",color:"gold"}
function magical_athlete:ui/refresh
''')
    assign=[]
    for side in range(1,7):
        for seat in range(1,9):
            assign += [f'execute if score #players ma_ctx matches {side}.. if entity @a[tag=ma.audience,scores={{ma_side=0,ma_seat={seat}}}] unless entity @a[tag=ma.audience,scores={{ma_side={side}}}] run scoreboard players set #side ma_ctx {side}',f'execute if score #players ma_ctx matches {side}.. as @a[tag=ma.audience,scores={{ma_side=0,ma_seat={seat}}},limit=1] unless entity @a[tag=ma.audience,scores={{ma_side={side}}}] run function magical_athlete:player/assign']
    put('game/assign',assign)
    put('player/init',['tag @s add ma.player','scoreboard players operation @s ma_table = @s ct_id','scoreboard players operation @s ma_seat = @s ct_seat','scoreboard players set @s ma_side 0','scoreboard players set @s ma_drop 0','scoreboard players reset @s ma_nonce'])
    put('player/assign','''
scoreboard players operation @s ma_side = #side ma_ctx
execute store result storage magical_athlete:runtime side int 1 run scoreboard players get @s ma_side
execute store result storage magical_athlete:runtime seat int 1 run scoreboard players get @s ma_seat
function magical_athlete:name/capture
function magical_athlete:player/store with storage magical_athlete:runtime
''')
    put('player/store','''
$data modify entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(side).name set from storage magical_athlete:runtime name.value
$data modify entity @e[tag=ma.current,limit=1] data.magical_athlete.p$(side).seat set value $(seat)
''')
    source=(PACK/'data/weiqi/function/name/capture.mcfunction').read_text(encoding='utf-8')
    put('name/capture',source.replace('weiqi:','magical_athlete:').replace('go.name_resolver','ma.name_resolver'))
    loot=PACK/'data/magical_athlete/loot_table/player_name.json';loot.parent.mkdir(parents=True,exist_ok=True)
    loot.write_text((PACK/'data/weiqi/loot_table/player_name.json').read_text(encoding='utf-8'),encoding='utf-8')
    put('game/sync',[f'execute store result score @s ma_{score} run data get entity @s data.magical_athlete.{field}' for score,field in [('state','phase'),('epoch','epoch'),('turn','turn')]]+['scoreboard players set @s ma_pending 0','execute store result score @s ma_pending run data get entity @s data.magical_athlete.pending.owner'])
    put('game/action','''
execute if score @s ct_paused matches 1 run return 0
function magical_athlete:system/context
execute unless entity @a[tag=ma.actor,tag=ma.audience,limit=1] run return 0
execute if score @s ma_anim matches 1.. run return 0
scoreboard players operation @s ma_previous = @s ma_state
data modify entity @s data.magical_athlete.visual_before set from entity @s data.magical_athlete.racers
function magical_athlete:engine/action
execute unless score #ok ma_ctx matches 1 run return run function magical_athlete:game/illegal
function magical_athlete:game/after_action
''')
    put('game/illegal',['tellraw @a[tag=ma.actor] {text:"[胡闹运动会] 操作未完成：请检查当前阶段、行动顺序和技能可选目标。",color:"red"}','function magical_athlete:sound/illegal','execute as @a[tag=ma.actor] run function magical_athlete:ui/open'])
    put('game/after_action','''
function magical_athlete:game/sync
execute if score @s ma_previous matches 2 if score @s ma_state matches 3 run function magical_athlete:visual/refresh
execute if score @s ma_previous matches 2 if score @s ma_state matches 3 run function magical_athlete:sound/race_start
execute if score @s ma_previous matches 4 if score @s ma_state matches 2 run function magical_athlete:visual/refresh
scoreboard players reset @a[tag=ma.audience] ma_nonce
execute as @a[tag=ma.audience] run dialog clear @s
function magical_athlete:visual/animate
execute unless score @s ma_anim matches 1.. run function magical_athlete:game/after_animation
''')
    put('game/pump','''
execute if score @s ct_paused matches 1 run return 0
execute if score @s ma_anim matches 1.. run return 0
execute unless data entity @s data.magical_athlete.queue[0] run return 0
execute if data entity @s data.magical_athlete.pending.options[0] run return 0
scoreboard players operation @s ma_previous = @s ma_state
data modify entity @s data.magical_athlete.visual_before set from entity @s data.magical_athlete.racers
function magical_athlete:engine/pump
execute if score #ok ma_ctx matches 1 run function magical_athlete:game/after_action
''')
    put('game/after_animation',['scoreboard players set @s ma_anim 0','function magical_athlete:visual/refresh','execute if score @s ma_state matches 5 run return run function magical_athlete:game/win','function magical_athlete:ui/refresh'])
    put('tick','''
execute as @a[scores={ma_settings=1..}] at @s run function magical_athlete:settings/save
execute as @a[scores={ma_action=1..}] at @s run function magical_athlete:ui/handle
execute as @a[tag=ma.player,scores={ma_drop=1..}] at @s run function magical_athlete:input/drop
'''+ '\n'.join(f'execute in minecraft:{dim} as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={{ct_game=23,ct_state=1}}] at @s run function magical_athlete:game/tick' for dim in ('overworld','the_nether','the_end'))+'''
execute as @a[tag=ma.player] unless entity @s[tag=ct.player] run function magical_athlete:player/clear_state
''')
    put('game/tick','''
execute if score @s ct_paused matches 1 run return 0
function magical_athlete:system/context
function magical_athlete:sound/tick
scoreboard players add @s ma_pulse 1
execute if score @s ma_pulse matches 20.. run function magical_athlete:game/hud
execute if score @s ma_finish matches 1.. run return run function magical_athlete:game/finish_tick
execute if score @s ma_anim matches 1.. run function magical_athlete:visual/tick
execute if score @s ma_anim matches 0 run function magical_athlete:game/pump
execute if score @s ma_pulse matches 0 as @a[tag=ma.audience] run function magical_athlete:input/give
''')
    put('game/hud',['scoreboard players set @s ma_pulse 0','function magical_athlete:game/hud_show with entity @s data.magical_athlete'])
    put('game/hud_show','$title @a[tag=ma.audience] actionbar [{text:"胡闹运动会 · 第$(round)／4场 · ",color:"gold"},{nbt:"data.magical_athlete.p$(turn).name",entity:"@s",interpret:true},{text:" · Q比赛菜单",color:"yellow"}]')
    put('game/win','''
execute if score @s ma_finish matches 1.. run return 0
scoreboard players set @s ma_finish 100
function magical_athlete:sound/win
tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 四场结束，积分最高的队伍获胜（同分共享胜利）。",color:"gold"}
data modify storage cardtable:result names set value {text:"",extra:[]}
'''+ '\n'.join(f'execute if data entity @s data.magical_athlete.p{side}.name run function magical_athlete:game/score {{side:{side}}}' for side in range(1,7))+'\n'+ '\n'.join(f'execute if data entity @s data.magical_athlete{{winners:[{side}]}} run function magical_athlete:game/announce {{side:{side}}}' for side in range(1,7)) + '\nfunction cardtable:game/result/title {audience:"@a[tag=ma.audience]",title:{text:"最终胜利者",color:"gold",bold:true},subtitle:{nbt:"names",storage:"cardtable:result",interpret:true}}')
    put('game/score','$tellraw @a[tag=ma.audience] [{nbt:"data.magical_athlete.p$(side).name",entity:"@s",interpret:true},{text:" · ",color:"gray"},{nbt:"data.magical_athlete.p$(side).points",entity:"@s"},{text:"分",color:"gold"}]')
    put('game/announce','''
$tellraw @a[tag=ma.audience] [{text:"获胜：",color:"gold"},{nbt:"data.magical_athlete.p$(side).name",entity:"@s",interpret:true},{text:" · ",color:"gray"},{nbt:"data.magical_athlete.p$(side).points",entity:"@s"},{text:"分",color:"gray"}]
$function cardtable:game/result/append_name {path:"data.magical_athlete.p$(side).name"}
$execute as @a[tag=ma.audience,scores={ma_side=$(side)}] at @s run function magical_athlete:game/firework
''')
    put('game/firework','''
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["ma.firework","ma.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=ma.firework.new] ct_id = #table ma_ctx
tag @e[type=minecraft:firework_rocket,tag=ma.firework.new] remove ma.firework.new
''')
    put('game/finish_tick',['scoreboard players remove @s ma_finish 1','execute if score @s ma_finish matches 0 run function magical_athlete:game/cleanup'])
    put('game/finish',['execute unless score @s ct_state matches 1 run return 0','function magical_athlete:game/sync','execute unless score @s ma_state matches 5 run return 0','function magical_athlete:game/win'])
    put('game/cleanup','''
function magical_athlete:system/context
scoreboard players set @s ma_finish 0
scoreboard players set @s ma_anim 0
data remove entity @s data.magical_athlete.visual_queue
function magical_athlete:sound/stop
function magical_athlete:visual/clear
execute as @e[tag=ma.firework] if score @s ct_id = #table ma_ctx run kill @s
execute as @a[tag=ma.audience] run function magical_athlete:player/clear_state
function magical_athlete:settings/invalidate_table
function cardtable:animation/deal/clear
function cardtable:game/return_lobby
''')
    put('game/abort',['execute unless score @s ct_state matches 1 run return fail','function magical_athlete:system/context','tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 游戏已中止，返回大厅。",color:"yellow"}','function magical_athlete:game/cleanup'])
    put('game/end_vote','function magical_athlete:game/abort')
    put('game/player_left','function magical_athlete:game/abort')
    put('game/remove','''
function magical_athlete:system/context
function magical_athlete:sound/stop
function magical_athlete:visual/clear
execute as @e[tag=ma.firework] if score @s ct_id = #table ma_ctx run kill @s
execute as @a[tag=ma.audience] run function magical_athlete:player/clear_state
function magical_athlete:settings/invalidate_table
data remove entity @s data.magical_athlete
tag @s remove ma.controller
''')
    put('player/clear_state',['function magical_athlete:sound/stop_player','clear @s minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}]','function magical_athlete:settings/clear_session','dialog clear @s']+[f'scoreboard players reset @s ma_{key}' for key in ['nonce','action','drop','panel','target','table','seat','side','seen','ui_load','ui_table','ui_seat']]+['tag @s remove ma.player','tag @s remove ma.audience','tag @s remove ma.actor','tag @s remove ma.sound_audience'])
    put('admin/abort','''
execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=23}] run return run function magical_athlete:game/abort
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23,ct_state=1},distance=..8] run tellraw @s {text:"[胡闹运动会] 同维度8格内没有进行中的胡闹运动会。",color:"yellow"}
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23,ct_state=1},sort=nearest,limit=1,distance=..8] at @s run function magical_athlete:game/abort
''')
    put('input/context','''
tag @a[tag=ma.actor] remove ma.actor
tag @e[tag=ma.current] remove ma.current
execute unless entity @s[tag=ct.player,tag=ma.player] run return 0
execute unless score @s ma_table = @s ct_id run return 0
execute unless score @s ma_seat = @s ct_seat run return 0
execute if score @s ct_paused matches 1 run return 0
scoreboard players operation #input_table ma_ctx = @s ma_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ma.controller,distance=0..,scores={ct_game=23,ct_state=1}] if score @s ct_id = #input_table ma_ctx unless score @s ct_paused matches 1 run tag @s add ma.current
execute unless entity @e[tag=ma.current,limit=1] run return 0
tag @s add ma.actor
execute as @e[tag=ma.current,limit=1] at @s run function magical_athlete:system/context
''')
    put('input/give','''
execute unless entity @s[tag=ma.player,tag=ct.player] run return 0
execute unless score @s ma_table = @s ct_id run return 0
execute unless score @s ma_seat = @s ct_seat run return 0
execute if score @s ct_paused matches 1 run return 0
execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run return 0
execute store result storage magical_athlete:input table int 1 run scoreboard players get @s ma_table
execute unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:input/menu_tool with storage magical_athlete:input
''')
    put('input/menu_tool','$item replace entity @s hotbar.8 with minecraft:paper[minecraft:custom_name={text:"胡闹运动会 · 比赛菜单",color:"gold",italic:false},minecraft:item_model="card:magical_athlete/prop/menu",minecraft:custom_data={magical_athlete:{tool:1b,table:$(table)}}]')
    put('input/drop','''
scoreboard players set @s ma_drop 0
tag @a[tag=ma.dropper] remove ma.dropper
tag @s add ma.dropper
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:input/check_drop
tag @s remove ma.dropper
''')
    put('input/check_drop','''
scoreboard players set #owner ma_ctx 0
execute on origin if entity @s[tag=ma.dropper] run scoreboard players set #owner ma_ctx 1
execute unless score #owner ma_ctx matches 1 run return 0
data modify storage magical_athlete:input drop set from entity @s Item.components."minecraft:custom_data".magical_athlete
function magical_athlete:input/use_drop with storage magical_athlete:input drop
kill @s
''')
    put('input/use_drop','''
$execute unless score @a[tag=ma.dropper,limit=1] ma_table matches $(table) run return 0
execute as @a[tag=ma.dropper,limit=1] run function magical_athlete:input/give
execute as @a[tag=ma.dropper,limit=1] run function magical_athlete:ui/open
''')
    put('debug/state','''
execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=23}] run return run function magical_athlete:debug/controller
tag @a[tag=ma.debug_actor] remove ma.debug_actor
tag @s add ma.debug_actor
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23},distance=..8] run tellraw @s {text:"[胡闹运动会 Debug] 同维度8格内没有本游戏牌桌。",color:"yellow"}
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23},distance=..8,sort=nearest,limit=1] at @s run function magical_athlete:debug/show
tag @s remove ma.debug_actor
''')
    put('debug/controller',['tag @a[tag=ma.debug_actor] remove ma.debug_actor','tag @a[tag=ct.debug] add ma.debug_actor','function magical_athlete:debug/show','tag @a[tag=ma.debug_actor] remove ma.debug_actor'])
    import json
    pieces=[{'text':'[胡闹运动会 Debug] 桌号：','color':'gold'},{'score':{'name':'@s','objective':'ct_id'}}]
    for field in ('phase','round','turn','active','dice','epoch','pending.kind','pending.owner','pending.options'):
        pieces +=[{'text':' · '+field+'：','color':'gray'},{'nbt':'data.magical_athlete.'+field,'entity':'@s'}]
    put('debug/show','tellraw @a[tag=ma.debug_actor] '+json.dumps(pieces,ensure_ascii=False,separators=(',',':')))
    sound()


def sound():
    put('sound/context',['scoreboard players operation #sound_table ma_ctx = @s ct_id','tag @a[tag=ma.sound_audience] remove ma.sound_audience','execute as @a[tag=ma.player,tag=ct.player] if score @s ma_table = #sound_table ma_ctx if score @s ct_id = #sound_table ma_ctx run tag @s add ma.sound_audience'])
    for event in ('roll','step','land','skill','trip','warp','coin','finish','race_start','win','illegal'):
        put('sound/'+event,['execute if score @s ct_paused matches 1 run return 0','function magical_athlete:sound/context',f'execute as @a[tag=ma.sound_audience] at @s run playsound magical_athlete:{event} master @s ~ ~ ~ 0.5 1'])
    put('sound/start',['execute if score @s ct_paused matches 1 run return 0','scoreboard players set @s ma_music_tick 0','execute if score @s ma_music matches 1 run function magical_athlete:sound/play'])
    put('sound/play',['execute if score @s ct_paused matches 1 run return 0','execute unless score @s ma_music matches 1 run return 0','function magical_athlete:sound/context','execute as @a[tag=ma.sound_audience] at @s run playsound magical_athlete:bgm record @s ~ ~ ~ 0.16 1','scoreboard players set @s ma_music_tick 640'])
    put('sound/tick',['execute if score @s ma_music matches 0 run return 0','scoreboard players remove @s ma_music_tick 1','execute if score @s ma_music_tick matches ..0 run function magical_athlete:sound/play'])
    put('sound/stop',['function magical_athlete:sound/context','execute as @a[tag=ma.sound_audience] run function magical_athlete:sound/stop_player','scoreboard players set @s ma_music_tick 0'])
    put('sound/stop_player','stopsound @s record magical_athlete:bgm')
    put('sound/pause',['function magical_athlete:system/context','function magical_athlete:sound/stop'])
    put('sound/resume',['function magical_athlete:system/context','function magical_athlete:sound/stop','execute if score @s ct_state matches 1 if score @s ma_music matches 1 run function magical_athlete:sound/start'])
    put('sound/reload',['function magical_athlete:sound/stop','execute unless score @s ct_paused matches 1 run function magical_athlete:sound/start'])
    from build_magical_athlete_music import functions as track_music
    track_music()


if __name__=='__main__':main()
