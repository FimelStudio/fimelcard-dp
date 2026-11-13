scoreboard players operation #count_seat gd_ctx = @s gd_seat
scoreboard players set #owned gd_ctx 0
execute as @e[tag=gd.cards] if score @s gd_owner = #count_seat gd_ctx run scoreboard players add #owned gd_ctx 1
scoreboard players operation @s gd_count = #owned gd_ctx
