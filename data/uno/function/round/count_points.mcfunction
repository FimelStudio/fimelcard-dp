execute if score @s un_value matches 0..9 run scoreboard players operation #u_points un_ctx += @s un_value
execute if score @s un_value matches 10..12 run scoreboard players add #u_points un_ctx 20
execute if score @s un_value matches 13..14 run scoreboard players add #u_points un_ctx 50
