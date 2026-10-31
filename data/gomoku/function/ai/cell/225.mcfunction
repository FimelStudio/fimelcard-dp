execute unless score #b225 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b185 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b187 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b187 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b188 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b188 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b189 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b189 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b207 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b207 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b208 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b208 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute if score #b263 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b263 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b264 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b264 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b265 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b265 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 225
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/225
function gomoku:ai/score/225
function gomoku:ai/consider
