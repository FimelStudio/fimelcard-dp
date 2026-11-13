# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s go_pulse 1
execute if score @s go_state matches 1 run function weiqi:clock/tick
execute if score @s go_state matches 2 run function weiqi:game/animate_tick
execute if score @s go_state matches 4 run function weiqi:game/result_tick
execute if score @s go_state matches 1 run function weiqi:ai/tick
execute if score @s go_state matches 5 if score @s go_autoplay matches 1 run function weiqi:game/review_tick
execute if score @s go_pulse matches 20.. run function weiqi:system/heartbeat
