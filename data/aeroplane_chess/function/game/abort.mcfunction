execute unless entity @s[tag=ac.controller] run return fail
function aeroplane_chess:system/context
tellraw @a[tag=ac.audience] {"text": "[飞行棋] 本场已中止。", "color": "yellow"}
function aeroplane_chess:game/cleanup
