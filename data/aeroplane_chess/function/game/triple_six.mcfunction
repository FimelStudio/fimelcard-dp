tellraw @a[tag=ac.audience] {"text": "[飞行棋] 连续第三次 6，本次不行动并结束回合。前两次移动保留。", "color": "yellow"}
scoreboard players set @s ac_sixes 0
function aeroplane_chess:game/next_turn
