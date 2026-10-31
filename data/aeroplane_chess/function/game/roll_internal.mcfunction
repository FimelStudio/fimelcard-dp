execute unless score @s ac_state matches 1 run return 0
# 唯一一次随机发生在锁状态后，重载和动画回调不得再次投骰。
scoreboard players set @s ac_state 2
scoreboard players add @s ac_epoch 1
execute store result score @s ac_roll run random value 1..6
scoreboard players set @s ac_timer 20
execute if score @s ac_speed matches 1 run scoreboard players set @s ac_timer 12
function aeroplane_chess:log {text:"投骰已锁定结果，开始播放动画"}
function aeroplane_chess:sound/dice_roll
function aeroplane_chess:visual/roll_tick
function aeroplane_chess:ui/refresh
