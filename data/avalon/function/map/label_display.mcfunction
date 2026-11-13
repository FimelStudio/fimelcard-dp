tag @s add av.game_entity
tag @s add av.map
scoreboard players operation @s av_id = #map_table av_ctx
$data merge entity @s {text:$(label),billboard:"vertical",alignment:"center",background:1073741824,shadow:1b,see_through:0b,line_width:96,view_range:24f,transformation:{translation:[0f,0f,0f],scale:[0.42f,0.42f,0.42f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}
