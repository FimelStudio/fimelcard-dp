function catan:ui/prepare
execute store result storage catan:action input.target int 1 run scoreboard players get @s ca_pick
data modify storage catan:action input.code set value 0
execute if score @s ca_mode matches 1 run data modify storage catan:action input.code set value 12
execute if score @s ca_mode matches 2 run data modify storage catan:action input.code set value 21
execute if score @s ca_mode matches 3 run data modify storage catan:action input.code set value 20
execute if score @s ca_mode matches 4 run data modify storage catan:action input.code set value 22
execute if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run data modify storage catan:action input.code set value 1
execute if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run data modify storage catan:action input.code set value 2
function catan:ui/submit
