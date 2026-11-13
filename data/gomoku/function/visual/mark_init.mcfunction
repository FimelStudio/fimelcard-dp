tag @s add gm.visual
tag @s add gm.highlight
scoreboard players operation @s ct_id = #vis_table gm_ctx
$scoreboard players set @s gm_sq $(sq)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:gomoku/$(mark)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[$(x)f,$(mark_y)f,$(z)f],right_rotation:[0f,1f,0f,0f],scale:[$(mark_scale)f,$(mark_scale)f,$(mark_scale)f]}}
execute if data storage gomoku:visual {mark:"winning"} run data merge entity @s {Glowing:1b,glow_color_override:5430679}
