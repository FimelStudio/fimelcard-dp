scoreboard players set #guess_phase dc_ctx 0
execute unless score @s dc_id = @s ct_id run return 0
scoreboard players operation #phase dc_ctx = @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_state
execute unless score #phase dc_ctx matches 5..8 run return 0
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_sync matches 1 run return run function decrypto:guess/sync_phase
function decrypto:player/can_input
execute if score #authorized dc_ctx matches 1 run scoreboard players operation #guess_phase dc_ctx = #phase dc_ctx
