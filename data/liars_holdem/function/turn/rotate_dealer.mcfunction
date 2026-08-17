# 庄位每局顺时针移动到下一名仍存活的玩家
scoreboard players set #found lh_ctx 0
function liars_holdem:turn/dealer_scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/dealer_scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/dealer_scan_once
execute if score #found lh_ctx matches 0 run function liars_holdem:turn/dealer_scan_once
