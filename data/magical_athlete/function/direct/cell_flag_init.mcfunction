tag @s add ma.direct
tag @s add ma.cell_preview
scoreboard players operation @s ct_id = #vis_table ma_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/prop/flag"}},item_display:"none",Glowing:1b,glow_color_override:16766720,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],scale:[0.16f,0.16f,0.16f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}
