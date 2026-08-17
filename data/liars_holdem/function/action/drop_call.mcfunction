scoreboard players set @s lh_drop_call 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @e[tag=lh.dropped_owned] remove lh.dropped_owned
scoreboard players set #drop_found lh_ctx 0
execute as @e[type=minecraft:item,distance=..4,sort=nearest] if items entity @s contents minecraft:lime_dye[minecraft:custom_data~{liars_holdem:{action:"call"}}] run function liars_holdem:action/tag_owned_drop
execute unless entity @e[tag=lh.dropped_owned,limit=1] run return 0
kill @e[tag=lh.dropped_owned,sort=nearest,limit=1]

tag @a[tag=lh.action_actor] remove lh.action_actor
tag @s add lh.action_actor
tag @e[tag=lh.action_controller] remove lh.action_controller
execute as @e[type=minecraft:marker,tag=lh.controller] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.action_controller
scoreboard players set #action_valid lh_ctx 0
execute if entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0}] if entity @e[tag=lh.action_controller,scores={lh_state=5},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute if entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0}] if entity @e[tag=lh.action_controller,scores={lh_state=7},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute if entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0}] if entity @e[tag=lh.action_controller,scores={lh_state=9},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute if entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0}] if entity @e[tag=lh.action_controller,scores={lh_state=11..12},limit=1] run scoreboard players set #action_valid lh_ctx 1
execute unless score #action_valid lh_ctx matches 1 run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'现在不能执行跟注。',color:'yellow'}]
execute unless score #action_valid lh_ctx matches 1 run tag @s remove lh.action_actor
execute unless score #action_valid lh_ctx matches 1 run tag @e[tag=lh.action_controller] remove lh.action_controller
execute unless score #action_valid lh_ctx matches 1 run tag @e[tag=lh.dropped_owned] remove lh.dropped_owned
execute unless score #action_valid lh_ctx matches 1 run return fail

execute as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:action/call
tag @e[tag=lh.action_controller] remove lh.action_controller
tag @s remove lh.action_actor
tag @e[tag=lh.dropped_owned] remove lh.dropped_owned
