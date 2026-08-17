# 只在所属牌桌处于大厅时把主动下马视为离开
scoreboard players operation #ctx_id ct_ctx = @s ct_id
scoreboard players set #lobby ct_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #ctx_id ct_ctx run scoreboard players set #lobby ct_ctx 1
execute unless score #lobby ct_ctx matches 1 run return 0

scoreboard players operation #ctx_seat ct_ctx = @s ct_seat
scoreboard players set #mounted ct_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #ctx_id ct_ctx if score @s ct_seat = #ctx_seat ct_ctx run scoreboard players set #mounted ct_ctx 1
execute if score #mounted ct_ctx matches 0 run function cardtable:seat/leave
