scoreboard objectives add ch_ctx dummy
execute unless score #version ch_ctx matches 1.. run function chess:system/install
execute if score #version ch_ctx matches 1 run function chess:system/upgrade_v2
execute if score #version ch_ctx matches 2 run function chess:system/upgrade_v3
# 分边默认按座位（1）；合法的显式随机（0）保留，旧指定座位值迁为默认。
execute as @e[tag=ch.controller] unless score @s ch_first matches 0..1 run scoreboard players set @s ch_first 1
scoreboard players set #minus ch_ctx -1
scoreboard players set #two ch_ctx 2
scoreboard players set #four ch_ctx 4
scoreboard players set #eight ch_ctx 8
scoreboard players set #twenty ch_ctx 20
scoreboard players set #sixty ch_ctx 60
scoreboard players set #thousand ch_ctx 1000
execute unless score #setting_serial ch_ctx matches 100000..999999 run scoreboard players set #setting_serial ch_ctx 99999
scoreboard players add #ui_load ch_ctx 1
scoreboard players reset * ch_action
scoreboard players reset * ch_settings
scoreboard players reset * ch_setnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=12}] at @s run function chess:system/reload
