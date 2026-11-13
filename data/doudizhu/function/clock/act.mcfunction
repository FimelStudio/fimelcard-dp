execute if score @e[tag=dd.current,limit=1] dd_state matches 3 run return run function doudizhu:clock/play
scoreboard players set #action dd_ctx 200
execute if score @e[tag=dd.current,limit=1] dd_bidmode matches 0 run return run function doudizhu:bid/submit
scoreboard players set #action dd_ctx 206
execute if score @e[tag=dd.current,limit=1] dd_bidmode matches 1 run function doudizhu:bid/rob_submit
