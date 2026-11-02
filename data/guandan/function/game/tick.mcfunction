# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s gd_state matches 1 run function guandan:deal/tick
execute if score @s gd_state matches 2..3 run function guandan:clock/tick
execute if score @s gd_state matches 4..5 run function guandan:round/result_tick
scoreboard players add @s gd_tick 1
execute if score @s gd_tick matches 20.. run function guandan:game/maintenance

execute if score @s gd_state matches 2..3 if score @s gd_anim matches 0 run function guandan:bot/tick
# BEGIN guandan music tick
function guandan:music/table_tick
# END guandan music tick
