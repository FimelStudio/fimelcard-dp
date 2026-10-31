execute unless score #b127 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b126 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b126 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b125 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b125 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b124 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b124 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b123 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b123 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b122 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b122 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b121 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b121 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b120 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b120 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b119 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b119 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b118 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b118 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b117 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b117 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b116 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b116 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b115 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b115 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b114 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b114 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b128 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b128 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b129 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b129 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b130 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b130 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b131 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b131 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b132 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b132 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/127_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b146 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b146 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b165 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b165 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b184 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b184 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b203 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b203 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/127_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b107 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b107 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b87 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b87 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b67 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b67 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b47 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b47 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b27 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b27 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b7 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b7 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b147 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b147 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b167 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b167 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b187 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b187 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b207 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b207 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b227 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b227 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/127_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b145 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b145 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b163 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b163 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b181 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b181 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b199 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b199 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b217 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b217 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b235 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b235 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b253 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b253 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b271 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b271 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b289 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b289 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b307 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b307 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b325 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b325 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b343 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b343 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/127_3
