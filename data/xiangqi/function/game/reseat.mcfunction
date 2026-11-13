# 先冻结双方目标座位，再全部下座、统一更新身份，最后按阵营分别骑乘。
# 不让尚未执行的玩家继续占用另一方目标，也不让临时选择器跨玩家串位。
function xiangqi:system/context
function xiangqi:system/side_seats
scoreboard players set #red_ready xq_ctx 0
scoreboard players set #black_ready xq_ctx 0
execute as @a[tag=xq.audience,scores={xq_side=1}] run scoreboard players add #red_ready xq_ctx 1
execute as @a[tag=xq.audience,scores={xq_side=-1}] run scoreboard players add #black_ready xq_ctx 1
execute if score @s xq_bot matches 1 run scoreboard players add #red_ready xq_ctx 1
execute if score @s xq_bot matches -1 run scoreboard players add #black_ready xq_ctx 1
execute unless score #red_ready xq_ctx matches 1 run return 0
execute unless score #black_ready xq_ctx matches 1 run return 0
execute as @a[tag=xq.audience] run function xiangqi:player/place_side
execute as @a[tag=xq.audience] run ride @s dismount
execute as @a[tag=xq.audience] run scoreboard players operation @s ct_seat = @s xq_seat
# 虚拟对手同样占用对应边的逻辑座号，供吃子区朝向和阵营显示使用。
scoreboard players operation @s xq_red = #red_seat xq_ctx
scoreboard players operation @s xq_black = #black_seat xq_ctx
execute unless score @s xq_bot matches 1 run scoreboard players operation @s xq_red = @a[tag=xq.audience,scores={xq_side=1},limit=1] xq_seat
execute unless score @s xq_bot matches -1 run scoreboard players operation @s xq_black = @a[tag=xq.audience,scores={xq_side=-1},limit=1] xq_seat
function cardtable:table/ensure_seats
scoreboard players set #seats_ok xq_ctx 1
execute as @a[tag=xq.audience,scores={xq_side=1},limit=1] at @s run function xiangqi:player/mount_side
execute as @a[tag=xq.audience,scores={xq_side=-1},limit=1] at @s run function xiangqi:player/mount_side
return run scoreboard players get #seats_ok xq_ctx
