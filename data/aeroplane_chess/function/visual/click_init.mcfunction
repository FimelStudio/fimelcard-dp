tag @s add ac.visual
tag @s add ac.plane_click
scoreboard players operation @s ct_id = #vis_table ac_ctx
$scoreboard players set @s ac_color $(color)
$scoreboard players set @s ac_plane $(plane)
$data merge entity @s {width:$(width)f,height:0.15f,response:1b}
