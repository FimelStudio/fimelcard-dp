# 只冻结目标，不提前改通用座位。两人全部下座后才提交，避免同椅。
scoreboard players operation @s go_seat = @s ct_seat
execute if score @s go_side matches 1 if score @s go_seat < #black_seat go_ctx run scoreboard players operation @s go_seat = #black_seat go_ctx
execute if score @s go_side matches 1 if score @s go_seat > #black_last go_ctx run scoreboard players operation @s go_seat = #black_seat go_ctx
execute if score @s go_side matches -1 if score @s go_seat < #white_seat go_ctx run scoreboard players operation @s go_seat = #white_seat go_ctx
execute if score @s go_side matches -1 if score @s go_seat > #white_last go_ctx run scoreboard players operation @s go_seat = #white_seat go_ctx
