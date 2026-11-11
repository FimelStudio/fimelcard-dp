scoreboard players operation #opposite dd_ctx = @s ct_seat
scoreboard players operation #opposite dd_ctx += #seat_span dd_ctx
execute if score #opposite dd_ctx > #seat_capacity dd_ctx run scoreboard players operation #opposite dd_ctx -= #seat_capacity dd_ctx
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx if score @s ct_seat = #opposite dd_ctx run scoreboard players add #paired dd_ctx 1
