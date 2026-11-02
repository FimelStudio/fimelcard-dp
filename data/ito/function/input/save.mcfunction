# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result score #length it_ctx run data get storage ito:input incoming
execute unless score #length it_ctx matches 1..80 run return run function ito:input/reject
function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
data modify entity @e[tag=it.focus,limit=1] data.description set from storage ito:input incoming
tellraw @s {"text":"[命悬一线] 描述已更新，出牌前可以继续修改。","color":"green"}
execute as @e[tag=it.current,limit=1] at @s run function ito:hud/refresh
