execute if score @s ct_joined > @s ct_capacity run return fail
execute unless score @s ct_joined matches 3..8 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[瞎掰王] ',color:'yellow'},{text:'需要3至8名玩家入座。',color:'red'}]
execute unless score @s ct_joined matches 3..8 run return fail
scoreboard players operation #ctx bw_ctx = @s ct_id
tag @s add bw.controller
scoreboard players operation @s bw_id = @s ct_id
scoreboard players set @s bw_state 1
scoreboard players set @s bw_round 1
execute store result entity @s data.bullshit.players int 1 run scoreboard players get @s ct_joined
scoreboard players set @s bw_turn 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx bw_ctx run tag @s add bw.player
execute as @a[tag=bw.player] if score @s ct_id = #ctx bw_ctx run scoreboard players operation @s bw_id = @s ct_id
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players operation @s bw_seat = @s ct_seat
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_score 0
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_drop 0
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run scoreboard players set @s bw_drop_dye 0
# 第一轮大聪明从本桌实际玩家中随机选出；后续各轮仍按座位轮换。
tag @a[tag=bw.first_pool] remove bw.first_pool
tag @a[tag=bw.first_smart] remove bw.first_smart
execute as @a[tag=bw.player] if score @s bw_id = #ctx bw_ctx run tag @s add bw.first_pool
tag @a[tag=bw.first_pool,sort=random,limit=1] add bw.first_smart
scoreboard players operation @s bw_turn = @a[tag=bw.first_smart,limit=1] bw_seat
scoreboard players remove @s bw_turn 1
execute if score @s bw_turn matches ..0 run scoreboard players set @s bw_turn 8
tag @a[tag=bw.first_pool] remove bw.first_pool
tag @a[tag=bw.first_smart] remove bw.first_smart
scoreboard players set @s ct_start 1
function bullshit:round/begin
