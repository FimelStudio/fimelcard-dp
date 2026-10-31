execute unless score #b340 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b300 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b300 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b302 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b302 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b319 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b319 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b320 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b320 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b321 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b321 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b322 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b322 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b338 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b338 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b339 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b339 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b341 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b341 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b357 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b357 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b358 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b358 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b359 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b359 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b360 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b360 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 340
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/340
function gomoku:ai/score/340
function gomoku:ai/consider
