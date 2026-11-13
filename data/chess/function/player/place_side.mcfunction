# 只计算目标，暂不修改通用座位，避免双方互换时出现中间的同座身份。
scoreboard players operation @s ch_seat = @s ct_seat
execute if score @s ch_side matches 1 if score @s ch_seat < #white_seat ch_ctx run scoreboard players operation @s ch_seat = #white_seat ch_ctx
execute if score @s ch_side matches 1 if score @s ch_seat > #white_last ch_ctx run scoreboard players operation @s ch_seat = #white_seat ch_ctx
execute if score @s ch_side matches -1 if score @s ch_seat < #black_seat ch_ctx run scoreboard players operation @s ch_seat = #black_seat ch_ctx
execute if score @s ch_side matches -1 if score @s ch_seat > #black_last ch_ctx run scoreboard players operation @s ch_seat = #black_seat ch_ctx
