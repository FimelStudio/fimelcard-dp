# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s dd_drop 0
scoreboard players set @s dd_drop_dye 0
tag @s add dd.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{doudizhu:{tool:"hand"}}] run function doudizhu:input/check_drop
tag @s remove dd.dropper
