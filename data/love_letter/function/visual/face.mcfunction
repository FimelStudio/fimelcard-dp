tag @s add ll.visual
tag @s add ll.face
scoreboard players operation @s ct_id = #vis_table ll_ctx
$scoreboard players set @s ll_v_seat $(seat)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[$(tx)f,0.022f,$(tz)f],left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[0.44f,0.44f,0.44f]}}
