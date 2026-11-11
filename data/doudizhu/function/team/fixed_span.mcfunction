scoreboard players operation #seat_capacity dd_ctx = @s ct_capacity
scoreboard players operation #seat_span dd_ctx = #seat_capacity dd_ctx
scoreboard players set #two dd_ctx 2
scoreboard players operation #seat_span dd_ctx /= #two dd_ctx
