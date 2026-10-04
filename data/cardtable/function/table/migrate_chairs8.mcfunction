# 仅迁移八人桌座椅，不重建桌面或重置游戏。
execute unless score @s ct_capacity matches 8 run return 0
scoreboard players operation #seat_owner ct_ctx = @s ct_id
# 只移除旧布局八个位置且朝向相符的默认白桦楼梯。
execute if block ~-1 ~ ~-3 minecraft:birch_stairs[facing=north,half=bottom,shape=straight] run setblock ~-1 ~ ~-3 minecraft:air
execute if block ~0 ~ ~-3 minecraft:birch_stairs[facing=north,half=bottom,shape=straight] run setblock ~0 ~ ~-3 minecraft:air
execute if block ~2 ~ ~-1 minecraft:birch_stairs[facing=east,half=bottom,shape=straight] run setblock ~2 ~ ~-1 minecraft:air
execute if block ~2 ~ ~0 minecraft:birch_stairs[facing=east,half=bottom,shape=straight] run setblock ~2 ~ ~0 minecraft:air
execute if block ~0 ~ ~2 minecraft:birch_stairs[facing=south,half=bottom,shape=straight] run setblock ~0 ~ ~2 minecraft:air
execute if block ~-1 ~ ~2 minecraft:birch_stairs[facing=south,half=bottom,shape=straight] run setblock ~-1 ~ ~2 minecraft:air
execute if block ~-3 ~ ~0 minecraft:birch_stairs[facing=west,half=bottom,shape=straight] run setblock ~-3 ~ ~0 minecraft:air
execute if block ~-3 ~ ~-1 minecraft:birch_stairs[facing=west,half=bottom,shape=straight] run setblock ~-3 ~ ~-1 minecraft:air
# 暂时下马并记录真正坐在本桌上的玩家，移动后回原座；不拉回已离座玩家。
execute as @e[type=minecraft:interaction,tag=ct.seat8] if score @s ct_id = #seat_owner ct_ctx on passengers if entity @s[type=minecraft:player] run tag @s add ct.reseat8
execute as @a[tag=ct.reseat8] run ride @s dismount
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=1}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~-1 ~0.32 ~-2.5
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=2}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~1 ~0.32 ~-2.5
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=3}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~2.5 ~0.32 ~-1
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=4}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~2.5 ~0.32 ~1
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=5}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~1 ~0.32 ~2.5
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=6}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~-1 ~0.32 ~2.5
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=7}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~-2.5 ~0.32 ~1
execute as @e[type=minecraft:interaction,tag=ct.seat8,scores={ct_seat=8}] if score @s ct_id = #seat_owner ct_ctx run tp @s ~-2.5 ~0.32 ~-1
function cardtable:table/spawn_chairs8
execute as @a[tag=ct.reseat8] at @s run function cardtable:seat/mount
tag @a[tag=ct.reseat8] remove ct.reseat8
data merge entity @s {data:{cardtable:{chairs_version:1}}}
