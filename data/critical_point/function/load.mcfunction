scoreboard objectives add cp_ctx dummy
# 新版本不再使用桌面实体牌；重载时一次性清除旧版本残留。
kill @e[type=minecraft:item_display,tag=cp.card]
execute unless score #version cp_ctx matches 1.. run function critical_point:system/install
execute if score #version cp_ctx matches 1 run function critical_point:system/upgrade_v2
scoreboard players set #three cp_ctx 3
tellraw @a[tag=cp.player] [{text:'[临界点] ',color:'red'},{text:'数据包已重新加载，当前游戏将安全结束。',color:'yellow'}]
execute as @e[type=minecraft:marker,tag=cp.controller] at @s run function critical_point:game/abort
