execute unless entity @s[tag=ch.controller] run return fail
function chess:system/context
tellraw @a[tag=ch.audience] {"text": "[国际象棋] 结束投票通过，本场提前结束。", "color": "yellow"}
function chess:game/cleanup
