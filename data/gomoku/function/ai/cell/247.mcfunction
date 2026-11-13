execute unless score #b247 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b209 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b209 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b210 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b210 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b228 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b228 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b229 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b229 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b230 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b230 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b248 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b248 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b249 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b249 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b266 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b266 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b267 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b267 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b268 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b268 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b285 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b285 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b286 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b286 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b287 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 247
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/247
function gomoku:ai/score/247
function gomoku:ai/consider
