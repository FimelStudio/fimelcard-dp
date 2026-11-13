function chess:system/context
function chess:ai/reset
execute unless score @s ch_state matches 4 run function chess:sound/end
scoreboard players set @s ch_state 4
scoreboard players set @s ch_timer 100
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_undo 0
scoreboard players add @s ch_epoch 1
function chess:visual/finish_move
function chess:visual/select
data modify entity @s data.chess.result set value "和棋"
execute if score @s ch_result matches 1 run data modify entity @s data.chess.result set value "白方获胜"
execute if score @s ch_result matches 2 run data modify entity @s data.chess.result set value "黑方获胜"
data modify storage chess:runtime result.title set from entity @s data.chess.result
data modify storage chess:runtime result.reason set value "对局结束"
execute if score @s ch_reason matches 1 run data modify storage chess:runtime result.reason set value "将死"
execute if score @s ch_reason matches 2 run data modify storage chess:runtime result.reason set value "无合法走法且未被将军"
execute if score @s ch_reason matches 3 run data modify storage chess:runtime result.reason set value "常见子力不足"
execute if score @s ch_reason matches 4 run data modify storage chess:runtime result.reason set value "五次重复局面"
execute if score @s ch_reason matches 5 run data modify storage chess:runtime result.reason set value "七十五回合未动兵或吃子"
execute if score @s ch_reason matches 6 run data modify storage chess:runtime result.reason set value "超时"
execute if score @s ch_reason matches 7 run data modify storage chess:runtime result.reason set value "认输"
execute if score @s ch_reason matches 8 run data modify storage chess:runtime result.reason set value "双方同意和棋"
execute if score @s ch_reason matches 9 run data modify storage chess:runtime result.reason set value "认领三次重复局面"
execute if score @s ch_reason matches 10 run data modify storage chess:runtime result.reason set value "认领五十回合未动兵或吃子"
execute if score @s ch_reason matches 11 run data modify storage chess:runtime result.reason set value "棋盘数据不完整或异常"
function chess:game/result_text with storage chess:runtime result
function chess:clock/update
function chess:ui/refresh
function chess:log {text:"对局结束，五秒后返回大厅"}
