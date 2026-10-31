execute unless score #b4 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b2 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b2 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b3 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b3 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b5 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b5 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b6 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b6 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b21 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b21 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b22 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b22 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b23 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b23 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b24 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b24 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b25 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b25 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b40 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b40 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b41 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b41 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b42 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b42 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b43 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b43 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b44 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b44 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 4
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/4
function gomoku:ai/score/4
function gomoku:ai/consider
