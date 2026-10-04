function doudizhu:action/context
execute if entity @e[tag=dd.current,scores={dd_state=2..3},limit=1] if score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run function doudizhu:input/give
function doudizhu:action/clear_context
