execute unless score #b187 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b147 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b147 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b148 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b148 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b149 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b149 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b150 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b150 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b151 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b151 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b167 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b167 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b168 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b168 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b169 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b169 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b170 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b170 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b186 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b188 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b188 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b189 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b189 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b205 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b206 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b207 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b207 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b208 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b208 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b223 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b224 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b225 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b226 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b227 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 187
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/187
function gomoku:ai/score/187
function gomoku:ai/consider
