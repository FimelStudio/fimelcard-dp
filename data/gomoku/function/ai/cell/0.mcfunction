execute unless score #b0 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b1 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b1 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b2 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b2 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b19 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b19 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b20 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b20 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b21 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b21 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b38 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b38 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b39 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b39 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b40 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b40 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 0
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/0
function gomoku:ai/score/0
function gomoku:ai/consider
