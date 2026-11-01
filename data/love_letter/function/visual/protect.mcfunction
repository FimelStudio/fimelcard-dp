tag @s add ll.visual
tag @s add ll.protect
scoreboard players operation @s ct_id = #vis_table ll_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/protection"}},item_display:"none",Glowing:1b,glow_color_override:7526595,brightness:{block:15,sky:15},view_range:0.5f,shadow_radius:0f,transformation:{translation:[0f,0.25f,0f],right_rotation:[0f,1f,0f,0f],scale:[0.5f,0.5f,0.5f]}}
