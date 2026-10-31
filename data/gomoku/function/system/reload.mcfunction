tag @s add gm.controller
execute if score @s ct_state matches 0 run return run function gomoku:game/init_table
function gomoku:system/context
scoreboard players add @s gm_epoch 1
function gomoku:ai/reset
# 保留阵营，恢复对应桌边与通用座位身份；不重新随机或重置棋局。
function gomoku:game/reseat
# 棋面、重复判定历史和时钟均保留；重建的只是展示实体。
function gomoku:visual/refresh
function gomoku:clock/create
execute as @a[tag=gm.audience] run function gomoku:input/give
function gomoku:ui/refresh
