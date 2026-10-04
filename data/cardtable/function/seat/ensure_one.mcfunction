# 以控制器为执行者、目标座位为执行位置。只维护本桌本座位。
tag @e[tag=ct.seat_candidate] remove ct.seat_candidate
tag @e[tag=ct.seat_occupied] remove ct.seat_occupied
tag @e[tag=ct.seat_keep] remove ct.seat_keep
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #seat_owner ct_ctx if score @s ct_seat = #new_seat ct_ctx run tag @s add ct.seat_candidate
execute unless entity @e[tag=ct.seat_candidate] unless score @s ct_capacity matches 8 summon minecraft:interaction run function cardtable:seat/init4
execute unless entity @e[tag=ct.seat_candidate] if score @s ct_capacity matches 8 summon minecraft:interaction run function cardtable:seat/init8
# 新建的实体无需去重；旧实体优先保留有乘客的，避免断开正常乘坐。
execute unless entity @e[tag=ct.seat_candidate] run return 0
execute as @e[tag=ct.seat_candidate] on passengers on vehicle run tag @s add ct.seat_occupied
tag @e[tag=ct.seat_candidate,tag=ct.seat_occupied,limit=1] add ct.seat_keep
execute unless entity @e[tag=ct.seat_keep] run tag @e[tag=ct.seat_candidate,limit=1] add ct.seat_keep
# 若罕见地有多个有人乘坐的副本，先保留它们，待离座后再收回。
kill @e[type=minecraft:interaction,tag=ct.seat_candidate,tag=!ct.seat_keep,tag=!ct.seat_occupied]
tag @e[tag=ct.seat_candidate] remove ct.seat_candidate
tag @e[tag=ct.seat_occupied] remove ct.seat_occupied
tag @e[tag=ct.seat_keep] remove ct.seat_keep
