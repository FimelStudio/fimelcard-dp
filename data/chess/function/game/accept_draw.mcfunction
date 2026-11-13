function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute if score @s ch_draw matches 0 run return 0
execute if score @e[tag=ch.actor,limit=1] ch_side = @s ch_draw run return 0
scoreboard players set @s ch_result 3
scoreboard players set @s ch_reason 8
function chess:game/finish
