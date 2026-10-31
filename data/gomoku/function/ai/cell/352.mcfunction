execute unless score #b352 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b312 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b312 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b313 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b313 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b314 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b314 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b315 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b315 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b316 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b316 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b331 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b331 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b332 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b332 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b333 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b333 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b334 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b334 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b335 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b335 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b350 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b350 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b351 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b351 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b353 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b353 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b354 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b354 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 352
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/352
function gomoku:ai/score/352
function gomoku:ai/consider
