execute unless score #b316 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b276 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b276 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b277 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b277 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b278 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b278 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b279 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b279 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b295 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b295 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b296 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b296 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b297 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b297 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b298 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b298 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b299 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b299 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b314 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b314 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b315 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b315 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b317 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b317 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b318 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b318 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b333 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b333 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b334 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b334 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b335 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b335 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b336 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b336 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b337 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b337 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b352 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b352 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b353 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b353 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b354 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b354 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b355 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b355 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b356 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b356 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 316
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/316
function gomoku:ai/score/316
function gomoku:ai/consider
