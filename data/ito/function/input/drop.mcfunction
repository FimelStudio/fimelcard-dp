# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=it.drop] remove it.drop
tag @s add it.drop
execute on origin if entity @s[tag=it.player] at @s run function ito:input/from_player
kill @s
