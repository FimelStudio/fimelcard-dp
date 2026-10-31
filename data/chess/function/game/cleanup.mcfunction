# 返回大厅并保留终局棋面，清除计时和输入；再次开局或切换游戏才重摆。
scoreboard players set @s ch_state 0
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_undo 0
data modify entity @s data.chess.review set value 1b
function chess:ai/reset
function chess:system/context
function chess:visual/finish_move
function chess:visual/select
execute as @e[type=minecraft:text_display,tag=ch.clock] if score @s ct_id = #table ch_ctx run kill @s
execute as @a[tag=ch.player] if score @s ch_table = #table ch_ctx run function chess:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}] run function chess:player/kill_drop
function cardtable:game/return_lobby
