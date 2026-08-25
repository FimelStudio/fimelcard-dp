# 先收集本桌牌库，再随机抽取，避免其他牌桌的牌先被 limit=1 选中。
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.secret_pick
tag @e[tag=ab.secret_candidate] remove ab.secret_candidate
execute as @e[type=minecraft:marker,tag=ab.deck] if score @s ab_id = #ctx ab_ctx run tag @s add ab.secret_candidate
execute as @e[type=minecraft:marker,tag=ab.secret_candidate,sort=random,limit=1] run tag @s add ab.secret_pick
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.deck
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run tag @s add ab.secret_stone
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run scoreboard players set @s ab_owner 0
execute as @e[tag=ab.secret_pick] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.secret_pick
tag @e[tag=ab.secret_candidate] remove ab.secret_candidate
