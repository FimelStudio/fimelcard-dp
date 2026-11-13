function xiangqi:input/clear
scoreboard players reset @s xq_table
scoreboard players reset @s xq_side
scoreboard players reset @s xq_seat
scoreboard players reset @s xq_weight
tag @s remove xq.player
tag @s remove xq.audience
