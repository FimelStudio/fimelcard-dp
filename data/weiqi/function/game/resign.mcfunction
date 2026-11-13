function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 1..3 run return 0
scoreboard players set @s go_result 1
execute if score @a[tag=go.actor,limit=1] go_side matches 1 run scoreboard players set @s go_result 2
scoreboard players set @s go_reason 7
function weiqi:game/finish
