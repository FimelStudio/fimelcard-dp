function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 1 run return 0
execute if score @s go_undo matches 0 run return 0
execute if score @a[tag=go.actor,limit=1] go_side = @s go_undo run return 0
function weiqi:game/restore_undo
