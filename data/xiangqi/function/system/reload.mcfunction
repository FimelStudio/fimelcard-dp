tag @s add xq.controller
execute if score @s ct_state matches 0 run return run function xiangqi:game/init_table
function xiangqi:system/context
scoreboard players add @s xq_epoch 1
function xiangqi:ai/reset
# 保留阵营，恢复对应桌边与通用座位身份；不重新随机或重置棋局。
function xiangqi:game/reseat
# 棋面、重复判定历史和时钟均保留；重建的只是展示实体。
function xiangqi:visual/refresh
function xiangqi:clock/create
execute as @a[tag=xq.audience] run function xiangqi:input/give
function xiangqi:ui/refresh
