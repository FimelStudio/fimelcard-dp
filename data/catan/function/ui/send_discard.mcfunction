function catan:ui/prepare
data modify storage catan:action input.code set value 11
execute store result storage catan:action input.offer[0] int 1 run scoreboard players get @s ca_g0
execute store result storage catan:action input.offer[1] int 1 run scoreboard players get @s ca_g1
execute store result storage catan:action input.offer[2] int 1 run scoreboard players get @s ca_g2
execute store result storage catan:action input.offer[3] int 1 run scoreboard players get @s ca_g3
execute store result storage catan:action input.offer[4] int 1 run scoreboard players get @s ca_g4
execute store result storage catan:action input.want[0] int 1 run scoreboard players get @s ca_w0
execute store result storage catan:action input.want[1] int 1 run scoreboard players get @s ca_w1
execute store result storage catan:action input.want[2] int 1 run scoreboard players get @s ca_w2
execute store result storage catan:action input.want[3] int 1 run scoreboard players get @s ca_w3
execute store result storage catan:action input.want[4] int 1 run scoreboard players get @s ca_w4
function catan:ui/submit
