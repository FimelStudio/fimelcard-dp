execute unless score #b308 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b268 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b268 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b270 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b270 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b271 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b271 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b272 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b272 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b289 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b289 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b290 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b290 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b306 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b306 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b307 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b307 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b309 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b309 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b310 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b310 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b325 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b325 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b326 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b326 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b327 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b327 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b328 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b328 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b329 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b329 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b344 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b344 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b345 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b345 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b346 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b346 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b347 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b347 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b348 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b348 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 308
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/308
function gomoku:ai/score/308
function gomoku:ai/consider
