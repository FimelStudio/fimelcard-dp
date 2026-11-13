function aeroplane_chess:input/clear
scoreboard players reset @s ac_table
scoreboard players reset @s ac_color
scoreboard players reset @s ac_seat
tag @s remove ac.player
tag @s remove ac.audience
