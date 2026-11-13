execute unless score #b164 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b124 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b124 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b125 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b125 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b127 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b127 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b128 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b128 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b143 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b143 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b144 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b144 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b146 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b146 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b147 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b147 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b162 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b162 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b163 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b163 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b165 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b165 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b166 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b181 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b181 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b182 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b182 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b183 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b184 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b184 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b185 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b200 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b200 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b201 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b201 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b202 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b202 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b203 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b203 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b204 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 164
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/164
function gomoku:ai/score/164
function gomoku:ai/consider
