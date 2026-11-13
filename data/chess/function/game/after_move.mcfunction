# engine已原子提交棋面和轮次，此处只读last，随后锁输入到插值结束。
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_undo 0
data modify entity @s data.chess.undo set from entity @s data.chess.pending_undo
data remove entity @s data.chess.pending_undo
# 单人悔棋保留真人提交前的快照，可连同人机应手撤回到真人回合。
execute store result score #moved_piece ch_ctx run data get entity @s data.chess.last.piece
execute if score @s ch_bot matches 1 if score #moved_piece ch_ctx matches ..-1 run data modify entity @s data.chess.ai_undo set from entity @s data.chess.undo
execute if score @s ch_bot matches -1 if score #moved_piece ch_ctx matches 1.. run data modify entity @s data.chess.ai_undo set from entity @s data.chess.undo
function chess:ai/reset
scoreboard players add @s ch_epoch 1
function chess:visual/move
function chess:game/announce_move
function chess:engine/evaluate
scoreboard players set @s ch_state 2
scoreboard players set @s ch_timer 8
function chess:clock/update
function chess:ui/refresh
function chess:log {text:"合法走子已提交，开始走子/吃子动画"}
scoreboard players set #legal ch_ctx 1
