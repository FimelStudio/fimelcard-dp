execute if score @s dd_bidphase matches 1 run return run function doudizhu:bid/rob_second_step
scoreboard players add @s dd_bidcount 1
execute if score @s dd_bidcount matches 3 run return run function doudizhu:bid/rob_second_start
function doudizhu:round/advance
