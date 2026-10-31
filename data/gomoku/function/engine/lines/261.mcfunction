execute unless score #b261 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b260 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b260 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b259 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b259 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b258 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b258 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b257 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b257 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b256 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b256 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b255 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b255 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b254 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b254 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b253 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b253 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b252 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b252 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b251 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b250 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b250 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b249 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b249 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b248 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b248 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b247 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b247 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b262 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b262 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b263 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b263 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b264 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b264 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b265 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b265 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/261_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b242 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b242 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b223 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b223 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b204 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b204 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b185 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b185 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b166 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b166 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b147 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b147 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b128 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b128 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b109 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b109 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b90 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b90 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b71 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b71 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b52 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b52 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b33 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b33 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b14 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b14 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b280 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b280 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b299 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b299 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b318 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b318 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b337 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b337 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b356 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b356 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/261_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b241 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b241 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b221 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b221 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b201 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b201 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b181 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b181 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b161 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b161 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b141 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b141 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b121 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b121 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b101 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b101 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b81 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b81 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b61 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b61 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b41 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b41 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b21 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b21 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b1 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b1 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b281 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b281 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b301 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b301 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b321 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b321 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b341 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b341 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/261_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b279 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b279 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b297 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b297 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b315 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b315 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b333 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b333 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b351 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b351 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b243 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b243 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b225 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b225 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b207 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b207 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b189 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b189 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/261_3
