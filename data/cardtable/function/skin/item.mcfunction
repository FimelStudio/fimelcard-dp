tag @s add ct.part
tag @s add ct.skin
scoreboard players operation @s ct_id = #skin_table ct_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:table_skin/$(model)"}},item_display:"none",Rotation:[$(yaw)f,0f],view_range:24f}

execute if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/sofa"] run tag @s add ct.sofa_v2

execute if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/bamboo_chair"] run tag @s add ct.theme_chair_v2

execute if items entity @s contents minecraft:paper[minecraft:item_model="card:table_skin/garden_chair"] run tag @s add ct.theme_chair_v2

# 关闭亮度覆盖，使用环境光照。
data remove entity @s brightness
