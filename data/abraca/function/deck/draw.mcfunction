scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @s ab_seat
execute as @e[tag=ab.drawn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.drawn
execute as @e[type=minecraft:marker,tag=ab.deck,sort=random,limit=1] if score @s ab_id = #ctx ab_ctx run tag @s add ab.drawn
execute unless entity @e[tag=ab.drawn,limit=1] run return 0
execute as @e[tag=ab.drawn,limit=1] run scoreboard players operation @s ab_owner = #seat ab_ctx
execute as @e[tag=ab.drawn,limit=1] run tag @s remove ab.deck
execute as @e[tag=ab.drawn,limit=1] run tag @s add ab.hand
# 【资源包待补】改为 card:abraca/back；当前只给持有者无牌面信息的纸张占位。
give @s minecraft:paper[minecraft:item_name='未知咒语石',minecraft:custom_data={abraca:{stone:1b}},minecraft:max_stack_size=1]
execute as @e[tag=ab.drawn] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.drawn
