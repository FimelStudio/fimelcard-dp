# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players set @s ma_drop 0
tag @a[tag=ma.dropper] remove ma.dropper
tag @s add ma.dropper
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:input/check_drop
tag @s remove ma.dropper
