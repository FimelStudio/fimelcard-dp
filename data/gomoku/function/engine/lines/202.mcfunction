execute unless score #b202 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
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
execute if score #run gm_ctx matches 1 if score #b203 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b203 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
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
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/202_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b183 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b183 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b164 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b164 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b145 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b145 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b126 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b126 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b107 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b107 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b88 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b88 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b69 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b69 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b50 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b50 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b31 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b31 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b12 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b12 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b221 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b221 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b240 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b240 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b259 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b259 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b278 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b278 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b297 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b297 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b316 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b316 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b335 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b335 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b354 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b354 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/202_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b182 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b182 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b162 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b162 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b142 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b142 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b122 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b122 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b102 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b102 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b82 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b82 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b62 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b62 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b42 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b42 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b22 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b22 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b2 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b2 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b222 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b222 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b242 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b242 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b262 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b262 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b282 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b282 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b302 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b302 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b322 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b322 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/202_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b220 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b220 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b238 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b238 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b256 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b256 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b274 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b274 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b292 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b292 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b310 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b310 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b328 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b328 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b346 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b346 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b184 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b184 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b166 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b166 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b148 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b148 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b130 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b130 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b112 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b112 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b94 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b94 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/202_3
