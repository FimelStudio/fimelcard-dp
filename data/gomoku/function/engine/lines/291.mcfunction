execute unless score #b291 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b292 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b292 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b293 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b293 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b294 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b294 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b295 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b295 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b296 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b296 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b297 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b297 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b298 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b298 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b299 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b299 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b300 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b300 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b301 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b301 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b302 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b302 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b303 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b303 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/291_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b272 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b272 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b253 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b253 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b234 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b234 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b215 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b215 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b196 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b196 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b177 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b177 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b158 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b158 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b139 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b139 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b120 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b120 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b101 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b101 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b82 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b82 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b63 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b63 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b44 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b44 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b25 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b25 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b6 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b6 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b310 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b310 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b329 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b329 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b348 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b348 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/291_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b271 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b271 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b251 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b231 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b231 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b211 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b211 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b191 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b191 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b171 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b171 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b311 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b311 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b331 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b331 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b351 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b351 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/291_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b309 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b309 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b327 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b327 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b345 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b345 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b273 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b273 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b255 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b255 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b237 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b237 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b219 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b219 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b201 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b201 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b183 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b183 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b165 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b165 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b147 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b147 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b129 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b129 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b111 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b111 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b93 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b93 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b75 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b75 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/291_3
