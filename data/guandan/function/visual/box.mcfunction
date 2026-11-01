tag @s add gd.visual
tag @s add gd.box
scoreboard players operation @s ct_id = #vis_table gd_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:cardbox"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[-0.07125f,0.07625f,0f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,1f,0f,0f],scale:[0.38f,0.38f,0.38f]}}
