scoreboard players operation #capacity gm_ctx = @s gm_size
scoreboard players operation #capacity gm_ctx *= @s gm_size
execute unless score @s gm_moves >= #capacity gm_ctx run return 0
scoreboard players set @s gm_result 3
scoreboard players set @s gm_reason 2
