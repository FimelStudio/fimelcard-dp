execute unless score #b265 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b225 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b244 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b244 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b245 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b245 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b246 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b246 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b263 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b263 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b264 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b264 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b282 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b282 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b283 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b283 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b284 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b284 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b301 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b302 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b302 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b303 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 265
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/265
function gomoku:ai/score/265
function gomoku:ai/consider
