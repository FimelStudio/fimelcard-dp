function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute unless score @s gm_bot matches 0 run return run function gomoku:game/bot_undo
execute unless data entity @s data.gomoku.undo run tellraw @a[tag=gm.actor] {"text": "[五子棋] 目前没有可撤回的落子。", "color": "black"}
execute unless data entity @s data.gomoku.undo run return 0
scoreboard players operation @s gm_undo = @e[tag=gm.actor,limit=1] gm_side
scoreboard players set @s gm_draw 0
scoreboard players add @s gm_epoch 1
tellraw @a[tag=gm.audience] {"text": "[五子棋] 对手申请悔棋，手持对局菜单按 Q 回应。", "color": "yellow"}
function gomoku:ui/refresh
