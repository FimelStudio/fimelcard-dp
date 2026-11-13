execute unless entity @s[tag=go.controller] run return fail
execute unless score @s ct_state matches 1 run return fail
function weiqi:system/context
function weiqi:game/early_record
tellraw @a[tag=go.audience] {"text": "[围棋] 结束投票通过，本场提前结束。", "color": "yellow"}
function weiqi:game/cleanup
