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
