# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s ac_drop 0
tag @a[tag=ac.dropper] remove ac.dropper
tag @s add ac.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}] run function aeroplane_chess:input/check_drop
tag @s remove ac.dropper
