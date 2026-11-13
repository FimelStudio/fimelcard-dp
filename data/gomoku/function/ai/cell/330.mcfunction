execute unless score #b330 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b290 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b290 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b292 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b292 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b293 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b293 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b294 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b294 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b309 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b309 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b310 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b310 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b311 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b311 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b312 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b312 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b313 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b313 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b328 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b328 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b329 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b329 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b331 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b331 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b332 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b332 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b347 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b347 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b348 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b348 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b349 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b349 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b350 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b350 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b351 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b351 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 330
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/330
function gomoku:ai/score/330
function gomoku:ai/consider
