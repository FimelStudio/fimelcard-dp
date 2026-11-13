execute unless score #b37 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b16 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b16 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b17 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b17 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b18 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b18 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b35 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b35 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b36 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b36 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 37
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/37
function gomoku:ai/score/37
function gomoku:ai/consider
