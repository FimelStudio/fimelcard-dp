function chess:input/clear
scoreboard players reset @s ch_table
scoreboard players reset @s ch_side
scoreboard players reset @s ch_seat
scoreboard players reset @s ch_weight
tag @s remove ch.player
tag @s remove ch.audience
