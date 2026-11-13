tag @s add go.visual
tag @s add go.dead_mark
scoreboard players operation @s ct_id = #vis_table go_ctx
$scoreboard players set @s go_sq $(sq)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:weiqi/dead"}},item_display:"none",brightness:{block:15,sky:15},view_range:0.5f,shadow_radius:0f,transformation:{translation:[$(x)f,$(last_y)f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}
