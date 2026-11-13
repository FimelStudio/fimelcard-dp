function xiangqi:visual/finish_move
execute if score @s xq_result matches 1..3 run return run function xiangqi:game/finish
function xiangqi:sound/landing
scoreboard players set @s xq_state 1
function xiangqi:clock/update
function xiangqi:ui/refresh
execute if score @s xq_check matches 1 run tellraw @a[tag=xq.audience] {"text": "[中国象棋] 将军！轮到的一方必须解除将军。", "color": "red"}
