execute unless score #b330 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b329 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b329 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b328 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b328 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b327 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b327 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b326 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b326 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b325 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b325 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b324 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b324 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b323 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b323 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b331 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b331 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b332 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b332 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b333 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b333 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b334 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b334 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b335 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b335 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b336 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b336 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b337 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b337 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b338 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b338 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b339 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b339 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b340 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b340 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b341 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b341 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/330_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b311 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b311 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b292 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b292 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b273 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b273 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b254 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b254 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b235 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b235 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b216 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b216 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b197 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b197 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b178 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b178 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b159 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b159 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b140 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b140 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b121 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b121 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b102 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b102 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b83 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b83 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b64 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b64 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b45 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b45 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b26 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b26 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b7 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b7 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b349 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b349 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/330_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b310 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b310 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b290 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b290 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b270 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b250 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b250 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b230 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b230 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b210 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b210 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b190 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b190 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b350 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b350 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/330_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b348 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b348 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b312 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b312 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b294 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b294 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b276 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b276 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b258 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b258 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b240 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b240 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b222 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b222 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b204 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b204 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b186 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b186 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b168 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b168 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b150 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b150 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b132 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b132 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/330_3
