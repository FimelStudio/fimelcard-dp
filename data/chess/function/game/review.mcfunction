# 大厅保留终局棋面；重载或修改配色只重建展示，不初始化规则局面。
execute unless score @s ct_game matches 12 run return 0
execute unless score @s ct_state matches 0 run return 0
function chess:system/context
scoreboard players set @s ch_state 0
scoreboard players set @s ch_sel -1
scoreboard players add @s ch_epoch 1
function chess:ai/reset
function chess:visual/refresh
