# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless data storage guandan:ui phase.extra[0] run data remove storage guandan:ui phase.extra
execute unless data storage guandan:ui rows.extra[0] run data remove storage guandan:ui rows.extra
execute unless data storage guandan:ui info.extra[0] run data remove storage guandan:ui info.extra
execute unless data storage guandan:ui grid.extra[0] run data remove storage guandan:ui grid.extra
