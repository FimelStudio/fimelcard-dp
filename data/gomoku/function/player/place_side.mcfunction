# 八座桌保留本来就在对应边的具体座位；否则使用该边的第一个座位。
execute if score @s gm_side matches 1 if score @s ct_seat < #black_seat gm_ctx run scoreboard players operation @s ct_seat = #black_seat gm_ctx
execute if score @s gm_side matches 1 if score @s ct_seat > #black_last gm_ctx run scoreboard players operation @s ct_seat = #black_seat gm_ctx
execute if score @s gm_side matches -1 if score @s ct_seat < #white_seat gm_ctx run scoreboard players operation @s ct_seat = #white_seat gm_ctx
execute if score @s gm_side matches -1 if score @s ct_seat > #white_last gm_ctx run scoreboard players operation @s ct_seat = #white_seat gm_ctx
scoreboard players operation @s gm_seat = @s ct_seat
