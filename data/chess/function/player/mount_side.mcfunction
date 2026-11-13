# 每一方单独完成通用骑乘及核验，再处理下一方；不共享待骑乘目标。
function cardtable:seat/mount
scoreboard players operation #mount_seat ch_ctx = @s ch_seat
scoreboard players set #mounted ch_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table ch_ctx if score @s ct_seat = #mount_seat ch_ctx run scoreboard players set #mounted ch_ctx 1
execute unless score #mounted ch_ctx matches 1 run scoreboard players set #seats_ok ch_ctx 0
