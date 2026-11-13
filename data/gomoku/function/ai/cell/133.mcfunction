execute unless score #b133 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b95 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b95 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute if score #b134 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b134 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b135 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b135 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b152 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b152 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b153 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b153 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b154 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b154 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b171 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b171 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b172 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b172 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 133
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/133
function gomoku:ai/score/133
function gomoku:ai/consider
