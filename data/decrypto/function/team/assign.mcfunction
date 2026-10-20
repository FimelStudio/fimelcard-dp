# 只在开局分队；三人模式由game/start独立随机选截密者。
execute if score @s dc_mode matches 3 run return 0
scoreboard players operation #team_capacity dc_ctx = @s ct_capacity
execute if score @s dc_team_mode matches 1 as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_fixed_one
execute if score @s dc_team_mode matches 1 run return 1
# 随机打乱本桌玩家后均分；奇数人数白队多一人。
scoreboard players operation #white_size dc_ctx = @s ct_joined
scoreboard players add #white_size dc_ctx 1
scoreboard players set #two dc_ctx 2
scoreboard players operation #white_size dc_ctx /= #two dc_ctx
scoreboard players set #order dc_ctx 0
tag @a[tag=dc.team_pool] remove dc.team_pool
execute as @a[tag=dc.player] if score @s dc_id = #ctx dc_ctx run tag @s add dc.team_pool
function decrypto:team/random_next
