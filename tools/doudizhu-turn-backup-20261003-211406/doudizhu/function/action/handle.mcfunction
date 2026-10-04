scoreboard players operation #action dd_ctx = @s dd_action
scoreboard players set @s dd_action 0
function doudizhu:action/context
execute unless entity @e[tag=dd.current,limit=1] run return run function doudizhu:player/clear_state
execute if score #action dd_ctx matches 1..54 if score @e[tag=dd.current,limit=1] dd_state matches 2..3 run function doudizhu:action/toggle
execute if score #action dd_ctx matches 100 run function doudizhu:action/play
execute if score #action dd_ctx matches 101 run function doudizhu:action/pass
execute if score #action dd_ctx matches 102 run scoreboard players set @e[tag=dd.hand] dd_selected 0
execute if score #action dd_ctx matches 200..203 run function doudizhu:bid/submit
execute if entity @s[tag=dd.player] run function doudizhu:dialog/open
tag @e[tag=dd.current] remove dd.current
tag @e[tag=dd.hand] remove dd.hand
