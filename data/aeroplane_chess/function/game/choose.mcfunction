function aeroplane_chess:game/actor_guard
execute unless score #actor_ok ac_ctx matches 1 run return 0
execute unless score @e[tag=ac.actor,limit=1] ac_color = @s ac_turn run return 0
function aeroplane_chess:game/choose_internal
