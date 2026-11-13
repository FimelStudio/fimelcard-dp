# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[distance=0..,type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{ito:{tool:1b}}}}}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function ito:input/drop
execute as @e[distance=0..,type=minecraft:marker,tag=it.controller,scores={it_state=1..4}] unless score @s ct_paused matches 1 unless entity @s[tag=ct.paused_return] at @s run function ito:game/tick
