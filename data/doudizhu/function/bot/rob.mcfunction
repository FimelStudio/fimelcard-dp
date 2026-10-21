scoreboard players set #action dd_ctx 206
execute if score @e[tag=dd.current,limit=1] dd_bid matches 0 run scoreboard players set #action dd_ctx 204
execute store result score #rob_choice dd_ctx run random value 0..1
execute if score @e[tag=dd.current,limit=1] dd_bid matches 1 if score #rob_choice dd_ctx matches 1 run scoreboard players set #action dd_ctx 205
function doudizhu:bid/rob_submit
