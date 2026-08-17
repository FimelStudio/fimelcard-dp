# 创建安装标记并按版本执行一次性安装或升级
scoreboard objectives add hb_ctx dummy
# 左侧牌面独立测试使用单独面板，并保存测试前的BetterTitle面板编号
scoreboard objectives add hb_test_panel dummy
scoreboard objectives add hb_test_prev dummy
function hanabi:title/ensure_library
execute unless score #version hb_ctx matches 1.. run function hanabi:system/install
execute if score #version hb_ctx matches 1 run function hanabi:system/upgrade_v2
execute if score #version hb_ctx matches 2 run function hanabi:system/upgrade_v3
execute if score #version hb_ctx matches 3 run function hanabi:system/upgrade_v4
execute if score #version hb_ctx matches 4 run function hanabi:system/upgrade_v5
execute if score #version hb_ctx matches 5 run function hanabi:system/upgrade_v6
execute if score #version hb_ctx matches 6 run function hanabi:system/upgrade_v7
execute if score #version hb_ctx matches 7 run function hanabi:system/upgrade_v8

tellraw @a[tag=hb.player] [{text:'[花火] ',color:'light_purple'},{text:'数据包已重新加载，正在恢复当前牌局。',color:'yellow'}]
title @a[tag=hb.player] actionbar {text:""}
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2}] at @s run function hanabi:title/activate_all
execute as @a[tag=hb.player] run function hanabi:hand/sync
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2}] at @s run function hanabi:hud/update
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2}] at @s run function hanabi:ui/discard_pile/spawn
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2}] at @s run function hanabi:input/restore_table
