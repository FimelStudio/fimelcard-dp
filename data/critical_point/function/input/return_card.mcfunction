# 无法出牌时只归还当前物品，并防止同一掉落物下一 tick 再次提交。
data modify entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] Owner set from entity @s UUID
data modify entity @e[type=minecraft:item,tag=cp.input_drop,limit=1] PickupDelay set value 0s
tag @e[type=minecraft:item,tag=cp.input_drop,limit=1] add cp.returned
tp @e[type=minecraft:item,tag=cp.input_drop,limit=1] @s
tag @e[tag=cp.current] remove cp.current
