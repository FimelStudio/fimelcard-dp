function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute unless score @s xq_bot matches 0 run return run function xiangqi:game/bot_draw
scoreboard players operation @s xq_draw = @e[tag=xq.actor,limit=1] xq_side
scoreboard players set @s xq_undo 0
scoreboard players add @s xq_epoch 1
tellraw @a[tag=xq.audience] {"text": "[中国象棋] 一方提出和棋，可按 Q 在对局面板中接受或拒绝。", "color": "yellow"}
function xiangqi:ui/refresh
