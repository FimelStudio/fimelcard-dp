execute unless score #b203 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b202 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b202 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b201 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b201 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b200 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b200 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b199 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b199 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b198 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b198 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b197 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b197 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b196 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b196 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b195 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b195 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b194 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b194 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b193 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b193 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b192 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b192 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b191 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b191 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b190 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b190 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b204 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b204 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b205 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b205 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b206 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b206 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b207 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b207 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b208 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b208 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/203_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b184 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b184 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b165 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b165 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b146 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b146 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b127 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b127 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b108 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b108 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b89 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b89 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b70 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b70 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b51 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b51 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b32 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b32 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b13 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b13 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b222 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b222 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b241 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b241 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b260 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b260 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b279 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b279 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b298 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b298 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b317 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b317 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b336 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b336 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b355 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b355 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/203_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b223 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b223 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b243 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b243 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b263 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b263 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b283 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b283 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b303 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b303 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/203_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b221 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b221 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b239 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b239 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b257 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b257 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b275 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b275 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b293 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b293 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b311 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b311 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b329 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b329 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b347 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b347 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b185 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b185 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b167 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b167 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b149 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b149 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b131 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b131 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b113 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b113 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/203_3
