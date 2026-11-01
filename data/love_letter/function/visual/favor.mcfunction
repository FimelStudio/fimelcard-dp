tag @s add ll.visual
tag @s add ll.favor
scoreboard players operation @s ct_id = #vis_table ll_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/favor"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[0f,0.1f,0f],right_rotation:[0f,1f,0f,0f],scale:[0.2f,0.2f,0.2f]}}
