"""情书17：牌桌生命周期、私密发牌动画、多轮计分与恢复。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK/'data/love_letter/function'
OBJECTIVES = '''ll_state ll_phase ll_turn ll_first ll_epoch ll_timer ll_clock ll_anim ll_round
ll_goal ll_goal_setting ll_time_setting ll_first_setting ll_discards_setting ll_actor ll_card
ll_target ll_guess ll_scored ll_winners ll_alive_n ll_high ll_seat ll_alive ll_hand ll_extra
ll_protect ll_spy ll_points ll_won ll_bonus ll_players ll_dealseat ll_dealstage ll_timeout
ll_matchwin ll_tick ll_action ll_settings ll_seen ll_pick ll_ui_tmp ll_ui_load ll_table
ll_setnonce ll_settable ll_setepoch ll_panel ll_prev_panel'''.split()


def put(name, body):
    target = ROOT/(name+'.mcfunction')
    target.parent.mkdir(parents=True, exist_ok=True)
    body = '\n'.join(body) if isinstance(body, list) else body
    target.write_text(body.strip()+'\n', encoding='utf-8')


def build():
    extra = {}
    try:
        from build_love_letter_ui import OBJECTIVES as ui_objectives
        extra.update(ui_objectives if isinstance(ui_objectives, dict) else {x:'dummy' for x in ui_objectives})
    except (ImportError, AttributeError):
        pass
    try:
        from build_love_letter_settings import OBJECTIVES as settings_objectives
        extra.update(settings_objectives if isinstance(settings_objectives, dict) else {x:'dummy' for x in settings_objectives})
    except (ImportError, AttributeError):
        pass
    objectives={x:'dummy' for x in OBJECTIVES}
    objectives.update({'ll_action':'trigger','ll_settings':'trigger','ll_drop':'minecraft.dropped:minecraft.purple_dye'})
    objectives.update(extra)
    put('load', [f'scoreboard objectives add {name} {kind}' for name,kind in sorted(objectives.items())]+[
        'scoreboard objectives add ll_ctx dummy',
        'execute unless score #version ll_ctx matches 1.. run scoreboard players set #version ll_ctx 1',
        'execute unless score #epoch_serial ll_ctx matches 10000..999999 run scoreboard players set #epoch_serial ll_ctx 10000',
        'scoreboard players set #thousand ll_ctx 1000',
        'scoreboard players add #ui_load ll_ctx 1',
        'scoreboard players reset * ll_action',
        'scoreboard players reset * ll_settings',
        'scoreboard players reset * ll_setnonce',
        'function love_letter:visual/load',
        'execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=17}] at @s run function love_letter:system/reload'])
    put('tick', '''
function love_letter:input/tick
execute as @e[type=minecraft:marker,tag=ll.controller,scores={ct_game=17}] at @s run function love_letter:visual/tick
execute as @e[type=minecraft:marker,tag=ll.controller,scores={ct_game=17,ll_state=1..4}] at @s run function love_letter:game/tick
''')
    put('system/context', '''
scoreboard players operation #table ll_ctx = @s ct_id
tag @a[tag=ll.audience] remove ll.audience
tag @e[tag=ll.audience] remove ll.audience
tag @e[tag=ll.board] remove ll.board
tag @e[tag=ll.current] remove ll.current
tag @s add ll.current
execute as @e[type=minecraft:marker,tag=ll.part] if score @s ct_id = #table ll_ctx run tag @s add ll.board
execute as @e[tag=ll.player,tag=ct.player] if score @s ll_table = #table ll_ctx if score @s ct_id = #table ll_ctx run tag @s add ll.audience
''')
    put('system/reload', '''
tag @s add ll.controller
execute if score @s ct_state matches 0 run return run function love_letter:game/init_table
function love_letter:system/context
function love_letter:game/bump_epoch
function love_letter:visual/refresh
execute as @a[tag=ll.audience] run function love_letter:input/give
function love_letter:hud/refresh
# 保留牌库、备用牌、手牌、当前角色子阶段和结算倒计时，不重新洗牌。
''')
    put('game/bump_epoch', '''
scoreboard players add #epoch_serial ll_ctx 1
execute unless score #epoch_serial ll_ctx matches 10000..999999 run scoreboard players set #epoch_serial ll_ctx 10000
scoreboard players operation @s ll_epoch = #epoch_serial ll_ctx
''')
    put('game/init_table', '''
tag @s add ll.controller
execute unless score @s ll_first_setting matches 0..1 run scoreboard players set @s ll_first_setting 0
execute unless score @s ll_goal_setting matches 0..10 run scoreboard players set @s ll_goal_setting 0
execute unless score @s ll_discards_setting matches 0..1 run scoreboard players set @s ll_discards_setting 1
execute unless score @s ll_time_setting matches 0..120 run scoreboard players set @s ll_time_setting 0
execute if score @s ct_state matches 1 run return 0
scoreboard players set @s ll_state 0
function love_letter:visual/setup
''')
    put('game/start', '''
scoreboard players set @s ct_start 0
execute unless score @s ct_joined matches 2..6 run return run function love_letter:game/bad_count
execute if score @s ct_capacity matches 4 unless score @s ct_joined matches 2..4 run return run function love_letter:game/bad_count
execute unless score @s ct_capacity matches 4 unless score @s ct_capacity matches 8 run return fail
scoreboard players operation #table ll_ctx = @s ct_id
scoreboard players set #occupied ll_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx if items entity @s hotbar.0 * run scoreboard players set #occupied ll_ctx 1
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx if items entity @s hotbar.8 * run scoreboard players set #occupied ll_ctx 1
execute if score #occupied ll_ctx matches 1 run return run function love_letter:game/bad_slots
function love_letter:game/clear
function love_letter:game/init_table
function love_letter:system/context
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run function love_letter:player/join
function love_letter:system/context
scoreboard players set @s ll_players 0
execute as @e[tag=ll.board] run scoreboard players add @e[tag=ll.current,limit=1] ll_players 1
execute unless score @s ll_players matches 2..6 run return run function love_letter:game/start_failed
scoreboard players set @s ll_goal 3
execute if score @s ll_players matches 2 run scoreboard players set @s ll_goal 6
execute if score @s ll_players matches 3 run scoreboard players set @s ll_goal 5
execute if score @s ll_players matches 4 run scoreboard players set @s ll_goal 4
execute if score @s ll_goal_setting matches 1..10 run scoreboard players operation @s ll_goal = @s ll_goal_setting
scoreboard players set @s ll_round 0
scoreboard players set @s ll_tick 0
scoreboard players set @s ll_first 99
execute as @e[tag=ll.board] run scoreboard players operation @e[tag=ll.current,limit=1] ll_first < @s ll_seat
execute if score @s ll_first_setting matches 0 run scoreboard players operation @s ll_first = @e[tag=ll.board,sort=random,limit=1] ll_seat
scoreboard players set @s ct_start 1
function love_letter:game/round_begin
function love_letter:log {text:"情书开局成功，已建立本桌独立牌组与参与者"}
''')
    put('game/start_failed', 'function love_letter:game/clear\nreturn fail')
    put('game/bad_count', '''
scoreboard players operation #table ll_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run tellraw @s {text:"[情书] 需要2～6人；四人桌最多4人。",color:"yellow"}
function love_letter:log {text:"拒绝开局：人数或桌型不符合情书要求"}
return fail
''')
    put('game/bad_slots', '''
execute as @a[tag=ct.player] if score @s ct_id = #table ll_ctx run tellraw @s {text:"[情书] 请先腾空快捷栏第1格与最后一格。",color:"yellow"}
return fail
''')
    put('player/join', '''
tag @s add ll.player
scoreboard players operation @s ll_table = @s ct_id
scoreboard players operation @s ll_seat = @s ct_seat
scoreboard players set @s ll_pick -1
scoreboard players set @s ll_drop 0
scoreboard players operation #join_seat ll_ctx = @s ll_seat
function love_letter:name/resolve
execute as @e[tag=ll.current,limit=1] at @s summon minecraft:marker run function love_letter:game/part
function love_letter:input/give
''')
    put('game/part', '''
tag @s add ll.part
scoreboard players operation @s ct_id = #table ll_ctx
scoreboard players operation @s ll_seat = #join_seat ll_ctx
scoreboard players set @s ll_points 0
scoreboard players set @s ll_matchwin 0
scoreboard players set @s ll_hand -1
scoreboard players set @s ll_extra -1
data modify entity @s data.ll_name set from storage love_letter:name resolved
data modify entity @s data.discards set value []
''')
    put('game/round_begin', '''
function love_letter:system/context
scoreboard players add @s ll_round 1
scoreboard players set @s ll_state 1
scoreboard players set @s ll_timer 3
scoreboard players set @s ll_dealseat 0
scoreboard players set @s ll_dealstage 0
scoreboard players set @s ll_anim 0
scoreboard players set @s ll_timeout 0
function love_letter:game/bump_epoch
function love_letter:engine/start_round
function love_letter:visual/refresh
function love_letter:sound/start
tellraw @a[tag=ll.audience] [{text:"[情书] 第",color:"gold"},{score:{name:"@s",objective:"ll_round"}},{text:"轮开始。"}]
function love_letter:hud/refresh
''')
    put('game/tick', '''
execute if score @s ll_state matches 1 run function love_letter:deal/tick
execute if score @s ll_state matches 2 run function love_letter:game/live_tick
execute if score @s ll_state matches 3..4 run function love_letter:game/result_tick
scoreboard players add @s ll_tick 1
execute if score @s ll_tick matches 20.. run function love_letter:game/maintenance
''')
    put('deal/tick', '''
scoreboard players remove @s ll_timer 1
execute if score @s ll_timer matches 1.. run return 0
execute if score @s ll_dealstage matches 1 run return run function love_letter:game/first_turn
function love_letter:system/context
scoreboard players set #deal_seat ll_ctx 99
scoreboard players operation #last_dealt ll_ctx = @s ll_dealseat
execute as @e[tag=ll.board] if score @s ll_seat > #last_dealt ll_ctx run scoreboard players operation #deal_seat ll_ctx < @s ll_seat
execute if score #deal_seat ll_ctx matches 99 run return run function love_letter:deal/wait
scoreboard players operation @s ll_dealseat = #deal_seat ll_ctx
function love_letter:deal/launch
scoreboard players set @s ll_timer 3
''')
    put('deal/wait', 'scoreboard players set @s ll_dealstage 1\nscoreboard players set @s ll_timer 8')
    put('deal/launch', '''
execute store result storage love_letter:deal seat int 1 run scoreboard players get #deal_seat ll_ctx
execute store result storage love_letter:deal table int 1 run scoreboard players get @s ct_id
function cardtable:animation/deal/spawn_card
function love_letter:deal/configure with storage love_letter:deal
function cardtable:animation/deal/sound
function cardtable:animation/deal/launch with storage love_letter:deal
function love_letter:sound/draw
''')
    put('deal/configure', '''
# 飞行实体仅表示一张牌，不携带真实身份，旁观者也只能看到牌背。
$item replace entity @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] contents with minecraft:paper[minecraft:item_model="card:love_letter/back",minecraft:item_name="情书",minecraft:custom_data={love_letter:{visual:1b,table:$(table)}},minecraft:max_stack_size=1]
tag @e[type=minecraft:item,tag=ct.new_dealt_card,distance=..2,limit=1] add ct.visual_only
''')
    put('game/first_turn', '''
scoreboard players set @s ll_state 2
function love_letter:game/begin_turn
''')
    put('game/begin_turn', '''
function love_letter:system/context
function love_letter:engine/start_turn
function love_letter:game/bump_epoch
scoreboard players set @s ll_anim 8
scoreboard players set @s ll_timeout 0
scoreboard players operation @s ll_clock = @s ll_time_setting
scoreboard players set #twenty ll_ctx 20
scoreboard players operation @s ll_clock *= #twenty ll_ctx
scoreboard players operation #deal_seat ll_ctx = @s ll_turn
function love_letter:deal/launch
function love_letter:visual/refresh
function love_letter:hud/refresh
''')
    put('game/live_tick', '''
execute if score @s ll_anim matches 1.. run return run function love_letter:game/anim_tick
execute if score @s ll_time_setting matches 0 run return 0
execute if score @s ll_clock matches 1.. run scoreboard players remove @s ll_clock 1
execute if score @s ll_clock matches 0 run function love_letter:game/timeout
''')
    put('game/anim_tick', '''
scoreboard players remove @s ll_anim 1
execute if score @s ll_anim matches 0 run function love_letter:ui/refresh
''')
    put('game/timeout', '''
function love_letter:system/context
execute if score @s ll_timeout matches 0 run tellraw @a[tag=ll.audience] {text:"[情书] 行动超时，自动完成当前回合。",color:"yellow"}
scoreboard players set @s ll_timeout 1
function love_letter:engine/auto
''')
    put('game/await_choice', '''
function love_letter:game/bump_epoch
function love_letter:visual/refresh
function love_letter:hud/refresh
execute unless score @s ll_timeout matches 1 run function love_letter:ui/refresh
''')
    put('game/after_action', '''
function love_letter:system/context
function love_letter:game/bump_epoch
function love_letter:game/announce
execute if score @s ll_card matches 4 run function love_letter:sound/seal
execute if score @s ll_card matches 7 if score @s ll_target matches 1..8 run function love_letter:sound/swap
execute if data entity @s data.love_letter.action.eliminated[0] run function love_letter:sound/eliminate
function love_letter:ui/private
function love_letter:visual/event
function love_letter:visual/refresh
function love_letter:engine/check_round
execute if score #over ll_ctx matches 1 run return 0
function love_letter:game/next_turn
''')
    put('game/next_turn', '''
function love_letter:system/context
scoreboard players operation #old_turn ll_ctx = @s ll_turn
scoreboard players set #next ll_ctx 99
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat > #old_turn ll_ctx run scoreboard players operation #next ll_ctx < @s ll_seat
execute if score #next ll_ctx matches 99 as @e[tag=ll.board,scores={ll_alive=1}] run scoreboard players operation #next ll_ctx < @s ll_seat
execute if score #next ll_ctx matches 99 run return run function love_letter:game/abort
scoreboard players operation @s ll_turn = #next ll_ctx
function love_letter:game/begin_turn
''')
    put('game/announce', '''
scoreboard players operation #public_actor ll_ctx = @s ll_actor
scoreboard players operation #public_role ll_ctx = @s ll_card
function love_letter:game/role_name
execute as @e[tag=ll.board] if score @s ll_seat = #public_actor ll_ctx run function love_letter:game/announce_part
function love_letter:sound/play
''')
    put('game/announce_part', '''
tellraw @a[tag=ll.audience] [{text:"[情书] ",color:"gold"},{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" 打出 "},{nbt:"role",storage:"love_letter:runtime",interpret:true},{text:"。"}]
''')
    roles=['间谍','侍卫','牧师','男爵','侍女','王子','大臣','国王','伯爵夫人','公主']
    put('game/role_name', [f'execute if score #public_role ll_ctx matches {i} run data modify storage love_letter:runtime role set value '+json.dumps({'text':f'{i} · {name}','color':'yellow'},ensure_ascii=False,separators=(',',':')) for i,name in enumerate(roles)])
    put('game/round_over', '''
execute if score @s ll_state matches 3..4 run return 0
function love_letter:system/context
function love_letter:engine/score_round
scoreboard players set @s ll_state 3
scoreboard players set @s ll_timer 120
scoreboard players set @s ll_anim 0
scoreboard players set @s ll_clock 0
function love_letter:game/bump_epoch
tellraw @a[tag=ll.audience] {text:"[情书] 本轮结束。",color:"gold"}
execute as @e[tag=ll.board,scores={ll_won=1}] run function love_letter:game/round_winner
execute as @e[tag=ll.board,scores={ll_bonus=1}] run function love_letter:game/spy_winner
execute as @e[tag=ll.board,scores={ll_alive=1}] run function love_letter:game/showdown
scoreboard players operation #goal ll_ctx = @s ll_goal
scoreboard players set @e[tag=ll.board] ll_matchwin 0
execute as @e[tag=ll.board] if score @s ll_points >= #goal ll_ctx run scoreboard players set @s ll_matchwin 1
execute if entity @e[tag=ll.board,scores={ll_matchwin=1}] run function love_letter:game/match_over
execute if score @s ll_state matches 3 run function love_letter:sound/round_win
function love_letter:visual/refresh
function love_letter:hud/refresh
function love_letter:ui/refresh
''')
    put('game/round_winner', 'tellraw @a[tag=ll.audience] [{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" 赢得本轮，好感 +1。",color:"gold"}]')
    put('game/spy_winner', 'tellraw @a[tag=ll.audience] [{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" 获得间谍奖励，好感 +1。",color:"light_purple"}]')
    put('game/showdown', '''
scoreboard players operation #public_role ll_ctx = @s ll_hand
function love_letter:game/role_name
tellraw @a[tag=ll.audience] [{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" 的留牌："},{nbt:"role",storage:"love_letter:runtime",interpret:true}]
''')
    put('game/match_over', '''
execute if score @s ll_state matches 4 run return 0
scoreboard players set @s ll_state 4
scoreboard players set @s ll_timer 120
execute as @e[tag=ll.board,scores={ll_matchwin=1}] run function love_letter:game/match_winner
function love_letter:sound/end
function love_letter:log {text:"情书整场结束，所有达到目标者共同获胜"}
''')
    put('game/match_winner', '''
tellraw @a[tag=ll.audience] [{text:"[情书] 本场胜者：",color:"gold"},{nbt:"data.ll_name",entity:"@s",interpret:true,color:"aqua"},{text:" · "},{score:{name:"@s",objective:"ll_points"}},{text:" 好感。"}]
scoreboard players operation #victory_seat ll_ctx = @s ll_seat
execute as @a[tag=ll.audience] if score @s ll_seat = #victory_seat ll_ctx at @s run function love_letter:game/firework
''')
    put('game/firework', '''
tag @e[type=minecraft:firework_rocket,tag=ll.firework.new] remove ll.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;14442467,16766720,16777215],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["ll.firework","ll.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=ll.firework.new] ct_id = #table ll_ctx
tag @e[type=minecraft:firework_rocket,tag=ll.firework.new] remove ll.firework.new
''')
    put('game/result_tick', '''
scoreboard players remove @s ll_timer 1
execute if score @s ll_timer matches 1.. run return 0
execute if score @s ll_state matches 4 run return run function love_letter:game/cleanup
function love_letter:system/context
scoreboard players operation @s ll_first = @e[tag=ll.board,scores={ll_won=1},sort=random,limit=1] ll_seat
function love_letter:game/round_begin
''')
    put('game/maintenance', '''
scoreboard players set @s ll_tick 0
function love_letter:system/context
scoreboard players set #online ll_ctx 0
execute as @a[tag=ll.audience] run scoreboard players add #online ll_ctx 1
execute unless score #online ll_ctx = @s ll_players run return run function love_letter:game/player_left
function love_letter:hud/refresh
''')
    put('game/resign', '''
function love_letter:system/context
scoreboard players operation #resigning ll_ctx = #actor ll_ctx
function love_letter:engine/resign
execute unless score #ok ll_ctx matches 1 run return 0
function love_letter:sound/eliminate
function love_letter:game/bump_epoch
function love_letter:visual/refresh
function love_letter:engine/check_round
execute if score #over ll_ctx matches 1 run return 0
execute if score #resigning ll_ctx = @s ll_turn run return run function love_letter:game/next_turn
execute if score #resume ll_ctx matches 1 run return run function love_letter:game/next_turn
function love_letter:hud/refresh
function love_letter:ui/refresh
''')
    put('game/abort', '''
execute unless entity @s[tag=ll.controller] run return 0
function love_letter:system/context
tellraw @a[tag=ll.audience] {text:"[情书] 本场已中止。",color:"yellow"}
function love_letter:game/cleanup
''')
    put('game/end_vote', 'function love_letter:game/abort')
    put('game/player_left', '''
function love_letter:system/context
tellraw @a[tag=ll.audience] {text:"[情书] 有参与者离开牌桌，本场中止。",color:"yellow"}
function love_letter:game/cleanup
''')
    put('game/cleanup', '''
scoreboard players set @s ll_state 0
function love_letter:game/clear
function cardtable:game/return_lobby
function love_letter:game/init_table
''')
    put('game/remove', 'function love_letter:game/clear')
    put('game/clear', '''
function love_letter:system/context
scoreboard players set @s ll_state 0
scoreboard players set @s ll_phase 0
scoreboard players set @s ll_timer 0
scoreboard players set @s ll_clock 0
scoreboard players set @s ll_anim 0
function love_letter:visual/clear
function cardtable:animation/deal/clear
execute as @a[tag=ll.player] if score @s ll_table = #table ll_ctx run function love_letter:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{love_letter:{tool:1b}}] run function love_letter:player/kill_drop
execute as @e[type=minecraft:firework_rocket,tag=ll.firework] if score @s ct_id = #table ll_ctx run kill @s
kill @e[tag=ll.board]
data remove entity @s data.love_letter
data remove entity @s data.ll_private
data remove entity @s data.ll_buffer
tag @s remove ll.controller
tag @s remove ll.current
''')
    put('player/kill_drop', '''
execute store result score #drop_table ll_ctx run data get entity @s Item.components."minecraft:custom_data".love_letter.table
execute if score #drop_table ll_ctx = #table ll_ctx run kill @s
''')
    put('player/clear_state', '''
function love_letter:hud/deactivate
function love_letter:input/clear
function love_letter:settings/clear_session
clear @s *[minecraft:custom_data~{love_letter:{tool:1b}}]
execute if entity @s[tag=ll.player] run dialog clear @s
tag @s remove ll.player
tag @s remove ll.audience
tag @s remove ll.actor
scoreboard players reset @s ll_table
scoreboard players reset @s ll_seat
scoreboard players reset @s ll_action
scoreboard players reset @s ll_seen
scoreboard players reset @s ll_pick
scoreboard players set @s ll_drop 0
''')
    put('admin/abort', '''
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[情书] 同维度8格内没有进行中的情书。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function love_letter:game/abort
''')
    put('log', '$tellraw @a[tag=ct.debug] [{text:"[情书] ",color:"gold"},{text:"$(text)",color:"gray"}]')
    print('Generated Love Letter lifecycle (game 17).')


if __name__ == '__main__':
    build()
