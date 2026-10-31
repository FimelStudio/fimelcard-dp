tag @s add ch.visual
tag @s add ch.hint
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:chess/hint"}},item_display:"none",brightness:{block:15,sky:15},Glowing:1b,glow_color_override:5635925,shadow_radius:0f,view_range:24f}
function chess:visual/resolve_square
data modify storage chess:visual x set from storage chess:visual coord.x
data modify storage chess:visual z set from storage chess:visual coord.z
execute if score #vis_cap ch_ctx matches 4 run data modify storage chess:visual scale set value 0.27
execute if score #vis_cap ch_ctx matches 4 run data modify storage chess:visual lift set value 0.135
execute if score #vis_cap ch_ctx matches 8 run data modify storage chess:visual scale set value 0.37
execute if score #vis_cap ch_ctx matches 8 run data modify storage chess:visual lift set value 0.185
function chess:hints/pose with storage chess:visual
