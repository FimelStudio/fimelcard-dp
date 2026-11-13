execute unless score @s ct_id = #prediction_table dd_ctx run return 0
function doudizhu:predict/bind
execute unless score @e[tag=dd.pred_controller,limit=1] dd_pred_token = #prediction_token dd_ctx run return 0
function doudizhu:predict/submit
