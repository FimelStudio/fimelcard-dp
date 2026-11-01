scoreboard players operation #actor ll_ctx = @s ll_actor
scoreboard players set #keep ll_ctx 0
execute store result score #best ll_ctx run data get entity @s data.ll_buffer[0]
execute store result score #choice ll_ctx run data get entity @s data.ll_buffer[1]
execute if score #choice ll_ctx > #best ll_ctx run scoreboard players set #keep ll_ctx 1
execute if score #choice ll_ctx > #best ll_ctx run scoreboard players operation #best ll_ctx = #choice ll_ctx
execute if data entity @s data.ll_buffer[2] store result score #choice ll_ctx run data get entity @s data.ll_buffer[2]
execute if data entity @s data.ll_buffer[2] if score #choice ll_ctx > #best ll_ctx run scoreboard players set #keep ll_ctx 2
function love_letter:engine/keep
