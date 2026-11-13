tag @s add go.clock
tag @s add go.visual
scoreboard players operation @s ct_id = #table go_ctx
data merge entity @s {billboard:"vertical",alignment:"center",line_width:320,background:0,shadow:1b,see_through:0b,view_range:0.5f,text:{text:"围棋",color:"gold",bold:true},brightness:{block:15,sky:15}}
