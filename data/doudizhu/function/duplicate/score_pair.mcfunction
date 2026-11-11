# 单桌成绩以红队为正，蓝队为负。两桌相加就是这一副的分差。
scoreboard players set @s dd_pair_scored 1
scoreboard players set @s dd_timer 100
scoreboard players operation #difference dd_ctx = @s dd_side_score
scoreboard players operation #difference dd_ctx += @e[tag=dd.other_lane,limit=1] dd_side_score
scoreboard players operation #pair_points dd_ctx = #difference dd_ctx
execute if score #pair_points dd_ctx matches 13.. run scoreboard players set #pair_points dd_ctx 12
execute if score #pair_points dd_ctx matches ..-13 run scoreboard players set #pair_points dd_ctx -12
execute if score @s dd_scoring matches 1 if score #pair_points dd_ctx matches 1.. run scoreboard players set #pair_points dd_ctx 1
execute if score @s dd_scoring matches 1 if score #pair_points dd_ctx matches ..-1 run scoreboard players set #pair_points dd_ctx -1
execute if score #pair_points dd_ctx matches 1.. run scoreboard players operation @s dd_team_one += #pair_points dd_ctx
execute if score #pair_points dd_ctx matches ..-1 run scoreboard players operation @s dd_team_two -= #pair_points dd_ctx
function doudizhu:duplicate/match_audience
execute unless score @s dd_hide_score matches 1 run function doudizhu:duplicate/announce_score
execute if score @s dd_void matches 1 if score @e[tag=dd.other_lane,limit=1] dd_void matches 1 run scoreboard players set @s dd_timer 0
execute if score @s dd_hide_score matches 1 if score @s dd_limit matches 2.. if score @s dd_pred_phase matches 0 if score @s dd_round >= @s dd_pred_round run return 0
execute if score @s dd_timer matches 1.. if score @s dd_round < @s dd_limit run tellraw @a[tag=dd.audience] {text:"5秒后两桌同时发下一副。",color:"yellow"}
execute if score @s dd_timer matches 1.. unless score @s dd_round < @s dd_limit run tellraw @a[tag=dd.audience] {text:"5秒后公布比赛结果并返回大厅。",color:"yellow"}
