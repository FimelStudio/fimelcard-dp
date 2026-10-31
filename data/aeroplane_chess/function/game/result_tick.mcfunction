scoreboard players remove @s ac_timer 1
execute if score @s ac_timer matches ..0 run function aeroplane_chess:game/cleanup
