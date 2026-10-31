function avalon:bind
execute unless entity @e[tag=av.current,limit=1] run return run function avalon:player/clear
function avalon:player/tools
scoreboard players set #manual_ui av_ctx 1
function avalon:dialog/open
scoreboard players set #manual_ui av_ctx 0
tag @e[tag=av.current] remove av.current
