# 玩家骑乘座椅离线时，座椅可能进入玩家 RootVehicle 存档。
# 必须等整张桌子所在区块均已加载，避免将未加载的座位误判为丢失。
execute unless loaded ~-3 ~ ~-3 run return 0
execute unless loaded ~3 ~ ~-3 run return 0
execute unless loaded ~-3 ~ ~3 run return 0
execute unless loaded ~3 ~ ~3 run return 0
scoreboard players operation #seat_owner ct_ctx = @s ct_id
execute if score @s ct_capacity matches 8 run return run function cardtable:table/ensure_seats8
scoreboard players set #new_seat ct_ctx 1
execute positioned ~ ~0.32 ~-2 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 2
execute positioned ~2 ~0.32 ~ run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 3
execute positioned ~ ~0.32 ~2 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 4
execute positioned ~-2 ~0.32 ~ run function cardtable:seat/ensure_one
