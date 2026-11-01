tag @s add gd.visual
tag @s add gd.face
scoreboard players operation @s ct_id = #vis_table gd_ctx
$scoreboard players set @s gd_v_seat $(seat)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:poker/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,interpolation_duration:1,start_interpolation:0,transformation:{translation:$(position),left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}
execute if score #effect gd_ctx matches 1 run function guandan:visual/playing with storage guandan:visual card
