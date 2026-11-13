execute unless score #b16 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b15 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b15 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b14 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b14 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b13 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b13 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b12 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b12 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b11 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b11 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b10 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b10 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b9 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b9 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b8 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b8 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b7 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b7 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b6 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b6 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b5 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b5 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b4 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b4 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b3 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b3 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b2 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b2 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b1 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b1 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b0 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b0 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b17 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b17 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b18 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b18 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/16_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b35 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b35 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b54 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b54 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b73 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b73 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b92 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b92 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b111 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b111 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b130 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b130 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b149 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b149 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b168 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b168 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b187 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b187 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b206 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b206 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b225 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b225 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b244 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b244 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b263 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b263 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b282 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b282 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b301 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b301 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b320 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b320 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b339 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b339 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b358 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b358 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/16_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b36 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b36 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b56 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b56 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/16_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b34 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b34 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
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
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/16_3
