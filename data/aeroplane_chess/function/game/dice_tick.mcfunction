scoreboard players remove @s ac_timer 1
function aeroplane_chess:visual/roll_tick
execute if score @s ac_timer matches ..0 run function aeroplane_chess:game/dice_done
