tag @s add ma.visual
tag @s add ma.table_info
scoreboard players operation @s ct_id = #vis_table ma_ctx
data merge entity @s {billboard:"vertical",alignment:"center",background:0,shadow:1b,see_through:0b,line_width:400,view_range:1.0f,brightness:{block:15,sky:15},transformation:{scale:[0.28f,0.28f,0.28f]}}
