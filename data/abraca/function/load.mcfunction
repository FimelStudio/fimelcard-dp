# 出包魔法师（2至4人基础版）。【资源包待补】咒语石目前使用原版纸张占位。
scoreboard objectives add ab_ctx dummy
function abraca:title/ensure_library
# 移除旧版本遗留的桌面咒语选择按钮。
kill @e[tag=ab.action_button]
execute unless score #version ab_ctx matches 1.. run function abraca:system/install
execute if score #version ab_ctx matches 1 run function abraca:system/upgrade_v2
execute if score #version ab_ctx matches 2 run function abraca:system/upgrade_v3
execute if score #version ab_ctx matches 3 run function abraca:system/upgrade_v4
execute if score #version ab_ctx matches 4 run function abraca:system/upgrade_v5
tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'数据包已重新加载。当前牌局将安全结束。',color:'yellow'}]
execute as @e[type=minecraft:marker,tag=ab.controller] at @s run function abraca:game/abort
