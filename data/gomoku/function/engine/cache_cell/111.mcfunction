execute store result score #cell_count gm_ctx if entity @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=111}]
execute unless score #cell_count gm_ctx matches 1 run scoreboard players set #cache_ok gm_ctx 0
execute if score #cell_count gm_ctx matches 1 run scoreboard players operation #b111 gm_ctx = @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=111},limit=1] gm_piece
