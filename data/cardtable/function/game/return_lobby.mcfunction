# 具体游戏已完成清理后，由通用层恢复大厅界面和可离座状态
function cardtable:log {text:"游戏清理完成，返回牌桌大厅"}
scoreboard players set @s ct_state 0
scoreboard players set @s ct_start 0
scoreboard players set @s ct_votes 0
scoreboard players operation #ctx_id ct_ctx = @s ct_id
function cardtable:animation/deal/clear
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx run scoreboard players set @s ct_voted 0
execute as @e[tag=ct.vote] if score @s ct_id = #ctx_id ct_ctx run kill @s
function cardtable:menu/render
