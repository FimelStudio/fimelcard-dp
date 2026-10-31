execute unless entity @s[tag=xq.controller] run return fail
function xiangqi:system/context
tellraw @a[tag=xq.audience] {"text": "[中国象棋] 结束投票通过，本场提前结束。", "color": "yellow"}
function xiangqi:game/cleanup
