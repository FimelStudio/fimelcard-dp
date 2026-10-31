execute unless score #b263 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b223 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b242 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b242 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b243 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b243 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b244 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b244 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b245 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b245 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b246 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b246 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b261 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b261 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b262 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b262 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b264 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b264 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b265 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b265 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b281 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b281 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b282 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b282 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b283 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b283 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b284 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b284 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b299 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b299 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b300 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b300 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b302 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b302 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 263
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/263
function gomoku:ai/score/263
function gomoku:ai/consider
