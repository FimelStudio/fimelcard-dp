execute unless score @s ct_state matches 1 run return fail
function catan:system/context
tellraw @a[tag=ca.audience] {"text": "[卡坦岛] 游戏已中止，返回大厅。", "color": "yellow"}
function catan:game/cleanup
