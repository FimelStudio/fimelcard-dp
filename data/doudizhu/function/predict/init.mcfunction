scoreboard players set @s dd_pred_phase 0
scoreboard players add #prediction_serial dd_ctx 1
scoreboard players operation @s dd_pred_token = #prediction_serial dd_ctx
# 3/4 向上取整。短赛将预测安排在末副前；单副赛没有中途预测。
scoreboard players operation @s dd_pred_round = @s dd_limit
scoreboard players set #three dd_ctx 3
scoreboard players set #four dd_ctx 4
scoreboard players operation @s dd_pred_round *= #three dd_ctx
scoreboard players add @s dd_pred_round 3
scoreboard players operation @s dd_pred_round /= #four dd_ctx
execute if score @s dd_pred_round >= @s dd_limit run scoreboard players remove @s dd_pred_round 1
