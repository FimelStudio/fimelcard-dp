execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=4}] at @s run function critical_point:game/finish_tick
execute as @e[type=minecraft:marker,tag=cp.controller] at @s run function critical_point:system/maintenance
# 丢弃统计在重载、规则切换等情况下可能漏报；附近出现掉落物时主动扫描作为兜底。
execute as @a[tag=cp.player] at @s if entity @e[type=minecraft:item,distance=..3] run function critical_point:input/card
execute as @a[tag=cp.player] at @s if entity @e[type=minecraft:item,distance=..3] run function critical_point:input/start_vote
execute as @a[tag=cp.player] at @s if entity @e[type=minecraft:item,distance=..3] run function critical_point:input/ready
execute as @a[tag=cp.player] at @s if entity @e[type=minecraft:item,distance=..3] run function critical_point:input/reopen_vote
execute as @a[tag=cp.player,scores={cp_drop=1..}] at @s run function critical_point:input/card
execute as @a[tag=cp.player,scores={cp_drop_red=1..}] at @s run function critical_point:input/start_vote
execute as @a[tag=cp.player,scores={cp_drop_lime=1..}] at @s run function critical_point:input/ready
execute as @a[tag=cp.player,scores={cp_drop_reopen=1..}] at @s run function critical_point:input/reopen_vote
execute as @a[tag=cp.player,scores={cp_action=1..}] at @s run function critical_point:vote/handle
