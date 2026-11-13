execute unless score #b84 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b83 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b83 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b82 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b82 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b81 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b81 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b80 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b80 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b79 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b79 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b78 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b78 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b77 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b77 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b76 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b76 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b85 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b85 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b86 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b86 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b87 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b87 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b88 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b88 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b89 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b89 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b90 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b90 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b91 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b91 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b92 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b92 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b93 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b93 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b94 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b94 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/84_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b65 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b65 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b46 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b46 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b27 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b27 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b8 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b8 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b103 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b103 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b122 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b122 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b141 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b141 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b160 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b160 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b179 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b179 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b198 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b198 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b217 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b217 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b236 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b236 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b255 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b255 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b274 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b274 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b293 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b293 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b312 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b312 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b331 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b331 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b350 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b350 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/84_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b64 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b64 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b44 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b44 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b24 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b24 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b4 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b4 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b104 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b104 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b124 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b124 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b144 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b144 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b164 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b164 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b184 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b184 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b204 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b204 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b224 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b224 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b244 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b244 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b264 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b264 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b284 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b284 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/84_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b102 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b102 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b120 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b120 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b138 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b138 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b156 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b156 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b174 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b174 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b192 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b192 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b210 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b210 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b228 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b228 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b66 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b66 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b48 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b48 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b30 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b30 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b12 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b12 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/84_3
