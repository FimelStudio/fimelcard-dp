# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s gm_drop 0
tag @a[tag=gm.dropper] remove gm.dropper
tag @s add gm.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}] run function gomoku:input/check_drop
tag @s remove gm.dropper
