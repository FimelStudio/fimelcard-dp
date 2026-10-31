scoreboard players operation #side ch_ctx = @s ch_turn
scoreboard players operation #side ch_ctx *= #minus ch_ctx
function chess:engine/can_mate
scoreboard players set @s ch_result 3
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches 1 run scoreboard players set @s ch_result 1
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches -1 run scoreboard players set @s ch_result 2
scoreboard players set @s ch_reason 6
function chess:game/finish
