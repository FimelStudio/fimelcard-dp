# 按牌桌号和座位号寻找唯一座椅
scoreboard players operation #ctx_id ct_ctx = @s ct_id
scoreboard players operation #ctx_seat ct_ctx = @s ct_seat
tag @e[tag=ct.mount_target] remove ct.mount_target
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #ctx_id ct_ctx if score @s ct_seat = #ctx_seat ct_ctx run tag @s add ct.mount_target
execute unless entity @e[tag=ct.mount_target,limit=1] run return fail

ride @s dismount
tp @s @e[tag=ct.mount_target,limit=1]
execute if score @s ct_seat matches 1 run tp @s ~ ~ ~ 0 0
execute if score @s ct_seat matches 2 run tp @s ~ ~ ~ 90 0
execute if score @s ct_seat matches 3 run tp @s ~ ~ ~ 180 0
execute if score @s ct_seat matches 4 run tp @s ~ ~ ~ -90 0
ride @s mount @e[tag=ct.mount_target,limit=1]

tag @e[tag=ct.mount_target] remove ct.mount_target
