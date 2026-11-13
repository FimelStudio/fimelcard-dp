# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=1..17}] at @s run function liars_holdem:system/maintenance_one
