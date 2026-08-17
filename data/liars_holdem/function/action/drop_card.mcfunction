# 当前执行者由物品实体的origin关系解析得到，lh.dropped_owned已精确标记该玩家丢出的牌
scoreboard players set @s lh_drop_card 0
scoreboard players set @s lh_drop_retry 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute unless entity @e[type=minecraft:item,tag=lh.dropped_owned,limit=1] run return fail

tag @a[tag=lh.swap_actor] remove lh.swap_actor
tag @s add lh.swap_actor
tag @e[tag=lh.action_controller] remove lh.action_controller
execute as @e[type=minecraft:marker,tag=lh.controller] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.action_controller
scoreboard players set #swap_valid lh_ctx 0
execute if entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0,lh_swap=1,lh_swap_pending=0}] if entity @e[tag=lh.action_controller,scores={lh_state=5},limit=1] run scoreboard players set #swap_valid lh_ctx 1
execute if entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0,lh_swap=1,lh_swap_pending=0}] if entity @e[tag=lh.action_controller,scores={lh_state=7},limit=1] run scoreboard players set #swap_valid lh_ctx 1
execute if entity @s[tag=lh.turn,scores={lh_alive=1,lh_fold=0,lh_swap=1,lh_swap_pending=0}] if entity @e[tag=lh.action_controller,scores={lh_state=9},limit=1] run scoreboard players set #swap_valid lh_ctx 1

execute unless score #swap_valid lh_ctx matches 1 as @e[tag=lh.dropped_owned,sort=nearest,limit=1] run function liars_holdem:action/return_card
execute unless score #swap_valid lh_ctx matches 1 run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'现在没有可用换牌机会，手牌已退回。',color:'yellow'}]
execute unless score #swap_valid lh_ctx matches 1 run tag @s remove lh.swap_actor
execute unless score #swap_valid lh_ctx matches 1 run tag @e[tag=lh.action_controller] remove lh.action_controller
execute unless score #swap_valid lh_ctx matches 1 run tag @e[tag=lh.dropped_owned] remove lh.dropped_owned
execute unless score #swap_valid lh_ctx matches 1 run return fail

scoreboard players set @s lh_swap_slot 0
execute if items entity @e[tag=lh.dropped_owned,sort=nearest,limit=1] contents minecraft:paper[minecraft:custom_data~{liars_holdem:{slot:1}}] run scoreboard players set @s lh_swap_slot 1
execute if items entity @e[tag=lh.dropped_owned,sort=nearest,limit=1] contents minecraft:paper[minecraft:custom_data~{liars_holdem:{slot:2}}] run scoreboard players set @s lh_swap_slot 2
execute unless score @s lh_swap_slot matches 1..2 as @e[tag=lh.dropped_owned,sort=nearest,limit=1] run function liars_holdem:action/return_card
execute unless score @s lh_swap_slot matches 1..2 run tag @s remove lh.swap_actor
execute unless score @s lh_swap_slot matches 1..2 run tag @e[tag=lh.action_controller] remove lh.action_controller
execute unless score @s lh_swap_slot matches 1..2 run tag @e[tag=lh.dropped_owned] remove lh.dropped_owned
execute unless score @s lh_swap_slot matches 1..2 run return fail

kill @e[tag=lh.dropped_owned,sort=nearest,limit=1]
scoreboard players set @s lh_swap 0
scoreboard players set @s lh_swap_pending 1
execute as @e[tag=lh.action_controller,limit=1] at @s run function liars_holdem:swap/open
tag @e[tag=lh.action_controller] remove lh.action_controller
tag @e[tag=lh.dropped_owned] remove lh.dropped_owned
tag @s remove lh.swap_actor
