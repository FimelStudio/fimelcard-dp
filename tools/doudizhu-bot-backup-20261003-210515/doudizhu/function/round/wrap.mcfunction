execute as @a[tag=dd.audience] if score @s dd_seat < #next dd_ctx run scoreboard players operation #next dd_ctx = @s dd_seat
