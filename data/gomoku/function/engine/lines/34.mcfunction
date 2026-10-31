execute unless score #b34 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b33 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b33 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b32 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b32 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b31 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b31 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b30 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b30 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b29 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b29 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b28 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b28 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b27 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b27 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b26 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b26 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b25 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b25 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b24 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b24 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b23 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b23 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b22 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b22 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b21 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b21 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b20 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b20 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b19 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b19 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b35 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b35 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b36 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b36 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b37 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b37 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/34_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b15 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b15 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b53 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b53 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b72 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b72 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b91 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b91 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b110 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b110 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b129 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b129 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b148 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b148 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b167 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b167 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b186 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b186 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b205 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b205 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b224 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b224 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b243 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b243 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b262 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b262 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b281 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b281 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b300 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b300 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b319 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b319 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b338 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b338 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b357 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b357 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/34_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b14 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b14 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b54 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b54 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b74 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b74 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b94 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b94 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/34_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b52 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b52 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b70 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b70 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b88 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b88 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b106 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b106 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b124 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b124 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b142 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b142 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b160 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b160 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b178 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b178 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b196 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b196 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b214 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b214 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b232 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b232 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b250 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b250 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b268 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b268 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b286 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b286 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b304 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b304 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b16 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b16 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/34_3
