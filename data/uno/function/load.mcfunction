# 安装只执行一次；重载保留牌组、回合与计时，只让旧对话框失效。
scoreboard objectives add un_ctx dummy
execute unless score #version un_ctx matches 1.. run function uno:system/install
execute if score #version un_ctx matches 1 run function uno:system/upgrade_v2
execute if score #version un_ctx matches 2 run function uno:system/upgrade_v3
scoreboard players add #ui_load un_ctx 1
execute as @e[type=minecraft:marker,tag=un.controller] at @s run function uno:system/reload
