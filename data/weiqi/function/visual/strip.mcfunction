tag @s add go.visual
tag @s add go.territory
scoreboard players operation @s ct_id = #vis_table go_ctx
$scoreboard players set @s go_v_len $(length)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:weiqi/territory_$(owner)"}},item_display:"none",brightness:{block:15,sky:15},view_range:0.5f,shadow_radius:0f,transformation:{translation:[$(strip_x)f,0.06f,$(strip_z)f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(strip_width)f,0.1f,$(strip_thin)f]}}
