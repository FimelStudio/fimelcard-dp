execute unless entity @s[tag=xq.controller] run return fail
function xiangqi:system/context
tellraw @a[tag=xq.audience] {"text": "[中国象棋] 本场已中止，牌桌返回大厅。", "color": "yellow"}
function xiangqi:game/cleanup
