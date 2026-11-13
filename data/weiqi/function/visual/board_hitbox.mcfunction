tag @s add go.visual
tag @s add go.cell
tag @s add go.tile
scoreboard players operation @s ct_id = #vis_table go_ctx
$data merge entity @s {width:$(footprint)f,height:0.035f,response:1b}
