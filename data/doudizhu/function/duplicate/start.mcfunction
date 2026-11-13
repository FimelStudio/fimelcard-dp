# 奇数座位打甲桌，偶数座位打乙桌。正对座位始终在同一分桌。
scoreboard players set @s dd_lane 1
scoreboard players set @s dd_humans 4
scoreboard players set @s dd_bidmode 0
scoreboard players set @s dd_bidbye 7
scoreboard players set @s dd_pair_scored 0
function doudizhu:predict/init
data remove entity @s data.dd_duplicate
execute summon minecraft:marker run function doudizhu:duplicate/init_other
scoreboard players operation #match dd_ctx = @s ct_id
execute as @e[tag=dd.actor] if score @s dd_id = #match dd_ctx run function doudizhu:duplicate/assign_seat
execute as @a[tag=dd.player] if score @s ct_id = #match dd_ctx run function doudizhu:duplicate/announce_seat
scoreboard players set @s ct_start 1
function doudizhu:duplicate/deal_pair
