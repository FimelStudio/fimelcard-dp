scoreboard objectives add ac_ctx dummy
execute unless score #version ac_ctx matches 1.. run function aeroplane_chess:system/install
execute if score #version ac_ctx matches 1 run function aeroplane_chess:system/upgrade_v2
scoreboard players set #four ac_ctx 4
scoreboard players set #thirteen ac_ctx 13
scoreboard players set #fiftytwo ac_ctx 52
scoreboard players set #hundred ac_ctx 100
execute unless score #setting_serial ac_ctx matches 10000..99999 run scoreboard players set #setting_serial ac_ctx 9999
scoreboard players add #ui_load ac_ctx 1
scoreboard players reset * ac_action
scoreboard players reset * ac_settings
scoreboard players reset * ac_setnonce
function aeroplane_chess:visual/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15}] run scoreboard players set @s ac_palette 0
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15}] at @s run function aeroplane_chess:system/reload
