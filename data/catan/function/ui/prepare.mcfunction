data modify storage catan:action input set value {actor:0,code:0,target:-1,a:-1,b:-1,epoch:0,offer:[0,0,0,0,0],want:[0,0,0,0,0]}
execute store result storage catan:action input.actor int 1 run scoreboard players get @s ca_side
execute store result storage catan:action input.epoch int 1 run scoreboard players get @s ca_seen
