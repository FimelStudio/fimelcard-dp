scoreboard players operation #target cp_ctx = @s cp_action
scoreboard players remove #target cp_ctx 200
scoreboard players set @s cp_action 0
execute unless score #target cp_ctx matches 1..4 run return 0
execute if score @s cp_locked matches 1 run tellraw @s [{text:'[临界点] ',color:'red'},{text:'你已经完成投票。',color:'yellow'}]
execute if score @s cp_locked matches 1 run return 0
scoreboard players operation #ctx cp_ctx = @s cp_id
tag @e[tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=3}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute unless entity @e[tag=cp.current,limit=1] run return 0
execute if score @s cp_seat = #target cp_ctx run tellraw @s [{text:'[临界点] ',color:'red'},{text:'不能投给自己，请重新选择。',color:'red'}]
execute if score @s cp_seat = #target cp_ctx run function critical_point:dialog/open_vote
execute if score @s cp_seat = #target cp_ctx run tag @e[tag=cp.current] remove cp.current
execute if score @s cp_seat = #target cp_ctx run return 0
scoreboard players set #valid cp_ctx 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx if score @s cp_seat = #target cp_ctx run scoreboard players set #valid cp_ctx 1
execute unless score #valid cp_ctx matches 1 run tellraw @s [{text:'[临界点] ',color:'red'},{text:'该座位没有本局玩家，请重新选择。',color:'red'}]
execute unless score #valid cp_ctx matches 1 run function critical_point:dialog/open_vote
execute unless score #valid cp_ctx matches 1 run tag @e[tag=cp.current] remove cp.current
execute unless score #valid cp_ctx matches 1 run return 0
scoreboard players operation @s cp_vote = #target cp_ctx
scoreboard players set @s cp_locked 1
clear @s minecraft:purple_dye[minecraft:custom_data~{critical_point:{tool:'vote_reopen'}}]
dialog clear @s
tellraw @s [{text:'[临界点] ',color:'red'},{text:'你已经完成投票，选择已秘密锁定。',color:'green'}]
execute as @e[tag=cp.current,limit=1] run function critical_point:vote/check_all
tag @e[tag=cp.current] remove cp.current
