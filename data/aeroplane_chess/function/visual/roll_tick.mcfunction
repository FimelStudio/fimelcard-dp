# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function aeroplane_chess:visual/context
execute store result storage aeroplane_chess:visual roll int 1 run scoreboard players get @s ac_roll
execute store result storage aeroplane_chess:visual frame int 1 run scoreboard players get @s ac_timer
function aeroplane_chess:visual/die_frame with storage aeroplane_chess:visual
