# 八座桌保留本来就在对应边的具体座位；否则使用该边的第一个座位。
execute if score @s ch_side matches 1 if score @s ct_seat < #white_seat ch_ctx run scoreboard players operation @s ct_seat = #white_seat ch_ctx
execute if score @s ch_side matches 1 if score @s ct_seat > #white_last ch_ctx run scoreboard players operation @s ct_seat = #white_seat ch_ctx
execute if score @s ch_side matches -1 if score @s ct_seat < #black_seat ch_ctx run scoreboard players operation @s ct_seat = #black_seat ch_ctx
execute if score @s ch_side matches -1 if score @s ct_seat > #black_last ch_ctx run scoreboard players operation @s ct_seat = #black_seat ch_ctx
scoreboard players operation @s ch_seat = @s ct_seat
