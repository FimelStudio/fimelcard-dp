execute as @e[tag=ac.board,scores={ac_color=0}] run scoreboard players operation @s ac_active = @e[tag=ac.sides,scores={ac_color=0},limit=1] ac_active
execute as @e[tag=ac.board,scores={ac_color=1}] run scoreboard players operation @s ac_active = @e[tag=ac.sides,scores={ac_color=1},limit=1] ac_active
execute as @e[tag=ac.board,scores={ac_color=2}] run scoreboard players operation @s ac_active = @e[tag=ac.sides,scores={ac_color=2},limit=1] ac_active
execute as @e[tag=ac.board,scores={ac_color=3}] run scoreboard players operation @s ac_active = @e[tag=ac.sides,scores={ac_color=3},limit=1] ac_active
