scoreboard players set @s ch_reason 1
execute if score #side ch_ctx matches 1 run scoreboard players set @s ch_result 2
execute if score #side ch_ctx matches -1 run scoreboard players set @s ch_result 1
