tag @s add ac.visual
tag @s add ac.board_display
scoreboard players operation @s ct_id = #vis_table ac_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/board/$(palette)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[0f,$(board_y)f,0f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(footprint)f,$(footprint)f,$(footprint)f]}}
