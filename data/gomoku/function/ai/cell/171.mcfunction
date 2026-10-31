execute unless score #b171 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b133 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b133 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute if score #b172 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b172 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b190 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b190 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b191 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b191 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b209 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b209 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b210 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b210 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 171
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/171
function gomoku:ai/score/171
function gomoku:ai/consider
