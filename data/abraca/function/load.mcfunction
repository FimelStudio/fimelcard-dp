# 出包魔法师（2至4人基础版）。【资源包待补】咒语石目前使用原版纸张占位。
scoreboard objectives add ab_ctx dummy
execute unless score #version ab_ctx matches 1.. run function abraca:system/install
execute if score #version ab_ctx matches 1 run function abraca:system/upgrade_v2
tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'数据包已重新加载。当前牌局将安全结束。',color:'yellow'}]
execute as @e[type=minecraft:marker,tag=ab.controller] at @s run function abraca:game/abort
