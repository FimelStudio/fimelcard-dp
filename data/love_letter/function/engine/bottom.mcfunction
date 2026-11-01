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
