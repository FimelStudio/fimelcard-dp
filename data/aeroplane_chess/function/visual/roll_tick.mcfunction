function aeroplane_chess:visual/context
execute store result storage aeroplane_chess:visual roll int 1 run scoreboard players get @s ac_roll
execute store result storage aeroplane_chess:visual frame int 1 run scoreboard players get @s ac_timer
function aeroplane_chess:visual/die_frame with storage aeroplane_chess:visual
