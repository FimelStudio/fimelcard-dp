# 与八人桌创建时的八个锚点保持一致，只补交互实体，不重复放置椅子。
scoreboard players set #new_seat ct_ctx 1
execute positioned ~-1 ~0.32 ~-2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 2
execute positioned ~1 ~0.32 ~-2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 3
execute positioned ~2.5 ~0.32 ~-1 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 4
execute positioned ~2.5 ~0.32 ~1 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 5
execute positioned ~1 ~0.32 ~2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 6
execute positioned ~-1 ~0.32 ~2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 7
execute positioned ~-2.5 ~0.32 ~1 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 8
execute positioned ~-2.5 ~0.32 ~-1 run function cardtable:seat/ensure_one
