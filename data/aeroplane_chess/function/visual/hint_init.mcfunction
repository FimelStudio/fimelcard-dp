tag @s add ac.visual
tag @s add ac.highlight
scoreboard players operation @s ct_id = #vis_table ac_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/selection"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,Glowing:1b,glow_color_override:16773283,transformation:{translation:[$(x)f,$(plane_y)f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}
