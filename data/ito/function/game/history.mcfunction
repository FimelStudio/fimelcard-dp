execute store result storage ito:runtime history.number int 1 run scoreboard players get @s it_number
execute store result storage ito:runtime history.seat int 1 run scoreboard players get @s it_owner
execute store result storage ito:runtime history.used int 1 run scoreboard players get @s it_used
data modify entity @e[tag=it.current,limit=1] data.ito.history append from storage ito:runtime history
