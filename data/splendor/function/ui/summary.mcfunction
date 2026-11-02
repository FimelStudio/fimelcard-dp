# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage splendor:ui title set value "璀璨宝石 · 市场"
data modify storage splendor:ui public set value {text:"",extra:[]}
execute store result storage splendor:ui side int 1 run scoreboard players get @s sp_side
function splendor:ui/private with storage splendor:ui
execute as @e[tag=sp.current,limit=1] run function splendor:ui/table_summary with entity @s data.splendor
function splendor:ui/bank_summary
