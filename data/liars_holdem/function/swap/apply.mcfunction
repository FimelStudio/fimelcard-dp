# 当前执行者是提交选择的玩家
scoreboard players operation #swap_choice lh_ctx = @s lh_swap_pick
scoreboard players set @s lh_swap_pick 0
execute unless score #swap_choice lh_ctx matches 1..3 run return fail
execute unless entity @s[tag=lh.player,scores={lh_alive=1,lh_fold=0,lh_swap_pending=1}] run return fail

scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players operation #swap_seat lh_ctx = @s lh_seat
scoreboard players operation #old_slot lh_ctx = @s lh_swap_slot
tag @s add lh.swap_actor
tag @e[tag=lh.action_controller] remove lh.action_controller
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=5}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_turn = #swap_seat lh_ctx run tag @s add lh.action_controller
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=7}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_turn = #swap_seat lh_ctx run tag @s add lh.action_controller
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=9}] if score @s lh_id = #ctx_id lh_ctx if score @s lh_turn = #swap_seat lh_ctx run tag @s add lh.action_controller
execute unless entity @e[tag=lh.action_controller,limit=1] run dialog clear @s
execute unless entity @e[tag=lh.action_controller,limit=1] run scoreboard players set @s lh_swap_pending 0
execute unless entity @e[tag=lh.action_controller,limit=1] run tag @s remove lh.swap_actor
execute unless entity @e[tag=lh.action_controller,limit=1] run return fail

tag @e[tag=lh.swap_choice] remove lh.swap_choice
execute as @e[tag=lh.swap_candidate] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx if score @s lh_slot = #swap_choice lh_ctx run tag @s add lh.swap_choice
execute unless entity @e[tag=lh.swap_choice,limit=1] run return run function liars_holdem:swap/fail
scoreboard players operation @s lh_card = @e[tag=lh.swap_choice,limit=1] lh_card
scoreboard players operation @s lh_rank = @e[tag=lh.swap_choice,limit=1] lh_rank
scoreboard players operation @s lh_suit = @e[tag=lh.swap_choice,limit=1] lh_suit

tag @e[tag=lh.old_hand] remove lh.old_hand
execute as @e[type=minecraft:marker,tag=lh.hand_card] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx if score @s lh_slot = #old_slot lh_ctx run tag @s add lh.old_hand
scoreboard players operation @e[tag=lh.old_hand,limit=1] lh_card = @s lh_card
scoreboard players operation @e[tag=lh.old_hand,limit=1] lh_rank = @s lh_rank
scoreboard players operation @e[tag=lh.old_hand,limit=1] lh_suit = @s lh_suit

function liars_holdem:card/load_definition
execute store result storage liars_holdem:card slot int 1 run scoreboard players get @s lh_swap_slot
execute store result storage liars_holdem:card table int 1 run scoreboard players get @s lh_id

data modify storage liars_holdem:card def.table set from storage liars_holdem:card table
data modify storage liars_holdem:card def.slot set from storage liars_holdem:card slot
function liars_holdem:swap/give_item with storage liars_holdem:card def
data remove storage liars_holdem:card def.table
data remove storage liars_holdem:card def.slot

# 被选与未被选的三张候选全部进入弃牌区，当前局不再返回牌库
execute as @e[tag=lh.swap_candidate] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx run kill @s
tag @e[tag=lh.old_hand] remove lh.old_hand
tag @e[tag=lh.swap_choice] remove lh.swap_choice
scoreboard players set @s lh_swap_pending 0
dialog clear @s
function liars_holdem:sound/swap_complete
tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'换牌完成；你仍需选择跟注、ALL IN或弃牌。',color:'green'}]
execute as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:log {text:"当前玩家完成三选一换牌"}
tag @e[tag=lh.action_controller] remove lh.action_controller
tag @s remove lh.swap_actor
