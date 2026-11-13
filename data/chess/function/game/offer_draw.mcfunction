function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute unless score @s ch_bot matches 0 run return run function chess:game/bot_draw
scoreboard players operation @s ch_draw = @e[tag=ch.actor,limit=1] ch_side
scoreboard players set @s ch_undo 0
scoreboard players add @s ch_epoch 1
tellraw @a[tag=ch.audience] {"text": "[国际象棋] 一方提出和棋，可按 Q 在对局面板中接受或拒绝。", "color": "yellow"}
function chess:ui/refresh
