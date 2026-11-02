# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function aeroplane_chess:visual/context
data modify storage aeroplane_chess:visual movement set from entity @s data.aeroplane_visual
execute store result storage aeroplane_chess:visual movement.remaining int 1 run scoreboard players get @s ac_timer
execute store result storage aeroplane_chess:visual movement.kind int 1 run scoreboard players get @s ac_kind
function aeroplane_chess:visual/interpolate
