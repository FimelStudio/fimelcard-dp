scoreboard objectives add dd_ctx dummy
execute unless score #version dd_ctx matches 1.. run function doudizhu:system/install
execute if score #version dd_ctx matches 1 run function doudizhu:system/upgrade_v2
# 重载保留牌局；重新启用操作入口并恢复手牌显示。
execute as @a[tag=dd.player] run scoreboard players enable @s dd_action

execute if score #version dd_ctx matches 2 run function doudizhu:system/upgrade_v3
execute if score #version dd_ctx matches 3 run function doudizhu:system/upgrade_v4
scoreboard players reset * dd_settings
scoreboard players reset * dd_set_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=10}] run function doudizhu:game/init_table
execute as @e[type=minecraft:marker,tag=dd.controller] run function doudizhu:game/ensure_match
execute unless data storage title:io panels run function title:code/load
execute as @e[type=minecraft:marker,tag=dd.controller] run function doudizhu:input/sync
