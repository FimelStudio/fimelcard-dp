execute unless score #b303 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b302 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b302 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b301 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b301 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b300 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b300 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b299 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b299 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b298 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b298 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b297 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b297 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b296 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b296 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b295 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b295 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b294 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b294 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b293 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b293 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b292 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b292 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b291 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b291 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b290 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b290 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b289 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b289 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b288 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b288 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b287 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b287 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b286 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b286 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b285 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b285 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/303_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b284 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b284 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b265 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b265 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b246 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b246 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b227 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b227 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b208 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b208 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b189 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b189 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b170 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b170 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b151 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b151 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b132 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b132 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b113 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b113 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b94 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b94 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b75 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b75 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b56 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b56 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b37 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b37 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b18 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b18 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b322 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b322 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b341 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b341 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b360 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b360 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/303_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b283 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b283 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b263 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b263 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b243 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b243 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b223 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b223 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b203 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b203 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b183 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b183 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b163 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b163 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b143 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b143 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b123 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b123 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b103 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b103 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b83 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b83 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b63 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b63 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b43 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b43 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b23 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b23 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b3 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b3 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/303_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b321 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b321 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b339 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b339 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b357 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b357 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/303_3
