execute store result score #vis_flight_y sp_ctx run data get entity @s transformation.translation[1] 100000
scoreboard players add #vis_flight_y sp_ctx 12000
execute store result entity @s transformation.translation[1] float 0.00001 run scoreboard players get #vis_flight_y sp_ctx
