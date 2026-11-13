# 选择游戏或改变外观后立即显示；绝不重置进行中的对局。
execute unless score @s ct_game matches 12 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.chess{review:1b} run return run function chess:game/review
tag @s add ch.controller
scoreboard players set @s ch_state 0
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_timer 0
scoreboard players set @s ch_pulse 0
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_undo 0
scoreboard players set @s ch_bot 0
function chess:ai/reset
data remove entity @s data.chess.ai_undo
data remove entity @s data.chess.undo
data remove entity @s data.chess.pending_undo
scoreboard players add @s ch_epoch 1
function chess:visual/clear
function chess:system/create_board
function chess:engine/init_board
function chess:visual/setup
