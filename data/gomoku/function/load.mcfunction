scoreboard objectives add gm_ctx dummy
execute unless score #version gm_ctx matches 1.. run function gomoku:system/install
# gm_first 已改为 0 随机黑白、1 按棋盘边自行选边；旧指定座位值不再有效。
execute as @e[tag=gm.controller] unless score @s gm_first matches 0..1 run scoreboard players set @s gm_first 0
function gomoku:visual/load
scoreboard players set #nineteen gm_ctx 19
scoreboard players set #minus gm_ctx -1
scoreboard players set #two gm_ctx 2
scoreboard players set #four gm_ctx 4
scoreboard players set #eight gm_ctx 8
scoreboard players set #nine gm_ctx 9
scoreboard players set #ten gm_ctx 10
scoreboard players set #twenty gm_ctx 20
scoreboard players set #sixty gm_ctx 60
scoreboard players set #thousand gm_ctx 1000
execute unless score #setting_serial gm_ctx matches 100000..999999 run scoreboard players set #setting_serial gm_ctx 99999
scoreboard players add #ui_load gm_ctx 1
scoreboard players reset * gm_action
scoreboard players reset * gm_settings
scoreboard players reset * gm_setnonce
scoreboard players reset * gm_coord
scoreboard players reset * gm_coordnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=14}] at @s run function gomoku:system/reload
