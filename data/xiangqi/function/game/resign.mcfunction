function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1..2 run return 0
scoreboard players operation #side xq_ctx = @e[tag=xq.actor,limit=1] xq_side
scoreboard players operation #side xq_ctx *= #minus xq_ctx
scoreboard players set @s xq_result 2
execute if score #side xq_ctx matches 1 run scoreboard players set @s xq_result 1
scoreboard players set @s xq_reason 7
function xiangqi:game/finish
