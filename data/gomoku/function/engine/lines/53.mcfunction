execute unless score #b53 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b52 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b52 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b51 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b51 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b50 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b50 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b49 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b49 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b48 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b48 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b47 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b47 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b46 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b46 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b45 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b45 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b44 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b44 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b43 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b43 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b42 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b42 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b41 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b41 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b40 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b40 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b39 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b39 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b38 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b38 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b54 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b54 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b55 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b55 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b56 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b56 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/53_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b34 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b34 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b15 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b15 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/53_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b33 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b33 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b13 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b13 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b73 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b73 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b93 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b93 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b113 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b113 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/53_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b35 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b35 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b17 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b17 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/53_3
