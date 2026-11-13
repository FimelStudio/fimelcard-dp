tag @s add gm.visual
tag @s add gm.cell
tag @s add gm.tile
scoreboard players operation @s ct_id = #vis_table gm_ctx
$data merge entity @s {width:$(footprint)f,height:0.035f,response:1b}
