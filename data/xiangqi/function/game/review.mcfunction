# 大厅保留终局棋面；重载或修改配色只重建展示，不初始化规则局面。
execute unless score @s ct_game matches 13 run return 0
execute unless score @s ct_state matches 0 run return 0
function xiangqi:system/context
scoreboard players set @s xq_state 0
scoreboard players set @s xq_sel -1
scoreboard players add @s xq_epoch 1
function xiangqi:ai/reset
function xiangqi:visual/refresh
