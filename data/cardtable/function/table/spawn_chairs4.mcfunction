execute if score @s ct_skin matches 1..6 run return 0
# 仅从新建默认四人桌的 build 调用；已有四人桌及自定义桌椅不迁移。
scoreboard players operation #seat_owner ct_ctx = @s ct_id
execute as @e[type=minecraft:block_display,tag=ct.chair4] if score @s ct_id = #seat_owner ct_ctx run kill @s
scoreboard players set #new_seat ct_ctx 1
execute positioned ~0 ~ ~-2 summon minecraft:block_display run function cardtable:seat/chair4_init
scoreboard players set #new_seat ct_ctx 2
execute positioned ~2 ~ ~0 summon minecraft:block_display run function cardtable:seat/chair4_init
scoreboard players set #new_seat ct_ctx 3
execute positioned ~0 ~ ~2 summon minecraft:block_display run function cardtable:seat/chair4_init
scoreboard players set #new_seat ct_ctx 4
execute positioned ~-2 ~ ~0 summon minecraft:block_display run function cardtable:seat/chair4_init
