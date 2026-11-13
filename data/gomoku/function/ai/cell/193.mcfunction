execute unless score #b193 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b153 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b153 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b154 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b154 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b157 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b157 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b172 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b172 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b174 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b174 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b175 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b175 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b176 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b176 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b191 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b191 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b194 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b194 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b195 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b195 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b210 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b210 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b212 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b212 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b213 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b213 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b229 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b229 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b230 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b230 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b231 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b231 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b232 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b232 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b233 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b233 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 193
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/193
function gomoku:ai/score/193
function gomoku:ai/consider
