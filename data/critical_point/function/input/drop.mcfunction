# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# @s 是唯一待处理的物品；on origin 只切换执行者，之后定位到该玩家。
tag @e[tag=cp.input_drop] remove cp.input_drop
tag @s add cp.input_drop
execute on origin if entity @s[tag=cp.player] at @s run function critical_point:input/from_player
tag @s remove cp.input_drop
tag @e[tag=cp.current] remove cp.current
