execute unless score #b305 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b266 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b266 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b267 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b267 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b268 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b268 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b269 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b285 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b285 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b286 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b286 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b288 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b304 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b304 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b306 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b306 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b307 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b307 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b323 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b323 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b324 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b324 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b325 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b325 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b326 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b326 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b342 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b342 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b343 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b343 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b344 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b344 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b345 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b345 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 305
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/305
function gomoku:ai/score/305
function gomoku:ai/consider
