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
