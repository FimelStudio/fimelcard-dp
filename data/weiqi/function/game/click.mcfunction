function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 1 run return 0
execute unless score @a[tag=go.actor,limit=1] go_side = @s go_turn run return 0
execute if score @s go_confirm matches 1 unless score @s go_sel = #to go_ctx run return run function weiqi:game/confirm_target
function weiqi:engine/try_move
execute unless score #legal go_ctx matches 1 run return run function weiqi:game/illegal
function weiqi:game/after_move
