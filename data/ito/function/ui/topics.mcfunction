# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage ito:ui label set from entity @e[tag=it.current,limit=1] data.ito.option1.text
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players add #button it_ctx 1
function ito:ui/button
data modify storage ito:ui label set from entity @e[tag=it.current,limit=1] data.ito.option2.text
scoreboard players operation #button it_ctx = #base it_ctx
scoreboard players add #button it_ctx 2
function ito:ui/button
