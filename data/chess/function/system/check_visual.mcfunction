scoreboard players set #has_visual ch_ctx 0
execute as @e[type=minecraft:interaction,tag=ch.cell] if score @s ct_id = #table ch_ctx run scoreboard players set #has_visual ch_ctx 1
execute if score #has_visual ch_ctx matches 0 run function chess:game/preview
