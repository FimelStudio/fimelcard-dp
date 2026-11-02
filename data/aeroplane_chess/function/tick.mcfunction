# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function aeroplane_chess:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15},tag=!ac.controller] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function aeroplane_chess:game/init_table
execute as @e[type=minecraft:marker,tag=ac.controller,scores={ct_game=15}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function aeroplane_chess:system/tick
