execute unless score #b289 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b290 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b290 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b291 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b291 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/289_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b270 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b251 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b232 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b232 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b213 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b213 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b194 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b194 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b175 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b175 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b156 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b156 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b137 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b137 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b118 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b99 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b99 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b80 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b80 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b61 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b61 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b42 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b42 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b23 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b23 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b4 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b4 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b308 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b308 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b327 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b327 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b346 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b346 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/289_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b269 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b269 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b249 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b249 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b229 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b229 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b209 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b209 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b309 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b309 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b329 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b329 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b349 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b349 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/289_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b307 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b307 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b325 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b325 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b343 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b343 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b271 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b271 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b253 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b253 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b235 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b235 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b217 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b217 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b199 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b199 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b181 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b181 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b163 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b163 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b145 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b145 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b127 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b127 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b109 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b109 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b91 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b91 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b73 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b73 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b55 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b55 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b37 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b37 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/289_3
