scoreboard players set #has_visual xq_ctx 0
execute as @e[type=minecraft:interaction,tag=xq.cell] if score @s ct_id = #table xq_ctx run scoreboard players set #has_visual xq_ctx 1
execute if score #has_visual xq_ctx matches 0 run function xiangqi:game/preview
