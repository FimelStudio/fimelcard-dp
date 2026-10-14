# 只统计当前在线、仍属于本桌的真人；离桌或淘汰者的旧票不再计入。
scoreboard players operation #vote_table ct_ctx = @s ct_id
scoreboard players set #vote_players ct_ctx 0
scoreboard players set #vote_cast ct_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #vote_table ct_ctx run scoreboard players add #vote_players ct_ctx 1
execute as @a[tag=ct.player,scores={ct_voted=1}] if score @s ct_id = #vote_table ct_ctx run scoreboard players add #vote_cast ct_ctx 1
scoreboard players operation @s ct_votes = #vote_cast ct_ctx
scoreboard players operation #vote_need ct_ctx = #vote_players ct_ctx
execute if score #vote_need ct_ctx matches 3.. run scoreboard players set #vote_need ct_ctx 3
# 八人桌按实际人数严格过半，人数不足八人时同样动态计算。
scoreboard players set #two ct_ctx 2
execute if score @s ct_capacity matches 8 run scoreboard players operation #vote_need ct_ctx = #vote_players ct_ctx
execute if score @s ct_capacity matches 8 run scoreboard players operation #vote_need ct_ctx /= #two ct_ctx
execute if score @s ct_capacity matches 8 run scoreboard players add #vote_need ct_ctx 1
execute if score #vote_need ct_ctx matches ..0 run scoreboard players set #vote_need ct_ctx 1
