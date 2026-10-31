execute unless score #b147 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b107 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b107 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b108 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b108 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b109 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b109 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b110 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b110 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b111 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b111 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b127 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b127 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b128 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b128 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b129 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b129 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b130 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b130 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b145 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b146 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b146 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b148 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b148 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b149 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b149 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 147
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/147
function gomoku:ai/score/147
function gomoku:ai/consider
