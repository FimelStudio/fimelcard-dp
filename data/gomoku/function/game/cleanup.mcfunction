# 返回大厅并保留终局棋面，清除计时和输入；再次开局或切换游戏才重摆。
scoreboard players set @s gm_state 0
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_undo 0
data modify entity @s data.gomoku.review set value 1b
function gomoku:ai/reset
function gomoku:system/context
function gomoku:visual/finish_move
function gomoku:visual/select
execute as @e[type=minecraft:firework_rocket,tag=gm.firework] if score @s ct_id = #table gm_ctx run kill @s
execute as @e[type=minecraft:text_display,tag=gm.clock] if score @s ct_id = #table gm_ctx run kill @s
execute as @a[tag=gm.player] if score @s gm_table = #table gm_ctx run function gomoku:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}] run function gomoku:player/kill_drop
function cardtable:game/return_lobby
