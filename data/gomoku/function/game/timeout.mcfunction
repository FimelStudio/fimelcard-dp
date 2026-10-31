function gomoku:system/context
scoreboard players operation #side gm_ctx = @s gm_turn
scoreboard players operation #side gm_ctx *= #minus gm_ctx
scoreboard players set @s gm_result 2
execute if score #side gm_ctx matches 1 run scoreboard players set @s gm_result 1
scoreboard players set @s gm_reason 6
function gomoku:game/finish
