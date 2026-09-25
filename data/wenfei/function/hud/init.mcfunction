tag @s add wq.game_entity
tag @s add wq.board
scoreboard players operation @s wq_id = #ctx wq_ctx
data merge entity @s {text:{text:"问非所答"},billboard:"center",line_width:240,background:0,shadow:1b,see_through:0b,view_range:20f,brightness:{block:15,sky:15},transformation:{scale:[0.65f,0.65f,0.65f]}}
