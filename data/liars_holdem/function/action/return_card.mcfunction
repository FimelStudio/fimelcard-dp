# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 当前执行者是被保护的手牌实体，lh.swap_actor是原玩家
data modify entity @s Owner set from entity @a[tag=lh.swap_actor,limit=1] UUID
data merge entity @s {PickupDelay:0s,Motion:[0.0d,0.0d,0.0d]}
tp @s @a[tag=lh.swap_actor,limit=1]
