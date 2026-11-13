# engine已原子提交棋面和轮次，此处只读last，随后锁输入到插值结束。
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_undo 0
data modify entity @s data.xiangqi.undo set from entity @s data.xiangqi.pending_undo
data remove entity @s data.xiangqi.pending_undo
# 单人悔棋保留真人提交前的快照，可连同人机应手撤回到真人回合。
execute store result score #moved_piece xq_ctx run data get entity @s data.xiangqi.last.piece
execute if score @s xq_bot matches 1 if score #moved_piece xq_ctx matches ..-1 run data modify entity @s data.xiangqi.ai_undo set from entity @s data.xiangqi.undo
execute if score @s xq_bot matches -1 if score #moved_piece xq_ctx matches 1.. run data modify entity @s data.xiangqi.ai_undo set from entity @s data.xiangqi.undo
function xiangqi:ai/reset
scoreboard players add @s xq_epoch 1
function xiangqi:visual/move
function xiangqi:game/announce_move
function xiangqi:engine/evaluate
scoreboard players set @s xq_state 2
scoreboard players set @s xq_timer 8
function xiangqi:clock/update
function xiangqi:ui/refresh
function xiangqi:log {text:"合法走子已提交，开始走子/吃子动画"}
scoreboard players set #legal xq_ctx 1
