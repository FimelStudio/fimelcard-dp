execute unless score #b35 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b34 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b34 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
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
execute if score #run gm_ctx matches 1 if score #b36 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b36 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b37 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b37 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/35_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b16 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b16 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/35_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b15 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b15 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b55 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b55 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b75 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b75 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/35_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b53 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b53 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b71 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b71 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b89 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b89 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b107 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b107 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b125 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b125 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b143 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b143 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b161 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b161 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b179 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b179 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b197 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b197 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b215 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b215 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b233 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b233 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b251 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b269 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b269 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b287 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b287 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b305 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b305 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b323 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b323 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b17 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b17 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/35_3
