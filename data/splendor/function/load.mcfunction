scoreboard objectives add sp_ctx dummy
execute unless score #version sp_ctx matches 1.. run function splendor:system/install
execute if score #version sp_ctx matches 1 run function splendor:system/migrate2
function splendor:engine/install
scoreboard players set #factor sp_ctx 10000
scoreboard players set #hundred sp_ctx 100
scoreboard players add #ui_load sp_ctx 1
scoreboard players reset * sp_action
scoreboard players reset * sp_nonce
function splendor:settings/load
function splendor:visual/load
function splendor:sound/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22}] at @s run function splendor:system/reload

scoreboard objectives add sp_dye minecraft.dropped:minecraft.purple_dye

scoreboard objectives add sp_hpanel dummy

scoreboard objectives add sp_hprev dummy
