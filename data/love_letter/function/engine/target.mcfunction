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
