execute unless score #b175 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b176 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b176 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/175_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b194 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b194 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b213 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b213 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b232 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b232 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b251 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b251 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b270 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b289 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b289 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b308 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b308 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b327 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b327 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b346 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b346 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/175_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b155 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b155 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b135 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b135 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b115 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b115 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b95 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b95 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b195 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b195 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b215 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b215 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b235 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b235 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b255 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b255 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b275 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b275 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b295 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b295 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b315 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b315 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b335 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b335 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b355 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b355 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/175_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b193 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b193 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b211 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b211 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b229 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b229 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b247 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b247 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b157 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b157 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b139 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b139 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b121 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b121 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b103 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b103 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b85 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b85 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b67 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b67 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b49 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b49 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b31 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b31 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b13 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b13 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/175_3
