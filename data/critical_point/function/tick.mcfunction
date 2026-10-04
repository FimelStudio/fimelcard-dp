execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=4}] at @s run function critical_point:game/finish_tick
execute as @e[type=minecraft:marker,tag=cp.controller] at @s run function critical_point:system/maintenance
# 逐个处理游戏掉落物，用 origin 找回丢出者，不依赖距离或丢弃统计。
execute as @e[type=minecraft:item,tag=!cp.returned] at @s if items entity @s contents *[minecraft:custom_data~{critical_point:{}}] run function critical_point:input/drop
execute as @a[tag=cp.player,scores={cp_action=1..}] at @s run function critical_point:vote/handle
