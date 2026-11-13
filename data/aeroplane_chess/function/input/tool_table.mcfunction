# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 投骰、选机、飞行和撞机动画都属于当前方的同一个回合。
execute if score @s ac_state matches 1..4 if score @s ac_turn = #item_seat ac_ctx run scoreboard players set #item_allowed ac_ctx 1
execute if score @s ac_state matches 6 if score @s ac_turn = #item_seat ac_ctx run scoreboard players set #item_allowed ac_ctx 1
