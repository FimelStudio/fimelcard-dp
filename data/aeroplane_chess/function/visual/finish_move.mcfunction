function aeroplane_chess:visual/context
data modify storage aeroplane_chess:visual movement set from entity @s data.aeroplane_visual
data modify storage aeroplane_chess:visual movement.remaining set value 0
execute store result storage aeroplane_chess:visual movement.kind int 1 run scoreboard players get @s ac_kind
function aeroplane_chess:visual/interpolate
