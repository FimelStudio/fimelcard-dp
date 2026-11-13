tag @s add ll.visual
tag @s add ll.info
scoreboard players operation @s ct_id = #vis_table ll_ctx
data merge entity @s {billboard:"vertical",alignment:"center",background:0,shadow:1b,see_through:0b,view_range:1.0f,line_width:300,brightness:{block:15,sky:15},transformation:{scale:[0.40f,0.40f,0.40f]}}
$data modify entity @s text set value {text:"",extra:$(lines)}
