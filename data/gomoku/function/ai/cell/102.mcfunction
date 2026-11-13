execute unless score #b102 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b62 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b62 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b63 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b63 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b64 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b65 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b66 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b66 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b81 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b81 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b82 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b82 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b84 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b85 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b85 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b100 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b100 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b101 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b101 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b103 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b103 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b104 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b104 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b119 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b119 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b120 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b120 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b121 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b121 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b122 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b122 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b123 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b123 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b138 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b138 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b139 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b139 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b140 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b140 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b141 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b141 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b142 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b142 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 102
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/102
function gomoku:ai/score/102
function gomoku:ai/consider
