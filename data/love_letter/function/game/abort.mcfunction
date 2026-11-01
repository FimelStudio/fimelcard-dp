execute unless entity @s[tag=ll.controller] run return 0
function love_letter:system/context
tellraw @a[tag=ll.audience] {text:"[情书] 本场已中止。",color:"yellow"}
function love_letter:game/cleanup
