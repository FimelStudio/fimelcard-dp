execute store result score #cell_count gm_ctx if entity @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=24}]
execute unless score #cell_count gm_ctx matches 1 run scoreboard players set #cache_ok gm_ctx 0
execute if score #cell_count gm_ctx matches 1 run scoreboard players operation #b24 gm_ctx = @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=24},limit=1] gm_piece
