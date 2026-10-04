tag @s add lh.showdown_display
tag @s add lh.showdown_single
execute if score #display_rank lh_ctx matches 1 run tag @s add lh.ranking_display
tag @s add lh.game_entity
scoreboard players operation @s lh_id = #display_owner lh_ctx
# 大小保持四人桌的0.22，取消横向偏移。
$data merge entity @s {text:$(line),billboard:"vertical",alignment:"center",line_width:600,background:1073741824,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.22f,0.22f,0.22f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}
