# 执行者必须是本桌控制器；只从lh_id相同的剩余牌库随机锁定一张
# 使用同步临时标签是为了避免相邻牌桌的牌库实体被误抽取
tag @e[tag=lh.drawn] remove lh.drawn
tag @e[tag=lh.deck_pool] remove lh.deck_pool
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @e[type=minecraft:marker,tag=lh.deck] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.deck_pool
execute as @e[type=minecraft:marker,tag=lh.deck_pool,sort=random,limit=1] run tag @s add lh.drawn
tag @e[tag=lh.deck_pool] remove lh.deck_pool
