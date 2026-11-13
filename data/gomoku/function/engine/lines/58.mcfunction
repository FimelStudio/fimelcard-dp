execute unless score #b58 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b57 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b57 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b59 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b59 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b60 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b60 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b61 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b61 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b62 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b62 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b63 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b63 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b64 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b64 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b65 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b65 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b66 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b66 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b67 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b67 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b68 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b68 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b69 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b69 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b70 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b70 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b71 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b71 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b72 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b72 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b73 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b73 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b74 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b74 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b75 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b75 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/58_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b39 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b39 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b20 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b20 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b1 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b1 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b77 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b77 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b96 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b96 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b115 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b115 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b134 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b134 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b153 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b153 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b172 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b172 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b191 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b191 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b210 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b210 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b229 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b229 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b248 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b248 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b267 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b267 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b286 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b286 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b305 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b305 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b324 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b324 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b343 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b343 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/58_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b38 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b38 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b78 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b78 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b98 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b98 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b118 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b138 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b138 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b158 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b158 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b178 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b178 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b198 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b198 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b218 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b218 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b238 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b238 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b258 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b258 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b278 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b278 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b298 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b298 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b318 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b318 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b338 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b338 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b358 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b358 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/58_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b76 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b76 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b40 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b40 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b22 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b22 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b4 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b4 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/58_3
