# 投骰、选机、飞行和撞机动画都属于当前方的同一个回合。
execute if score @s ac_state matches 1..4 if score @s ac_turn = #item_seat ac_ctx run scoreboard players set #item_allowed ac_ctx 1
execute if score @s ac_state matches 6 if score @s ac_turn = #item_seat ac_ctx run scoreboard players set #item_allowed ac_ctx 1
