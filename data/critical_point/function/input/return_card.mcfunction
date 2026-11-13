# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 无法出牌时只归还当前物品，并防止同一掉落物下一 tick 再次提交。
data modify entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] Owner set from entity @s UUID
data modify entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] PickupDelay set value 0s
tag @e[type=minecraft:item,tag=cp.input_drop,limit=1] add cp.returned
tp @e[type=minecraft:item,tag=cp.input_drop,limit=1] @s
tag @e[tag=cp.current] remove cp.current
