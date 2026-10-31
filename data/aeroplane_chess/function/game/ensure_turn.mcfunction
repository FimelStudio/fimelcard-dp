scoreboard players set #turn_ok ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1,ac_rank=0}] if score @s ac_color = @e[tag=ac.current,limit=1] ac_turn run scoreboard players set #turn_ok ac_ctx 1
execute if score #turn_ok ac_ctx matches 0 run scoreboard players add @s ac_turn 1
execute if score #turn_ok ac_ctx matches 0 run scoreboard players operation @s ac_turn %= #four ac_ctx
execute if score #turn_ok ac_ctx matches 0 run function aeroplane_chess:game/ensure_turn
