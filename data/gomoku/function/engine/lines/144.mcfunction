execute unless score #b144 gm_ctx = #mover gm_ctx run return 0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b143 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b143 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b142 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b142 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b141 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b141 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b140 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b140 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b139 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b139 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b138 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b138 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b137 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b137 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b136 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b136 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b135 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b135 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b134 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b134 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b133 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b133 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b145 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b145 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b146 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b146 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b147 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b147 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b148 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b148 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b149 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b149 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b150 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b150 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b151 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b151 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/144_0
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b125 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b125 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b106 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b106 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b87 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b87 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b68 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b68 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b49 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b49 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b30 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b30 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b11 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b11 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b163 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b163 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b182 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b182 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b201 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b201 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b220 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b220 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b239 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b239 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b258 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b258 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b277 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b277 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b296 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b296 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b315 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b315 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b334 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b334 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b353 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b353 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/144_1
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b124 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b124 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b104 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b104 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b84 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b84 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b64 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b64 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b44 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b44 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b24 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b24 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b4 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b4 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b164 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b164 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b184 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b184 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b204 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b204 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b224 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b224 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b244 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b244 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b264 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b264 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b284 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b284 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/144_2
scoreboard players set #length gm_ctx 1
scoreboard players set #left gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b162 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b162 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b180 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b180 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b198 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b198 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b216 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b216 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b234 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b234 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b252 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b252 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b270 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b270 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b288 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b288 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b306 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b306 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b324 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b324 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b342 gm_ctx = #mover gm_ctx run scoreboard players add #left gm_ctx 1
execute unless score #b342 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #left gm_ctx
scoreboard players set #right gm_ctx 0
scoreboard players set #run gm_ctx 1
execute if score #run gm_ctx matches 1 if score #b126 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b126 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b108 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b108 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b90 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b90 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b72 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b72 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b54 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b54 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b36 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b36 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
execute if score #run gm_ctx matches 1 if score #b18 gm_ctx = #mover gm_ctx run scoreboard players add #right gm_ctx 1
execute unless score #b18 gm_ctx = #mover gm_ctx run scoreboard players set #run gm_ctx 0
scoreboard players operation #length gm_ctx += #right gm_ctx
execute if score #length gm_ctx matches 5.. run function gomoku:engine/win/144_3
