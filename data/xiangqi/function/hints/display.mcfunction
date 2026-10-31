tag @s add xq.visual
tag @s add xq.hint
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:xiangqi/hint"}},item_display:"none",brightness:{block:15,sky:15},Glowing:1b,glow_color_override:5635925,shadow_radius:0f,view_range:24f}
function xiangqi:visual/resolve_square
data modify storage xiangqi:visual x set from storage xiangqi:visual coord.x
data modify storage xiangqi:visual z set from storage xiangqi:visual coord.z
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual scale set value 0.255
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual lift set value 0.1275
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual scale set value 0.35
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual lift set value 0.175
function xiangqi:hints/pose with storage xiangqi:visual
