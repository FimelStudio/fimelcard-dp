execute unless entity @s[tag=un.controller] run return fail
function uno:system/context
tellraw @a[tag=un.audience] [{text:'[UNO] 有玩家离线或离桌，本场中止。',color:'yellow'}]
function uno:game/abort
