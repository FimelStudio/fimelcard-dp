execute unless entity @s[tag=gm.controller] run return fail
function gomoku:system/context
tellraw @a[tag=gm.audience] {"text": "[五子棋] 结束投票通过，本场提前结束。", "color": "yellow"}
function gomoku:game/cleanup
