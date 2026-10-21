execute if score @e[tag=dd.current,limit=1] dd_bidmode matches 1 run return run function doudizhu:bot/rob
execute if score @e[tag=dd.current,limit=1] dd_bidmode matches 2 run return run function doudizhu:bid/speed_submit
# 没人叫分时叫1分；已有叫分就不叫，避免测试局连续无人叫地主。
scoreboard players set #action dd_ctx 200
execute if score @e[tag=dd.current,limit=1] dd_bid matches 0 run scoreboard players set #action dd_ctx 201
function doudizhu:bid/submit
