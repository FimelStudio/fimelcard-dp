execute unless entity @s[tag=gm.controller] run return fail
function gomoku:system/context
tellraw @a[tag=gm.audience] {"text": "[五子棋] 本场已中止，牌桌返回大厅。", "color": "yellow"}
function gomoku:game/cleanup
