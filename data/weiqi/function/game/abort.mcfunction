execute unless entity @s[tag=go.controller] run return fail
execute unless score @s ct_state matches 1 run return fail
function weiqi:system/context
function weiqi:game/early_record
tellraw @a[tag=go.audience] {"text": "[围棋] 本场已中止，牌桌返回大厅，保留棋面供复盘。", "color": "yellow"}
function weiqi:game/cleanup
