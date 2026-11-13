execute unless score #b119 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b79 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b79 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b80 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b80 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b81 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b81 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b82 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b82 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b83 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b98 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b98 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b99 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b99 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b100 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b100 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b101 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b101 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b102 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b102 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b117 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b117 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b118 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b118 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b120 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b120 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b121 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b121 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b136 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b136 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b137 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b137 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b138 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b138 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b139 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b139 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b140 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b140 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b157 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b157 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b158 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b158 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b159 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b159 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 119
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/119
function gomoku:ai/score/119
function gomoku:ai/consider
