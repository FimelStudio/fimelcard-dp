execute unless score #b318 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b278 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b278 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b279 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b279 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b281 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b281 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b282 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b282 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b297 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b297 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b298 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b298 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b299 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b299 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b300 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b300 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b316 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b316 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b317 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b317 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b319 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b319 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b320 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b320 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b335 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b335 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b336 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b336 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b337 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b337 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b338 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b338 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b339 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b339 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b354 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b354 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b355 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b355 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b356 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b356 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b357 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b357 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b358 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b358 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 318
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/318
function gomoku:ai/score/318
function gomoku:ai/consider
