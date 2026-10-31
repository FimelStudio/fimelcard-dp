function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute unless score @s ch_bot matches 0 run return run function chess:game/bot_undo
execute unless data entity @s data.chess.undo run tellraw @a[tag=ch.actor] {"text": "[国际象棋] 目前没有可撤回的走子。", "color": "red"}
execute unless data entity @s data.chess.undo run return 0
scoreboard players operation @s ch_undo = @e[tag=ch.actor,limit=1] ch_side
scoreboard players set @s ch_draw 0
scoreboard players add @s ch_epoch 1
tellraw @a[tag=ch.audience] {"text": "[国际象棋] 对手申请悔棋，手持对局菜单按 Q 回应。", "color": "yellow"}
function chess:ui/refresh
