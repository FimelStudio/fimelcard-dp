# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
clear @s minecraft:purple_dye[minecraft:custom_data~{catan:{tool:1b}}]
scoreboard players set @s ca_dye 0
