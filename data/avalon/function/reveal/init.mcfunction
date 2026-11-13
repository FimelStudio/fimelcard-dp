tag @s add av.game_entity
tag @s add av.reveal
scoreboard players operation @s av_id = #reveal_table av_ctx
scoreboard players operation @s ct_id = #reveal_table av_ctx
scoreboard players operation @s av_role = #reveal_role av_ctx
scoreboard players operation @s av_seat = #reveal_seat av_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:avalon/reveal/$(model)"}},item_display:"none",view_range:24f,shadow_radius:0f,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f],scale:[0.78f,0.78f,0.78f]}}
execute if score @s av_seat matches 1 run data modify entity @s transformation.left_rotation set value [-0.7071068f,0.0000000f,0.0000000f,0.7071068f]
execute if score @s av_seat matches 2 run data modify entity @s transformation.left_rotation set value [-0.7071068f,0.0000000f,0.0000000f,0.7071068f]
execute if score @s av_seat matches 3 run data modify entity @s transformation.left_rotation set value [-0.5000000f,-0.5000000f,-0.5000000f,0.5000000f]
execute if score @s av_seat matches 4 run data modify entity @s transformation.left_rotation set value [-0.5000000f,-0.5000000f,-0.5000000f,0.5000000f]
execute if score @s av_seat matches 5 run data modify entity @s transformation.left_rotation set value [-0.0000000f,0.7071068f,0.7071068f,0.0000000f]
execute if score @s av_seat matches 6 run data modify entity @s transformation.left_rotation set value [-0.0000000f,0.7071068f,0.7071068f,0.0000000f]
execute if score @s av_seat matches 7 run data modify entity @s transformation.left_rotation set value [-0.5000000f,0.5000000f,0.5000000f,0.5000000f]
execute if score @s av_seat matches 8 run data modify entity @s transformation.left_rotation set value [-0.5000000f,0.5000000f,0.5000000f,0.5000000f]
