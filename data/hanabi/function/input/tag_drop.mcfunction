# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 候选已由调用者按物品组件过滤；同一玩家本次事件只认最近的一件
execute if score #drop_found hb_ctx matches 1 run return 0
tag @s add hb.dropped_owned
scoreboard players set #drop_found hb_ctx 1
