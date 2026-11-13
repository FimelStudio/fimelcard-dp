# ItemDisplayRenderer 在模型前固定旋转 Y 180°；右旋抵消它，保留上表面 UV 与逻辑格一致。
tag @s add ch.visual
tag @s add ch.board_display
scoreboard players operation @s ct_id = #vis_table ch_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:chess/board_$(board)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
execute if score #vis_cap ch_ctx matches 4 if score #vis_orient ch_ctx matches 0 run data merge entity @s {transformation:{translation:[0.0f,1.18125f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0f,1f,0f,0f],scale:[2.3625f,2.3625f,2.3625f]}}
execute if score #vis_cap ch_ctx matches 4 if score #vis_orient ch_ctx matches 1 run data merge entity @s {transformation:{translation:[0.0f,1.18125f,0.0f],left_rotation:[0.0f,-0.7071068f,0.0f,0.7071068f],right_rotation:[0f,1f,0f,0f],scale:[2.3625f,2.3625f,2.3625f]}}
execute if score #vis_cap ch_ctx matches 8 if score #vis_orient ch_ctx matches 0 run data merge entity @s {transformation:{translation:[0.0f,1.61875f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0f,1f,0f,0f],scale:[3.2375f,3.2375f,3.2375f]}}
execute if score #vis_cap ch_ctx matches 8 if score #vis_orient ch_ctx matches 1 run data merge entity @s {transformation:{translation:[0.0f,1.61875f,0.0f],left_rotation:[0.0f,-0.7071068f,0.0f,0.7071068f],right_rotation:[0f,1f,0f,0f],scale:[3.2375f,3.2375f,3.2375f]}}
