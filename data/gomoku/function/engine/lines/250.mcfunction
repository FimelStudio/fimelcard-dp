execute unless score #b250 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b249 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b249 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b248 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b248 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b247 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b247 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b251 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b252 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b252 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b253 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b253 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b254 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b254 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b255 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b255 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b256 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b256 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b257 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b257 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b258 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b258 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b259 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b259 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b260 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b260 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b261 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b261 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b262 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b262 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b263 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b263 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b264 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b264 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b265 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b265 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/250_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b231 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b231 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b212 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b212 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b193 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b193 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b174 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b174 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b155 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b155 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b136 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b136 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b117 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b117 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b98 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b98 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b79 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b79 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b60 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b60 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b41 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b41 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b22 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b22 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b3 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b3 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b269 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b269 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b288 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b288 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b307 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b307 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b326 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b326 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b345 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b345 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/250_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b230 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b230 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b210 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b210 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b190 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b190 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b270 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b290 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b290 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b310 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b310 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b330 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b330 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b350 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b350 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/250_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b268 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b268 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b286 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b286 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b304 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b304 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b232 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b232 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b214 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b214 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b196 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b196 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b178 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b178 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b160 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b160 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b142 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b142 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b124 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b124 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b106 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b106 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b88 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b88 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b70 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b70 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b52 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b52 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b34 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b34 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b16 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b16 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/250_3
