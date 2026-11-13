function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 1 run return 0
execute if score @s go_undo matches 0 run return 0
execute if score @a[tag=go.actor,limit=1] go_side = @s go_undo run return 0
scoreboard players set @s go_undo 0
scoreboard players add @s go_epoch 1
tellraw @a[tag=go.audience] {"text": "[围棋] 悔棋申请已被拒绝。", "color": "yellow"}
function weiqi:ui/refresh
