scoreboard players set #part gm_ctx 0
execute if score #length gm_ctx matches 1 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 10
execute if score #length gm_ctx matches 2 if score #open gm_ctx matches 1 run scoreboard players set #part gm_ctx 80
execute if score #length gm_ctx matches 2 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 400
execute if score #length gm_ctx matches 3 if score #open gm_ctx matches 1 run scoreboard players set #part gm_ctx 1200
execute if score #length gm_ctx matches 3 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 12000
execute if score #length gm_ctx matches 4 if score #open gm_ctx matches 1 run scoreboard players set #part gm_ctx 20000
execute if score #length gm_ctx matches 4 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 100000
execute if score #length gm_ctx matches 5.. run scoreboard players set #part gm_ctx 100000000
execute if score #length gm_ctx matches 4 if score #open gm_ctx matches 1.. run scoreboard players add #fork gm_ctx 1
execute if score #length gm_ctx matches 3 if score #open gm_ctx matches 2 run scoreboard players add #fork gm_ctx 1
scoreboard players operation #shape gm_ctx += #part gm_ctx
