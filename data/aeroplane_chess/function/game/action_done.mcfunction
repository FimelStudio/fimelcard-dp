execute if score @s ac_extra matches 1 if score @s ac_roll matches 6 if score @s ac_sixes matches 1..2 run return run function aeroplane_chess:game/extra_turn
execute if score @s ac_extra matches 1 if score @s ac_roll matches 6 if score @s ac_triple matches 0 run return run function aeroplane_chess:game/extra_turn
function aeroplane_chess:game/next_turn
