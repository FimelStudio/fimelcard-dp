function xiangqi:system/context
function xiangqi:ai/reset
execute unless score @s xq_state matches 4 run function xiangqi:sound/end
scoreboard players set @s xq_state 4
scoreboard players set @s xq_timer 100
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_undo 0
scoreboard players add @s xq_epoch 1
function xiangqi:visual/finish_move
function xiangqi:visual/select
data modify entity @s data.xiangqi.result set value "和棋"
execute if score @s xq_result matches 1 run data modify entity @s data.xiangqi.result set value "红方获胜"
execute if score @s xq_result matches 2 run data modify entity @s data.xiangqi.result set value "黑方获胜"
data modify storage xiangqi:runtime result.title set from entity @s data.xiangqi.result
data modify storage xiangqi:runtime result.reason set value "对局结束"
execute if score @s xq_reason matches 1 run data modify storage xiangqi:runtime result.reason set value "将死"
execute if score @s xq_reason matches 2 run data modify storage xiangqi:runtime result.reason set value "困毙（无合法着法）"
execute if score @s xq_reason matches 3 run data modify storage xiangqi:runtime result.reason set value "双方均无进攻子力"
execute if score @s xq_reason matches 4 run data modify storage xiangqi:runtime result.reason set value "重复局面或单方长将"
execute if score @s xq_reason matches 5 run data modify storage xiangqi:runtime result.reason set value "连续120着（双方合计）未吃子"
execute if score @s xq_reason matches 6 run data modify storage xiangqi:runtime result.reason set value "超时"
execute if score @s xq_reason matches 7 run data modify storage xiangqi:runtime result.reason set value "认输"
execute if score @s xq_reason matches 8 run data modify storage xiangqi:runtime result.reason set value "双方同意和棋"
execute if score @s xq_reason matches 11 run data modify storage xiangqi:runtime result.reason set value "棋盘数据不完整或异常"
function xiangqi:game/result_text with storage xiangqi:runtime result
function xiangqi:clock/update
function xiangqi:ui/refresh
function xiangqi:log {text:"对局结束，五秒后返回大厅"}
