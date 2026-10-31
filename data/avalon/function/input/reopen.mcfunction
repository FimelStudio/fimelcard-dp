function avalon:bind
execute unless entity @e[tag=av.current,limit=1] run return run function avalon:player/clear
function avalon:player/tools
function avalon:dialog/open
tag @e[tag=av.current] remove av.current
