scoreboard players set #hint dc_ctx 1
execute if score @s dc_role matches 0 run scoreboard players set #hint dc_ctx 2
function decrypto:guess/phase
execute if score #guess_phase dc_ctx matches 5 run scoreboard players set #hint dc_ctx 6
execute if score #guess_phase dc_ctx matches 7 run scoreboard players set #hint dc_ctx 6
execute if score #guess_phase dc_ctx matches 6 run scoreboard players set #hint dc_ctx 5
execute if score #guess_phase dc_ctx matches 8 run scoreboard players set #hint dc_ctx 5
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_state matches 2 if score @s dc_encoder matches 1 run function decrypto:hint/encoder
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_state matches 4 if score @s dc_encoder matches 1 run function decrypto:hint/encoder
execute unless score @s dc_hint = #hint dc_ctx run scoreboard players set #hint_changed dc_ctx 1
scoreboard players operation @s dc_hint = #hint dc_ctx
