"""情书 21 牌版纯规则引擎；marker 保存手牌，控制器保存牌库与阶段。"""
from pathlib import Path

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/love_letter/function'
COUNTS = [2, 6, 2, 2, 2, 2, 2, 1, 1, 1]


def build(root=ROOT):
    def put(name, lines):
        p = root / (name + '.mcfunction')
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip()+'\n', encoding='utf-8')

    put('engine/start_round', '''
# 仅初始化新一轮；累计好感保留。首位 0 随机，非 0 为实际座号。
function love_letter:system/context
data modify entity @s data.love_letter set value {deck:[],reserve:-1,public:[],action:{}}
data modify entity @s data.ll_private set value {}
data modify entity @s data.ll_buffer set value []
scoreboard players set @e[tag=ll.board] ll_alive 1
scoreboard players set @e[tag=ll.board] ll_hand -1
scoreboard players set @e[tag=ll.board] ll_extra -1
scoreboard players set @e[tag=ll.board] ll_protect 0
scoreboard players set @e[tag=ll.board] ll_spy 0
scoreboard players set @e[tag=ll.board] ll_won 0
scoreboard players set @e[tag=ll.board] ll_bonus 0
execute as @e[tag=ll.board] run data modify entity @s data.discards set value []
scoreboard players set @s ll_scored 0
scoreboard players set @s ll_phase 1
scoreboard players set @s ll_actor 0
scoreboard players set @s ll_card -1
scoreboard players set @s ll_target 0
scoreboard players set @s ll_guess -1
scoreboard players set #players ll_ctx 0
execute as @e[tag=ll.board] run scoreboard players add #players ll_ctx 1
data modify storage love_letter:runtime shuffle set value []
'''+f'data modify storage love_letter:runtime pool set value {[r for r,n in enumerate(COUNTS) for _ in range(n)]}\n'+'''
scoreboard players set #left ll_ctx 21
function love_letter:engine/shuffle
data modify entity @s data.love_letter.deck set from storage love_letter:runtime shuffle
function love_letter:engine/draw
execute store result entity @s data.love_letter.reserve int 1 run scoreboard players get #draw ll_ctx
execute if score #players ll_ctx matches 2 run function love_letter:engine/public_three
execute as @e[tag=ll.board] run function love_letter:engine/deal_one
scoreboard players operation @s ll_turn = @s ll_first
scoreboard players operation #candidate ll_ctx = @s ll_first
scoreboard players set #valid ll_ctx 0
execute as @e[tag=ll.board] if score @s ll_seat = #candidate ll_ctx run scoreboard players set #valid ll_ctx 1
execute unless score #valid ll_ctx matches 1 store result score @s ll_turn run scoreboard players get @e[tag=ll.board,sort=random,limit=1] ll_seat
''')
    put('engine/shuffle', '''
execute unless score #left ll_ctx matches 1.. run return 0
scoreboard players operation #upper ll_ctx = #left ll_ctx
scoreboard players remove #upper ll_ctx 1
execute store result storage love_letter:runtime rng.upper int 1 run scoreboard players get #upper ll_ctx
function love_letter:engine/random_index with storage love_letter:runtime rng
execute store result storage love_letter:runtime rng.index int 1 run scoreboard players get #index ll_ctx
function love_letter:engine/shuffle_take with storage love_letter:runtime rng
scoreboard players remove #left ll_ctx 1
execute if score #left ll_ctx matches 1.. run function love_letter:engine/shuffle
''')
    put('engine/random_index', '$execute store result score #index ll_ctx run random value 0..$(upper)')
    put('engine/shuffle_take', '''
$data modify storage love_letter:runtime shuffle append from storage love_letter:runtime pool[$(index)]
$data remove storage love_letter:runtime pool[$(index)]
''')
    put('engine/draw', '''
# 普通牌库顶为 [0]；备用牌永远不在此函数自动补入。
scoreboard players set #draw ll_ctx -1
execute unless data entity @e[tag=ll.current,limit=1] data.love_letter.deck[0] run return 0
execute store result score #draw ll_ctx run data get entity @e[tag=ll.current,limit=1] data.love_letter.deck[0]
data remove entity @e[tag=ll.current,limit=1] data.love_letter.deck[0]
''')
    put('engine/public_three', ['function love_letter:engine/public_one']*3)
    put('engine/public_one', '''
function love_letter:engine/draw
execute store result storage love_letter:runtime card int 1 run scoreboard players get #draw ll_ctx
data modify entity @s data.love_letter.public append from storage love_letter:runtime card
''')
    put('engine/deal_one', '''
function love_letter:engine/draw
scoreboard players operation @s ll_hand = #draw ll_ctx
''')
    put('engine/start_turn', '''
function love_letter:system/context
tag @e[tag=ll.engine_actor] remove ll.engine_actor
scoreboard players operation #actor ll_ctx = @s ll_turn
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run tag @s add ll.engine_actor
execute unless entity @e[tag=ll.engine_actor] run return 0
scoreboard players set @e[tag=ll.engine_actor] ll_protect 0
function love_letter:engine/draw
scoreboard players operation @e[tag=ll.engine_actor,limit=1] ll_extra = #draw ll_ctx
scoreboard players set @s ll_phase 1
scoreboard players set @s ll_actor 0
scoreboard players set @s ll_target 0
data modify entity @s data.ll_private set value {}
data modify entity @s data.ll_buffer set value []
''')
    put('engine/validate', '''
# 只读验证，失败不消耗手牌、牌库或阶段。
scoreboard players set #ok ll_ctx 0
scoreboard players set #error ll_ctx 1
function love_letter:system/context
tag @e[tag=ll.engine_actor] remove ll.engine_actor
tag @e[tag=ll.engine_target] remove ll.engine_target
execute unless score @s ll_state matches 2 run return 0
execute unless score @s ll_anim matches 0 run return 0
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run tag @s add ll.engine_actor
execute unless entity @e[tag=ll.engine_actor] run return 0
scoreboard players set #valid ll_ctx 1
''')
    put('engine/play', '''
scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
execute unless score @s ll_phase matches 1 run return 0
execute unless score @s ll_turn = #actor ll_ctx run return 0
execute unless score #slot ll_ctx matches 0..1 run return 0
scoreboard players operation #hand ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_hand
scoreboard players operation #extra ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_extra
execute unless score #hand ll_ctx matches 0..9 run return 0
execute unless score #extra ll_ctx matches 0..9 run return 0
scoreboard players operation #card ll_ctx = #hand ll_ctx
scoreboard players operation #other ll_ctx = #extra ll_ctx
execute if score #slot ll_ctx matches 1 run scoreboard players operation #card ll_ctx = #extra ll_ctx
execute if score #slot ll_ctx matches 1 run scoreboard players operation #other ll_ctx = #hand ll_ctx
scoreboard players set #forced ll_ctx 0
execute if score #hand ll_ctx matches 8 if score #extra ll_ctx matches 5 run scoreboard players set #forced ll_ctx 1
execute if score #hand ll_ctx matches 8 if score #extra ll_ctx matches 7 run scoreboard players set #forced ll_ctx 1
execute if score #extra ll_ctx matches 8 if score #hand ll_ctx matches 5 run scoreboard players set #forced ll_ctx 1
execute if score #extra ll_ctx matches 8 if score #hand ll_ctx matches 7 run scoreboard players set #forced ll_ctx 1
scoreboard players set #error ll_ctx 2
execute if score #forced ll_ctx matches 1 unless score #card ll_ctx matches 8 run return 0
data modify entity @s data.love_letter.action set value {actor:0,card:0,target:0,guess:-1,eliminated:[],forced:-1}
execute store result entity @s data.love_letter.action.actor int 1 run scoreboard players get #actor ll_ctx
execute store result entity @s data.love_letter.action.card int 1 run scoreboard players get #card ll_ctx
data modify entity @s data.ll_private set value {}
data modify entity @s data.ll_buffer set value []
scoreboard players operation @s ll_actor = #actor ll_ctx
scoreboard players operation @s ll_card = #card ll_ctx
scoreboard players set @s ll_target 0
scoreboard players set @s ll_guess -1
scoreboard players operation @e[tag=ll.engine_actor,limit=1] ll_hand = #other ll_ctx
scoreboard players set @e[tag=ll.engine_actor] ll_extra -1
scoreboard players operation #discard ll_ctx = #card ll_ctx
execute as @e[tag=ll.engine_actor] run function love_letter:engine/discard
function love_letter:engine/dispatch
scoreboard players set #ok ll_ctx 1
scoreboard players set #error ll_ctx 0
''')
    put('engine/discard', '''
# 执行者为参与者；弃牌只记公开牌与间谍，不触发该角色技能。
execute unless score #discard ll_ctx matches 0..9 run return 0
execute store result storage love_letter:runtime card int 1 run scoreboard players get #discard ll_ctx
data modify entity @s data.discards append from storage love_letter:runtime card
execute if score #discard ll_ctx matches 0 run scoreboard players set @s ll_spy 1
''')
    put('engine/dispatch', '''
execute if score @s ll_card matches 4 run scoreboard players set @e[tag=ll.engine_actor] ll_protect 1
execute if score @s ll_card matches 9 as @e[tag=ll.engine_actor] run function love_letter:engine/eliminate
execute if score @s ll_card matches 6 run return run function love_letter:engine/chancellor
execute if score @s ll_card matches 1..3 run return run function love_letter:engine/need_target
execute if score @s ll_card matches 5 run return run function love_letter:engine/need_target
execute if score @s ll_card matches 7 run return run function love_letter:engine/need_target
function love_letter:engine/done
''')
    put('engine/targets', '''
tag @e[tag=ll.legal] remove ll.legal
scoreboard players operation #owner ll_ctx = @s ll_actor
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] unless score @s ll_seat = #owner ll_ctx run tag @s add ll.legal
execute if score @s ll_card matches 5 as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] run tag @s add ll.legal
''')
    put('engine/need_target', '''
function love_letter:engine/targets
execute unless entity @e[tag=ll.legal] run return run function love_letter:engine/done
scoreboard players set @s ll_phase 2
function love_letter:game/await_choice
''')
    put('engine/target', '''
scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
execute unless score @s ll_phase matches 2 run return 0
execute unless score @s ll_actor = #actor ll_ctx run return 0
function love_letter:engine/targets
execute as @e[tag=ll.legal] if score @s ll_seat = #target ll_ctx run tag @s add ll.engine_target
execute unless entity @e[tag=ll.engine_target] run return 0
scoreboard players operation @s ll_target = #target ll_ctx
execute store result entity @s data.love_letter.action.target int 1 run scoreboard players get #target ll_ctx
execute if score @s ll_card matches 1 run function love_letter:engine/need_guess
execute if score @s ll_card matches 2 run function love_letter:engine/priest
execute if score @s ll_card matches 3 run function love_letter:engine/baron
execute if score @s ll_card matches 5 run function love_letter:engine/prince
execute if score @s ll_card matches 7 run function love_letter:engine/king
scoreboard players set #ok ll_ctx 1
scoreboard players set #error ll_ctx 0
''')
    put('engine/need_guess', '''
scoreboard players set @s ll_phase 3
function love_letter:game/await_choice
''')
    put('engine/guess', '''
scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
execute unless score @s ll_phase matches 3 run return 0
execute unless score @s ll_actor = #actor ll_ctx run return 0
execute unless score #guess ll_ctx matches 0..9 run return 0
execute if score #guess ll_ctx matches 1 run return 0
scoreboard players operation #target ll_ctx = @s ll_target
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] if score @s ll_seat = #target ll_ctx run tag @s add ll.engine_target
execute unless entity @e[tag=ll.engine_target] run return 0
scoreboard players operation @s ll_guess = #guess ll_ctx
execute store result entity @s data.love_letter.action.guess int 1 run scoreboard players get #guess ll_ctx
execute as @e[tag=ll.engine_target] if score @s ll_hand = #guess ll_ctx run function love_letter:engine/eliminate
function love_letter:engine/done
scoreboard players set #ok ll_ctx 1
scoreboard players set #error ll_ctx 0
''')
    put('engine/private', '''
data modify entity @s data.ll_private set value {kind:"",seat:0,target:0,actor_card:-1,target_card:-1}
execute store result entity @s data.ll_private.seat int 1 run scoreboard players get @s ll_actor
execute store result entity @s data.ll_private.target int 1 run scoreboard players get @s ll_target
execute store result entity @s data.ll_private.actor_card int 1 run scoreboard players get @e[tag=ll.engine_actor,limit=1] ll_hand
execute store result entity @s data.ll_private.target_card int 1 run scoreboard players get @e[tag=ll.engine_target,limit=1] ll_hand
''')
    put('engine/priest', '''
function love_letter:engine/private
data modify entity @s data.ll_private.kind set value "priest"
function love_letter:engine/done
''')
    put('engine/baron', '''
function love_letter:engine/private
data modify entity @s data.ll_private.kind set value "baron"
scoreboard players operation #a ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_hand
scoreboard players operation #b ll_ctx = @e[tag=ll.engine_target,limit=1] ll_hand
execute if score #a ll_ctx < #b ll_ctx as @e[tag=ll.engine_actor] run function love_letter:engine/eliminate
execute if score #b ll_ctx < #a ll_ctx as @e[tag=ll.engine_target] run function love_letter:engine/eliminate
function love_letter:engine/done
''')
    put('engine/prince', '''
scoreboard players operation #discard ll_ctx = @e[tag=ll.engine_target,limit=1] ll_hand
scoreboard players operation #prince_card ll_ctx = #discard ll_ctx
execute store result entity @s data.love_letter.action.forced int 1 run scoreboard players get #discard ll_ctx
execute as @e[tag=ll.engine_target] run function love_letter:engine/discard
scoreboard players set @e[tag=ll.engine_target] ll_hand -1
execute if score #prince_card ll_ctx matches 9 as @e[tag=ll.engine_target] run function love_letter:engine/eliminate
execute if score #prince_card ll_ctx matches 9 run return run function love_letter:engine/done
function love_letter:engine/draw
execute if score #draw ll_ctx matches -1 run function love_letter:engine/reserve
scoreboard players operation @e[tag=ll.engine_target,limit=1] ll_hand = #draw ll_ctx
function love_letter:engine/done
''')
    put('engine/reserve', '''
execute store result score #draw ll_ctx run data get entity @s data.love_letter.reserve
data modify entity @s data.love_letter.reserve set value -1
''')
    put('engine/king', '''
function love_letter:engine/private
data modify entity @s data.ll_private.kind set value "king"
scoreboard players operation #swap ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_hand
scoreboard players operation @e[tag=ll.engine_actor,limit=1] ll_hand = @e[tag=ll.engine_target,limit=1] ll_hand
scoreboard players operation @e[tag=ll.engine_target,limit=1] ll_hand = #swap ll_ctx
function love_letter:engine/done
''')
    put('engine/eliminate', '''
# 淘汰公开弃掉剩余牌；公主、间谍等弃牌均不发动技能。
execute unless score @s ll_alive matches 1 run return 0
scoreboard players set @s ll_alive 0
scoreboard players operation #discard ll_ctx = @s ll_hand
function love_letter:engine/discard
scoreboard players operation #discard ll_ctx = @s ll_extra
function love_letter:engine/discard
scoreboard players set @s ll_hand -1
scoreboard players set @s ll_extra -1
scoreboard players set @s ll_protect 0
execute store result storage love_letter:runtime seat int 1 run scoreboard players get @s ll_seat
data modify entity @e[tag=ll.current,limit=1] data.love_letter.action.eliminated append from storage love_letter:runtime seat
''')
    put('engine/chancellor', '''
execute unless data entity @s data.love_letter.deck[0] run return run function love_letter:engine/done
data modify entity @s data.ll_buffer set value []
execute store result storage love_letter:runtime card int 1 run scoreboard players get @e[tag=ll.engine_actor,limit=1] ll_hand
data modify entity @s data.ll_buffer append from storage love_letter:runtime card
function love_letter:engine/buffer_draw
execute if data entity @s data.love_letter.deck[0] run function love_letter:engine/buffer_draw
scoreboard players set @s ll_phase 4
function love_letter:game/await_choice
''')
    put('engine/buffer_draw', '''
function love_letter:engine/draw
execute store result storage love_letter:runtime card int 1 run scoreboard players get #draw ll_ctx
data modify entity @s data.ll_buffer append from storage love_letter:runtime card
''')
    put('engine/keep', '''
scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
execute unless score @s ll_phase matches 4 run return 0
execute unless score @s ll_actor = #actor ll_ctx run return 0
execute store result score #length ll_ctx run data get entity @s data.ll_buffer
execute unless score #keep ll_ctx matches 0..2 run return 0
execute unless score #keep ll_ctx < #length ll_ctx run return 0
execute store result storage love_letter:runtime choice.index int 1 run scoreboard players get #keep ll_ctx
function love_letter:engine/keep_index with storage love_letter:runtime choice
execute if data entity @s data.ll_buffer[1] run scoreboard players set @s ll_phase 5
execute if data entity @s data.ll_buffer[1] run function love_letter:game/await_choice
execute unless data entity @s data.ll_buffer[1] run function love_letter:engine/return_buffer
scoreboard players set #ok ll_ctx 1
scoreboard players set #error ll_ctx 0
''')
    put('engine/keep_index', '''
$execute store result score @e[tag=ll.engine_actor,limit=1] ll_hand run data get entity @s data.ll_buffer[$(index)]
$data remove entity @s data.ll_buffer[$(index)]
''')
    put('engine/bottom', '''
scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
execute unless score @s ll_phase matches 5 run return 0
execute unless score @s ll_actor = #actor ll_ctx run return 0
execute store result score #length ll_ctx run data get entity @s data.ll_buffer
execute unless score #bottom ll_ctx matches 0..1 run return 0
execute unless score #bottom ll_ctx < #length ll_ctx run return 0
execute store result storage love_letter:runtime choice.index int 1 run scoreboard players get #bottom ll_ctx
function love_letter:engine/bottom_index with storage love_letter:runtime choice
function love_letter:engine/return_buffer
scoreboard players set #ok ll_ctx 1
scoreboard players set #error ll_ctx 0
''')
    put('engine/bottom_index', '''
$data modify entity @s data.love_letter.deck append from entity @s data.ll_buffer[$(index)]
$data remove entity @s data.ll_buffer[$(index)]
''')
    put('engine/return_buffer', '''
execute if data entity @s data.ll_buffer[0] run data modify entity @s data.love_letter.deck append from entity @s data.ll_buffer[0]
data modify entity @s data.ll_buffer set value []
function love_letter:engine/done
''')
    put('engine/done', '''
# 完整角色结算才交给局面层推进；防旧窗口重放。
scoreboard players set @s ll_phase 0
function love_letter:game/after_action
''')
    put('engine/check_round', '''
function love_letter:system/context
scoreboard players set #over ll_ctx 0
execute if score @s ll_phase matches 6 run scoreboard players set #over ll_ctx 1
execute if score @s ll_phase matches 6 run return 1
scoreboard players set @s ll_alive_n 0
execute as @e[tag=ll.board,scores={ll_alive=1}] run scoreboard players add @e[tag=ll.current,limit=1] ll_alive_n 1
execute if score @s ll_alive_n matches ..1 run scoreboard players set #over ll_ctx 1
execute if score #over ll_ctx matches 1 if score @s ll_phase matches 4..5 run function love_letter:engine/resign_buffer
execute if score #over ll_ctx matches 0 if score @s ll_phase matches 2..5 run return 0
execute unless data entity @s data.love_letter.deck[0] run scoreboard players set #over ll_ctx 1
execute unless score #over ll_ctx matches 1 run return 0
scoreboard players set @s ll_phase 6
function love_letter:game/round_over
scoreboard players set #over ll_ctx 1
''')
    put('engine/score_round', '''
function love_letter:system/context
execute if score @s ll_scored matches 1 run return 0
scoreboard players set @s ll_scored 1
scoreboard players set @e[tag=ll.board] ll_won 0
scoreboard players set @e[tag=ll.board] ll_bonus 0
scoreboard players set @s ll_high -1
execute as @e[tag=ll.board,scores={ll_alive=1}] run scoreboard players operation @e[tag=ll.current,limit=1] ll_high > @s ll_hand
scoreboard players operation #high ll_ctx = @s ll_high
scoreboard players set @s ll_winners 0
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_hand = #high ll_ctx run function love_letter:engine/award
scoreboard players set #spies ll_ctx 0
execute as @e[tag=ll.board,scores={ll_alive=1,ll_spy=1}] run scoreboard players add #spies ll_ctx 1
execute if score #spies ll_ctx matches 1 as @e[tag=ll.board,scores={ll_alive=1,ll_spy=1}] run function love_letter:engine/spy_bonus
''')
    put('engine/award', '''
scoreboard players set @s ll_won 1
scoreboard players add @s ll_points 1
scoreboard players add @e[tag=ll.current,limit=1] ll_winners 1
''')
    put('engine/spy_bonus', '''
scoreboard players set @s ll_bonus 1
scoreboard players add @s ll_points 1
''')
    put('engine/resign', '''
scoreboard players set #valid ll_ctx 0
scoreboard players set #resume ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
# 大臣抽出的牌先全部归回牌库，再弃手牌，避免认输吞牌。
execute if score @s ll_actor = #actor ll_ctx if score @s ll_phase matches 4..5 run function love_letter:engine/resign_buffer
execute if score @s ll_turn = #actor ll_ctx run data modify entity @s data.love_letter.action set value {actor:0,card:-1,target:0,guess:-1,eliminated:[],forced:-1}
execute if score @s ll_turn = #actor ll_ctx store result entity @s data.love_letter.action.actor int 1 run scoreboard players get #actor ll_ctx
execute as @e[tag=ll.engine_actor] run function love_letter:engine/eliminate
execute if score @s ll_phase matches 3 if score @s ll_target = #actor ll_ctx run scoreboard players set #resume ll_ctx 1
execute if score @s ll_phase matches 2 run function love_letter:engine/targets
execute if score @s ll_phase matches 2 unless entity @e[tag=ll.legal] run scoreboard players set #resume ll_ctx 1
execute if score #resume ll_ctx matches 1 run scoreboard players set @s ll_phase 0
execute if score @s ll_actor = #actor ll_ctx run scoreboard players set @s ll_phase 0
execute if score @s ll_turn = #actor ll_ctx run scoreboard players set @s ll_phase 0
data modify entity @s data.ll_private set value {}
scoreboard players set #ok ll_ctx 1
scoreboard players set #error ll_ctx 0
''')
    put('engine/resign_buffer', '''
# phase4 buffer[0] 是已有手牌的影像；它只能弃一次。phase5 已移除留牌，余下全归底。
execute if score @s ll_phase matches 4 run data remove entity @s data.ll_buffer[0]
execute if data entity @s data.ll_buffer[0] run data modify entity @s data.love_letter.deck append from entity @s data.ll_buffer[0]
execute if data entity @s data.ll_buffer[1] run data modify entity @s data.love_letter.deck append from entity @s data.ll_buffer[1]
data modify entity @s data.ll_buffer set value []
''')
    put('engine/auto', '''
execute unless score @s ll_state matches 2 run return 0
execute unless score @s ll_anim matches 0 run return 0
execute if score @s ll_phase matches 1 run return run function love_letter:engine/auto_play
execute if score @s ll_phase matches 2 run return run function love_letter:engine/auto_target
execute if score @s ll_phase matches 3 run return run function love_letter:engine/auto_guess
execute if score @s ll_phase matches 4 run return run function love_letter:engine/auto_keep
execute if score @s ll_phase matches 5 run return run function love_letter:engine/auto_bottom
''')
    put('engine/auto_play', '''
function love_letter:system/context
scoreboard players operation #actor ll_ctx = @s ll_turn
scoreboard players set #slot ll_ctx 0
scoreboard players set #auto_hand ll_ctx -1
scoreboard players set #auto_extra ll_ctx -1
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #auto_hand ll_ctx = @s ll_hand
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run scoreboard players operation #auto_extra ll_ctx = @s ll_extra
execute if score #auto_extra ll_ctx matches 8 if score #auto_hand ll_ctx matches 5 run scoreboard players set #slot ll_ctx 1
execute if score #auto_extra ll_ctx matches 8 if score #auto_hand ll_ctx matches 7 run scoreboard players set #slot ll_ctx 1
function love_letter:engine/play
''')
    put('engine/auto_target', '''
scoreboard players operation #actor ll_ctx = @s ll_actor
scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
function love_letter:engine/targets
execute unless entity @e[tag=ll.legal] run return run function love_letter:engine/done
scoreboard players operation #target ll_ctx = @e[tag=ll.legal,sort=random,limit=1] ll_seat
function love_letter:engine/target
''')
    put('engine/auto_guess', '''
scoreboard players operation #actor ll_ctx = @s ll_actor
execute store result score #guess ll_ctx run random value 0..8
execute if score #guess ll_ctx matches 1.. run scoreboard players add #guess ll_ctx 1
function love_letter:engine/guess
''')
    put('engine/auto_keep', '''
scoreboard players operation #actor ll_ctx = @s ll_actor
scoreboard players set #keep ll_ctx 0
execute store result score #best ll_ctx run data get entity @s data.ll_buffer[0]
execute store result score #choice ll_ctx run data get entity @s data.ll_buffer[1]
execute if score #choice ll_ctx > #best ll_ctx run scoreboard players set #keep ll_ctx 1
execute if score #choice ll_ctx > #best ll_ctx run scoreboard players operation #best ll_ctx = #choice ll_ctx
execute if data entity @s data.ll_buffer[2] store result score #choice ll_ctx run data get entity @s data.ll_buffer[2]
execute if data entity @s data.ll_buffer[2] if score #choice ll_ctx > #best ll_ctx run scoreboard players set #keep ll_ctx 2
function love_letter:engine/keep
''')
    put('engine/auto_bottom', '''
scoreboard players operation #actor ll_ctx = @s ll_actor
scoreboard players set #bottom ll_ctx 0
function love_letter:engine/bottom
''')


if __name__ == '__main__':
    build()
    print('情书规则引擎已生成。')
