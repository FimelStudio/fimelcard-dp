execute unless entity @s[tag=gd.controller] run return 0
function guandan:system/context
tellraw @a[tag=gd.audience] {text:"[掼蛋] 本场已中止。",color:"yellow"}
function guandan:game/cleanup
