tag @s add ch.visual
tag @s add ch.cell
tag @s add ch.tile
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
data merge entity @s {height:0.025f,response:1b}
execute if score #vis_cap ch_ctx matches 4 run data merge entity @s {width:0.266f}
execute if score #vis_cap ch_ctx matches 8 run data merge entity @s {width:0.366f}
