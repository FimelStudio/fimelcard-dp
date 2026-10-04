scoreboard players operation #ctx dd_ctx = @s dd_id
scoreboard players set #missing dd_ctx 3
scoreboard players operation #missing dd_ctx -= @s dd_humans
execute if score #missing dd_ctx matches 1.. run function doudizhu:bot/fill_seat {seat:1}
execute if score #missing dd_ctx matches 1.. run function doudizhu:bot/fill_seat {seat:2}
execute if score #missing dd_ctx matches 1.. run function doudizhu:bot/fill_seat {seat:3}
execute if score #missing dd_ctx matches 1.. run function doudizhu:bot/fill_seat {seat:4}
