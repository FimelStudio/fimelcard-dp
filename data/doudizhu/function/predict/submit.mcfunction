execute unless entity @s[tag=dd.player,tag=ct.player,scores={dd_prediction=0}] run return 0
execute unless entity @e[tag=dd.pred_controller,limit=1] run return 0
execute unless score #prediction_choice dd_ctx matches 1..8 run return 0
scoreboard players operation @s dd_prediction = #prediction_choice dd_ctx
function doudizhu:predict/clear
dialog clear @s
tellraw @s {text:"预测已提交。",color:"green"}
