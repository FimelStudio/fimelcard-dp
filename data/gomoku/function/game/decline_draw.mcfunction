function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute if score @s gm_draw matches 0 run return 0
execute if score @e[tag=gm.actor,limit=1] gm_side = @s gm_draw run return 0
scoreboard players set @s gm_draw 0
scoreboard players add @s gm_epoch 1
tellraw @a[tag=gm.audience] {"text": "[五子棋] 和棋提议已被拒绝。", "color": "yellow"}
function gomoku:ui/refresh
