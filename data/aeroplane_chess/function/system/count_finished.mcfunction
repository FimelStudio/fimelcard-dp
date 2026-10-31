function aeroplane_chess:system/context
scoreboard players set @s ac_finished 0
execute as @e[tag=ac.sides,scores={ac_rank=1..4}] run scoreboard players add @e[tag=ac.current,limit=1] ac_finished 1
