# 返回大厅并保留终局棋面，清除计时和输入；再次开局或切换游戏才重摆。
scoreboard players set @s xq_state 0
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_undo 0
data modify entity @s data.xiangqi.review set value 1b
function xiangqi:ai/reset
function xiangqi:system/context
function xiangqi:visual/finish_move
function xiangqi:visual/select
execute as @e[type=minecraft:text_display,tag=xq.clock] if score @s ct_id = #table xq_ctx run kill @s
execute as @a[tag=xq.player] if score @s xq_table = #table xq_ctx run function xiangqi:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}] run function xiangqi:player/kill_drop
function cardtable:game/return_lobby
