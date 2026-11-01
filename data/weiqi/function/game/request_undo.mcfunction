function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s go_state matches 1 run return 0
execute unless score @s go_moves matches 1.. run return 0
execute unless score @s go_bot matches 0 run return run function weiqi:game/bot_undo
scoreboard players operation @s go_undo = @a[tag=go.actor,limit=1] go_side
scoreboard players add @s go_epoch 1
tellraw @a[tag=go.audience] {"text": "[围棋] 对手申请撤回最后一手，按 Q 接受或拒绝。", "color": "yellow"}
function weiqi:ui/refresh
