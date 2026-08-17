# 游戏中若玩家因外力离座，重新送回自己的座椅
scoreboard players operation #ctx_id ct_ctx = @s ct_id
scoreboard players operation #ctx_seat ct_ctx = @s ct_seat
scoreboard players set #mounted ct_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #ctx_id ct_ctx if score @s ct_seat = #ctx_seat ct_ctx run scoreboard players set #mounted ct_ctx 1
execute if score #mounted ct_ctx matches 0 run function cardtable:seat/mount
