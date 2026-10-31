execute unless score #b69 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b29 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b29 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b30 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b30 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b31 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b31 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b32 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b32 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b33 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b33 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b49 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b49 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b50 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b50 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b51 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b51 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b52 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b52 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b67 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b67 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b68 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b68 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b70 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b70 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b71 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b71 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b86 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b86 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b87 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b87 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b88 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b88 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b89 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b89 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b90 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b90 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b105 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b105 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b107 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b107 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b108 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b108 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b109 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b109 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 69
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/69
function gomoku:ai/score/69
function gomoku:ai/consider
