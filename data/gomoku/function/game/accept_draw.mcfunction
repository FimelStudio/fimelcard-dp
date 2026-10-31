function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute if score @s gm_draw matches 0 run return 0
execute if score @e[tag=gm.actor,limit=1] gm_side = @s gm_draw run return 0
scoreboard players set @s gm_result 3
scoreboard players set @s gm_reason 8
function gomoku:game/finish
