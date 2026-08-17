# 候选已由调用者按物品组件过滤；同一玩家本次事件只认最近的一件
execute if score #drop_found hb_ctx matches 1 run return 0
tag @s add hb.dropped_owned
scoreboard players set #drop_found hb_ctx 1
