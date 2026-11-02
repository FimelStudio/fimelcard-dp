tag @s add sk.game_entity
tag @s add sk.visual
scoreboard players operation @s sk_id = #visual_table sk_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{}},item_display:"none",Rotation:[$(yaw)f,0f],brightness:{block:15,sky:15},view_range:0.6f,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.43f,0.43f,0.43f]}}
data modify entity @s item.components."minecraft:item_model" set from storage skull:visual model
