scoreboard objectives add go_ctx dummy
execute unless score #version go_ctx matches 2.. run function weiqi:system/install
function weiqi:visual/load
scoreboard players set #minus go_ctx -1
scoreboard players set #two go_ctx 2
scoreboard players set #nineteen go_ctx 19
scoreboard players set #twenty go_ctx 20
scoreboard players set #sixty go_ctx 60
scoreboard players set #minute go_ctx 1200
execute unless score #setting_serial go_ctx matches 9999..99999 run scoreboard players set #setting_serial go_ctx 9999
scoreboard players add #ui_load go_ctx 1
scoreboard players reset * go_action
scoreboard players reset * go_settings
scoreboard players reset * go_coord
scoreboard players reset * go_setnonce
scoreboard players reset * go_coordnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=20}] at @s run function weiqi:system/reload
