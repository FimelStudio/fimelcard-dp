execute unless score #b66 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b26 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b26 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b27 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b27 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b28 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b28 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b29 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b29 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b30 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b30 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b45 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b45 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b46 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b46 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b47 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b47 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b48 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b49 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b49 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b67 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b67 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b68 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b68 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b85 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b85 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b86 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b86 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b87 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b87 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b102 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b102 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b103 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b103 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b104 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b104 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b105 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b105 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 66
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/66
function gomoku:ai/score/66
function gomoku:ai/consider
