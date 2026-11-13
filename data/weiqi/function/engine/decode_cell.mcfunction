scoreboard players operation @s go_piece = #row go_ctx
scoreboard players operation @s go_piece /= @s go_pow
scoreboard players operation @s go_piece %= #three go_ctx
execute if score @s go_piece matches 2 run scoreboard players set @s go_piece -1
scoreboard players operation @s go_eff = @s go_piece
