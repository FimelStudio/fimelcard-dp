tag @e[tag=ab.drawn] remove ab.drawn
tag @e[tag=ab.draw_pool] remove ab.draw_pool
execute as @e[type=minecraft:marker,tag=ab.deck] if score @s ab_id = #ctx ab_ctx run tag @s add ab.draw_pool
tag @e[type=minecraft:marker,tag=ab.draw_pool,sort=random,limit=1] add ab.drawn
tag @e[tag=ab.draw_pool] remove ab.draw_pool
