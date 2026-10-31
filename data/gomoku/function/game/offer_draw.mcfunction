function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute unless score @s gm_bot matches 0 run return run function gomoku:game/bot_draw
scoreboard players operation @s gm_draw = @e[tag=gm.actor,limit=1] gm_side
scoreboard players set @s gm_undo 0
scoreboard players add @s gm_epoch 1
tellraw @a[tag=gm.audience] {"text": "[五子棋] 一方提出和棋，可按 Q 在对局面板中接受或拒绝。", "color": "yellow"}
function gomoku:ui/refresh
