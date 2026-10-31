tag @s add xq.visual
tag @s add xq.cell
tag @s add xq.tile
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
data merge entity @s {height:0.025f,response:1b}
execute if score #vis_cap xq_ctx matches 4 run data merge entity @s {width:0.251f}
execute if score #vis_cap xq_ctx matches 8 run data merge entity @s {width:0.346f}
