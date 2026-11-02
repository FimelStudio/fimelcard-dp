# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s sp_drop 0
tag @a[tag=sp.dropper] remove sp.dropper
tag @s add sp.dropper
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run function splendor:input/check_drop
tag @s remove sp.dropper
