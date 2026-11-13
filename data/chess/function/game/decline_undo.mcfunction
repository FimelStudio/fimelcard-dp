function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute if score @s ch_undo matches 0 run return 0
execute if score @e[tag=ch.actor,limit=1] ch_side = @s ch_undo run return 0
scoreboard players set @s ch_undo 0
scoreboard players add @s ch_epoch 1
tellraw @a[tag=ch.audience] {"text": "[国际象棋] 悔棋申请已被拒绝。", "color": "yellow"}
function chess:ui/refresh
