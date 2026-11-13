execute if score #next gd_ctx matches 1..8 run return 0
scoreboard players add #next_order gd_ctx 3
scoreboard players operation #next_order gd_ctx %= #four gd_ctx
execute as @e[tag=gd.board,scores={gd_rank=0}] if score @s gd_order = #next_order gd_ctx run scoreboard players operation #next gd_ctx = @s gd_seat
