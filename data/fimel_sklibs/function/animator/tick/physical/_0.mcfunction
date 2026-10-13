
execute store result storage fimel_sklibs:animator temp.args1.vx double 0.001 run scoreboard players get @s fcs_an_vx
execute store result storage fimel_sklibs:animator temp.args1.vy double 0.001 run scoreboard players get @s fcs_an_vy

function fimel_sklibs:animator/tick/physical/_3.tick_0 with entity @s
function fimel_sklibs:animator/tick/physical/_1.move with storage fimel_sklibs:animator temp.args1

scoreboard players operation @s fcs_an_vy -= @s fcs_an_g
scoreboard players remove @s fcs_an_t 1

execute if score @s fcs_an_t matches ..0 run function fimel_sklibs:animator/tick/physical/_2.del_0 with entity @s

