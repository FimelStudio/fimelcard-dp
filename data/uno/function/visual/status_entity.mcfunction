tag @s add un.visual
tag @s add un.status
scoreboard players operation @s ct_id = #vis_table un_ctx
data modify entity @s text set from storage uno:visual roster
data merge entity @s {billboard:"center",line_width:300,background:0,shadow:1b,view_range:24f,transformation:{scale:[0.48f,0.48f,0.48f]},brightness:{block:15,sky:15}}
