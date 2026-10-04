function doudizhu:action/context
execute unless entity @e[tag=dd.current,limit=1] run return 0
function doudizhu:hand/build
title @s actionbar {nbt:"hand",storage:"doudizhu:ui",interpret:true}
tag @e[tag=dd.hand] remove dd.hand
tag @e[tag=dd.current] remove dd.current
