# 按整场名单选取胜队。4v4 乙桌使用相反的 dd_id，2v2 轮空者仍是 dd.actor。
scoreboard players operation #result_table dd_ctx = @s dd_id
scoreboard players set #result_other dd_ctx 0
scoreboard players operation #result_other dd_ctx -= #result_table dd_ctx
tag @e[tag=dd.result_winner] remove dd.result_winner
$execute as @e[tag=dd.actor,scores={dd_team=$(team)}] if score @s dd_id = #result_table dd_ctx run tag @s add dd.result_winner
$execute if score @s dd_lane matches 1 as @e[tag=dd.actor,scores={dd_team=$(team)}] if score @s dd_id = #result_other dd_ctx run tag @s add dd.result_winner
$function cardtable:game/result/title {audience:"@a[tag=dd.audience]",title:$(title),subtitle:{selector:"@e[tag=dd.result_winner]",separator:{text:"、"}}}
tag @e[tag=dd.result_winner] remove dd.result_winner
