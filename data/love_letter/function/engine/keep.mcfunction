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
