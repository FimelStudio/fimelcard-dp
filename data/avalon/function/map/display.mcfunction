# Same surface height, scale and Y compensation as the eight-seat chess board.
tag @s add av.game_entity
tag @s add av.map
scoreboard players operation @s av_id = #map_table av_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:avalon/map/$(model)"}},item_display:"none",shadow_radius:0f,view_range:24f,transformation:{translation:[0.0f,1.61875f,0.0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f],scale:[3.2375f,3.2375f,3.2375f]}}
