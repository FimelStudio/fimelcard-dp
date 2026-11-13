scoreboard players set @s dd_pred_phase 2
execute as @a[tag=dd.audience] run function doudizhu:predict/clear
dialog clear @a[tag=dd.audience,scores={dd_prediction=0}]
