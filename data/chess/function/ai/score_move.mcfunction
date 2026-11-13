function chess:ai/gain
# 优先考虑子力交换，再给占中、发展兵和易位少量加分。
execute store result storage chess:ai pos.f int 1 run scoreboard players get #from ch_ctx
execute store result storage chess:ai pos.t int 1 run scoreboard players get #to ch_ctx
function chess:ai/position with storage chess:ai pos
scoreboard players operation #ai_score ch_ctx += #ai_center_to ch_ctx
scoreboard players operation #ai_score ch_ctx -= #ai_center_from ch_ctx
execute if score #kind ch_ctx matches 1 run function chess:ai/pawn_advance
execute if score #rook_from ch_ctx matches 0..63 run scoreboard players add #ai_score ch_ctx 70
# 在临时棋盘上检查目标格安全；结束后完整还原，不修改真实棋局。
function chess:ai/apply_checked
scoreboard players operation #attack_sq ch_ctx = #to ch_ctx
scoreboard players operation #attacker ch_ctx = #side ch_ctx
scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
function chess:engine/attack
execute if score #attacked ch_ctx matches 1 run function chess:ai/safety_penalty
execute if score @s ch_level matches 3 run function chess:ai/check_bonus
function chess:ai/restore_checked
