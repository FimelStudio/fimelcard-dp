scoreboard players set #new_winner ac_ctx 0
execute if score @s ac_winner matches -1 run scoreboard players set #new_winner ac_ctx 1
execute if score @s ac_winner matches -1 as @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] run scoreboard players operation @e[tag=ac.current,limit=1] ac_winner = @s ac_color
execute if score #new_winner ac_ctx matches 1 run scoreboard players operation #winning ac_ctx = @s ac_winner
execute if score #new_winner ac_ctx matches 1 run function aeroplane_chess:game/firework_color
scoreboard players operation #last_rank ac_ctx = @s ac_finished
scoreboard players add #last_rank ac_ctx 1
scoreboard players operation @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] ac_rank = #last_rank ac_ctx
function aeroplane_chess:game/finish
