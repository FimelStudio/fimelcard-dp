tag @s add ll.visual
tag @s add ll.deck_count
scoreboard players operation @s ct_id = #vis_table ll_ctx
data merge entity @s {billboard:"vertical",alignment:"center",background:0,shadow:1b,see_through:0b,view_range:0.7f,line_width:160,brightness:{block:15,sky:15},transformation:{scale:[0.30f,0.30f,0.30f]}}
