# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s dd_action matches 300 run return run function doudizhu:predict/reopen
execute if score @s dd_action matches 301..308 run return run function doudizhu:predict/from_dialog
scoreboard players set #submitted dd_ctx 0
scoreboard players operation #action dd_ctx = @s dd_action
scoreboard players set @s dd_action 0
function doudizhu:action/context
execute unless entity @e[tag=dd.current,limit=1] run return run function doudizhu:player/clear_state
execute unless score @e[tag=dd.current,limit=1] dd_state matches 2..3 run return run function doudizhu:action/clear_context
function doudizhu:bid/can_operate
execute unless score #can_operate dd_ctx matches 1 run return run function doudizhu:input/reject
execute if score #action dd_ctx matches 1..54 run scoreboard players set @e[tag=dd.current,limit=1] dd_hint 0
execute if score #action dd_ctx matches 1..54 if score @e[tag=dd.current,limit=1] dd_state matches 2..3 run function doudizhu:action/toggle
execute if score #action dd_ctx matches 100 run function doudizhu:action/play
execute if score #action dd_ctx matches 101 run function doudizhu:action/pass
execute if score #action dd_ctx matches 102 run scoreboard players set @e[tag=dd.current,limit=1] dd_hint 0
execute if score #action dd_ctx matches 102 run scoreboard players set @e[tag=dd.hand] dd_selected 0
execute if score #action dd_ctx matches 103 if score @e[tag=dd.current,limit=1] dd_state matches 3 run function doudizhu:hint/select
execute if score #action dd_ctx matches 200..203 run function doudizhu:bid/submit
execute if score #action dd_ctx matches 204..206 run function doudizhu:bid/rob_submit
execute if score #action dd_ctx matches 207 run function doudizhu:bid/speed_submit
execute if entity @s[tag=dd.player] if score #submitted dd_ctx matches 0 run function doudizhu:dialog/open
execute if entity @s[tag=dd.player] if score #submitted dd_ctx matches 1 run dialog clear @s
tag @e[tag=dd.current] remove dd.current
tag @e[tag=dd.hand] remove dd.hand
