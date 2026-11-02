# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function avalon:bind
execute unless entity @e[tag=av.current,limit=1] run return run function avalon:player/clear
function avalon:player/tools
scoreboard players set #manual_ui av_ctx 1
function avalon:dialog/open
scoreboard players set #manual_ui av_ctx 0
tag @e[tag=av.current] remove av.current
