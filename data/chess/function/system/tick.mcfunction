# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s ch_pulse 1
execute if score @s ch_state matches 1 run function chess:clock/tick
execute if score @s ch_state matches 3 run function chess:clock/tick
execute if score @s ch_state matches 2 run function chess:game/animate_tick
execute if score @s ch_state matches 4 run function chess:game/result_tick
execute if score @s ch_state matches 1 run function chess:ai/tick
execute if score @s ch_pulse matches 20.. run function chess:system/heartbeat
