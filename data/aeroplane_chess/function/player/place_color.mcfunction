execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 0 run scoreboard players set @s ct_seat 3
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 1 run scoreboard players set @s ct_seat 4
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 2 run scoreboard players set @s ct_seat 1
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 3 run scoreboard players set @s ct_seat 2
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 0 run scoreboard players set @s ct_seat 4
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 1 run scoreboard players set @s ct_seat 1
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 2 run scoreboard players set @s ct_seat 2
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 4 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 3 run scoreboard players set @s ct_seat 3
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 0 run scoreboard players set @s ct_seat 5
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 1 run scoreboard players set @s ct_seat 7
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 2 run scoreboard players set @s ct_seat 1
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 0 if score @s ac_color matches 3 run scoreboard players set @s ct_seat 3
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 0 run scoreboard players set @s ct_seat 7
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 1 run scoreboard players set @s ct_seat 1
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 2 run scoreboard players set @s ct_seat 3
execute if score @e[tag=ac.current,limit=1] ct_capacity matches 8 if score @e[tag=ac.current,limit=1] ac_orient matches 1 if score @s ac_color matches 3 run scoreboard players set @s ct_seat 5
scoreboard players operation @s ac_seat = @s ct_seat
