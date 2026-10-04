scoreboard players set @e[tag=dd.hand] dd_selected 0
function doudizhu:bot/search
execute if score #bot_found dd_ctx matches 1 run return run function doudizhu:action/play
scoreboard players set @e[tag=dd.hand] dd_selected 0
function doudizhu:action/pass
