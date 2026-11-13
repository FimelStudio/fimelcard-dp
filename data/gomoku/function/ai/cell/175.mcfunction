execute unless score #b175 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b135 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b135 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b136 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b136 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b137 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b137 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b138 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b138 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b139 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b139 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b154 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b154 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b155 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b156 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b157 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b157 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b158 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b158 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b173 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b174 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b174 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b176 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b176 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b177 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b177 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b192 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b193 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b193 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b194 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b194 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b195 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b195 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b196 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b196 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b211 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b212 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b212 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b213 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b213 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 175
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/175
function gomoku:ai/score/175
function gomoku:ai/consider
