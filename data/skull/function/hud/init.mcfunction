tag @s add sk.board
tag @s add sk.game_entity
scoreboard players operation @s sk_id = #ctx sk_ctx
data merge entity @s {text:{text:"骷髅牌 · 准备发牌",color:"gold"},billboard:"vertical",alignment:"center",line_width:200,background:0,default_background:0b,shadow:1b,see_through:0b,view_range:24f,brightness:{block:15,sky:15}}
