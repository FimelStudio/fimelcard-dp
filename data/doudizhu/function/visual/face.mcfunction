tag @s add dd.public_card
scoreboard players operation @s dd_id = #vc_table dd_ctx
scoreboard players operation @s dd_owner = #vc_seat dd_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:poker/$(model)"}},item_display:"none",shadow_radius:0f,view_range:1f,transformation:{translation:[$(x)f,$(y)f,$(z)f],left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[0.43f,0.43f,0.43f]}}
