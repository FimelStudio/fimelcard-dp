execute unless score #b268 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b228 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b228 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b229 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b229 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b230 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b230 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b231 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b231 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b232 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b232 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b247 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b247 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b248 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b248 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b249 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b249 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b250 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b250 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b251 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b251 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b266 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b266 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b267 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b267 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b270 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b270 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b285 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b285 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b286 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b286 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b289 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b289 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b304 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b304 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b305 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b305 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b306 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b306 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b307 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b307 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b308 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b308 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 268
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/268
function gomoku:ai/score/268
function gomoku:ai/consider
