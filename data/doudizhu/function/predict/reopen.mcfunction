scoreboard players set @s dd_action 0
execute unless entity @s[tag=dd.player,tag=ct.player,scores={dd_prediction=0}] run return 0
function doudizhu:predict/bind
execute unless entity @e[tag=dd.pred_controller,limit=1] run return 0
execute store result storage doudizhu:input prediction.table int 1 run scoreboard players get @s ct_id
execute store result storage doudizhu:input prediction.token int 1 run scoreboard players get @e[tag=dd.pred_controller,limit=1] dd_pred_token
function doudizhu:predict/issue
