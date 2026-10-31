tag @s add xq.clock
tag @s add xq.visual
scoreboard players operation @s ct_id = #table xq_ctx
data merge entity @s {billboard:"vertical",alignment:"center",line_width:300,background:0,shadow:1b,see_through:0b,view_range:24f,text:{text:"中国象棋",color:"gold",bold:true},brightness:{block:15,sky:15}}
