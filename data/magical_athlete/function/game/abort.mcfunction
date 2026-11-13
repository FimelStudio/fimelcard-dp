execute unless score @s ct_state matches 1 run return fail
function magical_athlete:system/context
tellraw @a[tag=ma.audience] {text:"[胡闹运动会] 游戏已中止，返回大厅。",color:"yellow"}
function magical_athlete:game/cleanup
