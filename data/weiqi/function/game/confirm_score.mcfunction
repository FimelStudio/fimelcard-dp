function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 3 run return 0
execute if score @a[tag=go.actor,limit=1] go_side matches 1 run scoreboard players set @s go_bconfirm 1
execute if score @a[tag=go.actor,limit=1] go_side matches -1 run scoreboard players set @s go_wconfirm 1
scoreboard players add @s go_epoch 1
execute if score @s go_bconfirm matches 1 if score @s go_wconfirm matches 1 run return run function weiqi:game/settle_score
function weiqi:ui/refresh
