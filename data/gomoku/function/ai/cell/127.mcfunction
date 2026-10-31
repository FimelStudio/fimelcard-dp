execute unless score #b127 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b87 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b87 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b88 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b88 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b89 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b89 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b90 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b90 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b91 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b91 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b106 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b107 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b107 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b108 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b108 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b109 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b109 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b110 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b110 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b125 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b125 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b126 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b128 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b128 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b129 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b129 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
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
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 127
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/127
function gomoku:ai/score/127
function gomoku:ai/consider
