# 先保存提交值并立即关闭trigger窗口，随后按权威状态分派
scoreboard players operation #action hb_ctx = @s hb_action
scoreboard players set @s hb_action 0
execute unless entity @s[tag=hb.player,tag=hb.turn] run return fail

scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #actor_seat hb_ctx = @s hb_seat
tag @s add hb.action_actor
tag @e[tag=hb.action_controller] remove hb.action_controller
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=2}] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.action_controller
execute unless entity @e[tag=hb.action_controller,limit=1] run tag @s remove hb.action_actor
execute unless entity @e[tag=hb.action_controller,limit=1] run return fail

# 奖励牌处理优先级高于所有普通回合操作；即使本次选择完成并移除了pending，也按入口状态结束分派
scoreboard players set #reward_input hb_ctx 0
execute if entity @s[tag=hb.reward_pending] run scoreboard players set #reward_input hb_ctx 1
execute if score #reward_input hb_ctx matches 1 run function hanabi:reward/input
execute if score #reward_input hb_ctx matches 1 run tag @s remove hb.action_actor
execute if score #reward_input hb_ctx matches 1 run tag @e[tag=hb.action_controller] remove hb.action_controller
execute if score #reward_input hb_ctx matches 1 run return 0

# 没有待处理奖励时，奖励Dialog的旧提交一律无效
execute if score #action hb_ctx matches 801..999 run tag @s remove hb.action_actor
execute if score #action hb_ctx matches 801..999 run tag @e[tag=hb.action_controller] remove hb.action_controller
execute if score #action hb_ctx matches 801..999 run return fail
execute if score #action hb_ctx matches 1100..1399 run tag @s remove hb.action_actor
execute if score #action hb_ctx matches 1100..1399 run tag @e[tag=hb.action_controller] remove hb.action_controller
execute if score #action hb_ctx matches 1100..1399 run return fail

execute if score #action hb_ctx matches 101..105 run scoreboard players operation #slot hb_ctx = #action hb_ctx
execute if score #action hb_ctx matches 101..105 run scoreboard players remove #slot hb_ctx 100
execute if score #action hb_ctx matches 101..105 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:action/play

execute if score #action hb_ctx matches 201..205 run scoreboard players operation #slot hb_ctx = #action hb_ctx
execute if score #action hb_ctx matches 201..205 run scoreboard players remove #slot hb_ctx 200
execute if score #action hb_ctx matches 201..205 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:action/discard

execute if score #action hb_ctx matches 300 run function hanabi:dialog/hint/target
execute if score #action hb_ctx matches 301..308 run function hanabi:action/hint/select_target
execute if score #action hb_ctx matches 390 run function hanabi:input/cancel_hint
execute if score #action hb_ctx matches 401..406 run scoreboard players operation #hint_value hb_ctx = #action hb_ctx
execute if score #action hb_ctx matches 401..406 run scoreboard players remove #hint_value hb_ctx 400
execute if score #action hb_ctx matches 401..406 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:action/hint/color
execute if score #action hb_ctx matches 501..505 run scoreboard players operation #hint_value hb_ctx = #action hb_ctx
execute if score #action hb_ctx matches 501..505 run scoreboard players remove #hint_value hb_ctx 500
execute if score #action hb_ctx matches 501..505 as @e[tag=hb.action_controller,limit=1] at @s run function hanabi:action/hint/rank

execute if score #action hb_ctx matches 700 run function hanabi:dialog/discard/open
execute if score #action hb_ctx matches 701 run function hanabi:dialog/main/open

tag @s remove hb.action_actor
tag @e[tag=hb.action_controller] remove hb.action_controller
