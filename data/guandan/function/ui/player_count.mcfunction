# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result storage guandan:ui count int 1 run scoreboard players get @s gd_count
function guandan:ui/player_count_text with storage guandan:ui
