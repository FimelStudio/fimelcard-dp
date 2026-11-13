execute unless score #b53 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b13 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b13 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b14 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b14 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b15 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b15 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b16 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b16 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b17 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b17 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b32 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b32 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b33 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b33 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b34 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b34 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b35 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b35 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b36 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b36 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b51 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b51 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b52 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b52 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b54 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b54 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b55 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b55 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b70 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b70 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b71 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b71 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b72 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b72 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b73 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b73 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b74 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b74 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b89 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b89 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b90 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b90 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b91 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b91 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b92 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b92 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b93 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b93 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 53
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/53
function gomoku:ai/score/53
function gomoku:ai/consider
