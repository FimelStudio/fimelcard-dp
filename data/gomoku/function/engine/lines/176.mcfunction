execute unless score #b176 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b175 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b175 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b174 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b174 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b173 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b173 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b172 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b172 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b171 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b171 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b177 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b177 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b178 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b178 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b179 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b179 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b180 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b180 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b181 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b181 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b182 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b182 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b183 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b183 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b184 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b184 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b185 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b185 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b186 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b186 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b187 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b187 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b188 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b188 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b189 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b189 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/176_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b157 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b157 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b138 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b138 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b119 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b119 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b100 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b100 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b81 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b81 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b62 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b62 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b43 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b43 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b24 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b24 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b5 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b5 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b195 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b195 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b214 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b214 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b233 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b233 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b252 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b252 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b271 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b271 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b290 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b290 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b309 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b309 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b328 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b328 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b347 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b347 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/176_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b156 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b156 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b136 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b136 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b116 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b116 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b96 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b96 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b76 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b76 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b196 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b196 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b216 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b216 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b236 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b236 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b256 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b256 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b276 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b276 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b296 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b296 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b316 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b316 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b336 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b336 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b356 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b356 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/176_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b194 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b194 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b212 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b212 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b230 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b230 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b248 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b248 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b266 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b266 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b158 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b158 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b140 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b140 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b122 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b122 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b104 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b104 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b86 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b86 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b68 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b68 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b50 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b50 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b32 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b32 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b14 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b14 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/176_3
