
scoreboard players remove @s fcs_life 1
execute if score @s fcs_life matches ..0 run kill @s

execute store result storage fimel_sklibs:runtime deathtimer.temp.args1.life int 1.0 run scoreboard players get @s fcs_life
data modify storage fimel_sklibs:runtime deathtimer.temp.args1.UUID set from entity @s UUID

function fimel_sklibs:skapi/deathtimer/_tick_0 with storage fimel_sklibs:runtime deathtimer.temp.args1
