execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{ito:{tool:1b}}}}}] at @s run function ito:input/drop
execute as @e[type=minecraft:marker,tag=it.controller,scores={it_state=1..4}] at @s run function ito:game/tick
