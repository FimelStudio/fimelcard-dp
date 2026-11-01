# 只计算目标，暂不修改通用座位，避免双方互换时出现中间的同座身份。
scoreboard players operation @s xq_seat = @s ct_seat
execute if score @s xq_side matches 1 if score @s xq_seat < #red_seat xq_ctx run scoreboard players operation @s xq_seat = #red_seat xq_ctx
execute if score @s xq_side matches 1 if score @s xq_seat > #red_last xq_ctx run scoreboard players operation @s xq_seat = #red_seat xq_ctx
execute if score @s xq_side matches -1 if score @s xq_seat < #black_seat xq_ctx run scoreboard players operation @s xq_seat = #black_seat xq_ctx
execute if score @s xq_side matches -1 if score @s xq_seat > #black_last xq_ctx run scoreboard players operation @s xq_seat = #black_seat xq_ctx
