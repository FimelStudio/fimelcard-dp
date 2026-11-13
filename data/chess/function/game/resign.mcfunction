function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1..3 run return 0
scoreboard players operation #side ch_ctx = @e[tag=ch.actor,limit=1] ch_side
scoreboard players operation #side ch_ctx *= #minus ch_ctx
function chess:engine/can_mate
scoreboard players set @s ch_result 3
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches 1 run scoreboard players set @s ch_result 1
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches -1 run scoreboard players set @s ch_result 2
scoreboard players set @s ch_reason 7
function chess:game/finish
