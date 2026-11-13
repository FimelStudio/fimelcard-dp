# uninstall-guard: begin (tools/build_uninstall.py)
execute if data storage cardtable:uninstall active run return 0
execute unless score #version ct_ctx matches 1.. run return 0
# uninstall-guard: end
# 必须早于游戏tick与通用调度库；本刻掉线立刻暂停，不让计时多走一刻。
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s run function cardtable:session/detect_finish
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s run function cardtable:session/detect_finish
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s run function cardtable:session/detect_finish
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s unless score @s ct_finishing matches 1 unless score @s ct_session matches 1.. run function cardtable:session/migrate
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s unless score @s ct_finishing matches 1 unless score @s ct_session matches 1.. run function cardtable:session/migrate
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s unless score @s ct_finishing matches 1 unless score @s ct_session matches 1.. run function cardtable:session/migrate
execute as @a[tag=ct.player,tag=!ct.rejoining] unless score @s ct_online matches 1 run function cardtable:session/begin_rejoin
execute as @a[tag=ct.player,tag=ct.rejoining] at @s run function cardtable:session/reconcile_player
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s run function cardtable:session/check_table
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s run function cardtable:session/check_table
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] at @s run function cardtable:session/check_table
scoreboard players set * ct_online 0
scoreboard players set @a[tag=ct.player] ct_online 1
