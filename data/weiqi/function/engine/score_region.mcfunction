# execute as 的筛选条件需在函数内复查：前一个洪泛可能已遍历本格。
execute if score @s go_checked matches 1 run return 0
scoreboard players operation #seed go_ctx = @s go_sq
scoreboard players set #color go_ctx 0
function weiqi:engine/group/start
scoreboard players set @e[tag=go.board,tag=go.group] go_checked 1
execute if score #border_black go_ctx matches 1 if score #border_white go_ctx matches 0 run scoreboard players operation #bterrit go_ctx += #count go_ctx
execute if score #border_black go_ctx matches 0 if score #border_white go_ctx matches 1 run scoreboard players operation #wterrit go_ctx += #count go_ctx
execute if score #border_black go_ctx = #border_white go_ctx run scoreboard players operation #neutral go_ctx += #count go_ctx
execute if score #border_black go_ctx matches 1 if score #border_white go_ctx matches 0 run scoreboard players set @e[tag=go.board,tag=go.group] go_owner 1
execute if score #border_black go_ctx matches 0 if score #border_white go_ctx matches 1 run scoreboard players set @e[tag=go.board,tag=go.group] go_owner -1
