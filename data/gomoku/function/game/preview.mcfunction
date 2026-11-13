# 选择游戏或改变外观后立即显示；绝不重置进行中的对局。
execute unless score @s ct_game matches 14 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.gomoku{review:1b} run return run function gomoku:game/review
tag @s add gm.controller
scoreboard players set @s gm_state 0
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_timer 0
scoreboard players set @s gm_pulse 0
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_undo 0
scoreboard players set @s gm_animundo 0
scoreboard players set @s gm_bot 0
function gomoku:ai/reset
data remove entity @s data.gomoku.ai_undo
data remove entity @s data.gomoku.undo
data remove entity @s data.gomoku.pending_undo
scoreboard players add @s gm_epoch 1
function gomoku:visual/clear
function gomoku:system/create_board
function gomoku:engine/init_board
function gomoku:visual/setup
