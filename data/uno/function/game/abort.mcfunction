execute unless entity @s[tag=un.controller] run return fail
function uno:system/context
tellraw @a[tag=un.audience] [{text:'[UNO] 本场游戏已中止，牌桌返回大厅。',color:'yellow'}]
function uno:log {text:"中止对局并清理专属状态"}
function uno:game/cleanup
