# 冻结在途实体，避免暂停时仍拾取/超时消失；恢复后使用原有补发路径。
scoreboard players operation #flight_table ct_ctx = @s ct_id
scoreboard players set #flight_paused ct_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_paused=1}] if score @s ct_id = #flight_table ct_ctx run scoreboard players set #flight_paused ct_ctx 1
execute if score #flight_paused ct_ctx matches 1 run return run function cardtable:session/freeze_deal
execute if entity @s[tag=ct.deal_frozen] run return run function cardtable:session/thaw_deal
function cardtable:animation/deal/flying_tick
