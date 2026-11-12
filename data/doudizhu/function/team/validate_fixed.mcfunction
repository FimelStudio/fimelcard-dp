function doudizhu:team/fixed_span
scoreboard players set #first_pair dd_ctx 0
scoreboard players set #second_pair dd_ctx 0
scoreboard players set #too_many_pairs dd_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx dd_ctx run function doudizhu:team/check_opposite
execute if score #too_many_pairs dd_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] {text:"2v2需要坐在同两对对座内。请换到已有玩家的正对座，再开始游戏。",color:"red"}
execute if score #too_many_pairs dd_ctx matches 1 run return fail
# 只有一对有真人时，选择另一对空座给人机。
execute if score #second_pair dd_ctx matches 0 run scoreboard players set #second_pair dd_ctx 1
execute if score #second_pair dd_ctx = #first_pair dd_ctx run scoreboard players set #second_pair dd_ctx 2
return 1
