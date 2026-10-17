# 仅由经过大厅及桌号验证的设置提交调用。
scoreboard players operation #skin_table ct_ctx = @s ct_id
execute as @e[tag=ct.skin] if score @s ct_id = #skin_table ct_ctx run kill @s
execute as @e[type=minecraft:block_display,tag=ct.chair4] if score @s ct_id = #skin_table ct_ctx run kill @s
execute as @e[type=minecraft:block_display,tag=ct.chair8] if score @s ct_id = #skin_table ct_ctx run kill @s
execute if score @s ct_skin matches 1 unless score @s ct_capacity matches 8 run function cardtable:skin/elegant4
execute if score @s ct_skin matches 1 if score @s ct_capacity matches 8 run function cardtable:skin/elegant8
execute if score @s ct_skin matches 0 unless score @s ct_capacity matches 8 run function cardtable:skin/default4
execute if score @s ct_skin matches 0 if score @s ct_capacity matches 8 run function cardtable:skin/default8
execute if score @s ct_skin matches 0 unless score @s ct_capacity matches 8 run function cardtable:table/spawn_chairs4
execute if score @s ct_skin matches 0 if score @s ct_capacity matches 8 run function cardtable:table/spawn_chairs8
