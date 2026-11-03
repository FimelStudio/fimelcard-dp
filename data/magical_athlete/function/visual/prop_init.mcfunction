tag @s add ma.visual
tag @s add ma.event_prop
scoreboard players operation @s ct_id = #vis_table ma_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/prop/$(prop)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[0f,0.12f,0f],scale:[0.35f,0.35f,0.35f],right_rotation:[0f,1f,0f,0f]}}
