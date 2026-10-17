execute if score @s ct_skin matches 1 run return 0
# 控制器位置执行；方块展示实体与座位共用中心、桌号和座号。
scoreboard players operation #seat_owner ct_ctx = @s ct_id
execute as @e[type=minecraft:block_display,tag=ct.chair8] if score @s ct_id = #seat_owner ct_ctx run kill @s
scoreboard players set #new_seat ct_ctx 1
execute positioned ~-1 ~ ~-2.5 summon minecraft:block_display run function cardtable:seat/chair8_init
scoreboard players set #new_seat ct_ctx 2
execute positioned ~1 ~ ~-2.5 summon minecraft:block_display run function cardtable:seat/chair8_init
scoreboard players set #new_seat ct_ctx 3
execute positioned ~2.5 ~ ~-1 summon minecraft:block_display run function cardtable:seat/chair8_init
scoreboard players set #new_seat ct_ctx 4
execute positioned ~2.5 ~ ~1 summon minecraft:block_display run function cardtable:seat/chair8_init
scoreboard players set #new_seat ct_ctx 5
execute positioned ~1 ~ ~2.5 summon minecraft:block_display run function cardtable:seat/chair8_init
scoreboard players set #new_seat ct_ctx 6
execute positioned ~-1 ~ ~2.5 summon minecraft:block_display run function cardtable:seat/chair8_init
scoreboard players set #new_seat ct_ctx 7
execute positioned ~-2.5 ~ ~1 summon minecraft:block_display run function cardtable:seat/chair8_init
scoreboard players set #new_seat ct_ctx 8
execute positioned ~-2.5 ~ ~-1 summon minecraft:block_display run function cardtable:seat/chair8_init
