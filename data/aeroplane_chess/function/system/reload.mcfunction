tag @s add ac.controller
execute if score @s ct_state matches 0 run return run function aeroplane_chess:game/init_table
function aeroplane_chess:system/context
scoreboard players add @s ac_epoch 1
# 已确定的骰值、移动队列和阶段保留；只重建模型，绝不重新 random。
function aeroplane_chess:game/reseat
function aeroplane_chess:visual/refresh
execute if score @s ac_state matches 2 run function aeroplane_chess:visual/roll_tick
execute if score @s ac_state matches 4 run function aeroplane_chess:visual/move
execute as @a[tag=ac.audience] run function aeroplane_chess:input/give
function aeroplane_chess:ui/refresh
