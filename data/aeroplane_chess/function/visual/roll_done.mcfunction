function aeroplane_chess:visual/context
execute store result storage aeroplane_chess:visual roll int 1 run scoreboard players get @s ac_roll
data modify storage aeroplane_chess:visual frame set value 0
function aeroplane_chess:visual/die_frame with storage aeroplane_chess:visual
