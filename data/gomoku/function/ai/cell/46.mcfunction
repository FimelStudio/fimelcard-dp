execute unless score #b46 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b6 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b6 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b7 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b7 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b8 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b8 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b9 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b9 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b10 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b10 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b25 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b25 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b26 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b26 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b27 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b27 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b28 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b28 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b29 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b29 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b44 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b44 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b45 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b45 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b47 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b47 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b63 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b63 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b66 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b66 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b67 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b67 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b82 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b82 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b85 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b85 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b86 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b86 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 46
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/46
function gomoku:ai/score/46
function gomoku:ai/consider
