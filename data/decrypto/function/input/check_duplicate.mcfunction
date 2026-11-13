# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=dc.duplicate] remove dc.duplicate
$execute as @e[type=minecraft:item_display,tag=dc.history] if items entity @s contents minecraft:paper[minecraft:custom_name=$(name)] run tag @s add dc.duplicate
