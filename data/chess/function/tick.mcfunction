# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function chess:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=12},tag=!ch.controller] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function chess:game/init_table
execute as @e[type=minecraft:marker,tag=ch.controller,scores={ct_game=12}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function chess:system/tick
