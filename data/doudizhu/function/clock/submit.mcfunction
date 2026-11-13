function doudizhu:action/context
execute unless entity @e[tag=dd.current,scores={dd_state=2..3,dd_turn_clock=0},limit=1] run return run function doudizhu:action/clear_context
execute unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run return run function doudizhu:action/clear_context
dialog clear @s
scoreboard players set @s dd_action 0
function doudizhu:clock/act
function doudizhu:action/clear_context
