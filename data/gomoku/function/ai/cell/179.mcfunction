execute unless score #b179 gm_ctx matches 0 run return 0
scoreboard players set #neighbor gm_ctx 0
execute if score #b139 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b139 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b140 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b140 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b141 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b141 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b142 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b142 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b143 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b143 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b158 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b158 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b159 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b159 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b160 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b160 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b161 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b161 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b162 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b162 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b177 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b177 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b178 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b178 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b180 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b180 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b181 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b181 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b196 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b196 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b197 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b197 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b198 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b198 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b199 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b199 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b200 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b200 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b215 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b216 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b216 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b217 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b217 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b218 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b218 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b219 gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1
execute if score #b219 gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1
execute unless score #neighbor gm_ctx matches 1 run return 0
scoreboard players set #candidate gm_ctx 179
execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/179
function gomoku:ai/score/179
function gomoku:ai/consider
