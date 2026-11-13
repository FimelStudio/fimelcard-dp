execute unless score @s ct_state matches 1 run return fail
function splendor:system/context
tellraw @a[tag=sp.audience] {text:"[璀璨宝石] 游戏已中止，返回大厅。",color:"yellow"}
function splendor:game/cleanup
