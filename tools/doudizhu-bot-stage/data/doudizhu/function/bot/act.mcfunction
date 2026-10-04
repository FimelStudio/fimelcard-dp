function doudizhu:action/context
execute unless entity @e[tag=dd.current,limit=1] run return 0
execute if score @e[tag=dd.current,limit=1] dd_state matches 2 run function doudizhu:bot/bid
execute if entity @e[tag=dd.current,limit=1] if score @e[tag=dd.current,limit=1] dd_state matches 3 if score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run function doudizhu:bot/play
function doudizhu:action/clear_context
function doudizhu:bot/clear_actors
