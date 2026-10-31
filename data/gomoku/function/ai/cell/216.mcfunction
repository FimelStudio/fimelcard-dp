execute unless score #b216 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b176 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b176 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b177 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b177 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b178 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b178 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b179 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b179 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b180 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b180 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b195 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b195 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b196 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b196 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b197 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b197 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b198 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b198 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b199 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b199 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b214 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b217 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b217 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b218 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b218 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b233 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b233 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b234 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b234 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b235 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b235 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b236 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b236 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b237 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b237 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b252 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b252 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b253 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b253 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b254 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b254 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b255 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b255 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b256 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b256 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 216
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/216
function gomoku:ai/score/216
function gomoku:ai/consider
