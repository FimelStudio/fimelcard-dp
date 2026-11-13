tag @s add it.visual
scoreboard players operation @s ct_id = #visual_table it_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:ito/table/$(number)"}},item_display:"none",brightness:{block:15,sky:15},view_range:0.6f,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.43f,0.43f,0.43f]}}
