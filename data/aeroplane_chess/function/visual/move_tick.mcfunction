function aeroplane_chess:visual/context
data modify storage aeroplane_chess:visual movement set from entity @s data.aeroplane_visual
execute store result storage aeroplane_chess:visual movement.remaining int 1 run scoreboard players get @s ac_timer
execute store result storage aeroplane_chess:visual movement.kind int 1 run scoreboard players get @s ac_kind
function aeroplane_chess:visual/interpolate
