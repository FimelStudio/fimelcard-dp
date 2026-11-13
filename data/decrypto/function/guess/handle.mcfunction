scoreboard players operation #guess_command dc_ctx = @s dc_action
scoreboard players set @s dc_action 0
scoreboard players set #guess_hundred dc_ctx 100
scoreboard players operation #guess_serial dc_ctx = #guess_command dc_ctx
scoreboard players operation #guess_serial dc_ctx /= #guess_hundred dc_ctx
execute unless score #guess_serial dc_ctx = @s dc_gserial run return 0
function decrypto:guess/bind
execute unless score #guess_phase dc_ctx matches 5..8 run return 0
execute unless score #guess_phase dc_ctx = @s dc_gp run return 0
execute unless score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_round = @s dc_gr run return 0
scoreboard players operation #guess_command dc_ctx %= #guess_hundred dc_ctx
execute if score #guess_command dc_ctx matches 91 run return run dialog clear @s
execute if score #guess_command dc_ctx matches 90 run return run function decrypto:guess/confirm
execute if score #guess_command dc_ctx matches 11..14 run scoreboard players operation @s dc_g1 = #guess_command dc_ctx
execute if score #guess_command dc_ctx matches 11..14 run scoreboard players remove @s dc_g1 10
execute if score #guess_command dc_ctx matches 21..24 run scoreboard players operation @s dc_g2 = #guess_command dc_ctx
execute if score #guess_command dc_ctx matches 21..24 run scoreboard players remove @s dc_g2 20
execute if score #guess_command dc_ctx matches 31..34 run scoreboard players operation @s dc_g3 = #guess_command dc_ctx
execute if score #guess_command dc_ctx matches 31..34 run scoreboard players remove @s dc_g3 30
scoreboard players set #guess_invalid dc_ctx 0
function decrypto:guess/render
