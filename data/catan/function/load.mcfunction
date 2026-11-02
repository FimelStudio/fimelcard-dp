scoreboard objectives add ca_ctx dummy
execute unless score #version ca_ctx matches 1.. run function catan:system/install
function catan:engine/install
scoreboard players set #two ca_ctx 2
scoreboard players set #minus ca_ctx -1
scoreboard players set #factor ca_ctx 10000
scoreboard players add #ui_load ca_ctx 1
scoreboard players reset * ca_action
scoreboard players reset * ca_nonce
function catan:visual/load
function catan:sound/load
function catan:settings/load
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21}] at @s run function catan:system/reload
