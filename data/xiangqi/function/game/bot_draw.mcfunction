tellraw @a[tag=xq.audience] {"text": "[中国象棋] 人机同意和棋。", "color": "yellow"}
scoreboard players set @s xq_result 3
scoreboard players set @s xq_reason 8
function xiangqi:game/finish
