function avalon:bind
execute unless entity @e[tag=av.current,limit=1] run function avalon:player/clear
tag @e[tag=av.current] remove av.current
