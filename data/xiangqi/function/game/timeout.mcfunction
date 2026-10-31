function xiangqi:system/context
scoreboard players operation #side xq_ctx = @s xq_turn
scoreboard players operation #side xq_ctx *= #minus xq_ctx
scoreboard players set @s xq_result 2
execute if score #side xq_ctx matches 1 run scoreboard players set @s xq_result 1
scoreboard players set @s xq_reason 6
function xiangqi:game/finish
