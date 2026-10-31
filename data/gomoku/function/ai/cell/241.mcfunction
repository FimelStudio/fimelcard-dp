execute unless score #b241 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b201 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b201 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b202 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b202 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b203 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b203 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b220 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b220 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b221 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b221 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b222 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b222 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b239 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b239 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b240 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b240 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b242 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b242 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b243 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b243 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b258 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b258 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b259 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b259 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b260 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b260 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b261 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b261 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b262 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b262 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b277 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b277 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b278 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b278 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b279 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b279 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b280 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b281 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b281 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 241
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/241
function gomoku:ai/score/241
function gomoku:ai/consider
