tag @s add ll.part
scoreboard players operation @s ct_id = #table ll_ctx
scoreboard players operation @s ll_seat = #join_seat ll_ctx
scoreboard players set @s ll_points 0
scoreboard players set @s ll_matchwin 0
scoreboard players set @s ll_hand -1
scoreboard players set @s ll_extra -1
data modify entity @s data.ll_name set from storage love_letter:name resolved
data modify entity @s data.discards set value []
