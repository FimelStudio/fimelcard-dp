# 两人先一起下座，再改双方身份并骑乘，互换阵营时不会被旧乘客占住。
# 通用层以玩家 ct_id + ct_seat 判断占用；无需修改其他桌子的座椅。
function chess:system/side_seats
execute as @a[tag=ch.audience] run ride @s dismount
execute as @a[tag=ch.audience] run function chess:player/place_side
# 虚拟对手同样占用对应边的逻辑座号，供吃子区朝向和阵营显示使用。
scoreboard players operation @s ch_white = #white_seat ch_ctx
scoreboard players operation @s ch_black = #black_seat ch_ctx
execute unless score @s ch_bot matches 1 run scoreboard players operation @s ch_white = @a[tag=ch.audience,scores={ch_side=1},limit=1] ch_seat
execute unless score @s ch_bot matches -1 run scoreboard players operation @s ch_black = @a[tag=ch.audience,scores={ch_side=-1},limit=1] ch_seat
function cardtable:table/ensure_seats
execute as @a[tag=ch.audience] at @s run function cardtable:seat/mount
