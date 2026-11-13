execute unless score @s dd_pred_phase matches 1 run return 0
execute if score @s ct_paused matches 1 run return 0
function doudizhu:duplicate/match_audience
execute unless score @s dd_scoring matches 0 run return run function doudizhu:predict/cancel
execute store result storage doudizhu:input prediction.table int 1 run scoreboard players get @s ct_id
execute store result storage doudizhu:input prediction.token int 1 run scoreboard players get @s dd_pred_token
execute as @a[tag=dd.audience,scores={dd_prediction=0}] run function doudizhu:predict/issue
