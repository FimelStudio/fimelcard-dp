execute unless score #b293 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b253 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b253 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b254 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b254 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b255 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b255 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b256 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b256 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b257 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b257 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b272 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b272 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b273 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b273 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b274 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b274 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b275 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b275 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b276 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b276 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b292 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b292 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b294 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b294 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b295 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b295 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b310 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b310 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b311 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b311 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b312 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b312 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b313 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b313 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b314 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b314 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b329 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b329 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b330 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b330 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b331 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b331 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b332 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b332 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b333 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b333 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 293
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/293
function gomoku:ai/score/293
function gomoku:ai/consider
