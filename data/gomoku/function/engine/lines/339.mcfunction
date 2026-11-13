execute unless score #b339 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b338 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b338 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b337 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b337 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b336 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b336 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b335 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b335 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b334 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b334 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b333 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b333 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b332 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b332 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b331 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b331 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b330 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b330 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
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
execute if score #run gm_ctx matches 1 if score #b340 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b340 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b341 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b341 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/339_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b320 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b320 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b301 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b301 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b282 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b282 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b263 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b263 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b244 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b244 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b225 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b225 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b206 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b206 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b187 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b187 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b168 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b168 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b149 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b149 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b130 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b130 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b111 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b111 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b92 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b92 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b73 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b73 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b54 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b54 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b35 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b35 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b16 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b16 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b358 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b358 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/339_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b319 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b319 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b299 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b299 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b279 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b279 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b259 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b259 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b239 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b239 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b219 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b219 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b199 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b199 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b179 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b179 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b159 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b159 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b139 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b139 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b119 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b119 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b99 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b99 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b79 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b79 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b59 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b59 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b39 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b39 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b19 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b19 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b359 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b359 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/339_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b357 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b357 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b321 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b321 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b303 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b303 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/339_3
