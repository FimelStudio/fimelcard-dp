scoreboard players set #side_team dd_ctx 0
execute as @e[tag=dd.actors] if score @s dd_seat = #winner dd_ctx run scoreboard players operation #side_team dd_ctx = @s dd_team
scoreboard players operation @s dd_side_score = #unit dd_ctx
data modify entity @s data.doudizhu.side_unit_scoring set value 1b
scoreboard players set #minus_one dd_ctx -1
execute if score #side_team dd_ctx matches 2 run scoreboard players operation @s dd_side_score *= #minus_one dd_ctx
# 胜负音乐只提示本分桌的结果，独立于双桌分差。
scoreboard players operation #music_winner dd_ctx = #side_team dd_ctx
function doudizhu:music/team_result
execute unless score @s dd_hide_score matches 1 run function doudizhu:duplicate/announce_side
execute if score @s dd_hide_score matches 1 run tellraw @a[tag=dd.audience] {text:"本桌已结束，等待另一桌完成。",color:"yellow"}
execute as @a[tag=dd.audience] run dialog clear @s
function doudizhu:input/sync
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
