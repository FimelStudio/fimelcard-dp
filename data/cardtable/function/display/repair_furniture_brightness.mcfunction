# 移除家具亮度覆盖，恢复环境光照；菜单文字与游戏牌面保持不变。
execute as @e[type=minecraft:item_display,tag=ct.skin] if data entity @s brightness run data remove entity @s brightness
execute as @e[type=minecraft:block_display,tag=ct.chair4] if data entity @s brightness run data remove entity @s brightness
execute as @e[type=minecraft:block_display,tag=ct.chair8] if data entity @s brightness run data remove entity @s brightness
