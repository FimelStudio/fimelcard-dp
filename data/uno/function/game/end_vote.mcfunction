execute unless entity @s[tag=un.controller] run return fail
function uno:system/context
tellraw @a[tag=un.audience] [{text:'[UNO] 结束投票通过，本场提前结束。',color:'yellow'}]
function uno:game/cleanup
