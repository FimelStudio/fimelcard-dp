function doudizhu:action/context
function doudizhu:bid/can_operate
execute if entity @e[tag=dd.current,scores={dd_state=2..3},limit=1] if score #can_operate dd_ctx matches 1 run function doudizhu:input/give
function doudizhu:action/clear_context
