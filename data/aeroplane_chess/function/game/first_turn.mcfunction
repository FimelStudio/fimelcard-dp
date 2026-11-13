execute if score @s ac_first matches 0 run scoreboard players operation @s ac_turn = @e[tag=ac.sides,scores={ac_active=1,ac_rank=0},sort=random,limit=1] ac_color
execute if score @s ac_first matches 1..4 run scoreboard players operation @s ac_turn = @s ac_first
execute if score @s ac_first matches 1..4 run scoreboard players remove @s ac_turn 1
function aeroplane_chess:game/ensure_turn
