# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=4}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function critical_point:game/finish_tick
execute as @e[type=minecraft:marker,tag=cp.controller] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function critical_point:system/maintenance
# 逐个处理游戏掉落物，用 origin 找回丢出者，不依赖距离或丢弃统计。
execute as @e[type=minecraft:item,tag=!cp.returned] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s if items entity @s contents *[minecraft:custom_data~{critical_point:{}}] run function critical_point:input/drop
execute as @a[tag=cp.player,scores={cp_action=1..}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function critical_point:vote/handle
