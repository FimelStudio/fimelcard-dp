function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute unless score @s xq_bot matches 0 run return run function xiangqi:game/bot_undo
execute unless data entity @s data.xiangqi.undo run tellraw @a[tag=xq.actor] {"text": "[中国象棋] 目前没有可撤回的走子。", "color": "red"}
execute unless data entity @s data.xiangqi.undo run return 0
scoreboard players operation @s xq_undo = @e[tag=xq.actor,limit=1] xq_side
scoreboard players set @s xq_draw 0
scoreboard players add @s xq_epoch 1
tellraw @a[tag=xq.audience] {"text": "[中国象棋] 对手申请悔棋，手持对局菜单按 Q 回应。", "color": "yellow"}
function xiangqi:ui/refresh
