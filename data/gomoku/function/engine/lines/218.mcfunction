execute unless score #b218 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b217 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b217 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b216 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b216 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b215 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b215 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b214 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b214 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b213 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b213 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b212 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b212 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b211 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b211 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b210 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b210 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b209 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b209 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b219 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b219 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b220 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b220 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b221 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b221 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b222 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b222 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b223 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b223 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b224 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b224 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b225 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b225 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b226 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b226 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b227 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b227 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/218_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b199 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b199 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b180 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b180 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b161 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b161 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b142 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b142 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b123 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b123 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b104 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b104 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b85 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b85 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b66 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b66 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b47 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b47 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b28 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b28 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b9 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b9 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b237 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b237 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b256 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b256 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b275 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b275 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b294 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b294 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b313 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b313 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b332 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b332 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b351 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b351 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/218_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b198 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b198 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b178 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b178 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b158 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b158 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b138 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b138 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b118 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b98 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b98 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b78 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b78 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b58 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b58 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b38 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b38 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/218_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b236 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b236 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b254 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b254 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b272 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b272 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b290 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b290 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b308 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b308 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b326 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b326 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b344 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b344 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b200 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b200 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b182 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b182 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b164 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b164 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b146 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b146 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b128 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b128 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b110 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b110 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b92 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b92 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b74 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b74 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b56 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b56 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/218_3
