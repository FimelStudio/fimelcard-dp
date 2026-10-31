function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute if score @s xq_undo matches 0 run return 0
execute if score @e[tag=xq.actor,limit=1] xq_side = @s xq_undo run return 0
scoreboard players set @s xq_undo 0
scoreboard players add @s xq_epoch 1
tellraw @a[tag=xq.audience] {"text": "[中国象棋] 悔棋申请已被拒绝。", "color": "yellow"}
function xiangqi:ui/refresh
