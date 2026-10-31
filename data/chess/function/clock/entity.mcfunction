tag @s add ch.clock
tag @s add ch.visual
scoreboard players operation @s ct_id = #table ch_ctx
data merge entity @s {billboard:"vertical",alignment:"center",line_width:300,background:0,shadow:1b,see_through:0b,view_range:24f,text:{text:"国际象棋",color:"gold",bold:true},brightness:{block:15,sky:15}}
