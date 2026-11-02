# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage catan:action input set value {actor:0,code:0,target:-1,a:-1,b:-1,epoch:0,offer:[0,0,0,0,0],want:[0,0,0,0,0]}
execute store result storage catan:action input.actor int 1 run scoreboard players get @s ca_side
execute store result storage catan:action input.epoch int 1 run scoreboard players get @s ca_seen
