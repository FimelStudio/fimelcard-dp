# 八座桌保留本来就在对应边的具体座位；否则使用该边的第一个座位。
execute if score @s xq_side matches 1 if score @s ct_seat < #red_seat xq_ctx run scoreboard players operation @s ct_seat = #red_seat xq_ctx
execute if score @s xq_side matches 1 if score @s ct_seat > #red_last xq_ctx run scoreboard players operation @s ct_seat = #red_seat xq_ctx
execute if score @s xq_side matches -1 if score @s ct_seat < #black_seat xq_ctx run scoreboard players operation @s ct_seat = #black_seat xq_ctx
execute if score @s xq_side matches -1 if score @s ct_seat > #black_last xq_ctx run scoreboard players operation @s ct_seat = #black_seat xq_ctx
scoreboard players operation @s xq_seat = @s ct_seat
