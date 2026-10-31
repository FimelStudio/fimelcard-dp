tag @s add ac.visual
tag @s add ac.man
scoreboard players operation @s ct_id = #vis_table ac_ctx
$scoreboard players set @s ac_color $(color)
$scoreboard players set @s ac_plane $(plane)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:aeroplane_chess/plane/$(palette)_$(color_name)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}
function aeroplane_chess:visual/plane_pose with storage aeroplane_chess:visual
