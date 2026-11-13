function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1..2 run return 0
scoreboard players operation #side gm_ctx = @e[tag=gm.actor,limit=1] gm_side
scoreboard players operation #side gm_ctx *= #minus gm_ctx
scoreboard players set @s gm_result 2
execute if score #side gm_ctx matches 1 run scoreboard players set @s gm_result 1
scoreboard players set @s gm_reason 7
function gomoku:game/finish
