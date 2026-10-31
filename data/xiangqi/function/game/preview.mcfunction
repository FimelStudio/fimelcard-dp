# 选择游戏或改变外观后立即显示；绝不重置进行中的对局。
execute unless score @s ct_game matches 13 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.xiangqi{review:1b} run return run function xiangqi:game/review
tag @s add xq.controller
scoreboard players set @s xq_state 0
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_timer 0
scoreboard players set @s xq_pulse 0
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_undo 0
scoreboard players set @s xq_bot 0
function xiangqi:ai/reset
data remove entity @s data.xiangqi.ai_undo
data remove entity @s data.xiangqi.undo
data remove entity @s data.xiangqi.pending_undo
scoreboard players add @s xq_epoch 1
function xiangqi:visual/clear
function xiangqi:system/create_board
function xiangqi:engine/init_board
function xiangqi:visual/setup
