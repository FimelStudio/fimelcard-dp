# 规则淘汰真正释放座位时注销该成员；离线本身绝不调用本函数。
execute unless score @s ct_session matches 1.. run return 0
scoreboard players operation #depart_table ct_ctx = @s ct_id
scoreboard players operation #depart_session ct_ctx = @s ct_session
execute store result storage cardtable:session departed.seat int 1 run scoreboard players get @s ct_seat
execute in minecraft:overworld as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] if score @s ct_id = #depart_table ct_ctx if score @s ct_session = #depart_session ct_ctx run function cardtable:session/drop_at_table
execute in minecraft:the_nether as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] if score @s ct_id = #depart_table ct_ctx if score @s ct_session = #depart_session ct_ctx run function cardtable:session/drop_at_table
execute in minecraft:the_end as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={ct_state=1}] if score @s ct_id = #depart_table ct_ctx if score @s ct_session = #depart_session ct_ctx run function cardtable:session/drop_at_table
