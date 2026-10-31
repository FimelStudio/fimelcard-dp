execute unless score #b82 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b42 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b42 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b43 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b43 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b44 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b44 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b45 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b45 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b46 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b46 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b61 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b61 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b62 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b62 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b63 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b63 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b80 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b80 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b81 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b81 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b99 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b99 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b100 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b100 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b101 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b101 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b102 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b102 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b103 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b103 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b118 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b118 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b119 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b119 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b120 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b120 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b121 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b121 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b122 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b122 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 82
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/82
function gomoku:ai/score/82
function gomoku:ai/consider
