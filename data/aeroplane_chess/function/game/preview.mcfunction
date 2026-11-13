execute unless score @s ct_game matches 15 run return 0
execute unless score @s ct_state matches 0 run return 0
function aeroplane_chess:system/context
execute if data entity @s data.aeroplane_chess{review:1b} run return run function aeroplane_chess:visual/refresh
scoreboard players set @s ac_state 0
scoreboard players set @s ac_turn 0
scoreboard players set @s ac_roll 1
scoreboard players set @s ac_selected -1
scoreboard players add @s ac_epoch 1
function aeroplane_chess:visual/clear
function aeroplane_chess:engine/init_board
function aeroplane_chess:visual/setup
