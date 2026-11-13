function chess:visual/finish_move
execute if score @s ch_result matches 1..3 run return run function chess:game/finish
function chess:sound/landing
scoreboard players set @s ch_state 1
function chess:clock/update
function chess:ui/refresh
execute if score @s ch_check matches 1 run tellraw @a[tag=ch.audience] {"text": "[国际象棋] 将军！轮到的一方必须解除将军。", "color": "red"}
