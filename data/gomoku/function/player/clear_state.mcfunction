function gomoku:input/clear
scoreboard players reset @s gm_table
scoreboard players reset @s gm_side
scoreboard players reset @s gm_seat
scoreboard players reset @s gm_weight
tag @s remove gm.player
tag @s remove gm.audience
