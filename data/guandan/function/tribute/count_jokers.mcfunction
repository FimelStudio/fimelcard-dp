scoreboard players operation #donor gd_ctx = @s gd_seat
execute as @e[tag=gd.cards,scores={gd_type=53}] if score @s gd_owner = #donor gd_ctx run scoreboard players add #bigjokers gd_ctx 1
