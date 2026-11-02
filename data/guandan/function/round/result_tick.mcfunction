# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players remove @s gd_timer 1
execute if score @s gd_timer matches 1.. run return 0
execute if score @s gd_state matches 5 run return run function guandan:game/cleanup
function guandan:round/begin
