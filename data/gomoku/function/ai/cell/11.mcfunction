execute unless score #b11 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b9 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b9 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b10 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b10 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b12 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b12 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b13 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b13 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b28 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b28 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b29 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b29 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b30 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b30 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b31 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b31 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b32 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b32 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b47 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b47 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b49 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b49 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b50 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b50 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b51 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b51 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 11
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/11
function gomoku:ai/score/11
function gomoku:ai/consider
