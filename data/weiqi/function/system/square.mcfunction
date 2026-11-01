tag @s add go.square
scoreboard players operation @s ct_id = #table go_ctx
$scoreboard players set @s go_sq $(sq)
$scoreboard players set @s go_file $(file)
$scoreboard players set @s go_rank $(rank)
scoreboard players set @s go_piece 0
scoreboard players set @s go_dead 0
