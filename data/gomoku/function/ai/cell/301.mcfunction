execute unless score #b301 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b261 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b261 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b262 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b262 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b263 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b263 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute if score #b302 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b302 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b318 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b318 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b319 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b319 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b320 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b320 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b321 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b321 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b322 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b322 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b337 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b337 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b338 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b338 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b339 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b339 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b340 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b340 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b341 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b341 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 301
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/301
function gomoku:ai/score/301
function gomoku:ai/consider
