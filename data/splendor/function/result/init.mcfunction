tag @s add sp.visual
tag @s add sp.result
scoreboard players operation @s ct_id = #result_table sp_ctx
scoreboard players operation @s sp_table = #result_table sp_ctx
$data merge entity @s {text:$(line),billboard:"vertical",alignment:"center",line_width:600,background:1073741824,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],scale:[0.22f,0.22f,0.22f],right_rotation:[0f,0f,0f,1f]}}
