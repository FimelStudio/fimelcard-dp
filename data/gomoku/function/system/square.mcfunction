tag @s add gm.square
scoreboard players operation @s ct_id = #table gm_ctx
$scoreboard players set @s gm_sq $(sq)
$scoreboard players set @s gm_file $(file)
$scoreboard players set @s gm_rank $(rank)
scoreboard players set @s gm_piece 0
