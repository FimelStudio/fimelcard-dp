# 同一对座位以较小座号标识。
scoreboard players operation #pair dd_ctx = @s ct_seat
execute if score #pair dd_ctx > #seat_span dd_ctx run scoreboard players operation #pair dd_ctx -= #seat_span dd_ctx
execute if score #pair dd_ctx = #first_pair dd_ctx run return 0
execute if score #pair dd_ctx = #second_pair dd_ctx run return 0
execute if score #first_pair dd_ctx matches 0 run return run scoreboard players operation #first_pair dd_ctx = #pair dd_ctx
execute if score #second_pair dd_ctx matches 0 run return run scoreboard players operation #second_pair dd_ctx = #pair dd_ctx
scoreboard players set #too_many_pairs dd_ctx 1
