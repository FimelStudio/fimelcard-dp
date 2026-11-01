function weiqi:system/context
# 保留终局或当前复盘帧；外观设置只重绘，不重开局。
execute unless score @s go_state matches 5 run scoreboard players set @s go_state 0
scoreboard players add @s go_epoch 1
function weiqi:visual/refresh
