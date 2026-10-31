$execute store result score #cell_count gm_ctx if entity @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=$(sq)}]
execute unless score #cell_count gm_ctx matches 1 run return 0
$execute if score @e[type=minecraft:marker,tag=gm.board,scores={gm_sq=$(sq)},limit=1] gm_piece matches 0 run scoreboard players set #legal gm_ctx 1
