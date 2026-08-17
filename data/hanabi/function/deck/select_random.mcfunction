# 执行者必须是本桌控制器；临时池只在本同步函数链内存在
tag @e[tag=hb.drawn] remove hb.drawn
tag @e[tag=hb.deck_pool] remove hb.deck_pool
scoreboard players operation #ctx_id hb_ctx = @s hb_id
execute as @e[type=minecraft:marker,tag=hb.deck] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.deck_pool
execute as @e[type=minecraft:marker,tag=hb.deck_pool,sort=random,limit=1] run tag @s add hb.drawn
tag @e[tag=hb.deck_pool] remove hb.deck_pool
