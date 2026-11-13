# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 玩家重新上线后，清除已经结束的牌局遗留物品和标签。
scoreboard players operation #ctx dd_ctx = @s dd_id
scoreboard players set #session dd_ctx 0
execute as @e[type=minecraft:marker,tag=dd.controller] if score @s dd_id = #ctx dd_ctx run scoreboard players set #session dd_ctx 1
execute if score #session dd_ctx matches 0 run function doudizhu:player/clear_state
