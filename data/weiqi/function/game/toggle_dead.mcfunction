function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 3 run return 0
function weiqi:engine/toggle_dead
execute unless score #ok go_ctx matches 1 run return 0
function weiqi:game/reset_score_confirm
function weiqi:engine/score
function weiqi:visual/refresh
function weiqi:visual/estimate
function weiqi:ui/refresh
