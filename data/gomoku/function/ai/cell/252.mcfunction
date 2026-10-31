execute unless score #b252 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b212 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b212 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b213 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b213 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b216 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b216 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b231 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b231 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b232 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b232 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b233 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b233 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b234 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b234 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b235 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b235 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b250 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b250 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b251 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b251 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b253 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b253 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b254 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b254 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b270 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b270 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b271 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b271 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b272 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b272 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b273 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b273 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b289 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b289 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b290 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b290 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b291 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b292 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b292 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 252
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/252
function gomoku:ai/score/252
function gomoku:ai/consider
