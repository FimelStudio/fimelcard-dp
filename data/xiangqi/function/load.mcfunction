scoreboard objectives add xq_ctx dummy
execute unless score #version xq_ctx matches 1.. run function xiangqi:system/install
execute as @e[type=minecraft:marker,tag=ct.controller,tag=xq.controller] unless data entity @s data.xiangqi{palette_version:2b} run function xiangqi:system/migrate_palette
# xq_first 已改为 0 随机红黑、1 按棋盘边自行选边；旧指定座位值不再有效。
execute as @e[tag=xq.controller] unless score @s xq_first matches 0..1 run scoreboard players set @s xq_first 0
scoreboard players set #minus xq_ctx -1
scoreboard players set #two xq_ctx 2
scoreboard players set #four xq_ctx 4
scoreboard players set #eight xq_ctx 8
scoreboard players set #nine xq_ctx 9
scoreboard players set #ten xq_ctx 10
scoreboard players set #twenty xq_ctx 20
scoreboard players set #sixty xq_ctx 60
scoreboard players set #thousand xq_ctx 1000
execute unless score #setting_serial xq_ctx matches 100000..999999 run scoreboard players set #setting_serial xq_ctx 99999
scoreboard players add #ui_load xq_ctx 1
scoreboard players reset * xq_action
scoreboard players reset * xq_settings
scoreboard players reset * xq_setnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=13}] at @s run function xiangqi:system/reload
