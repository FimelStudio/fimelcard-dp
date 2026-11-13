# 先锁定结算，重复调用不能重置倒计时或再次庆祝。
execute unless score @s gm_state matches 1..2 run return 0
execute unless score @s gm_result matches 1..3 run return 0
scoreboard players set @s gm_state 4
function gomoku:system/context
function gomoku:ai/reset
function gomoku:sound/end
scoreboard players set @s gm_timer 100
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_undo 0
scoreboard players add @s gm_epoch 1
function gomoku:visual/finish_move
function gomoku:visual/select
data modify entity @s data.gomoku.result set value "和棋"
execute if score @s gm_result matches 1 run data modify entity @s data.gomoku.result set value "黑方获胜"
execute if score @s gm_result matches 2 run data modify entity @s data.gomoku.result set value "白方获胜"
data modify storage gomoku:runtime result.title set from entity @s data.gomoku.result
data modify storage gomoku:runtime result.reason set value "对局结束"
execute if score @s gm_reason matches 1 run data modify storage gomoku:runtime result.reason set value "连成五子"
execute if score @s gm_reason matches 2 run data modify storage gomoku:runtime result.reason set value "棋盘已满"
execute if score @s gm_reason matches 6 run data modify storage gomoku:runtime result.reason set value "超时"
execute if score @s gm_reason matches 7 run data modify storage gomoku:runtime result.reason set value "认输"
execute if score @s gm_reason matches 8 run data modify storage gomoku:runtime result.reason set value "双方同意和棋"
execute if score @s gm_reason matches 11 run data modify storage gomoku:runtime result.reason set value "棋盘数据不完整或异常"
execute if score @s gm_result matches 1..2 run function gomoku:game/firework
function gomoku:game/result_text with storage gomoku:runtime result
function gomoku:clock/update
function gomoku:ui/refresh
function gomoku:log {text:"对局结束，五秒后返回大厅"}
