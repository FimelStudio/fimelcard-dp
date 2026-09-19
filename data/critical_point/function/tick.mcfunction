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

# 出牌阶段的模糊点数提示。通过物品 origin 找回真正的丢出者，避免多人靠近时串人。
execute as @e[type=minecraft:item] if items entity @s contents minecraft:black_dye[minecraft:custom_data~{critical_point:{tool:'signal_big'}}] run tag @s add cp.signal_big_drop
execute as @e[type=minecraft:item,tag=cp.signal_big_drop] at @s on origin if entity @s[tag=cp.player] run function critical_point:input/signal_big
tag @e[type=minecraft:item,tag=cp.signal_big_drop] remove cp.signal_big_drop
execute as @e[type=minecraft:item] if items entity @s contents minecraft:white_dye[minecraft:custom_data~{critical_point:{tool:'signal_small'}}] run tag @s add cp.signal_small_drop
execute as @e[type=minecraft:item,tag=cp.signal_small_drop] at @s on origin if entity @s[tag=cp.player] run function critical_point:input/signal_small
tag @e[type=minecraft:item,tag=cp.signal_small_drop] remove cp.signal_small_drop
