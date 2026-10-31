scoreboard players set #has_visual gm_ctx 0
execute as @e[type=minecraft:interaction,tag=gm.cell] if score @s ct_id = #table gm_ctx run scoreboard players set #has_visual gm_ctx 1
execute if score #has_visual gm_ctx matches 0 run function gomoku:game/preview
