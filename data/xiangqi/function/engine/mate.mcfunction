scoreboard players set @s xq_reason 1
execute if score @s xq_check matches 0 run scoreboard players set @s xq_reason 2
execute if score #side xq_ctx matches 1 run scoreboard players set @s xq_result 2
execute if score #side xq_ctx matches -1 run scoreboard players set @s xq_result 1
