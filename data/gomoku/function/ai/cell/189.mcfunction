execute unless score #b189 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b149 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b149 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b150 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b150 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b151 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b151 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b168 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b168 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b169 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b169 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b170 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b170 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b187 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b187 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b188 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b188 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b207 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b207 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b208 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b208 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 189
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/189
function gomoku:ai/score/189
function gomoku:ai/consider
