function xiangqi:ai/gain
# 优先考虑子力交换，再给占中与兵卒发展少量加分。
execute store result storage xiangqi:ai pos.f int 1 run scoreboard players get #from xq_ctx
execute store result storage xiangqi:ai pos.t int 1 run scoreboard players get #to xq_ctx
function xiangqi:ai/position with storage xiangqi:ai pos
scoreboard players operation #ai_score xq_ctx += #ai_center_to xq_ctx
scoreboard players operation #ai_score xq_ctx -= #ai_center_from xq_ctx
execute if score #kind xq_ctx matches 1 run function xiangqi:ai/pawn_advance
# 在临时棋盘上检查目标格安全；结束后完整还原，不修改真实棋局。
function xiangqi:ai/apply_checked
scoreboard players operation #attack_sq xq_ctx = #to xq_ctx
scoreboard players operation #attacker xq_ctx = #side xq_ctx
scoreboard players operation #attacker xq_ctx *= #minus xq_ctx
function xiangqi:engine/attack
execute if score #attacked xq_ctx matches 1 run function xiangqi:ai/safety_penalty
execute if score @s xq_level matches 3 run function xiangqi:ai/check_bonus
function xiangqi:ai/restore_checked
