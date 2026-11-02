# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s ll_drop 0
tag @a[tag=ll.dropper] remove ll.dropper
tag @s add ll.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents *[minecraft:custom_data~{love_letter:{tool:1b}}] run function love_letter:input/check_drop
tag @a[tag=ll.dropper] remove ll.dropper
