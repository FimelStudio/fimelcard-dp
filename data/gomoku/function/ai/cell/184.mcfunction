execute unless score #b184 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b144 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b144 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b146 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b146 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b147 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b147 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b148 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b148 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b163 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b163 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b164 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b164 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b165 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b165 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b167 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b167 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b182 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b182 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 184
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/184
function gomoku:ai/score/184
function gomoku:ai/consider
