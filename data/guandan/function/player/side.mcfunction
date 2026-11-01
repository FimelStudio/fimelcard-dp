scoreboard players operation @s gd_order = @s ct_seat
scoreboard players remove @s gd_order 1
execute if score #cap gd_ctx matches 8 run scoreboard players operation @s gd_order /= #two gd_ctx
