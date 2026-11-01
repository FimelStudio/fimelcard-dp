tag @s add ll.visual
tag @s add ll.label
scoreboard players operation @s ct_id = #vis_table ll_ctx
$scoreboard players set @s ll_v_seat $(seat)
$data merge entity @s {text:{text:"$(seat)号位 · ♥$(points) · 弃$(count)",color:"gold"},billboard:"center",background:0,shadow:1b,see_through:0b,view_range:0.5f,line_width:240,transformation:{scale:[0.18f,0.18f,0.18f]}}
