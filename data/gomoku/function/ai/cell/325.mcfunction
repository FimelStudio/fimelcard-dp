execute unless score #b325 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
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
execute if score #b323 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b323 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b324 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b324 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b326 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b326 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b327 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b327 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b342 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b342 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b343 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b343 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b344 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b344 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b345 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b345 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b346 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b346 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 325
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/325
function gomoku:ai/score/325
function gomoku:ai/consider
