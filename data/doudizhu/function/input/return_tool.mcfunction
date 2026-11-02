# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function doudizhu:action/context
function doudizhu:bid/can_operate
execute if entity @e[tag=dd.current,scores={dd_state=2..3},limit=1] if score #can_operate dd_ctx matches 1 run function doudizhu:input/give
function doudizhu:action/clear_context
