# 北、东、南、西顺时针编号；每侧中心偏移±1格，椅子之间净空1格。
scoreboard players operation #seat_owner ct_ctx = @s ct_id
scoreboard players set #new_seat ct_ctx 1
execute positioned ~-1 ~0.32 ~-2.5 summon minecraft:interaction run function cardtable:seat/init8
scoreboard players set #new_seat ct_ctx 2
execute positioned ~1 ~0.32 ~-2.5 summon minecraft:interaction run function cardtable:seat/init8
scoreboard players set #new_seat ct_ctx 3
execute positioned ~2.5 ~0.32 ~-1 summon minecraft:interaction run function cardtable:seat/init8
scoreboard players set #new_seat ct_ctx 4
execute positioned ~2.5 ~0.32 ~1 summon minecraft:interaction run function cardtable:seat/init8
scoreboard players set #new_seat ct_ctx 5
execute positioned ~1 ~0.32 ~2.5 summon minecraft:interaction run function cardtable:seat/init8
scoreboard players set #new_seat ct_ctx 6
execute positioned ~-1 ~0.32 ~2.5 summon minecraft:interaction run function cardtable:seat/init8
scoreboard players set #new_seat ct_ctx 7
execute positioned ~-2.5 ~0.32 ~1 summon minecraft:interaction run function cardtable:seat/init8
scoreboard players set #new_seat ct_ctx 8
execute positioned ~-2.5 ~0.32 ~-1 summon minecraft:interaction run function cardtable:seat/init8
function cardtable:table/spawn_chairs8
data merge entity @s {data:{cardtable:{chairs_version:1}}}
