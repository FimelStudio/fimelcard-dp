execute unless score #b132 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b92 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b92 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b93 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b93 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b94 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b94 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 132
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/132
function gomoku:ai/score/132
function gomoku:ai/consider
