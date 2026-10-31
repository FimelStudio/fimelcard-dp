execute unless entity @s[tag=ch.controller] run return fail
function chess:system/context
tellraw @a[tag=ch.audience] {"text": "[国际象棋] 本场已中止，牌桌返回大厅。", "color": "yellow"}
function chess:game/cleanup
