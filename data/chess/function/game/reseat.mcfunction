# 先冻结双方目标座位，再全部下座、统一更新身份，最后按阵营分别骑乘。
# 不让尚未执行的玩家继续占用另一方目标，也不让临时选择器跨玩家串位。
function chess:system/context
function chess:system/side_seats
scoreboard players set #white_ready ch_ctx 0
scoreboard players set #black_ready ch_ctx 0
execute as @a[tag=ch.audience,scores={ch_side=1}] run scoreboard players add #white_ready ch_ctx 1
execute as @a[tag=ch.audience,scores={ch_side=-1}] run scoreboard players add #black_ready ch_ctx 1
execute if score @s ch_bot matches 1 run scoreboard players add #white_ready ch_ctx 1
execute if score @s ch_bot matches -1 run scoreboard players add #black_ready ch_ctx 1
execute unless score #white_ready ch_ctx matches 1 run return 0
execute unless score #black_ready ch_ctx matches 1 run return 0
execute as @a[tag=ch.audience] run function chess:player/place_side
execute as @a[tag=ch.audience] run ride @s dismount
execute as @a[tag=ch.audience] run scoreboard players operation @s ct_seat = @s ch_seat
# 虚拟对手同样占用对应边的逻辑座号，供吃子区朝向和阵营显示使用。
scoreboard players operation @s ch_white = #white_seat ch_ctx
scoreboard players operation @s ch_black = #black_seat ch_ctx
execute unless score @s ch_bot matches 1 run scoreboard players operation @s ch_white = @a[tag=ch.audience,scores={ch_side=1},limit=1] ch_seat
execute unless score @s ch_bot matches -1 run scoreboard players operation @s ch_black = @a[tag=ch.audience,scores={ch_side=-1},limit=1] ch_seat
function cardtable:table/ensure_seats
scoreboard players set #seats_ok ch_ctx 1
execute as @a[tag=ch.audience,scores={ch_side=1},limit=1] at @s run function chess:player/mount_side
execute as @a[tag=ch.audience,scores={ch_side=-1},limit=1] at @s run function chess:player/mount_side
return run scoreboard players get #seats_ok ch_ctx
