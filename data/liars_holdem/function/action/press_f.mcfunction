# 执行者已被tick确认为当前回合且Call物品位于副手的玩家
execute unless entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0,lh_swap_pending=0}] run return 0

scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.action_actor] remove lh.action_actor
tag @s add lh.action_actor
tag @e[tag=lh.action_controller] remove lh.action_controller
execute as @e[type=minecraft:marker,tag=lh.controller] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.action_controller

# 普通三个行动阶段和最终抉择阶段可以F键ALL IN；全押响应阶段的F视为跟随
scoreboard players set #action_valid lh_ctx 0
execute if entity @e[tag=lh.action_controller,scores={lh_state=5},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute if entity @e[tag=lh.action_controller,scores={lh_state=7},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute if entity @e[tag=lh.action_controller,scores={lh_state=9},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute if entity @e[tag=lh.action_controller,scores={lh_state=11},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute if entity @e[tag=lh.action_controller,scores={lh_state=12},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute unless score #action_valid lh_ctx matches 1 run tag @s remove lh.action_actor
execute unless score #action_valid lh_ctx matches 1 run tag @e[tag=lh.action_controller] remove lh.action_controller
execute unless score #action_valid lh_ctx matches 1 run return 0

scoreboard players operation #f_state lh_ctx = @e[tag=lh.action_controller,limit=1] lh_state
execute if score #f_state lh_ctx matches 5 as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:action/all_in
execute if score #f_state lh_ctx matches 7 as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:action/all_in
execute if score #f_state lh_ctx matches 9 as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:action/all_in
execute if score #f_state lh_ctx matches 11 as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:action/all_in
execute if score #f_state lh_ctx matches 12 as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:action/follow_allin
tag @e[tag=lh.action_controller] remove lh.action_controller
tag @s remove lh.action_actor
