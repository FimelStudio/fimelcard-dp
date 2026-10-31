execute unless score #b204 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b164 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b164 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b165 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b165 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b167 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b167 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b168 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b168 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b184 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b184 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b187 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b187 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b202 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b202 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b203 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b203 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b221 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b221 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b222 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b222 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b240 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b240 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b241 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b241 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b242 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b242 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b243 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b243 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b244 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b244 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 204
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/204
function gomoku:ai/score/204
function gomoku:ai/consider
