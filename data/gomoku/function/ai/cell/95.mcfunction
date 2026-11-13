execute unless score #b95 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b57 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b57 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b58 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b58 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b59 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b59 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b76 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b76 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b77 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b77 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b78 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b78 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b96 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b96 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b97 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b97 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b114 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b114 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b115 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b115 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b116 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b116 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b133 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b133 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b134 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b134 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b135 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b135 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 95
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/95
function gomoku:ai/score/95
function gomoku:ai/consider
