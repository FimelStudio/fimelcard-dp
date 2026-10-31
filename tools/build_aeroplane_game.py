"""生成飞行棋：持久骰值、逐段移动、四方生命周期和电脑补位。"""
from pathlib import Path
import json

ROOT=Path(__file__).resolve().parents[1]/'data/aeroplane_chess/function'
def put(name,lines):
    p=ROOT/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n',encoding='utf-8')
def say(text,color='yellow',target='@a[tag=ac.audience]'):
    return 'tellraw '+target+' '+json.dumps({'text':'[飞行棋] '+text,'color':color},ensure_ascii=False)

def build():
    from build_aeroplane_engine import build as engine
    from build_aeroplane_settings import build as settings
    from build_aeroplane_ui import build as ui
    engine();settings();ui()
    fields='state turn roll timer epoch color plane pos prev legal active bot rank players ranked finished winner sixes selected frompos topos kind land wait pulse table seat seen ui_load ui_tmp set_table setnonce setepoch nonce takeoff extra triple jump fly finish palette orient first speed hints fill ranking assign'.split()
    put('system/install',[f'scoreboard objectives add ac_{v} dummy' for v in fields]+['scoreboard objectives add ac_action trigger','scoreboard objectives add ac_settings trigger','scoreboard objectives add ac_drop minecraft.dropped:minecraft.paper','scoreboard players set #version ac_ctx 2'])
    put('load','''
scoreboard objectives add ac_ctx dummy
execute unless score #version ac_ctx matches 1.. run function aeroplane_chess:system/install
execute if score #version ac_ctx matches 1 run function aeroplane_chess:system/upgrade_v2
scoreboard players set #four ac_ctx 4
scoreboard players set #thirteen ac_ctx 13
scoreboard players set #fiftytwo ac_ctx 52
scoreboard players set #hundred ac_ctx 100
execute unless score #setting_serial ac_ctx matches 10000..99999 run scoreboard players set #setting_serial ac_ctx 9999
scoreboard players add #ui_load ac_ctx 1
scoreboard players reset * ac_action
scoreboard players reset * ac_settings
scoreboard players reset * ac_setnonce
function aeroplane_chess:visual/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15}] run scoreboard players set @s ac_palette 0
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15}] at @s run function aeroplane_chess:system/reload
''')
    put('system/upgrade_v2','''
# 兼容制作期间已加载过旧版的存档；保留骰值、移动队列与名次。
scoreboard objectives add ac_finished dummy
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15}] at @s run function aeroplane_chess:system/count_finished
scoreboard players set #version ac_ctx 2
''')
    put('system/count_finished','''
function aeroplane_chess:system/context
scoreboard players set @s ac_finished 0
execute as @e[tag=ac.sides,scores={ac_rank=1..4}] run scoreboard players add @e[tag=ac.current,limit=1] ac_finished 1
''')
    put('system/context','''
scoreboard players operation #table ac_ctx = @s ct_id
tag @e[tag=ac.current] remove ac.current
tag @e[tag=ac.board] remove ac.board
tag @e[tag=ac.sides] remove ac.sides
tag @e[tag=ac.audience] remove ac.audience
tag @a[tag=ac.audience] remove ac.audience
tag @s add ac.current
execute as @e[type=minecraft:marker,tag=ac.plane] if score @s ct_id = #table ac_ctx run tag @s add ac.board
execute as @e[type=minecraft:marker,tag=ac.side] if score @s ct_id = #table ac_ctx run tag @s add ac.sides
execute as @e[tag=ac.player,tag=ct.player] if score @s ac_table = #table ac_ctx if score @s ct_id = #table ac_ctx run tag @s add ac.audience
''')
    defaults={'takeoff':(0,2,0),'extra':(0,1,1),'triple':(0,1,0),'jump':(0,1,1),'fly':(0,1,1),'finish':(0,1,0),'palette':(0,0,0),'orient':(0,1,0),'first':(0,4,0),'speed':(0,1,0),'hints':(0,1,1),'fill':(0,2,0),'ranking':(0,1,0),'assign':(0,1,0)}
    put('game/init_table',['tag @s add ac.controller']+[f'execute unless score @s ac_{k} matches {lo}..{hi} run scoreboard players set @s ac_{k} {d}' for k,(lo,hi,d) in defaults.items()]+['execute unless score @s ac_epoch matches 1.. run scoreboard players set @s ac_epoch 1','execute if score @s ct_state matches 0 run function aeroplane_chess:game/preview'])
    put('game/preview','''
execute unless score @s ct_game matches 15 run return 0
execute unless score @s ct_state matches 0 run return 0
function aeroplane_chess:system/context
execute if data entity @s data.aeroplane_chess{review:1b} run return run function aeroplane_chess:visual/refresh
scoreboard players set @s ac_state 0
scoreboard players set @s ac_turn 0
scoreboard players set @s ac_roll 1
scoreboard players set @s ac_selected -1
scoreboard players add @s ac_epoch 1
function aeroplane_chess:visual/clear
function aeroplane_chess:engine/init_board
function aeroplane_chess:visual/setup
''')
    put('system/reload','''
tag @s add ac.controller
execute if score @s ct_state matches 0 run return run function aeroplane_chess:game/init_table
function aeroplane_chess:system/context
scoreboard players add @s ac_epoch 1
# 已确定的骰值、移动队列和阶段保留；只重建模型，绝不重新 random。
function aeroplane_chess:game/reseat
function aeroplane_chess:visual/refresh
execute if score @s ac_state matches 2 run function aeroplane_chess:visual/roll_tick
execute if score @s ac_state matches 4 run function aeroplane_chess:visual/move
execute as @a[tag=ac.audience] run function aeroplane_chess:input/give
function aeroplane_chess:ui/refresh
''')
    put('game/start',[
        'function aeroplane_chess:game/init_table',
        'execute unless score @s ct_joined matches 1..4 run '+say('支持 1～4 位玩家；单人开局需开启电脑补位。','red','@a[tag=ct.start_actor,limit=1]'),
        'execute unless score @s ct_joined matches 1..4 run return fail',
        'execute if score @s ct_joined matches 1 if score @s ac_fill matches 2 run '+say('电脑补位已关闭，请至少两位玩家入座，或在设置中开启电脑。','red','@a[tag=ct.start_actor,limit=1]'),
        'execute if score @s ct_joined matches 1 if score @s ac_fill matches 2 run return fail',
        'function aeroplane_chess:system/context','scoreboard players set #online ac_ctx 0','scoreboard players set #blocked ac_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ac_ctx run scoreboard players add #online ac_ctx 1',
        *[f'execute as @a[tag=ct.player] if score @s ct_id = #table ac_ctx if items entity @s hotbar.{slot} * unless items entity @s hotbar.{slot} minecraft:paper[minecraft:custom_data~{{aeroplane_chess:{{tool:1b}}}}] run scoreboard players set #blocked ac_ctx 1' for slot in (0,8)],
        'execute unless score #online ac_ctx = @s ct_joined run return fail',
        'execute if score #blocked ac_ctx matches 1 run '+say('请先清空快捷栏第 1 格和最后一格。','red','@a[tag=ct.start_actor,limit=1]'),
        'execute if score #blocked ac_ctx matches 1 run return fail',
        'function aeroplane_chess:settings/invalidate_table','function aeroplane_chess:engine/init_board',
        'scoreboard players set @e[tag=ac.sides] ac_active 0','scoreboard players set @e[tag=ac.sides] ac_bot 0',
        'scoreboard players set @s ac_players 0', 'scoreboard players set @s ac_ranked 0','scoreboard players set @s ac_finished 0','scoreboard players set @s ac_winner -1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ac_ctx run function aeroplane_chess:player/init',
        'function aeroplane_chess:system/context','function aeroplane_chess:game/fill_bots','function aeroplane_chess:game/sync_active','function aeroplane_chess:game/reseat',
        'data remove entity @s data.aeroplane_chess.review','data remove entity @s data.aeroplane_chess.queue',
        'scoreboard players set @s ac_state 1','scoreboard players set @s ac_sixes 0','scoreboard players set @s ac_selected -1','scoreboard players set @s ac_wait 10','scoreboard players set @s ac_pulse 0',
        'scoreboard players add @s ac_epoch 1','function aeroplane_chess:game/first_turn',
        'function aeroplane_chess:visual/setup','execute as @a[tag=ac.audience] run function aeroplane_chess:input/give',
        'scoreboard players set @s ct_start 1','function aeroplane_chess:ui/refresh','function aeroplane_chess:sound/start',say('对局开始。第 1 格按 Q 投骰，骰子停稳后右键飞机。')])
    put('player/init','''
tag @s add ac.player
scoreboard players operation @s ac_table = @s ct_id
scoreboard players operation @s ac_seat = @s ct_seat
scoreboard players set @s ac_seen -1
function aeroplane_chess:player/seat_color
execute if score @e[tag=ac.current,limit=1] ac_assign matches 1 run scoreboard players operation #wanted ac_ctx = @e[tag=ac.sides,scores={ac_active=0},sort=random,limit=1] ac_color
scoreboard players set #claimed ac_ctx 0
function aeroplane_chess:player/claim
execute if score #claimed ac_ctx matches 0 run function aeroplane_chess:player/next_claim
execute if score #claimed ac_ctx matches 0 run function aeroplane_chess:player/next_claim
execute if score #claimed ac_ctx matches 0 run function aeroplane_chess:player/next_claim
scoreboard players operation @s ac_color = #wanted ac_ctx
scoreboard players add @e[tag=ac.current,limit=1] ac_players 1
''')
    put('player/claim','''
execute as @e[tag=ac.sides,scores={ac_active=0}] if score @s ac_color = #wanted ac_ctx run scoreboard players set #claimed ac_ctx 1
execute if score #claimed ac_ctx matches 1 as @e[tag=ac.sides] if score @s ac_color = #wanted ac_ctx run scoreboard players set @s ac_active 1
''')
    put('player/next_claim','''
scoreboard players add #wanted ac_ctx 1
scoreboard players operation #wanted ac_ctx %= #four ac_ctx
function aeroplane_chess:player/claim
''')
    # Base color seats: red south, blue west, green north, yellow east.
    seatlines=['scoreboard players set #wanted ac_ctx 0']
    for cap,groups in [(4,[(3,3),(4,4),(1,1),(2,2)]),(8,[(5,6),(7,8),(1,2),(3,4)])]:
        for c,(lo,hi) in enumerate(groups):
            for o in (0,1):
                # orient1 rotates red south -> west, so observed west maps red.
                color=(c-o)%4
                seatlines.append(f'execute if score @e[tag=ac.current,limit=1] ct_capacity matches {cap} if score @e[tag=ac.current,limit=1] ac_orient matches {o} if score @s ct_seat matches {lo}..{hi} run scoreboard players set #wanted ac_ctx {color}')
    put('player/seat_color',seatlines)
    put('game/fill_bots','''
execute if score @s ac_players matches 1 if score @s ac_fill matches 0..1 run function aeroplane_chess:game/add_opposite
execute if score @s ac_fill matches 1 as @e[tag=ac.sides,scores={ac_active=0}] run function aeroplane_chess:game/add_bot
''')
    put('game/add_opposite','''
scoreboard players set #wanted ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1}] run scoreboard players operation #wanted ac_ctx = @s ac_color
scoreboard players add #wanted ac_ctx 2
scoreboard players operation #wanted ac_ctx %= #four ac_ctx
execute as @e[tag=ac.sides] if score @s ac_color = #wanted ac_ctx run function aeroplane_chess:game/add_bot
''')
    put('game/add_bot','''
scoreboard players set @s ac_active 1
scoreboard players set @s ac_bot 1
scoreboard players add @e[tag=ac.current,limit=1] ac_players 1
''')
    put('game/sync_active',[f'execute as @e[tag=ac.board,scores={{ac_color={c}}}] run scoreboard players operation @s ac_active = @e[tag=ac.sides,scores={{ac_color={c}}},limit=1] ac_active' for c in range(4)])
    reseat=['function aeroplane_chess:system/context','execute as @a[tag=ac.audience] run ride @s dismount','execute as @a[tag=ac.audience] run function aeroplane_chess:player/place_color','function cardtable:table/ensure_seats','execute as @a[tag=ac.audience] at @s run function cardtable:seat/mount']
    put('game/reseat',reseat)
    places=[]
    for cap,seats in [(4,[3,4,1,2]),(8,[5,7,1,3])]:
        for o in (0,1):
            for c in range(4):
                seat=seats[(c+o)%4]
                places.append(f'execute if score @e[tag=ac.current,limit=1] ct_capacity matches {cap} if score @e[tag=ac.current,limit=1] ac_orient matches {o} if score @s ac_color matches {c} run scoreboard players set @s ct_seat {seat}')
    places+=['scoreboard players operation @s ac_seat = @s ct_seat']
    put('player/place_color',places)
    put('game/first_turn','''
execute if score @s ac_first matches 0 run scoreboard players operation @s ac_turn = @e[tag=ac.sides,scores={ac_active=1,ac_rank=0},sort=random,limit=1] ac_color
execute if score @s ac_first matches 1..4 run scoreboard players operation @s ac_turn = @s ac_first
execute if score @s ac_first matches 1..4 run scoreboard players remove @s ac_turn 1
function aeroplane_chess:game/ensure_turn
''')
    put('game/ensure_turn','''
scoreboard players set #turn_ok ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn run scoreboard players set #turn_ok ac_ctx 1
execute if score #turn_ok ac_ctx matches 0 run scoreboard players add @s ac_turn 1
execute if score #turn_ok ac_ctx matches 0 run scoreboard players operation @s ac_turn %= #four ac_ctx
execute if score #turn_ok ac_ctx matches 0 run function aeroplane_chess:game/ensure_turn
''')
    put('game/actor_guard','''
function aeroplane_chess:system/context
scoreboard players set #actor_ok ac_ctx 0
execute as @e[tag=ac.actor,tag=ac.audience,limit=1] if score @s ac_table = #table ac_ctx run scoreboard players set #actor_ok ac_ctx 1
''')
    put('game/roll','''
function aeroplane_chess:game/actor_guard
execute unless score #actor_ok ac_ctx matches 1 run return 0
execute unless score @e[tag=ac.actor,limit=1] ac_color = @s ac_turn run return 0
function aeroplane_chess:game/roll_internal
''')
    put('game/roll_internal','''
execute unless score @s ac_state matches 1 run return 0
# 唯一一次随机发生在锁状态后，重载和动画回调不得再次投骰。
scoreboard players set @s ac_state 2
scoreboard players add @s ac_epoch 1
execute store result score @s ac_roll run random value 1..6
scoreboard players set @s ac_timer 20
execute if score @s ac_speed matches 1 run scoreboard players set @s ac_timer 12
function aeroplane_chess:log {text:"投骰已锁定结果，开始播放动画"}
function aeroplane_chess:sound/dice_roll
function aeroplane_chess:visual/roll_tick
function aeroplane_chess:ui/refresh
''')
    put('game/dice_tick','''
scoreboard players remove @s ac_timer 1
function aeroplane_chess:visual/roll_tick
execute if score @s ac_timer matches ..0 run function aeroplane_chess:game/dice_done
''')
    put('game/dice_done','''
function aeroplane_chess:system/context
function aeroplane_chess:visual/roll_done
function aeroplane_chess:sound/dice_land
execute store result storage aeroplane_chess:runtime rolled.dice int 1 run scoreboard players get @s ac_roll
function aeroplane_chess:ui/color_name
data modify storage aeroplane_chess:runtime rolled.color set from storage aeroplane_chess:ui color
function aeroplane_chess:game/announce_roll with storage aeroplane_chess:runtime rolled
execute if score @s ac_roll matches 6 run scoreboard players add @s ac_sixes 1
execute unless score @s ac_roll matches 6 run scoreboard players set @s ac_sixes 0
execute if score @s ac_triple matches 1 if score @s ac_sixes matches 3.. run return run function aeroplane_chess:game/triple_six
scoreboard players set @s ac_state 3
scoreboard players set @s ac_wait 10
function aeroplane_chess:engine/legal_planes
execute if score #available ac_ctx matches 0 run return run function aeroplane_chess:game/no_moves
scoreboard players add @s ac_epoch 1
function aeroplane_chess:ui/refresh
''')
    put('game/announce_roll','$tellraw @a[tag=ac.audience] [{text:"[飞行棋] ",color:"gold"},{text:"$(color)方掷出 $(dice) 点。",color:"yellow"}]')
    put('game/triple_six',[say('连续第三次 6，本次不行动并结束回合。前两次移动保留。'),'scoreboard players set @s ac_sixes 0','function aeroplane_chess:game/next_turn'])
    put('game/no_moves',[say('没有可以移动的飞机。'),'function aeroplane_chess:game/action_done'])
    put('game/choose','''
function aeroplane_chess:game/actor_guard
execute unless score #actor_ok ac_ctx matches 1 run return 0
execute unless score @e[tag=ac.actor,limit=1] ac_color = @s ac_turn run return 0
function aeroplane_chess:game/choose_internal
''')
    put('game/choose_internal','''
execute unless score @s ac_state matches 3 run return 0
execute unless score #plane ac_ctx matches 0..3 run return 0
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players operation @s ac_selected = #plane ac_ctx
function aeroplane_chess:engine/plan
execute unless score #legal ac_ctx matches 1 run return run function aeroplane_chess:sound/illegal
data modify entity @s data.aeroplane_chess.queue set from storage aeroplane_chess:runtime plan.queue
scoreboard players set @s ac_state 4
scoreboard players add @s ac_epoch 1
function aeroplane_chess:log {text:"选机合法，提交持久移动队列"}
scoreboard players set @e[tag=ac.board] ac_legal 0
function aeroplane_chess:visual/select
function aeroplane_chess:game/segment_begin
function aeroplane_chess:ui/refresh
''')
    put('game/segment_begin','''
tag @e[tag=ac.captured] remove ac.captured
execute unless data entity @s data.aeroplane_chess.queue[0] run return run function aeroplane_chess:game/move_done
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players operation #plane ac_ctx = @s ac_selected
execute as @e[tag=ac.board] if score @s ac_color = #color ac_ctx if score @s ac_plane = #plane ac_ctx run scoreboard players operation @e[tag=ac.current,limit=1] ac_frompos = @s ac_pos
execute store result score @s ac_topos run data get entity @s data.aeroplane_chess.queue[0].pos
execute store result score @s ac_kind run data get entity @s data.aeroplane_chess.queue[0].kind
execute store result score @s ac_land run data get entity @s data.aeroplane_chess.queue[0].land
scoreboard players set @s ac_timer 4
execute if score @s ac_speed matches 1 run scoreboard players set @s ac_timer 2
execute if score @s ac_kind matches 1 run function aeroplane_chess:sound/takeoff
execute if score @s ac_kind matches 2 run function aeroplane_chess:sound/jump
execute if score @s ac_kind matches 3 run function aeroplane_chess:sound/fly
execute if score @s ac_kind matches 0 run function aeroplane_chess:sound/move
function aeroplane_chess:visual/move
''')
    put('game/move_tick','''
scoreboard players remove @s ac_timer 1
function aeroplane_chess:visual/move_tick
execute if score @s ac_timer matches ..0 run function aeroplane_chess:game/segment_done
''')
    put('game/segment_done','''
function aeroplane_chess:system/context
function aeroplane_chess:visual/finish_move
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players operation #plane ac_ctx = @s ac_selected
execute as @e[tag=ac.board] if score @s ac_color = #color ac_ctx if score @s ac_plane = #plane ac_ctx run scoreboard players operation @s ac_pos = @e[tag=ac.current,limit=1] ac_topos
execute if score @s ac_land matches 1 run function aeroplane_chess:engine/land
data remove entity @s data.aeroplane_chess.queue[0]
execute if entity @e[tag=ac.board,tag=ac.captured] run return run function aeroplane_chess:game/capture_wait
function aeroplane_chess:game/segment_begin
''')
    put('game/capture_wait','''
# 给客户端六刻插值返航；此阶段不接收重复投骰或选机，也不重建模型。
scoreboard players set @s ac_state 6
scoreboard players set @s ac_timer 6
''')
    put('game/capture_tick','''
scoreboard players remove @s ac_timer 1
execute if score @s ac_timer matches 1.. run return 0
scoreboard players set @s ac_state 4
function aeroplane_chess:game/segment_begin
''')
    put('game/move_done','''
function aeroplane_chess:visual/refresh
execute if score @s ac_topos matches 57 run function aeroplane_chess:sound/home
scoreboard players set #home ac_ctx 0
scoreboard players operation #color ac_ctx = @s ac_turn
execute as @e[tag=ac.board,scores={ac_pos=57}] if score @s ac_color = #color ac_ctx run scoreboard players add #home ac_ctx 1
execute if score #home ac_ctx matches 4 run function aeroplane_chess:game/rank_side
execute if score @s ac_state matches 5 run return 0
function aeroplane_chess:game/action_done
''')
    put('game/rank_side','''
scoreboard players add @s ac_ranked 1
scoreboard players add @s ac_finished 1
execute as @e[tag=ac.sides] if score @s ac_color = #color ac_ctx run scoreboard players operation @s ac_rank = @e[tag=ac.current,limit=1] ac_finished
execute if score @s ac_winner matches -1 run scoreboard players operation @s ac_winner = @s ac_turn
execute store result storage aeroplane_chess:runtime rank.rank int 1 run scoreboard players get @s ac_finished
function aeroplane_chess:game/announce_rank with storage aeroplane_chess:runtime rank
function aeroplane_chess:game/firework
scoreboard players operation #remaining ac_ctx = @s ac_players
scoreboard players operation #remaining ac_ctx -= @s ac_ranked
execute if score @s ac_ranking matches 0 run return run function aeroplane_chess:game/finish
execute if score #remaining ac_ctx matches ..1 run return run function aeroplane_chess:game/last_side
scoreboard players set @s ac_sixes 0
''')
    put('game/announce_rank','$tellraw @a[tag=ac.audience] {text:"[飞行棋] 本方四架飞机全部抵达，获得第 $(rank) 名！",color:"gold"}')
    put('game/action_done','''
execute if score @s ac_extra matches 1 if score @s ac_roll matches 6 if score @s ac_sixes matches 1..2 run return run function aeroplane_chess:game/extra_turn
execute if score @s ac_extra matches 1 if score @s ac_roll matches 6 if score @s ac_triple matches 0 run return run function aeroplane_chess:game/extra_turn
function aeroplane_chess:game/next_turn
''')
    put('game/extra_turn','''
# 已完成排名的颜色不能因六点再次行动。
scoreboard players set #rank ac_ctx 0
execute as @e[tag=ac.sides] if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn run scoreboard players operation #rank ac_ctx = @s ac_rank
execute unless score #rank ac_ctx matches 0 run return run function aeroplane_chess:game/next_turn
scoreboard players set @s ac_state 1
scoreboard players set @s ac_wait 10
scoreboard players add @s ac_epoch 1
function aeroplane_chess:ui/refresh
''')
    put('game/next_turn','''
scoreboard players set @s ac_state 1
scoreboard players set @s ac_sixes 0
scoreboard players set @s ac_selected -1
scoreboard players set @s ac_wait 10
scoreboard players add @s ac_turn 1
scoreboard players operation @s ac_turn %= #four ac_ctx
function aeroplane_chess:game/ensure_turn
scoreboard players add @s ac_epoch 1
function aeroplane_chess:ui/refresh
''')
    put('tick','''
function aeroplane_chess:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15},tag=!ac.controller] at @s run function aeroplane_chess:game/init_table
execute as @e[type=minecraft:marker,tag=ac.controller,scores={ct_game=15}] at @s run function aeroplane_chess:system/tick
''')
    put('system/tick','''
function aeroplane_chess:system/context
# 同一刻只执行起始阶段，骰子落稳或段落切换不重复推进。
scoreboard players operation #tick_state ac_ctx = @s ac_state
execute if score #tick_state ac_ctx matches 2 run function aeroplane_chess:game/dice_tick
execute if score #tick_state ac_ctx matches 4 run function aeroplane_chess:game/move_tick
execute if score #tick_state ac_ctx matches 5 run function aeroplane_chess:game/result_tick
execute if score #tick_state ac_ctx matches 6 run function aeroplane_chess:game/capture_tick
execute if score #tick_state ac_ctx matches 1 run function aeroplane_chess:ai/tick
execute if score #tick_state ac_ctx matches 3 run function aeroplane_chess:ai/tick
scoreboard players add @s ac_pulse 1
execute if score @s ac_pulse matches 20.. run function aeroplane_chess:system/heartbeat
''')
    put('system/heartbeat','''
scoreboard players set @s ac_pulse 0
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online ac_ctx 0
execute as @a[tag=ac.audience] run scoreboard players add #online ac_ctx 1
scoreboard players set #expected ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_bot=0,ac_rank=0}] run scoreboard players add #expected ac_ctx 1
scoreboard players set #online_active ac_ctx 0
execute as @a[tag=ac.audience] run function aeroplane_chess:player/count_active
execute unless score #online_active ac_ctx = #expected ac_ctx run function aeroplane_chess:game/abort
execute if score @s ct_state matches 1 run function aeroplane_chess:ui/board_status
''')
    put('player/count_active','''
scoreboard players operation #color ac_ctx = @s ac_color
execute as @e[tag=ac.sides,scores={ac_active=1,ac_bot=0,ac_rank=0}] if score @s ac_color = #color ac_ctx run scoreboard players add #online_active ac_ctx 1
''')
    put('ai/tick','''
scoreboard players set #bot ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn run scoreboard players operation #bot ac_ctx = @s ac_bot
execute unless score #bot ac_ctx matches 1 run return 0
scoreboard players remove @s ac_wait 1
execute if score @s ac_wait matches 1.. run return 0
execute if score @s ac_state matches 1 run return run function aeroplane_chess:game/roll_internal
execute if score @s ac_state matches 3 run function aeroplane_chess:ai/choose
''')
    put('ai/choose',['scoreboard players set #best ac_ctx -9999','scoreboard players set #bestplane ac_ctx -1','scoreboard players operation #color ac_ctx = @s ac_turn']+
        [f'function aeroplane_chess:ai/candidate {{plane:{p}}}' for p in range(4)]+[
        'execute unless score #bestplane ac_ctx matches 0..3 run return run function aeroplane_chess:game/no_moves','scoreboard players operation #plane ac_ctx = #bestplane ac_ctx','function aeroplane_chess:game/choose_internal'])
    put('ai/candidate','''
$scoreboard players set #plane ac_ctx $(plane)
function aeroplane_chess:engine/plan
execute unless score #legal ac_ctx matches 1 run return 0
scoreboard players operation #value ac_ctx = #dest ac_ctx
execute if score #dest ac_ctx matches 0 run scoreboard players add #value ac_ctx 35
execute if score #dest ac_ctx matches 57 run scoreboard players add #value ac_ctx 1000
execute if score #dest ac_ctx matches 1..51 run function aeroplane_chess:ai/captures
execute if score #dest ac_ctx matches 1..51 run function aeroplane_chess:ai/risk
execute if score #value ac_ctx > #best ac_ctx run scoreboard players operation #bestplane ac_ctx = #plane ac_ctx
execute if score #value ac_ctx > #best ac_ctx run scoreboard players operation #best ac_ctx = #value ac_ctx
''')
    put('ai/captures','''
scoreboard players operation #landing ac_ctx = #color ac_ctx
scoreboard players operation #landing ac_ctx *= #thirteen ac_ctx
scoreboard players operation #landing ac_ctx += #dest ac_ctx
scoreboard players remove #landing ac_ctx 1
scoreboard players operation #landing ac_ctx %= #fiftytwo ac_ctx
execute as @e[tag=ac.board,scores={ac_pos=1..51}] unless score @s ac_color = #color ac_ctx run function aeroplane_chess:ai/capture_value
''')
    put('ai/capture_value','''
scoreboard players operation #enemy ac_ctx = @s ac_color
scoreboard players operation #enemy ac_ctx *= #thirteen ac_ctx
scoreboard players operation #enemy ac_ctx += @s ac_pos
scoreboard players remove #enemy ac_ctx 1
scoreboard players operation #enemy ac_ctx %= #fiftytwo ac_ctx
execute if score #enemy ac_ctx = #landing ac_ctx run scoreboard players add #value ac_ctx 180
''')
    put('ai/risk','''
# 基础启发式：离对方前方六格的外环落点容易被下一次掷骰追上。
# 不另抽骰，不改真实棋面；捕获收益仍优先于轻量风险扣分。
execute as @e[tag=ac.board,scores={ac_pos=1..51,ac_active=1}] unless score @s ac_color = #color ac_ctx run function aeroplane_chess:ai/risk_one
''')
    put('ai/risk_one','''
scoreboard players operation #enemy ac_ctx = @s ac_color
scoreboard players operation #enemy ac_ctx *= #thirteen ac_ctx
scoreboard players operation #enemy ac_ctx += @s ac_pos
scoreboard players remove #enemy ac_ctx 1
scoreboard players operation #enemy ac_ctx %= #fiftytwo ac_ctx
scoreboard players operation #gap ac_ctx = #landing ac_ctx
scoreboard players operation #gap ac_ctx -= #enemy ac_ctx
scoreboard players operation #gap ac_ctx += #fiftytwo ac_ctx
scoreboard players operation #gap ac_ctx %= #fiftytwo ac_ctx
execute if score #gap ac_ctx matches 1..6 run scoreboard players remove #value ac_ctx 12
''')
    put('game/resign',[
        'function aeroplane_chess:game/actor_guard','execute unless score #actor_ok ac_ctx matches 1 run return 0','execute if score @s ac_state matches 0 run return 0','execute if score @s ac_state matches 5 run return 0',
        'scoreboard players operation #resigning ac_ctx = @e[tag=ac.actor,limit=1] ac_color',
        'scoreboard players set #rank ac_ctx -1',
        'execute as @e[tag=ac.sides] if score @s ac_color = #resigning ac_ctx run scoreboard players operation #rank ac_ctx = @s ac_rank',
        'execute unless score #rank ac_ctx matches 0 run return 0',
        'execute as @e[tag=ac.sides] if score @s ac_color = #resigning ac_ctx run scoreboard players set @s ac_rank 99',
        'scoreboard players add @s ac_ranked 1',say('一方已认输退出本局。'),
        'scoreboard players operation #remaining ac_ctx = @s ac_players','scoreboard players operation #remaining ac_ctx -= @s ac_ranked',
        'execute if score #remaining ac_ctx matches ..1 run return run function aeroplane_chess:game/last_side',
        'execute if score #resigning ac_ctx = @s ac_turn run data remove entity @s data.aeroplane_chess.queue',
        'execute if score #resigning ac_ctx = @s ac_turn run function aeroplane_chess:game/next_turn'])
    put('game/last_side','''
scoreboard players set #new_winner ac_ctx 0
execute if score @s ac_winner matches -1 run scoreboard players set #new_winner ac_ctx 1
execute if score @s ac_winner matches -1 as @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] run scoreboard players operation @e[tag=ac.current,limit=1] ac_winner = @s ac_color
execute if score #new_winner ac_ctx matches 1 run scoreboard players operation #winning ac_ctx = @s ac_winner
execute if score #new_winner ac_ctx matches 1 run function aeroplane_chess:game/firework_color
scoreboard players operation #last_rank ac_ctx = @s ac_finished
scoreboard players add #last_rank ac_ctx 1
scoreboard players operation @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] ac_rank = #last_rank ac_ctx
function aeroplane_chess:game/finish
''')
    put('game/finish',[
        'execute if score @s ac_state matches 5 run return 0','function aeroplane_chess:system/context','scoreboard players set @s ac_state 5','scoreboard players set @s ac_timer 100','scoreboard players add @s ac_epoch 1','scoreboard players set @e[tag=ac.board] ac_legal 0','function aeroplane_chess:visual/refresh','function aeroplane_chess:visual/select','function aeroplane_chess:sound/end','function aeroplane_chess:log {text:"对局结算，保留终局棋面"}',say('本局结束，5 秒后返回大厅。'), 'function aeroplane_chess:ui/refresh'])
    # Winner position follows actual player's seat. Firework preset API is resolved from builtin below.
    firework=['function aeroplane_chess:system/context','scoreboard players operation #winning ac_ctx = @s ac_turn','function aeroplane_chess:game/firework_color']
    put('game/firework',firework)
    put('game/firework_color','''
function aeroplane_chess:system/context
execute as @a[tag=ac.audience] if score @s ac_color = #winning ac_ctx at @s run function aeroplane_chess:game/firework_player
scoreboard players set #bot_winner ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_bot=1}] if score @s ac_color = #winning ac_ctx run scoreboard players set #bot_winner ac_ctx 1
execute if score #bot_winner ac_ctx matches 1 run function aeroplane_chess:game/firework_bot
''')
    bot_firework=[]
    anchors={4:[(0,2),(-2,0),(0,-2),(2,0)],8:[(1,2.5),(-2.5,1),(-1,-2.5),(2.5,-1)]}
    for cap in (4,8):
        for orient in (0,1):
            for color in range(4):
                x,z=anchors[cap][(color+orient)%4]
                bot_firework.append(f'execute if score @s ct_capacity matches {cap} if score @s ac_orient matches {orient} if score #winning ac_ctx matches {color} positioned ~{x} ~0.32 ~{z} run function aeroplane_chess:game/firework_player')
    put('game/firework_bot',bot_firework)
    put('game/firework_player','''
tag @e[type=minecraft:firework_rocket,tag=ac.firework.new] remove ac.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16733525,16777045,5635925,5592575],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["ac.firework","ac.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=ac.firework.new] ct_id = #table ac_ctx
tag @e[type=minecraft:firework_rocket,tag=ac.firework.new] remove ac.firework.new
''')
    put('game/result_tick','''
scoreboard players remove @s ac_timer 1
execute if score @s ac_timer matches ..0 run function aeroplane_chess:game/cleanup
''')
    put('player/clear_state','''
function aeroplane_chess:input/clear
scoreboard players reset @s ac_table
scoreboard players reset @s ac_color
scoreboard players reset @s ac_seat
tag @s remove ac.player
tag @s remove ac.audience
''')
    put('game/cleanup','''
function aeroplane_chess:system/context
scoreboard players set @s ac_state 0
scoreboard players set @e[tag=ac.board] ac_legal 0
scoreboard players add @s ac_epoch 1
data modify entity @s data.aeroplane_chess.review set value 1b
data remove entity @s data.aeroplane_chess.queue
function aeroplane_chess:visual/refresh
title @a[tag=ac.audience] actionbar {text:""}
execute as @a[tag=ac.player] if score @s ac_table = #table ac_ctx run function aeroplane_chess:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}] run function aeroplane_chess:player/kill_drop
function cardtable:game/return_lobby
''')
    put('player/kill_drop','''
execute store result score #drop_table ac_ctx run data get entity @s Item.components."minecraft:custom_data".aeroplane_chess.table
execute if score #drop_table ac_ctx = #table ac_ctx run kill @s
''')
    put('game/remove','''
function aeroplane_chess:settings/invalidate_table
function aeroplane_chess:system/context
execute as @a[tag=ac.player] if score @s ac_table = #table ac_ctx run function aeroplane_chess:player/clear_state
function aeroplane_chess:visual/clear
kill @e[tag=ac.board]
kill @e[tag=ac.sides]
data remove entity @s data.aeroplane_chess
data remove entity @s data.aeroplane_visual
tag @s remove ac.controller
tag @s remove ac.current
scoreboard players set @s ac_state 0
''')
    put('game/abort',['execute unless entity @s[tag=ac.controller] run return fail','function aeroplane_chess:system/context',say('本场已中止。'),'function aeroplane_chess:game/cleanup'])
    put('game/end_vote',['execute unless entity @s[tag=ac.controller] run return fail','function aeroplane_chess:system/context',say('结束投票通过。'),'function aeroplane_chess:game/cleanup'])
    put('game/player_left','function aeroplane_chess:game/abort')
    put('log','$tellraw @a[tag=ct.debug] [{text:"[飞行棋] ",color:"gold"},{text:"$(text)",color:"gray"}]')
    put('admin/abort','''
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[飞行棋] 同维度 8 格内没有进行中的飞行棋。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function aeroplane_chess:game/abort
''')
    print('Generated aeroplane lifecycle and engine')

if __name__=='__main__':build()
