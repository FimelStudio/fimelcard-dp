execute unless score #b94 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b54 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b54 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b55 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b55 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b56 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b56 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b73 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b73 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b74 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b74 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b75 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b75 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b92 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b92 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b93 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b93 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b111 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b111 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b112 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b112 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b113 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b113 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b130 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b130 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b131 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b131 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b132 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b132 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 94
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/94
function gomoku:ai/score/94
function gomoku:ai/consider
