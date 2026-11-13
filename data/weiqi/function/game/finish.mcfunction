# 先锁定结算，防止超时/断线/重复确认重入。
execute unless score @s go_state matches 1..3 run return 0
execute unless score @s go_result matches 1..3 run return 0
scoreboard players set @s go_state 4
function weiqi:system/context
function weiqi:ai/reset
scoreboard players set @s go_timer 100
scoreboard players set @s go_sel -1
scoreboard players set @s go_undo 0
scoreboard players add @s go_epoch 1
execute store result entity @s data.weiqi.finalresult int 1 run scoreboard players get @s go_result
data modify entity @s data.weiqi.result set value "和棋"
execute if score @s go_result matches 1 run data modify entity @s data.weiqi.result set value "黑方获胜"
execute if score @s go_result matches 2 run data modify entity @s data.weiqi.result set value "白方获胜"
function weiqi:visual/finish_move
function weiqi:sound/end
function weiqi:game/result_text
execute if score @s go_result matches 1..2 run function weiqi:game/firework
function weiqi:clock/update
function weiqi:ui/refresh
function weiqi:log {text:"围棋结束，五秒后回大厅并保留终局"}
