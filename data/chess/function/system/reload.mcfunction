tag @s add ch.controller
execute if score @s ct_state matches 0 run return run function chess:game/init_table
function chess:system/context
scoreboard players add @s ch_epoch 1
function chess:ai/reset
# 保留阵营，恢复对应桌边与通用座位身份；不重新随机或重置棋局。
function chess:game/reseat
# 规则局面、王车权、过路兵、历史和时钟均保留；重建的只是展示实体。
function chess:visual/refresh
function chess:clock/create
execute as @a[tag=ch.audience] run function chess:input/give
function chess:ui/refresh
execute if score @s ch_state matches 3 as @a[tag=ch.audience] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run function chess:ui/promotion
