# 只数公开张数，不读取点数或花色。
execute unless score #bot_seat dd_ctx = #bot_lord dd_ctx unless score @s dd_seat = #bot_lord dd_ctx run return 0
scoreboard players operation #bot_other dd_ctx = @s dd_seat
scoreboard players set #bot_count dd_ctx 0
execute as @e[tag=dd.card] if score @s dd_id = #bot_table dd_ctx if score @s dd_owner = #bot_other dd_ctx run scoreboard players add #bot_count dd_ctx 1
execute if score #bot_count dd_ctx matches 1.. run scoreboard players operation #bot_enemy_min dd_ctx < #bot_count dd_ctx
