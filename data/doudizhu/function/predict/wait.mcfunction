function doudizhu:duplicate/match_audience
scoreboard players set #predicted dd_ctx 0
execute as @a[tag=dd.audience,scores={dd_prediction=1..8}] run scoreboard players add #predicted dd_ctx 1
execute unless score #predicted dd_ctx matches 8 run return 0
scoreboard players set @s dd_pred_phase 2
scoreboard players operation #red_margin dd_ctx = @s dd_team_one
scoreboard players operation #red_margin dd_ctx -= @s dd_team_two
execute as @a[tag=dd.audience] run function doudizhu:predict/feedback
function doudizhu:duplicate/next
