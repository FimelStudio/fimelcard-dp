# 每一方单独完成通用骑乘及核验，再处理下一方；不共享待骑乘目标。
function cardtable:seat/mount
scoreboard players operation #mount_seat xq_ctx = @s xq_seat
scoreboard players set #mounted xq_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table xq_ctx if score @s ct_seat = #mount_seat xq_ctx run scoreboard players set #mounted xq_ctx 1
execute unless score #mounted xq_ctx matches 1 run scoreboard players set #seats_ok xq_ctx 0
